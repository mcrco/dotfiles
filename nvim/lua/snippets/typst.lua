local ls = require("luasnip")
local t = ls.text_node
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local conds = require("luasnip.extras.conditions")
local fmta = require("luasnip.extras.fmt").fmta

-- Function to check if we're in math environment
local function in_math()
    return vim.api.nvim_eval("typst#in_math()") == 1
end

-- Condition for math environment
local math = conds.make_condition(in_math)

return {
    s({ trig = "mk", snippetType = "autosnippet", wordTrig = true }, { t("$"), i(1), t("$"), i(2) }, {}),
    s(
        { trig = "dm", dscr = "Problem set sub-question", snippetType = "autosnippet", wordTrig = true },
        fmta(
            [[
$
  <>
$ <>
        ]],
            { i(1), i(2) }
        )
    ),

    -- Definite integral
    s(
        { trig = "dint", snippetType = "autosnippet", wordTrig = true },
        fmta("integral_(<>)^(<>) <> d<><>", { i(1, "-\\infty"), i(2, "\\infty"), i(3), i(4), i(0) }),
        { condition = math }
    ),

    -- Powers
    s({ trig = "sr", snippetType = "autosnippet", wordTrig = false }, { t("^2") }, { condition = math }),
    s({ trig = "cb", snippetType = "autosnippet", wordTrig = false }, { t("^3") }, { condition = math }),
    s(
        { trig = "rd", snippetType = "autosnippet", wordTrig = false },
        fmta("^(<>)<>", { i(1), i(0) }),
        { condition = math }
    ),

    -- Math stuff
    s({ trig = "==", snippetType = "autosnippet" }, { t("&=") }, { condition = math }),

    -- Problem Sets
    s(
        { trig = "pset", dscr = "Problem set template", regTrig = false, wordTrig = false },
        fmta(
            [[
#let ans(body) = {
  block(
    width: 100%,
    stroke: 1pt + black,
    inset: 10pt,
    radius: 5pt,
    fill: luma(250),
    [
      *Solution*: #body
    ]
  )
}
#let prf(body) = { [_Proof:_ #body $square$] }
#let qs(body) = {
  set enum(numbering: "(a)")
  body
}
#let pt(body) = {
  body
}

#align(center)[
  = <> -- <>
  Marco Yang
]

        ]],
            { i(1), i(2) }
        )
    ),
    s(
        { trig = "qs", dscr = "Problem set question", regTrig = false, wordTrig = false },
        fmta(
            [[
+ #qs[
  <>
]
        ]],
            { i(1) }
        )
    ),
    s(
        { trig = "pt", dscr = "Problem set sub-question", regTrig = false, wordTrig = false },
        fmta(
            [[
+ #pt[
  <>
]
        ]],
            { i(1) }
        )
    ),
    s(
        { trig = "ans", dscr = "Problem set solution", regTrig = false, wordTrig = false },
        fmta(
            [[
#ans[
  <>
]
        ]],
            { i(1) }
        )
    ),

    -- Auto subscript with one digit
    s({ trig = "([A-Za-z])(%d)", regTrig = true, wordTrig = false, snippetType = "autosnippet" }, {
        f(function(_, snip)
            return snip.captures[1]
        end),
        t("_"),
        f(function(_, snip)
            return snip.captures[2]
        end),
    }, { condition = math }),

    -- Auto subscript with two digits
    s({ trig = "([A-Za-z])_(%d%d)", regTrig = true, wordTrig = false, snippetType = "autosnippet" }, {
        f(function(_, snip)
            return snip.captures[1]
        end),
        t("_("),
        f(function(_, snip)
            return snip.captures[2]
        end),
        t(")"),
    }, { condition = math }),

    -- Subscript
    s(
        { trig = "_", snippetType = "autosnippet", regTrig = true, wordTrig = false },
        fmta("_(<>)<>", { i(1), i(0) }),
        { condition = math }
    ),
}
