using Base.Test
using LibGit2

include("util.jl")

testnames = ["oid", 
             "blob",
             "repository", 
             "config", 
             "signature", 
             "index", 
             "object",
             "odb", 
             "reference", 
             "tree", 
             "walker", 
             "tag", 
             "note", 
             "diff", 
             "branch",
             "repository_pack", 
             "patch", 
             "merge", 
             "remote"
             ]

tests = isempty(ARGS) || ARGS == ["all"] ? testnames : ARGS

function runtests(name)
    println(" \033[1m*\033[0m \033[31m$(name)\033[0m")
    # support shell tab expansion
    if endswith(name, ".jl")
        Core.include("$name")
    else
        Core.include("$name.jl")
    end
end

function propagate_errors(a, b)
    if isa(a,Exception)
        rethrow(a)
    end
    if isa(b,Exception)
        rethrow(b)
    end
    nothing
end

reduce(propagate_errors, nothing, map(runtests, tests))

println(" \033[32;1mSUCCESS\033[0m")
