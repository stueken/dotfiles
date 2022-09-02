local null_ls = require("null-ls")
local builtins = require("null-ls.builtins")
local formatting = builtins.formatting
local diagnostics = builtins.diagnostics

local format_filetypes_on_save = {}
local sources = {}
local ld = false

-- Lua
if vim.fn.executable("stylua") == 1 then
    ld = true
    sources[#sources + 1] = formatting.stylua
    -- autoformat lua files on save if stlylua is present
    format_filetypes_on_save[#format_filetypes_on_save + 1] = "lua"
end

-- Python
if vim.fn.executable("black") == 1 then
    ld = true
    sources[#sources + 1] = formatting.black.with({
        command = "black",
        args = { "--quiet", "--fast", "-" },
    })
    format_filetypes_on_save[#format_filetypes_on_save + 1] = "python"
end

if vim.fn.executable("flake8") == 1 then
    ld = true
    sources[#sources + 1] = diagnostics.flake8
    if not format_filetypes_on_save[#format_filetypes_on_save] == "python" then
        format_filetypes_on_save[#format_filetypes_on_save + 1] = "python"
    end
end

if vim.fn.executable("isort") == 1 then
    ld = true
    sources[#sources + 1] = formatting.isort

    if not format_filetypes_on_save[#format_filetypes_on_save] == "python" then
        format_filetypes_on_save[#format_filetypes_on_save + 1] = "python"
    end
end

if vim.fn.executable("djhtml") == 1 then
    ld = true
    sources[#sources + 1] = formatting.djhtml.with({
        command = "djhtml",
        args = { "--tabwidth=2" },
    })
    if not format_filetypes_on_save[#format_filetypes_on_save] == "htmldjango" then
        format_filetypes_on_save[#format_filetypes_on_save + 1] = "htmldjango"
    end
end

-- JS

if vim.fn.executable("prettier") == 1 then
    ld = true
    sources[#sources + 1] = formatting.prettier
end

local on_attach = function(client)
    -- autoformat python and lua files when saving files
    if client.resolved_capabilities.document_formatting then
        for _, v in pairs(format_filetypes_on_save) do
            if v == vim.bo.filetype then
                vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
                break
            end
        end
    end
end

if ld then
    null_ls.setup({
        debug = false,
        debounce = 150,
        sources = sources,
        on_attach = on_attach,
    })
end
