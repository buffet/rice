(module init
  {require {a aniseed.core
            nvim aniseed.nvim}})

;; Load all modules in no particular order
(let [config-path (nvim.fn.stdpath "config")
      module-glob (.. config-path "/fnl/modules/**/*.fnl")]
  (each [_ path (ipairs (vim.fn.glob module-glob true true true))]
    (-> path
        (string.gsub (.. config-path "/fnl/") "")
        (string.gsub "/" ".")
        (string.gsub ".fnl" "")
        (string.gsub "fnl" "lua")
        (require))))
