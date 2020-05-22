module DatasToolbox

const EDITOR = ENV["JULIA_EDITOR"]


function stashdata(obj; cleanup::Bool=true)
    dir = isdir("/dev/shm") ? "/dev/shm" : tempdir()
    fname = tempname(dir, cleanup=cleanup)
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


export vim

end # module
