;; init-ui
(use-package tao-theme
  :ensure t
  :config
  (load-theme 'tao-yang t))

(use-package all-the-icons
  :ensure t
  :config
  (progn
   (all-the-icons-octicon "file-binary") ;; GitHub Octicon for Binary File
   (all-the-icons-faicon  "cogs")	 ;; FontAwesome icon for cogs
   (all-the-icons-wicon   "tornado")))

(use-package powerline
  :ensure t
  :defer t)

(use-package spaceline-all-the-icons
  :ensure t
  :config
  (progn
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
   ))

(use-package color-identifiers-mode
  :ensure t
  :config (add-hook 'after-init-hook 'global-color-identifiers-mode))

(use-package neotree
  :ensure t
  :disabled t
  :bind ([f8] . neotree-toggle)
  :config
  (setq neo-theme (if (display-graphic-p) 'icons 'none)))

(use-package treemacs
  :ensure t
  :bind
  (:map global-map
        ([f8]        . treemacs-toggle)
	("C-c C-f" . treemacs-find-file))
  :config
  (progn
   (setq treemacs-follow-after-init          t
         treemacs-width                      35
         treemacs-indentation                2
         treemacs-git-integration            t
         treemacs-collapse-dirs              3
         treemacs-silent-refresh             nil
         treemacs-change-root-without-asking nil
         treemacs-sorting                    'alphabetic-desc
         treemacs-show-hidden-files          t
         treemacs-never-persist              nil
         treemacs-is-never-other-window      nil
         treemacs-goto-tag-strategy          'refetch-index
	 treemacs-width                      30)
   (treemacs-follow-mode t)
   (treemacs-filewatch-mode t)
   
   ;; remove linum in org mode
    (defun nolinum ()
      (linum-mode 0))
    (add-hook 'treemacs-mode-hook 'nolinum)
   ))

(provide 'init-ui)
