(module utils
  {require {a aniseed.core
            nvim aniseed.nvim}})

(defn contains? [list elem]
  (or (a.some #(= elem $1) list)) false)

(defn filter-table [f t]
  (collect [k v (pairs t)]
    (when (f k v)
      (values k v))))

(defn without-keys [keys t]
  (filter-table #(not (contains? keys $1)) t))

(defn keymap [mode from to ?opts]
  "Set a mapping in the given mode, and some optional parameters, defaulting to {:noremap true :silent true}.
  If :buffer is set, uses buf_set_keymap rather than set_keymap"
  (local full-opts 
    (->> (or ?opts {})
      (a.merge {:noremap true :silent true})
      (without-keys [:buffer])))
  (if (and ?opts (?. ?opts :buffer))
    (nvim.buf_set_keymap 0 mode from to full-opts)
    (nvim.set_keymap mode from to full-opts)))

(defn highlight [groups colset]
  (let [groups (if (a.string? groups) [groups] groups)
        opts (a.merge {:fg "NONE" :bg "NONE" :gui "NONE"} colset)]
    (each [_ group (ipairs groups)]
      (nvim.command (.. "hi!" group " guifg='" opts.fg "' guibg='" opts.bg "' gui='" opts.gui "'")))))
