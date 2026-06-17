local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmta = require("luasnip.extras.fmt").fmta

local function in_mathzone()
  return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

local function ms(trig, nodes, opts)
  opts = opts or {}
  return s({
    trig = trig,
    snippetType = "autosnippet",
    condition = in_mathzone,
    regTrig = opts.regTrig,
    trigEngine = opts.trigEngine,
    wordTrig = opts.wordTrig or false,
    priority = opts.priority,
  }, nodes)
end

local function sm(trig, repl)
  return ms(trig, { t(repl) })
end

local snippets = {
  -- Greek letters
  sm("@a", "\\alpha"),
  sm("@A", "\\alpha"),
  sm("@b", "\\beta"),
  sm("@B", "\\beta"),
  sm("@c", "\\chi"),
  sm("@C", "\\chi"),
  sm("@g", "\\gamma"),
  sm("@G", "\\Gamma"),
  sm("@d", "\\delta"),
  sm("@D", "\\Delta"),
  sm("@e", "\\epsilon"),
  sm("@E", "\\epsilon"),
  sm(":e", "\\varepsilon"),
  sm(":E", "\\varepsilon"),
  sm("@z", "\\zeta"),
  sm("@Z", "\\zeta"),
  sm("@t", "\\theta"),
  sm("@T", "\\Theta"),
  sm("@k", "\\kappa"),
  sm("@K", "\\kappa"),
  sm("@l", "\\lambda"),
  sm("@L", "\\Lambda"),
  sm("@m", "\\mu"),
  sm("@M", "\\mu"),
  sm("@r", "\\rho"),
  sm("@R", "\\rho"),
  sm("@s", "\\sigma"),
  sm("@S", "\\Sigma"),
  sm("ome", "\\omega"),
  sm("@o", "\\omega"),
  sm("@O", "\\Omega"),
  sm("@u", "\\tau"),
  sm("@U", "\\Tau"),

  -- Operations
  ms("text", fmta("\\text{<>}", { i(1) })),
  ms("bf", fmta("\\mathbf{<>}", { i(1) })),
  sm("sr", "^{2}"),
  sm("cb", "^{3}"),
  ms("rd", fmta("^{<>}<>", { i(1), i(0) })),
  ms("_", fmta("_{<>}<>", { i(1), i(0) })),
  ms("sq", fmta("\\sqrt{ <> }<>", { i(1), i(0) })),
  ms("//", fmta("\\frac{<>}{<>}<>", { i(1), i(2), i(0) })),
  ms("ee", fmta("e^{ <> }<>", { i(1), i(0) })),
  ms("rm", fmta("\\mathrm{<>}<>", { i(1), i(0) })),
  sm("conj", "^{*}"),
  sm("trace", "\\mathrm{Tr}"),
  sm("det", "\\det"),
  sm("re", "\\mathrm{Re}"),
  sm("im", "\\mathrm{Im}"),

  -- Decorations
  ms("bar", fmta("\\bar{<>}<>", { i(1), i(0) })),
  ms("hat", fmta("\\hat{<>}<>", { i(1), i(0) })),
  ms("dot", fmta("\\dot{<>}<>", { i(1), i(0) })),
  ms("ddot", fmta("\\ddot{<>}<>", { i(1), i(0) }), { priority = 2 }),
  ms("vec", fmta("\\vec{<>}<>", { i(1), i(0) })),
  ms("tilde", fmta("\\tilde{<>}<>", { i(1), i(0) })),
  ms("und", fmta("\\underline{<>}<>", { i(1), i(0) })),

  -- Symbols
  sm("ooo", "\\infty"),
  sm("sum", "\\sum"),
  sm("prod", "\\prod"),
  ms("lim", fmta("\\lim_{ <> \\to <> } <>", { i(1, "n"), i(2, "\\infty"), i(0) })),
  sm("+-", "\\pm"),
  sm("-+", "\\mp"),
  sm("...", "\\dots"),
  sm("<->", "\\leftrightarrow "),
  sm("->", "\\to"),
  sm("!>", "\\mapsto"),
  sm("invs", "^{-1}"),
  sm("||", "\\mid"),
  sm("and", "\\cap"),
  sm("orr", "\\cup"),
  sm("inn", "\\in"),
  ms("set", fmta("\\{ <> \\}<>", { i(1), i(0) })),
  sm("=>", "\\implies"),
  sm("=<", "\\impliedby"),
  sm("iff", "\\iff"),
  sm("===", "\\equiv"),
  sm("Sq", "\\square"),
  sm("!=", "\\neq"),
  sm(">=", "\\geq"),
  sm("<=", "\\leq"),
  sm(">>", "\\gg"),
  sm("<<", "\\ll"),
  sm("~~", "\\sim"),
  sm("prop", "\\propto"),
  sm("nabl", "\\nabla"),
  sm("del", "\\nabla"),
  sm("xx", "\\times"),
  sm("**", "\\cdot"),
  sm("para", "\\parallel"),

  -- Common subscripts
  sm("xnn", "x_{n}"),
  sm("xii", "x_{i}"),
  sm("xjj", "x_{j}"),
  sm("xp1", "x_{n+1}"),
  sm("ynn", "y_{n}"),
  sm("yii", "y_{i}"),
  sm("yjj", "y_{j}"),

  -- Fonts
  ms("mcal", fmta("\\mathcal{<>}<>", { i(1), i(0) })),
  ms("mbb", fmta("\\mathbb{<>}<>", { i(1), i(0) })),
  sm("ell", "\\ell"),
  sm("lll", "\\ell"),
  sm("LL", "\\mathcal{L}"),
  sm("HH", "\\mathcal{H}"),
  sm("CC", "\\mathbb{C}"),
  sm("RR", "\\mathbb{R}"),
  sm("ZZ", "\\mathbb{Z}"),
  sm("NN", "\\mathbb{N}"),
  sm("II", "\\mathbb{1}"),
  sm("AA", "\\mathcal{A}"),
  sm("BB", "\\mathbf{B}"),
  sm("EE", "\\mathbf{E}"),

  -- Unit vectors
  sm(":i", "\\mathbf{i}"),
  sm(":j", "\\mathbf{j}"),
  sm(":k", "\\mathbf{k}"),
  sm(":x", "\\hat{\\mathbf{x}}"),
  sm(":y", "\\hat{\\mathbf{y}}"),
  sm(":z", "\\hat{\\mathbf{z}}"),

  -- Derivatives
  ms("pdv3", fmta("\\pdv[3]{<>}{<>}<>", { i(1, "y"), i(2, "x"), i(0) })),
  ms("pdv2", fmta("\\pdv[2]{<>}{<>}<>", { i(1, "y"), i(2, "x"), i(0) })),

  s(
    { trig = "pdv", condition = in_mathzone },
    fmta("\\pdv{<>}{<>}<>", {
      i(1, "y"),
      i(2, "x"),
      i(0),
    })
  ),

  s(
    { trig = "dv", condition = in_mathzone },
    fmta("\\dv{<>}{<>}<>", {
      i(1, "y"),
      i(2, "x"),
      i(0),
    })
  ),

  ms("ddt", fmta("\\dv{<>}{t}", { i(1) })),

  -- Integrals
  ms("oinf", fmta("\\int_{0}^{\\infty} <> \\, d<> <>", { i(1), i(2, "x"), i(0) })),
  ms("infi", fmta("\\int_{-\\infty}^{\\infty} <> \\, d<> <>", { i(1), i(2, "x"), i(0) })),
  ms("dint", fmta("\\int_{<>}^{<>} <> \\, d<> <>", { i(1, "0"), i(2, "\\infty"), i(3), i(4, "x"), i(0) })),
  sm("oint", "\\oint"),
  sm("iiint", "\\iiint"),
  sm("iint", "\\iint"),
  ms("int", fmta("\\int <> \\, d<> <>", { i(1), i(2, "x"), i(0) })),

  -- Physics / QM
  sm("kbt", "k_{B}T"),
  sm("hba", "\\hbar"),
  sm("dag", "^{\\dagger}"),
  sm("o+", "\\oplus "),
  sm("ox", "\\otimes "),
  ms("bra", fmta("\\bra{<>} <>", { i(1), i(0) })),
  ms("ket", fmta("\\ket{<>} <>", { i(1), i(0) })),
  ms("brk", fmta("\\braket{ <> | <> } <>", { i(1), i(2), i(0) })),
  ms("outp", fmta("\\ket{<>} \\bra{<>} <>", { i(1, "\\psi"), i(2, "\\psi"), i(0) })),

  -- Astro / chemistry
  ms("pu", fmta("\\pu{ <> }", { i(1) })),
  sm("msun", "M_{\\odot}"),
  sm("solm", "M_{\\odot}"),
  ms("ce", fmta("\\ce{ <> }", { i(1) })),
  ms("iso", fmta("{}^{<>}_{<>}<>", { i(1, "4"), i(2, "2"), i(3, "He") })),
  sm("hel4", "{}^{4}_{2}He "),
  sm("hel3", "{}^{3}_{2}He "),

  -- -- Environments
  -- ms("pmat", fmta("\\begin{pmatrix}\n<>\n\\end{pmatrix}", { i(1) })),
  -- ms("bmat", fmta("\\begin{bmatrix}\n<>\n\\end{bmatrix}", { i(1) })),
  -- ms("Bmat", fmta("\\begin{Bmatrix}\n<>\n\\end{Bmatrix}", { i(1) })),
  -- ms("vmat", fmta("\\begin{vmatrix}\n<>\n\\end{vmatrix}", { i(1) })),
  -- ms("Vmat", fmta("\\begin{Vmatrix}\n<>\n\\end{Vmatrix}", { i(1) })),
  -- ms("case", fmta("\\begin{cases}\n<>\n\\end{cases}", { i(1) })),
  -- ms("align", fmta("\\begin{align}\n<>\n\\end{align}", { i(1) })),
  -- ms("array", fmta("\\begin{array}\n<>\n\\end{array}", { i(1) })),
  -- ms("matrix", fmta("\\begin{matrix}\n<>\n\\end{matrix}", { i(1) })),

  -- Brackets
  ms("avg", fmta("\\langle <> \\rangle <>", { i(1), i(0) })),
  ms("norm", fmta("\\lvert <> \\rvert <>", { i(1), i(0) })),
  ms("mod", fmta("|<>|<>", { i(1), i(0) })),
  ms("lr(", fmta("\\left( <> \\right) <>", { i(1), i(0) })),
  ms("lr|", fmta("\\left| <> \\right| <>", { i(1), i(0) })),
  ms("lr{", fmta("\\left\\{ <> \\right\\} <>", { i(1), i(0) })),
  ms("lr[", fmta("\\left[ <> \\right] <>", { i(1), i(0) })),
  ms("lra", fmta("\\left\\langle <> \\right\\rangle <>", { i(1), i(0) })),

  -- Misc
  ms(
    "tayl",
    fmta("<>(<> + <>) = <>(<>) + <>'(<>)<> + <>''(<>) \\frac{<>^{2}}{2!} + \\dots<>", {
      i(1, "f"),
      i(2, "x"),
      i(3, "h"),
      i(4, "f"),
      i(5, "x"),
      i(6, "f"),
      i(7, "x"),
      i(8, "h"),
      i(9, "f"),
      i(10, "x"),
      i(11, "h"),
      i(0),
    })
  ),
}

