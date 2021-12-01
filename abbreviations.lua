

-- this trick was found on
-- https://github.com/nanotee/nvim-lua-guide/issues/37

local api = vim.api

local ex = setmetatable({}, {
    __index = function(t, k)
      local command = k:gsub("_$", "!")
      local f = function(...)
        return api.nvim_command(table.concat(vim.tbl_flatten {command, ...}, " "))
      end
      rawset(t, k, f)
      return f
    end
});

ex.abbrev('foo', 'bar')
ex.abbrev('ps', 'PackerSync')
ex.abbrev('pi', 'PackerInstall')
ex.abbrev('pc', 'PackerClean')
ex.abbrev('pu', 'PackerUpdate')
ex.abbrev('pcp', 'PackerCompile')
ex.abbrev("help", "vertical help")
ex.abbrev("h", "vertical help")
ex.abbrev("ve", "verbose")
ex.abbrev("va", "verbose autocmd")
