;; init-ui
(use-package tao-theme
  :ensure t
  :config
  (load-theme 'tao-yang t))

(use-package powerline
  :ensure t
  :config
  (setq powerline-image-apple-rgb t
	powerline-default-separator 'butt)
  (powerline-center-evil-theme)
  )

(use-package neotree
  :ensure t
  :defer t)

(use-package color-identifiers-mode
  :ensure t
  :diminish color-identifiers-mode
  :config (add-hook 'after-init-hook 'global-color-identifiers-mode))

(use-package treemacs
  :ensure t
  :bind 
  (:map global-map
	([f8] . treemacs)
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
   ;; remove linum
   (add-hook 'treemacs-mode-hook (lambda () (linum-mode -1)))
   ))

(provide 'du-ui)
