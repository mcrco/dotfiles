local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local extras = require("luasnip.extras")
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = extras.rep
local events = require("luasnip.util.events")
local conds = require("luasnip.extras.conditions")
local ai = require("luasnip.nodes.absolute_indexer")
local types = require("luasnip.util.types")

-- Function to check if we're in math environment
local function in_math()
    return vim.api.nvim_eval("vimtex#syntax#in_mathzone()") == 1
end

-- Condition for math environment
local math = conds.make_condition(in_math)

-- Reusable function to format regex captures for fraction snippets
local function get_visual(args, parent)
    if #parent.snippet.env.SELECT_RAW > 0 then
        return sn(nil, t(parent.snippet.env.SELECT_RAW))
    else
        return sn(nil, i(1))
    end
end

return {
    -- Begin/End environment snippet
    s({
        trig = "beg",
        dscr = "begin{} / end{} environment",
        regTrig = false,
        wordTrig = true,
        snippetType = "autosnippet",
    }, fmta("\\begin{<>}\n\t<>\n\\end{<>}", { i(1), i(0), rep(1) })),

    -- Problem set template snippet
    s(
        { trig = "pset", dscr = "Problem set template", regTrig = false, wordTrig = false },
        fmta(
            [[
\documentclass[answers]{exam}
\makeindex

\usepackage{amsmath, amsfonts, amssymb, amstext, amscd, amsthm, makeidx, graphicx, hyperref, url, enumerate}
\newtheorem{theorem}{Theorem}
\allowdisplaybreaks

\begin{document}

\begin{center}
{\Large <>} \\
\medskip
Marco Yang
\bigskip
\end{center}

\begin{questions}
    \question <>
\end{questions}

\end{document}
        ]],
            { i(1), i(2) }
        )
    ),

    -- LaTeX dots (in math)
    s({ trig = "...", wordTrig = false, snippetType = "autosnippet" }, { t("\\ldots") }, { condition = math }),

    -- Table environment
    s(
        { trig = "table", dscr = "Table environment", wordTrig = false },
        fmta(
            [[
\begin{table}[<>]
    \centering
    \caption{<>}
    \label{tab:<>}
    \begin{tabular}{<>}
    <>
    \end{tabular}
    \end{table}
]],
            {
                i(1, "htpb"),
                i(2, "caption"),
                i(3, "label"),
                i(4, "c"),
                i(0),
            }
        )
    ),

    -- Figure environment
    s(
        { trig = "fig", dscr = "Figure environment", wordTrig = true },
        fmta(
            [[
\begin{figure}[<>]
    \centering
    <>\includegraphics[width=0.8\textwidth]{<>}
    \caption{<>}
    \label{fig:<>}
\end{figure}
        ]],
            {
                i(1, "htpb"),
                i(2, ""),
                i(3),
                i(4, ""),
                f(function(args)
                    local arg = args[1][1] or ""
                    return arg:gsub("\\W+", "-")
                end, { 3 }),
            }
        )
    ),

    -- Enumerate environment
    s(
        { trig = "enum", dscr = "Enumerate environment", wordTrig = false },
        fmta(
            [[
\begin{enumerate}
    \item <>
\end{enumerate}
        ]],
            { i(0) }
        )
    ),

    -- Itemize environment
    s(
        { trig = "item", dscr = "Itemize environment", wordTrig = false },
        fmta(
            [[
\begin{itemize}
\item <>
\end{itemize}
        ]],
            { i(0) }
        )
    ),

    -- Description environment
    s(
        { trig = "desc", dscr = "Description environment", wordTrig = true },
        fmta(
            [[
\begin{description}
\item[<>] <>
\end{description}
        ]],
            { i(1), i(0) }
        )
    ),

    -- Package import
    s(
        { trig = "pac", dscr = "Package", wordTrig = true },
        fmta("\\usepackage[<>]{<>}<>", { i(1, "options"), i(2, "package"), i(0) })
    ),

    -- Implication symbols
    s({ trig = "=>", snippetType = "autosnippet" }, { t("\\implies") }, { condition = math }),
    s({ trig = "=<", snippetType = "autosnippet" }, { t("\\impliedby") }, { condition = math }),
    s({ trig = "iff", snippetType = "autosnippet" }, { t("\\iff") }, { condition = math }),

    -- Inline math
    s({ trig = "mk", snippetType = "autosnippet", wordTrig = true }, { t("$"), i(1), t("$"), i(2) }, {}),

    -- Display math
    s(
        { trig = "dm", snippetType = "autosnippet", wordTrig = true },
        fmta(
            [[
\[
    <>
.\] <>
        ]],
            { i(1), i(0) }
        ),
        {}
    ),

    -- Align environment
    s(
        { trig = "^ali", snippetType = "autosnippet", wordTrig = true, regTrig = true },
        fmta(
            [[
\begin{align*}
    <>
.\end{align*}
        ]],
            { i(1) }
        ),
        {}
    ),

    -- Parts environment
    s({ trig = "parts", wordTrig = true }, fmta("\\begin{parts}\n\t\\part <>\n\\end{parts}", { i(1) })),

    -- Fraction
    s(
        { trig = "//", snippetType = "autosnippet", wordTrig = false },
        fmta("\\frac{<>}{<>}<>", { i(1), i(2), i(0) }),
        { condition = math }
    ),

    -- Fraction with visual selection
    s(
        { trig = "/", wordTrig = false },
        fmta("\\frac{<>}{<>}<>", {
            d(1, get_visual),
            i(2),
            i(0),
        }),
        { condition = math }
    ),

    -- Symbol fraction using regex
    s(
        { trig = "([%d%a]+)/", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta("\\frac{<>}{<>}<>", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            i(1),
            i(0),
        }),
        { condition = math }
    ),

    -- Parentheses fraction using regex
    s({ trig = "([^%s]+)%)/", regTrig = true, wordTrig = false, snippetType = "autosnippet" }, {
        f(function(_, snip)
            local str = snip.captures[1]
            local depth = 0
            local i = #str

            while i > 0 do
                if str:sub(i, i) == ")" then
                    depth = depth + 1
                elseif str:sub(i, i) == "(" then
                    depth = depth - 1
                end

                if depth == 0 then
                    break
                end
                i = i - 1
            end

            local prefix = str:sub(1, i - 1)
            local content = str:sub(i + 1, #str - 1)

            return prefix .. "\\frac{" .. content .. "}"
        end),
        t("{"),
        i(1),
        t("}"),
        i(0),
    }, { condition = math }),

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
        t("_{"),
        f(function(_, snip)
            return snip.captures[2]
        end),
        t("}"),
    }, { condition = math }),

    -- Common math operators and symbols
    s({ trig = "approx", snippetType = "autosnippet" }, { t("\\approx") }, { condition = math }),
    s({ trig = "prop", snippetType = "autosnippet" }, { t("\\propto") }, { condition = math }),
    s({ trig = "perpp", snippetType = "autosnippet" }, { t("\\perp") }, { condition = math }),
    s({ trig = "==", snippetType = "autosnippet" }, { t("&="), i(1) }, {}),
    s({ trig = "!=", snippetType = "autosnippet" }, { t("\\neq ") }, {}),

    -- Ceiling and floor
    s(
        { trig = "ceil", snippetType = "autosnippet" },
        fmta("\\left\\lceil <> \\right\\rceil <>", { i(1), i(0) }),
        { condition = math }
    ),
    s(
        { trig = "floor", snippetType = "autosnippet" },
        fmta("\\left\\lfloor <> \\right\\rfloor<>", { i(1), i(0) }),
        { condition = math }
    ),

    -- Matrix environments
    s(
        { trig = "pmat", snippetType = "autosnippet" },
        fmta("\\begin{pmatrix} \n\t<> \n\\end{pmatrix} <>", { i(1), i(0) }),
        {}
    ),
    s({ trig = "fj", snippetType = "autosnippet" }, { t(" & ") }, { condition = math }),
    s(
        { trig = "bmat", snippetType = "autosnippet" },
        fmta("\\begin{bmatrix} <> \\end{bmatrix} <>", { i(1), i(0) }),
        {}
    ),

    -- Delimiters
    -- s(
    --     { trig = "()", snippetType = "autosnippet" },
    --     fmta("\\left( <> \\right) <>", { i(1), i(0) }),
    --     { condition = math }
    -- ),
    s({ trig = "lr", wordTrig = false }, fmta("\\left( <> \\right) <>", { i(1), i(0) }), {}),
    s({ trig = "lr(", wordTrig = false }, fmta("\\left( <> \\right) <>", { i(1), i(0) }), {}),
    s({ trig = "lr|", wordTrig = false }, fmta("\\left| <> \\right| <>", { i(1), i(0) }), {}),
    s({ trig = "lr{", wordTrig = false }, fmta("\\left\\{ <> \\right\\} <>", { i(1), i(0) }), {}),
    s({ trig = "lrb", snippetType = "autosnippet" }, fmta("\\left[ <> \\right] <>", { i(1), i(0) }), {}),
    s({ trig = "lr[]", snippetType = "autosnippet" }, fmta("\\left[ <> \\right] <>", { i(1), i(0) }), {}),
    s({ trig = "lra", snippetType = "autosnippet" }, fmta("\\left\\langle<>\\right\\rangle<>", { i(1), i(0) }), {}),

    -- Conjugate
    s({ trig = "conj", snippetType = "autosnippet" }, fmta("\\overline{<>}<>", { i(1), i(0) }), { condition = math }),

    -- Sum operator
    s(
        { trig = "sum", snippetType = "autosnippet", wordTrig = true },
        fmta("\\sum_{<>}^{<>}<>", { i(1), i(2), i(3) }),
        { condition = math }
    ),

    -- Taylor series
    s(
        { trig = "taylor", wordTrig = true },
        fmta(
            "\\sum_{<>=${<>}}^{<>} <> (x-a)^<> <>",
            { i(1, "k"), i(2, "0"), i(3, "\\infty"), i(4, "c_$1"), rep(1), i(0) }
        ),
        {}
    ),

    -- Limits
    s(
        { trig = "lim", snippetType = "autosnippet", wordTrig = true },
        fmta("\\lim_{<> \\to <>} ", { i(1, "n"), i(2, "\\infty") }),
        { condition = math }
    ),
    s({ trig = "limsup", wordTrig = true }, fmta("\\limsup_{<> \\to <>} ", { i(1, "n"), i(2, "\\infty") }), {}),

    -- Product
    s(
        { trig = "prod", wordTrig = true },
        fmta("\\prod_{<>}^{<>} <> <>", { i(1, "i=1"), i(2, "\\infty"), i(3), i(0) }),
        {}
    ),

    -- Partial derivative
    s(
        { trig = "part", wordTrig = true },
        fmta("\\frac{\\partial <>}{\\partial <>} <>", { i(1, "V"), i(2, "x"), i(0) }),
        {}
    ),
    s({ trig = "parsub", wordTrig = true }, fmta("\\partial_{<>} <>", { i(1, "x"), i(0) }), {}),

    -- dx
    s({ trig = "ddx", snippetType = "autosnippet" }, { t("\\, dx "), i(0) }, {}),

    -- Square root
    s({ trig = "sq", snippetType = "autosnippet" }, fmta("\\sqrt{<>}<>", { i(1), i(0) }), { condition = math }),

    -- Powers
    s({ trig = "sr", snippetType = "autosnippet", wordTrig = false }, { t("^2") }, { condition = math }),
    s({ trig = "cb", snippetType = "autosnippet", wordTrig = false }, { t("^3") }, { condition = math }),
    s(
        { trig = "td", snippetType = "autosnippet", wordTrig = false },
        fmta("^{<>}<>", { i(1), i(0) }),
        { condition = math }
    ),
    s(
        { trig = "rd", snippetType = "autosnippet", wordTrig = false },
        fmta("^{<>}<>", { i(1), i(0) }),
        { condition = math }
    ),

    -- Subscript
    s(
        { trig = "_", snippetType = "autosnippet", regTrig = true, wordTrig = false },
        fmta("_{<>}<>", { i(1), i(0) }),
        { condition = math }
    ),

    -- Argmax/Argmin
    s(
        { trig = "argmax", snippetType = "autosnippet" },
        fmta("\\underset{<>}{\\text{argmax }} <>", { i(1), i(0) }),
        { condition = math }
    ),
    s(
        { trig = "argmin", snippetType = "autosnippet" },
        fmta("\\underset{<>}{\\text{argmin }} <>", { i(1), i(0) }),
        { condition = math }
    ),

    -- Infinity and other symbols
    s({ trig = "ooo", snippetType = "autosnippet" }, { t("\\infty") }, {}),
    s({ trig = "equiv", snippetType = "autosnippet" }, { t("\\equiv") }, { condition = math }),
    s({ trig = "not", snippetType = "autosnippet" }, { t("\\not") }, { condition = math }),
    s({ trig = "!||", snippetType = "autosnippet" }, { t("\\nmid") }, { condition = math }),
    s({ trig = "mod", snippetType = "autosnippet" }, fmta("\\mod <> <>", { i(1), i(0) }), { condition = math }),

    -- Indexed family notation
    s(
        { trig = "rij", wordTrig = false },
        fmta("(<>_<>)_{<>\\in<>}<>", { i(1, "x"), i(2, "n"), i(3, "$2"), i(4, "\\N"), i(0) }),
        { condition = math }
    ),

    -- Inequalities
    s({ trig = "<=", snippetType = "autosnippet" }, { t("\\le ") }, {}),
    s({ trig = ">=", snippetType = "autosnippet" }, { t("\\ge ") }, {}),

    -- Logic symbols
    s({ trig = "EE", snippetType = "autosnippet" }, { t("\\exists ") }, { condition = math }),
    s({ trig = "fora", snippetType = "autosnippet" }, { t("\\forall ") }, { condition = math }),

    -- Common variable subscripts
    s({ trig = "xnn", snippetType = "autosnippet" }, { t("x_{n}") }, { condition = math }),
    s({ trig = "ynn", snippetType = "autosnippet" }, { t("y_{n}") }, { condition = math }),
    s({ trig = "xii", snippetType = "autosnippet" }, { t("x_{i}") }, { condition = math }),
    s({ trig = "yii", snippetType = "autosnippet" }, { t("y_{i}") }, { condition = math }),
    s({ trig = "xjj", snippetType = "autosnippet" }, { t("x_{j}") }, { condition = math }),
    s({ trig = "yjj", snippetType = "autosnippet" }, { t("y_{j}") }, { condition = math }),
    s({ trig = "xp1", snippetType = "autosnippet" }, { t("x_{n+1}") }, { condition = math }),
    s({ trig = "xmm", snippetType = "autosnippet" }, { t("x_{m}") }, { condition = math }),

    -- TikZ plot
    s(
        { trig = "plot", wordTrig = true },
        fmta(
            [[
\begin{figure}[<>]
    \centering
    \begin{tikzpicture}
        \begin{axis}[
            xmin= <>, xmax= <>,
            ymin= <>, ymax = <>,
            axis lines = middle,
        ]
            \addplot[domain=<>:<>, samples=<>]{<>};
        \end{axis}
    \end{tikzpicture}
    \caption{<>}
    \label{<>}
\end{figure}
      ]],
            {
                i(1),
                i(2, "-10"),
                i(3, "10"),
                i(4, "-10"),
                i(5, "10"),
                rep(2),
                rep(3),
                i(6, "100"),
                i(7),
                i(8),
                i(9, "$8"),
            }
        ),
        {}
    ),

    -- TikZ node
    s(
        { trig = "nn", wordTrig = true },
        fmta("\\node[<>] (<>) <> {$<>$};\n<>", {
            i(5),
            f(function(args)
                local str = args[1][1] or ""
                return str:gsub("[^0-9a-zA-Z]", "") .. args[2][1]
            end, { 1, 2 }),
            i(3, "at (0,0) "),
            i(1),
            i(0),
        }),
        { condition = math }
    ),

    -- Math formatting
    s({ trig = "mcal", snippetType = "autosnippet" }, fmta("\\mathcal{<>}<>", { i(1), i(0) }), { condition = math }),
    s({ trig = "lll", snippetType = "autosnippet" }, { t("\\ell") }, {}),
    s({ trig = "nabl", snippetType = "autosnippet" }, { t("\\nabla ") }, { condition = math }),
    s({ trig = "xx", snippetType = "autosnippet" }, { t("\\times") }, { condition = math }),
    s({ trig = "**", snippetType = "autosnippet" }, { t("\\cdot") }, {}),
    s({ trig = "circ", snippetType = "autosnippet" }, { t("\\circ") }, { condition = math }),
    s({ trig = "odt", snippetType = "autosnippet" }, { t("\\odot") }, {}),
    s({ trig = "norm", snippetType = "autosnippet" }, fmta("\\|<>\\|<>", { i(1), i(0) }), { condition = math }),

    -- Trig functions and other standard functions
    s({
        trig = "log",
        wordTrig = false,
        snippetType = "autosnippet",
    }, t("\\log"), { condition = math }),
    s({
        trig = "(sin|cos|tan|arccot|cot|csc|ln|log|exp|star|perp)",
        regTrig = true,
        wordTrig = false,
        snippetType = "autosnippet",
        condition = math,
    }, {
        t("\\"),
        f(function(_, snip)
            return snip.captures[1]
        end),
    }, { condition = math }),

    -- Double integral
    s(
        { trig = "iint", snippetType = "autosnippet", wordTrig = true },
        fmta("\\iint_{<>} <> \\, d<> <>", { i(1), i(2), i(3), i(0) }),
        { condition = math }
    ),

    -- Definite integral
    s(
        { trig = "dint", snippetType = "autosnippet", wordTrig = true },
        fmta("\\int_{<>}^{<>} <> \\, d<><>", { i(1, "-\\infty"), i(2, "\\infty"), i(3), i(4), i(0) }),
        { condition = math }
    ),

    -- Other math functions
    s({
        trig = "(arcsin|arccos|arctan|arccot|arccsc|arcsec|pi|zeta|int)",
        regTrig = true,
        wordTrig = false,
        snippetType = "autosnippet",
    }, {
        t("\\"),
        f(function(_, snip)
            return snip.captures[1]
        end),
    }, { condition = math }),

    -- Binomial coefficient
    s(
        { trig = "choose", snippetType = "autosnippet", wordTrig = true },
        fmta("\\binom{<>}{<>}<>", { i(1), i(2), i(0) }),
        { condition = math }
    ),

    -- Arrows
    s({ trig = "->", snippetType = "autosnippet" }, { t("\\to ") }, { condition = math }),
    s({ trig = "<->", snippetType = "autosnippet" }, { t("\\leftrightarrow") }, { condition = math }),
    s({ trig = "!>", snippetType = "autosnippet" }, { t("\\mapsto ") }, { condition = math }),

    -- Superscripts
    s({ trig = "invs", snippetType = "autosnippet" }, { t("^{-1}") }, { condition = math }),
    s({ trig = "compl", snippetType = "autosnippet" }, { t("^{c}") }, { condition = math }),

    -- Set operations
    s({ trig = "\\\\\\", snippetType = "autosnippet" }, { t("\\setminus") }, { condition = math }),
    s({ trig = ">>", snippetType = "autosnippet" }, { t("\\gg") }, {}),
    s({ trig = "<<", snippetType = "autosnippet" }, { t("\\ll") }, {}),
    s({ trig = "~~", snippetType = "autosnippet" }, { t("\\sim ") }, {}),
    s(
        { trig = "set", snippetType = "autosnippet", wordTrig = true },
        fmta("\\{<>\\}<>", { i(1), i(0) }),
        { condition = math }
    ),
    s({ trig = "mmid", snippetType = "autosnippet" }, { t("\\mid ") }, {}),
    s({ trig = "cc", snippetType = "autosnippet" }, { t("\\subset ") }, { condition = math }),
    s({ trig = "subset", snippetType = "autosnippet" }, { t("\\subset ") }, { condition = math }),
    s({ trig = "notin", snippetType = "autosnippet" }, { t("\\not\\in ") }, { condition = math }),
    s({ trig = "inn", snippetType = "autosnippet" }, { t("\\in ") }, { condition = math }),
    s(
        { trig = "uuu", snippetType = "autosnippet" },
        fmta("\\bigcup_{<> \\in <>} <>", { i(1, "i"), i(2, " I"), i(0) }),
        { condition = math }
    ),
    s(
        { trig = "nnn", snippetType = "autosnippet" },
        fmta("\\bigcap_{<> \\in <>} <>", { i(1, "i"), i(2, " I"), i(0) }),
        { condition = math }
    ),
    s({ trig = "OO", snippetType = "autosnippet" }, { t("\\emptyset") }, { condition = math }),

    -- Number sets
    s({ trig = "RR", snippetType = "autosnippet" }, { t("\\mathbb{R}") }, { condition = math }),
    s({ trig = "QQ", snippetType = "autosnippet" }, { t("\\mathbb{Q}") }, { condition = math }),
    s({ trig = "ZZ", snippetType = "autosnippet" }, { t("\\mathbb{Z}") }, { condition = math }),
    s({ trig = "NN", snippetType = "autosnippet" }, { t("\\mathbb{N}") }, { condition = math }),
    s({ trig = "<!", snippetType = "autosnippet" }, { t("\\triangleleft ") }, { condition = math }),
    s({ trig = "<>", snippetType = "autosnippet" }, { t("\\diamond ") }, {}),

    -- Text formatting in math mode
    s(
        { trig = "sts", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta("_\\text{<>} <>", { i(1), i(0) }),
        { condition = math } -- Only using the math condition
    ),
    s({ trig = "te", snippetType = "autosnippet" }, fmta("\\text{<>}<>", { i(1), i(0) }), { condition = math }),
    s({ trig = "bf", snippetType = "autosnippet" }, fmta("\\textbf{<>}<>", { i(1), i(2) }), { condition = math }),
    s({ trig = "ttt", snippetType = "autosnippet" }, fmta("\\texttt{<>}<>", { i(1), i(2) }), { condition = math }),
    s(
        { trig = "opnm", snippetType = "autosnippet" },
        fmta("\\operatorname{<>}<>", { i(1), i(2) }),
        { condition = math }
    ),

    -- Max function
    s({ trig = "max", snippetType = "autosnippet" }, { t("\\operatorname{max}") }, { condition = math }),
    -- Min function
    s({ trig = "min", snippetType = "autosnippet" }, { t("\\operatorname{min}") }, { condition = math }),

    -- Cases environment
    s(
        { trig = "case", snippetType = "autosnippet", wordTrig = true },
        fmta("\\begin{cases}\n\t<>\n\\end{cases}", { i(1) }),
        { condition = math }
    ),

    -- Big function definition
    s(
        { trig = "bigfun", snippetType = "autosnippet" },
        fmta(
            "\\begin{align*}\n\t<>: <> &\\longrightarrow <> \\\\\\\\\n\t<> &\\longmapsto <>(<>) = <>\n.\\end{align*}",
            { i(1), i(2), i(3), i(4), rep(1), rep(4), i(0) }
        ),
        {}
    ),

    -- Column vector
    s(
        { trig = "cvec", snippetType = "autosnippet" },
        fmta(
            "\\begin{pmatrix} <>_<>\\\\\\\\ \\vdots\\\\\\\\ <>_<> \\end{pmatrix}",
            { i(1, "x"), i(2, "1"), rep(1), rep(2) }
        ),
        { condition = math }
    ),

    -- Underset
    s(
        { trig = "uset", snippetType = "autosnippet" },
        fmta("\\underset{<>}{<>}<>", { i(1), i(2), i(0) }),
        { condition = math }
    ),

    -- Dot notation
    s(
        { trig = "ddot", regTrig = true, snippetType = "autosnippet" },
        fmta("\\ddot{<>}<>", { i(1), i(0) }),
        { condition = math }
    ),
    -- Priority snippets for math decorations with regex capture
    -- ddot snippet (priority 200)
    s({
        trig = "([a-zA-Z])ddot",
        wordTrig = false,
        regTrig = true,
        priority = 200,
        condition = math,
        desc = "\\ddot{} - automatic with letter capture",
    }, {
        f(function(_, snip)
            return "\\ddot{" .. snip.captures[1] .. "}"
        end, {}),
    }),

    -- dot snippet (priority 10) - standalone
    s({
        trig = "dot",
        wordTrig = false,
        priority = 10,
        condition = math,
        desc = "\\dot{} - standalone",
    }, {
        t("\\dot{"),
        i(1),
        t("}"),
        i(0),
    }),

    -- dot snippet with regex capture (priority 100)
    s({
        trig = "([a-zA-Z])dot",
        wordTrig = false,
        regTrig = true,
        priority = 100,
        condition = math,
        desc = "\\dot{} - automatic with letter capture",
    }, {
        f(function(_, snip)
            return "\\dot{" .. snip.captures[1] .. "}"
        end, {}),
    }),

    -- bar snippet (priority 10) - standalone
    s({
        trig = "bar",
        wordTrig = false,
        priority = 10,
        condition = math,
        desc = "\\overline{} - standalone",
    }, {
        t("\\overline{"),
        i(1),
        t("}"),
        i(0),
    }),

    -- bar snippet (priority 10) - standalone
    s({
        trig = "tld",
        wordTrig = false,
        priority = 10,
        condition = math,
        snippetType = "autosnippet",
        desc = "\\tilde{} - standalone",
    }, {
        t("\\tilde{"),
        i(1),
        t("}"),
        i(0),
    }),
    -- bar snippet with regex capture (priority 100)
    s({
        trig = "([a-zA-Z])bar",
        wordTrig = false,
        regTrig = true,
        priority = 100,
        condition = math,
        desc = "\\overline{} - automatic with letter capture",
    }, {
        f(function(_, snip)
            return "\\overline{" .. snip.captures[1] .. "}"
        end, {}),
    }),

    -- hat snippet (priority 10) - standalone
    s({
        trig = "hat",
        wordTrig = false,
        priority = 10,
        condition = math,
        desc = "\\hat{} - standalone",
    }, {
        t("\\hat{"),
        i(1),
        t("}"),
        i(0),
    }),

    -- hat snippet with regex capture (priority 100)
    s({
        trig = "([a-zA-Z])hat",
        wordTrig = false,
        regTrig = true,
        priority = 100,
        condition = math,
        desc = "\\hat{} - automatic with letter capture",
    }, {
        f(function(_, snip)
            return "\\hat{" .. snip.captures[1] .. "}"
        end, {}),
    }),

    -- bold snippet with regex capture (priority 100)
    s({
        trig = "([a-zA-Z])bf",
        wordTrig = false,
        regTrig = true,
        priority = 100,
        condition = math,
        desc = "\\textbf{} - automatic with letter capture",
    }, {
        f(function(_, snip)
            return "\\textbf{" .. snip.captures[1] .. "}"
        end, {}),
    }),

    -- bold snippet
    s({
        trig = "tbf",
        wordTrig = true,
        regTrig = false,
        priority = 100,
        desc = "\\textbf{}",
    }, {
        t("\\textbf{"),
        i(1),
        t("}"),
        i(2),
    }),

    -- Let omega snippet
    s({
        trig = "letw",
        wordTrig = true,
        desc = "Let Omega subset C be open",
    }, {
        t("Let $\\Omega \\subset \\C$ be open."),
    }),

    -- mathbb snippet
    s({
        trig = "mbb",
        wordTrig = true,
        desc = "\\mathbb{}",
    }, {
        t("\\mathbb{"),
        i(1),
        t("}"),
        i(2),
    }),

    -- vector snippet
    s({
        trig = "vec",
        wordTrig = true,
        condition = math,
        desc = "\\vec{}",
    }, {
        t("\\vec{"),
        i(1),
        t("}"),
        i(2),
    }),

    -- determinant snippet
    s({
        trig = "det",
        wordTrig = true,
        condition = math,
        desc = "\\det",
    }, {
        t("\\det "),
    }),

    -- mathbb H snippet
    s({
        trig = "HH",
        wordTrig = true,
        desc = "\\mathbb{H}",
    }, {
        t("\\mathbb{H}"),
    }),

    -- mathbb D snippet
    s({
        trig = "DD",
        wordTrig = true,
        desc = "\\mathbb{D}",
    }, {
        t("\\mathbb{D}"),
    }),

    -- Set operations and logical operators
    s({
        trig = "cap",
        wordTrig = true,
        condition = math,
        desc = "intersection",
    }, {
        t("\\cap"),
    }),

    s({
        trig = "cup",
        wordTrig = true,
        condition = math,
        desc = "union",
    }, {
        t("\\cup"),
    }),

    s({
        trig = "orr",
        wordTrig = true,
        condition = math,
        desc = "logical or",
        snippetType = "autosnippet",
    }, {
        t("\\lor"),
    }),

    s({
        trig = "and",
        wordTrig = true,
        condition = math,
        desc = "logical and",
        snippetType = "autosnippet",
    }, {
        t("\\land"),
    }),

    -- Greek letters

    -- Alpha
    s({
        trig = "@a",
        wordTrig = true,
        condition = math,
        desc = "alpha",
        snippetType = "autosnippet",
    }, {
        t("\\alpha"),
    }),

    -- Beta
    s({
        trig = "@b",
        wordTrig = true,
        condition = math,
        desc = "beta",
        snippetType = "autosnippet",
    }, {
        t("\\beta"),
    }),

    -- Gamma (lowercase)
    s({
        trig = "@g",
        wordTrig = true,
        condition = math,
        desc = "gamma",
        snippetType = "autosnippet",
    }, {
        t("\\gamma"),
    }),

    -- Gamma (uppercase)
    s({
        trig = "@G",
        wordTrig = true,
        condition = math,
        desc = "Gamma",
        snippetType = "autosnippet",
    }, {
        t("\\Gamma"),
    }),

    -- Delta (lowercase)
    s({
        trig = "@d",
        wordTrig = true,
        condition = math,
        desc = "delta",
        snippetType = "autosnippet",
    }, {
        t("\\delta"),
    }),

    -- Delta (uppercase)
    s({
        trig = "@D",
        wordTrig = true,
        condition = math,
        desc = "Delta",
        snippetType = "autosnippet",
    }, {
        t("\\Delta"),
    }),

    -- Epsilon
    s({
        trig = "@e",
        wordTrig = true,
        condition = math,
        desc = "epsilon",
        snippetType = "autosnippet",
    }, {
        t("\\epsilon"),
    }),

    -- Omega
    s({
        trig = "@o",
        wordTrig = true,
        condition = math,
        desc = "omega",
        snippetType = "autosnippet",
    }, {
        t("\\omega"),
    }),

    s({
        trig = "@O",
        wordTrig = true,
        condition = math,
        desc = "Omega",
        snippetType = "autosnippet",
    }, {
        t("\\Omega"),
    }),

    -- Rho
    s({
        trig = "@r",
        wordTrig = true,
        condition = math,
        desc = "rho",
        snippetType = "autosnippet",
    }, {
        t("\\rho"),
    }),

    -- Theta
    s({
        trig = "@t",
        wordTrig = true,
        condition = math,
        desc = "theta",
        snippetType = "autosnippet",
    }, {
        t("\\theta"),
    }),
    s({
        trig = "@T",
        wordTrig = true,
        condition = math,
        desc = "theta",
        snippetType = "autosnippet",
    }, {
        t("\\Theta"),
    }),

    -- Tau
    s({
        trig = "tau",
        wordTrig = true,
        condition = math,
        desc = "tau",
        snippetType = "autosnippet",
    }, {
        t("\\tau"),
    }),

    -- Phi
    s({
        trig = "phi",
        wordTrig = true,
        condition = math,
        desc = "phi",
        snippetType = "autosnippet",
    }, {
        t("\\phi"),
    }),
    s({
        trig = "Phi",
        wordTrig = true,
        condition = math,
        desc = "Phi",
        snippetType = "autosnippet",
    }, {
        t("\\Phi"),
    }),

    -- Psi
    s({
        trig = "psi",
        wordTrig = true,
        condition = math,
        desc = "psi",
        snippetType = "autosnippet",
    }, {
        t("\\psi"),
    }),

    -- Mu
    s({
        trig = "mu",
        wordTrig = true,
        condition = math,
        desc = "mu",
        snippetType = "autosnippet",
    }, {
        t("\\mu"),
    }),

    -- Lambda (lowercase)
    s({
        trig = "@l",
        wordTrig = true,
        condition = math,
        desc = "lambda",
        snippetType = "autosnippet",
    }, {
        t("\\lambda"),
    }),

    -- Lambda (uppercase)
    s({
        trig = "@L",
        wordTrig = true,
        condition = math,
        desc = "Lambda",
        snippetType = "autosnippet",
    }, {
        t("\\Lambda"),
    }),

    -- Sigma (lowercase)
    s({
        trig = "@s",
        wordTrig = true,
        condition = math,
        desc = "sigma",
        snippetType = "autosnippet",
    }, {
        t("\\sigma"),
    }),

    -- Sigma (uppercase)
    s({
        trig = "@S",
        wordTrig = true,
        condition = math,
        desc = "Sigma",
        snippetType = "autosnippet",
    }, {
        t("\\Sigma"),
    }),

    -- Chi
    s({
        trig = "chi",
        wordTrig = true,
        condition = math,
        desc = "chi",
        snippetType = "autosnippet",
    }, {
        t("\\chi"),
    }),

    -- Xi
    s({
        trig = "@x",
        wordTrig = true,
        condition = math,
        desc = "xi",
        snippetType = "autosnippet",
    }, {
        t("\\xi"),
    }),

    -- kappa
    s({
        trig = "@k",
        wordTrig = true,
        condition = math,
        desc = "kappa",
        snippetType = "autosnippet",
    }, {
        t("\\kappa"),
    }),

    -- pi
    s({
        trig = "pi",
        wordTrig = true,
        condition = math,
        desc = "pi",
        snippetType = "autosnippet",
    }, {
        t("\\pi"),
    }),
}
