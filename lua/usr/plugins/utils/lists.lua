local trouble_status, trouble = pcall(require, "trouble")
if not trouble_status then
    print("Couldn't load trouble")
    return
end

local todo_comments_status, todo_comments = pcall(require, "todo-comments")
if not todo_comments_status then
    print("Couldn't load todo-comments")
    return
end

trouble.setup({
    opts = {
        modes = {
            lsp = {
                win = { position = "right" },
            },
        },
    },
})

todo_comments.setup()
