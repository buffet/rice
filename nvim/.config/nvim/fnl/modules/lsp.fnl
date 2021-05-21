(module modules.lsp
  {require {a aniseed.core
            lsp lspconfig
            lsp_signature lsp_signature
            rust-tools rust-tools
            utils utils}})

(fn on_attach [client bufnr]
  (lsp_signature.on_attach)
  (if client.resolved_capabilities.document_highlight
    (do
      (utils.highlight "LspReferenceRead" {:gui "underline"})
      (utils.highlight "LspReferenceText" {:gui "underline"})
      (utils.highlight "LspReferenceWrite" {:gui "underline"}))))

(fn init-lsp [lsp-name ?opts]
  "Initialize a language server"
  (let [merged-opts (a.merge {:on_attach on_attach} (or ?opts {}))]
    ((. lsp lsp-name :setup) merged-opts)))

;; Rust extra caps
(let [caps (vim.lsp.protocol.make_client_capabilities)]
  (set caps.textDocument.completion.completionItem.snippetSupport true)
  (set caps.textDocument.completion.completionItem.resolveSupport
       {:properties ["documentation" "detail" "additionalTextEdits"]})
  (lsp.rust_analyzer.setup
    {:capabilities caps
     :on_attach (fn [...]
                  (on_attach ...))}))
                  ;; TODO: fix
                  ;(rust-tools.setup
                  ;  {:tools {:inlay_hints {:show_parameter_hints false}}}))}))

(init-lsp :bashls)
(init-lsp :clangd)
(init-lsp :vimls)
