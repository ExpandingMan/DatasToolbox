# DatasToolbox

<p align="center"><img src="https://i2.wp.com/www.tor.com/wp-content/uploads/2016/09/DataLaughing.jpg?resize=740%2C460&type=vertical&ssl=1" alt="mr tricorder" width="400" height="200"></p>

A collection of useful tools I find myself needing or wanting in the Julia REPL.

## `vim`
This command lets you edit stuff in vim.  Binary stuff.  E.g.
```julia
vim([1,2,3])
```
will edit the array `[1,2,3]` in hex by way of `xxd`.  Save your work, and it will be
returned as a `Vector{UInt8}`.

You can also edit expressions by doing, e.g.
```julia
ex = quote
    f(x) = a
end
vim(ex)  # returns edited expression
```
or you can start with an empty expression by doing
```julia
vim(Expr)
```
