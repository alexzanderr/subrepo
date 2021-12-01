

require("nvim-gps").setup({
	icons = {
		["class-name"] = '  ',      -- Classes and class-like objects
		["function-name"] = '  ',   -- Functions
		["method-name"] = '  ',     -- Methods (functions inside class-like objects)
		["container-name"] = '⛶  ',  -- Containers (example: lua tables)
		["tag-name"] = '炙 '         -- Tags (example: html tags)
	},
	-- Disable any languages individually over here
	-- Any language not disabled here is enabled by default
	languages = {
		-- ["bash"] = false,
		-- ["go"] = false,
	},
	separator = " ❱  ",
	-- separator = " > ",

})
