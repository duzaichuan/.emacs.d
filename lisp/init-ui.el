;; appearance setting
(add-to-list 'default-frame-alist '(fullscreen . maximized))
;;(add-to-list 'default-frame-alist '(height . 40))
;;(add-to-list 'default-frame-alist '(width . 85))

;; font
(set-face-attribute 'default nil
		    :font "DejaVu Sans Mono")

(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-linum-mode 1)
(set-face-attribute 'default nil :height 170)
(setq inhibit-startup-screen t)
(setq-default cursor-type 'bar)
(global-hl-line-mode t)

(use-package all-the-icons
  :config
  (all-the-icons-octicon "file-binary")  ;; GitHub Octicon for Binary File
  (all-the-icons-faicon  "cogs")         ;; FontAwesome icon for cogs
  (all-the-icons-wicon   "tornado"))

(use-package spaceline-all-the-icons
  :config
  (spaceline-all-the-icons-theme)
  (setq spaceline-all-the-icons-icon-set-bookmark 'heart
        spaceline-all-the-icons-icon-set-modified 'toggle
        spaceline-all-the-icons-icon-set-dedicated 'pin
        spaceline-all-the-icons-separator-type 'none
        spaceline-all-the-icons-icon-set-flycheck-slim 'dots
        spaceline-all-the-icons-flycheck-alternate t
        spaceline-all-the-icons-highlight-file-name t
        spaceline-all-the-icons-hide-long-buffer-path t)
  (spaceline-toggle-all-the-icons-bookmark-on)
  (spaceline-toggle-all-the-icons-dedicated-on)
  (spaceline-toggle-all-the-icons-fullscreen-on)
  (spaceline-toggle-all-the-icons-buffer-position-on)
  (spaceline-all-the-icons--setup-package-updates)
  (spaceline-all-the-icons--setup-paradox)
  (spaceline-all-the-icons--setup-neotree)
  )

(add-hook 'after-init-hook 'global-color-identifiers-mode)
(require 'neotree)
(setq neo-theme (if (display-graphic-p) 'icons 'none))
(neotree-show)

(provide 'init-ui)
