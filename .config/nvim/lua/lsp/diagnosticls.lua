local M = {}

M.filetypes = {
    javascript = "eslint",
    javascriptreact = "eslint",
    typescript = "eslint",
    typescriptreact = "eslint",
    markdown = {"markdownlint", "writeGood"},
    lua = "",
    yaml = "",
    json = "",
    jsonc = ""
}

M.linters = {
    eslint = {
        sourceName = "eslint",
        command = "eslint_d",
        rootPatterns = {".eslintrc.js", "package.json"},
        debounce = 100,
        args = {"--stdin", "--stdin-filename", "%filepath", "--format", "json"},
        parseJson = {
            errorsRoot = "[0].messages",
            line = "line",
            column = "column",
            endLine = "endLine",
            endColumn = "endColumn",
            message = "${message} [${ruleId}]",
            security = "severity"
        },
        securities = {[2] = "error", [1] = "warning"}
    },
    markdownlint = {
        command = "markdownlint",
        rootPatterns = {".git"},
        isStderr = true,
        debounce = 100,
        args = {
            "--config", vim.fn.getenv("HOME") .. "/.markdownlint.json",
            "--stdin"
        },
        offsetLine = 0,
        offsetColumn = 0,
        sourceName = "markdownlint",
        securities = {undefined = "hint"},
        formatLines = 1,
        formatPattern = {
            "^.*:(\\d+)\\s+(.*)$", {line = 1, column = -1, message = 2}
        }
    },
    writeGood = {
        command = "write-good",
        debounce = 100,
        args = {"--text=%text"},
        offsetLine = 0,
        offsetColumn = 1,
        sourceName = "write-good",
        formatLines = 1,
        formatPattern = {
            "(.*)\\s+on\\s+line\\s+(\\d+)\\s+at\\s+column\\s+(\\d+)\\s*$",
            {line = 2, column = 3, message = 1}
        }
    }
}

M.formatters = {
    luaFormat = {
        command = "lua-format",
        args = {"--single-quote-to-double-quote", "-i"}
    },
    prettier = {command = "prettier", args = {"--stdin-filepath", "%filepath"}}
}

M.formatFiletypes = {
    lua = "luaFormat",
    javascript = "prettier",
    javascriptreact = "prettier",
    typescript = "prettier",
    typescriptreact = "prettier",
    markdown = "prettier",
    yaml = "prettier",
    json = "prettier",
    jsonc = "prettier"
}

return M
