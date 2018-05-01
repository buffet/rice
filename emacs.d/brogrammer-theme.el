;; default {'caret': '#ecf0f1', 'foreground': '#ecf0f1', 'gutterForeground': '#ffffff', 'selection': '#2a2a2a', 'findHighlight': '#e74c3c', 'invisibles': '#F3FFB51A', 'lineHighlight': '#2a2a2a', 'inactiveSelection': '#e74c3c', 'gutter': '#2a2a2a', 'activeGuide': '#ffffff', 'background': '#1a1a1a', 'selectionForeground': '#ffffff', 'guide': '#222222'}
;; comment {'foreground': '#606060', 'fontStyle': 'italic'}
;; constant {'foreground': '#6c71c4', 'fontStyle': ''}
;; entity {'foreground': '#2ecc71', 'fontStyle': ''}
;; keyword {'foreground': '#e74c3c', 'fontStyle': ' bold'}
;; storage {'foreground': '#3498db', 'fontStyle': ''}
;; string {'foreground': '#f1c40f', 'fontStyle': ''}
;; support {'foreground': '#3498db', 'fontStyle': ' bold'}
;; variable {'foreground': '#e67e22', 'fontStyle': ''}
;; invalid {'foreground': '#ffffff', 'background': '#e74c3c'}
;; text source {'background': ''}
;; text.html.ruby source {'background': ''}
;; entity.other.inherited-class {'foreground': '#2ecc71', 'fontStyle': 'italic'}
;; string.quoted source {'foreground': '#f1c40f', 'fontStyle': ''}
;; string constant {'foreground': '#6c71c4'}
;; string.regexp {'foreground': '#3498db'}
;; string variable {'foreground': '#ffffff'}
;; support.function {'foreground': '#3498db', 'fontStyle': ''}
;; support.constant {'foreground': '#2ecc71', 'fontStyle': ''}
;; other.preprocessor.c {'foreground': '#3498db'}
;; other.preprocessor.c entity {'foreground': '#2ecc71'}
;; declaration.tag, declaration.tag entity, meta.tag, meta.tag entity {'foreground': '#e74c3c'}
;; meta.selector.css entity.name.tag {'foreground': '#1abc9c'}
;; meta.selector.css entity.other.attribute-name.id {'foreground': '#2ecc71'}
;; meta.selector.css entity.other.attribute-name.class {'foreground': '#2ecc71'}
;; support.type.property-name.css {'foreground': '#3498db', 'fontStyle': ''}
;; meta.property-group support.constant.property-value.css, meta.property-value support.constant.property-value.css {'foreground': '#2ecc71', 'fontStyle': ' italic'}
;; meta.preprocessor.at-rule keyword.control.at-rule {'foreground': '#f1c40f', 'fontStyle': ' bold'}
;; meta.property-value support.constant.named-color.css, meta.property-value constant {'foreground': '#e74c3c'}
;; meta.constructor.argument.css {'foreground': '#e74c3c'}
;; meta.diff, meta.diff.header {'foreground': '#F8F8F8', 'fontStyle': 'italic', 'background': '#2ecc71'}
;; markup.deleted {'foreground': '#F8F8F8', 'background': '#e74c3c'}
;; markup.changed {'foreground': '#F8F8F8', 'background': '#e67e22'}
;; markup.inserted {'foreground': '#F8F8F8', 'background': '#f1c40f'}
;; markup.deleted.git_gutter {'foreground': '#d7503c'}
;; markup.inserted.git_gutter {'foreground': '#2ecc71'}
;; markup.changed.git_gutter {'foreground': '#f1c40f'}
;; markup.ignored.git_gutter {'foreground': '#2a2a2a'}
;; markup.untracked.git_gutter {'foreground': '#2a2a2a'}
;; sublimelinter.outline.notes {'background': '#233345'}
;; sublimelinter.outline.illegal {'background': '#d7503c'}
;; sublimelinter.underline.illegal {'background': '#d7503c'}
;; sublimelinter.outline.warning {'foreground': '#ffffff', 'background': '#9f3a2c'}
;; sublimelinter.underline.warning {'background': '#d7503c'}
;; sublimelinter.outline.violation {'background': '#9f3a2c'}
;; sublimelinter.underline.violation {'background': '#d7503c'}
;; entity.other.attribute-name.id.html {'foreground': '#2ecc71'}
;; entity.other.attribute-name.html {'foreground': '#2ecc71'}
;; punctuation.definition.tag.end, punctuation.definition.tag.begin, punctuation.definition.tag {'foreground': '#fff'}
;; keyword.control.at-rule.import.css {'foreground': '#f1c40f', 'fontStyle': ' bold'}
;; variable.other.less {'foreground': '#ffffff'}
;; entity.other.less.mixin {'foreground': '#9b59b6'}
;; source.css.less keyword.unit.css {'foreground': '#3498db'}
;; entity.other.attribute-name.angular.html, source.angular.embedded.html {'foreground': '#e74c3c'}
;; constant.character.entity.html {'foreground': '#3498db'}
;; variable.other.readwrite.instance.coffee {'foreground': '#e67e22'}
;; meta.brace.round.coffee,meta.brace.square.coffee {'foreground': '#f1c40f'}
;; punctuation.section.embedded.coffee {'foreground': '#5eebb8'}
;; variable.assignment.coffee variable.assignment.coffee {'foreground': '#FFFFFF'}
;; meta.delimiter.method.period.coffee {'foreground': '#3cadd7'}
;; meta.brace.curly.coffee {'foreground': '#1abc9c'}
;; meta.tag.sgml.doctype.xml, declaration.sgml.html declaration.doctype, declaration.sgml.html declaration.doctype entity, declaration.sgml.html declaration.doctype string, declaration.xml-processing, declaration.xml-processing entity, declaration.xml-processing string, doctype {'foreground': '#3c444d'}
(deftheme brogrammer
  "Brogrammer emacs theme autoconverted from the textMate theme by Ken Wheeler")
