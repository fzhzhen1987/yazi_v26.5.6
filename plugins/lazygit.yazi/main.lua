return {
    entry = function(self, args)
        local output = Command("git"):arg("status"):stderr(Command.PIPED):output()
        if output.stderr ~= "" then
            ya.notify({
                title = "lazygit",
                content = "Not in a git directory\nError: " .. output.stderr,
                level = "warn",
                timeout = 5,
            })
        else
            ya.emit("shell", {
                "lazygit",
                block = true,
                orphan = false,
            })
        end
    end,
}
