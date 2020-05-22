module DatasToolbox

const EDITOR = ENV["JULIA_EDITOR"]

function tempname(;cleanup::Bool=true)
    dir = isdir("/dev/shm") ? "/dev/shm" : tempdir()
    Base.tempname(dir, cleanup=cleanup)
end


function stashdata(obj; cleanup::Bool=true)
    fname = tempname(cleanup=cleanup)
    write(fname, obj)
    fname
end

function vim(str::AbstractString)
    fname = stashdata(str)
    run(`$EDITOR -b $fname`)
    read(fname, String)
end

function vim(obj)
    fname = stashdata(obj)
    run(`$EDITOR -b +%!'xxd -g1' +'set ft=xxd' $fname`)
    io = IOBuffer()
    run(pipeline(`xxd -r`, stdin=fname, stdout=io))
    read(seekstart(io))
end

function vim(ex::Expr; cleanup::Bool=true)
    fname = stashdata(string(ex), cleanup=cleanup)
    run(`$EDITOR +'set ft=julia' $fname`)
    Meta.parse(read(fname, String))
end
function vim(::Type{Expr}; cleanup::Bool=true)
    fname = tempname(cleanup=cleanup)
    run(`$EDITOR +'set ft=julia' $fname`)
    Meta.parse(read(fname, String))
end

export vim

end # module