(custom-theme-set-faces
  'brogrammer
    '(trailing-whitespace ((t (:background "#30312a"))))
    '(whitespace-trailing ((t (:background "#30312a"))))

    '(border ((t (:background "#2a2a2a" ))))
    '(css-property ((t (:foreground "#3498db" ))))
    '(css-proprietary-property ((t (:foreground "#3498db" ))))
    '(css-selector ((t (:foreground "#2ecc71" ))))
    '(cursor ((t (:background "#ecf0f1" ))))
    '(default ((t (:foreground "#ecf0f1" :background "#1a1a1a" ))))
    '(diff-added ((t (:foreground "#f8f8f8" :background "#f1c40f" ))))
    '(diff-changed ((t (:foreground "#f8f8f8" :background "#e67e22" ))))
    '(diff-header ((t (:foreground "#f8f8f8" :italic t :background "#2ecc71" ))))
    '(diff-hunk-header ((t (:foreground "#f8f8f8" :italic t :background "#2ecc71" ))))
    '(diff-removed ((t (:foreground "#f8f8f8" :background "#e74c3c" ))))
    '(font-lock-builtin-face ((t (:foreground "#3498db" ))))
    '(font-lock-comment-delimiter-face ((t (:foreground "#606060" :italic t ))))
    '(font-lock-comment-face ((t (:foreground "#606060" :italic t ))))
    '(font-lock-constant-face ((t (:foreground "#2ecc71" ))))
    '(font-lock-doc-face ((t (:foreground "#6c71c4" ))))
    '(font-lock-function-name-face ((t (:foreground "#3498db" ))))
    '(font-lock-keyword-face ((t (:foreground "#e74c3c" :bold t ))))
    '(font-lock-negation-char-face ((t (:foreground "#e74c3c" :bold t ))))
    '(font-lock-regexp-grouping-backslash ((t (:foreground "#3498db" ))))
    '(font-lock-regexp-grouping-construct ((t (:foreground "#3498db" ))))
    '(font-lock-string-face ((t (:foreground "#f1c40f" )))) ;;6c71c4
    '(font-lock-type-face ((t (:foreground "#3498db" ))))
    '(font-lock-variable-name-face ((t (:foreground "#e67e22" ))))
    '(font-lock-warning-face ((t (:foreground "#ffffff" :background "#e74c3c" ))))
    '(fringe ((t (:background "#2a2a2a" ))))
    '(highlight ((t (:background "#2a2a2a" ))))
    '(hl-line ((t (:background "#2a2a2a" ))))
    '(isearch ((t (:foreground "#f8f8f8" :background "#e67e22" ))))
    '(isearch-fail ((t (:foreground "#f8f8f8" :background "#e74c3c" ))))
    '(iswitchb-current-match ((t (:foreground "#f8f8f8" :background "#f1c40f" ))))
    '(iswitchb-invalid-regexp ((t (:foreground "#f8f8f8" :background "#e74c3c" ))))
    '(iswitchb-single-match ((t (:foreground "#f8f8f8" :background "#f1c40f" ))))
    '(iswitchb-virtual-matches ((t (:foreground "#f8f8f8" :background "#e67e22" ))))
    '(linum ((t (:background "#2a2a2a" ))))
    '(match ((t (:foreground "#f8f8f8" :background "#f1c40f" ))))
    '(menu ((t (:foreground "#ecf0f1" :background "#1a1a1a" ))))
    '(minibuffer-prompt ((t (:foreground "#e74c3c" ))))
    '(mode-line ((t (:background "#2a2a2a" :foreground "#ecf0f1"))))
    '(mode-line-buffer-id ((t (:foreground "#2ecc71" ))))
    '(mode-line-emphasis ((t (:bold t ))))
    '(mode-line-highlight ((t (:italic t ))))
    '(mode-line-inactive ((t (:background "#2a2a2a" ))))
    '(org-agenda-dimmed-todo-face ((t (:foreground "#606060" :italic t ))))
    '(org-column ((t (:background "#2a2a2a" ))))
    '(org-column-title ((t (:background "#2a2a2a" ))))
    '(org-done ((t (:foreground "#f8f8f8" :background "#f1c40f" ))))
    '(org-hide ((t (:foreground "#1a1a1a" ))))
    '(org-todo ((t (:foreground "#ffffff" :background "#e74c3c" ))))
    '(org-upcoming-deadline ((t (:foreground "#ffffff" :background "#e74c3c" ))))
    '(org-warning ((t (:foreground "#ffffff" :background "#e74c3c" ))))
    '(region ((t (:background "#2a2a2a" ))))
    '(secondary-selection ((t (:background "#2a2a2a" ))))
    '(show-paren-match-face ((t (:background "#2a2a2a" ))))
    '(show-paren-mismatch-face ((t (:foreground "#ffffff" :background "#e74c3c" ))))
)

(provide-theme 'brogrammer)
