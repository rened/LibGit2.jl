export message, oid

type GitNote
    msg::String
    id::Oid
end

function message(n::GitNote)
    return n.msg
end

function oid(n::GitNote)
    return n.id
end

let
    function git_note_message(n_ptr::Ptr{Void})
        @assert n_ptr != C_NULL
        msg_ptr = api.git_note_message(n_ptr)
        return bytestring(msg_ptr)
    end

    function git_note_oid(n_ptr::Ptr{Void})
        @assert n_ptr != C_NULL
        oid_ptr = api.git_note_oid(n_ptr)
        return Oid(oid_ptr)
    end

    function GitNote(ptr::Ptr{Void})
        @assert ptr !=  C_NULL
        return GitNote(git_note_message(ptr),
                       git_note_oid(ptr))
    end
end