-- Regex snippets
table.insert(
  snippets,
  ms("([A-Za-z])(\\d)", {
    f(function(_, snip)
      return snip.captures[1] .. "_{" .. snip.captures[2] .. "}"
    end),
  }, { regTrig = true, priority = -1 })
)

table.insert(
  snippets,
  ms("([A-Za-z])bar", {
    f(function(_, snip)
      return "\\bar{" .. snip.captures[1] .. "}"
    end),
  }, { regTrig = true })
)

table.insert(
  snippets,
  ms("([A-Za-z])hat", {
    f(function(_, snip)
      return "\\hat{" .. snip.captures[1] .. "}"
    end),
  }, { regTrig = true })
)

table.insert(
  snippets,
  ms("([A-Za-z])dot", {
    f(function(_, snip)
      return "\\dot{" .. snip.captures[1] .. "}"
    end),
  }, { regTrig = true })
)

table.insert(
  snippets,
  ms("([A-Za-z])ddot", {
    f(function(_, snip)
      return "\\ddot{" .. snip.captures[1] .. "}"
    end),
  }, { regTrig = true, priority = 3 })
)

table.insert(
  snippets,
  ms("([A-Za-z])vec", {
    f(function(_, snip)
      return "\\vec{" .. snip.captures[1] .. "}"
    end),
  }, { regTrig = true })
)

