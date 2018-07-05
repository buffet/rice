;;; This fixed garbage collection, makes emacs start up faster ;;;;;;;
(setq gc-cons-threshold 402653184
      gc-cons-percentage 0.6)

(defvar startup/file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)

(defun startup/revert-file-name-handler-alist ()
  (setq file-name-handler-alist startup/file-name-handler-alist))
(defun startup/reset-gc ()
  (setq gc-cons-threshold 16777216
	gc-cons-percentage 0.1))

(add-hook 'emacs-startup-hook 'startup/revert-file-name-handler-alist)
(add-hook 'emacs-startup-hook 'startup/reset-gc)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Minimal UI
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)

;; Package config
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("org"   . "http://orgmode.org/elpa/")
			 ("gnu"   . "http://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")))

(package-initialize)

;; Bootstrap `use-package`
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;;; General settings
;; Remove startup screen
(setq inhibit-startup-message t)

;; UTF-8
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; No annoying additional files
(setq make-backup-files nil)
(setq auto-save-default nil)

;; Shorter prompt
(defalias 'yes-or-no-p 'y-or-n-p)

;; projectile mode
(use-package projectile
  :ensure t
  :init
  (projectile-mode 1))

;; make with projectile
(global-set-key (kbd "<f5>") 'projectile-compile-projectile)

;;; evil mode
(use-package evil
  :ensure t
  :config
  (evil-mode 1))

;; smash escape
(use-package evil-escape
  :ensure t
  :init
  (evil-escape-mode)
  :config
  (setq-default evil-escape-key-sequence "kj"))

;; which key
(use-package which-key
  :ensure t
  :init
  (setq which-key-seperator " ")
  (setq which-key-prefix-prefix "+")
  :config
  (which-key-mode))

;; Spacemacs keybindings
;(use-package general
; :ensure t
;  :config
;  (general-define-key
;   :states '(normal visual insert emacs)
;   :prefix "SPC"
;   :non-normal-prefix "M-SPC"
;   "TAB" '(switch-to-prev-buffer :which-key "previous buffer")
;   "SPC" '(helm-M-x :which-key "M-x")
;   "ff"  '(helm-find-files :which-key "find files")
;   "fs"  '(save-buffer :which-key "save buffer")
;   "bb"  '(helm-buffers-list :which-key "buffers list")
;   "qq"  '(save-buffers-kill-terminal :which-key "quit emacs")
;   "wh"  '(windmove-left :which-key "move left")
;   "wj"  '(windmove-down :which-key "move down")
;   "wk"  '(windmove-up :which-key "move up")
;   "wl"  '(windmove-right :which-key "move right")
;   "w/"  '((lambda () (interactive) (split-window-right) (balance-windows) (other-window 1)) :which-key "split right")
;   "w-"  '((lambda () (interactive) (split-window-below) (balance-windows) (other-window 1)) :which-key "split below")
;   "wx"  '(delete-window :which-key "delete window")))

;;; Misc

;; Theme
(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-one))

;; Show trailing whitespace
(setq-default show-trailing-whitespace t)

;; ws-butler
(use-package ws-butler
  :ensure t
  :config
  (add-hook 'prog-mode-hook #'ws-butler-mode))

;; magit
(use-package magit
  :ensure t
  :config
  (setq magit-push-always-verify nil)
  (setq git-commit-summery-max-length 50)
  :bind
  ("M-g" . magit-status))

;; Make org-mode look gud
(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode))))

;; Helm
(use-package helm
  :ensure t
  :init
  (setq helm-mode-fuzzy-match t)
  (setq helm-completion-in-region-fuzzy-match t)
  (setq helm-candidate-number-list 50)
  :bind
  ("C-x C-f" . helm-find-files)
  ("M-x" . helm-M-x))

;;; Language specific
;; yasnippet
(use-package yasnippet
  :ensure t
  :config
  (use-package yasnippet-snippets
    :ensure t)
  (yas-reload-all))

;; flycheck
(use-package flycheck
  :ensure t)

;; company-mode
(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 2))

;; C/C++
;; yasnippet
(add-hook 'c++-mode-hook 'yas-minor-mode)
(add-hook 'c-mode-hook 'yas-minor-mode)

;; flycheck
(use-package flycheck-clang-analyzer
  :ensure t
  :config
  (with-eval-after-load 'flycheck
    (require 'flycheck-clang-analyzer)
    (flycheck-clang-analyzer-setup)))

;; company (requires libclang)
(with-eval-after-load 'company
  (add-hook 'c++-mode-hook 'company-mode)
  (add-hook 'c-mode-hook 'company-mode))

(use-package company-c-headers
  :ensure t)

(use-package company-irony
  :ensure t
  :config
  (setq company-backends '((company-c-headers
			    company-dabbrev-code
			    company-irony))))

;; Rust
(use-package rust-mode
  :ensure t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("9d9fda57c476672acd8c6efeb9dc801abea906634575ad2c7688d055878e69d6" default)))
 '(package-selected-packages
   (quote
    (rust-mode yasnippet-snippets ws-butler which-key use-package projectile org-bullets magit helm general flycheck-clang-analyzer evil-escape doom-themes company-irony company-c-headers))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
