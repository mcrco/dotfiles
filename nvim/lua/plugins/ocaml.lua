return {
    "neovim/nvim-lspconfig",
    opts = {
        servers = {
            ocamllsp = {
                filetypes = {
                    "ocaml",
                    "ocaml.menhir",
                    "ocaml.interface",
                    "ocaml.ocamllex",
                    "reason",
                    "dune",
                },
                root_dir = function(fname)
                    return require("lspconfig.util").root_pattern(
                        "*.opam",
                        "esy.json",
                        "package.json",
                        ".git",
                        "dune-project",
                        "dune-workspace",
                        "*.ml"
                    )(fname)
                end,
                mason = false,
            },
        },
    },
}
