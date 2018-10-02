;;; init.el --- Emacs configuration
;;
;;; Commentary:
;; Loads org-mode and then uses org-babel to load the actual configuration file.
;;
;;; Code:

(require 'package)
(setq package-enable-at-startup nil)
(unless (assoc-default "melpa" package-archives)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t))
(package-initialize)

;; Bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(setq emacs-dir (file-name-directory (or (buffer-file-name) load-file-name)))

;; Load org-mode and org-babel
(require 'org-install)
(require 'ob-tangle)

;; Load all .org files in this directory
(mapc #'org-babel-load-file (directory-files emacs-dir t "\\.org$"))

;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
