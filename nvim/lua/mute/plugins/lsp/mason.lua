local status, mason = pcall(require, "mason")
if not status then
    return
end

local config = {
    ui = {
        --border = {"┌", "─", "┐", "│", "┘", "─", "└", "│"},
        border = "single",
    }
}

mason.setup(config)
