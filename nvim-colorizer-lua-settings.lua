-- nvim-colorizer-lua
--
-- plugin url
-- https://github.com/norcalli/nvim-colorizer.lua
--
-- TODO fix the not rust, because i want colors in rust, except the name codes
require"colorizer".setup({ "*", "!rust" }, {
    RGB = true, -- #RGB hex codes
    RRGGBB = true, -- #RRGGBB hex codes
    names = false, -- "Name" codes like Blue
    RRGGBBAA = true, -- #RRGGBBAA hex codes
    rgb_fn = true, -- CSS rgb() and rgba() functions
    hsl_fn = true, -- CSS hsl() and hsla() functions
    css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
    mode = "background"
})

