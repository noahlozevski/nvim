require("catppuccin").setup({
	flavour = "mocha", -- latte, frappe, macchiato, mocha
	background = { -- :h background
	light = "frappe",
	dark = "mocha"
},
transparent_background = true,
show_end_of_buffer = false, -- show the '~' characters after the end of buffers
term_colors = true,
dim_inactive = {
	enabled = false,
	shade = "dark",
	percentage = 0.15
},
no_italic = false, -- Force no italic
no_bold = false, -- Force no bold
styles = {
	comments = {"italic"},
	conditionals = {"italic"},
	loops = {},
	functions = {},
	keywords = {},
	strings = {},
	variables = {},
	numbers = {},
	booleans = {},
	properties = {},
	types = {},
	operators = {}
},
color_overrides = {
	all = {},
	latte = {},
	frappe = {},
	macchiato = {},
	mocha = {}
},
integrations = {
	-- <module> = <boolean>
	harpoon = true,        
	telescope = true,
	treesitter = true,
	treesitter_context = true,
}
})
vim.cmd.colorscheme "catppuccin"