table.insert(
  snippets,
  ms("([A-Za-z])tilde", {
    f(function(_, snip)
      return "\\tilde{" .. snip.captures[1] .. "}"
    end),
  }, { regTrig = true })
)

table.insert(
  snippets,
  ms("([A-Za-z])und", {
    f(function(_, snip)
      return "\\underline{" .. snip.captures[1] .. "}"
    end),
  }, { regTrig = true })
)
local greek = {
  a = "\\alpha",
  b = "\\beta",
  g = "\\gamma",
  d = "\\delta",
  e = "\\epsilon",
  t = "\\theta",
  l = "\\lambda",
  m = "\\mu",
  r = "\\rho",
  s = "\\sigma",
  o = "\\omega",
}

local function greek_var(x)
  return greek[x] or x
end

table.insert(
  snippets,
  ms("dv([a-z])([a-z])", {
    f(function(_, snip)
      return "\\dv{" .. greek_var(snip.captures[1]) .. "}{" .. greek_var(snip.captures[2]) .. "}"
    end),
  }, { regTrig = true, trigEngine = "pattern", priority = 1000 })
)

table.insert(
  snippets,
  ms("pdv([a-z])([a-z])", {
    f(function(_, snip)
      return "\\pdv{" .. greek_var(snip.captures[1]) .. "}{" .. greek_var(snip.captures[2]) .. "}"
    end),
  }, { regTrig = true, trigEngine = "pattern", priority = 1000 })
)
return snippets
