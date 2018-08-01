(use-package recentf
  :bind ("\C-x\ \C-r" . recentf-open-files)
  :config
  (progn
    (setq 
        recentf-max-saved-items 500
        recentf-max-menu-items 15
        ;; disable recentf-cleanup on Emacs start, because it can cause problems with remote files
        recentf-auto-cleanup 'never)
    (recentf-mode +1) ))

(use-package imenu-anywhere
  :ensure t
  :bind ("C-." . imenu-anywhere))

(use-package dired
  :config
  (progn
    ;; 延迟加载
    (with-eval-after-load 'dired
      (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))
    ;; dired - reuse current buffer by pressing 'a'
    (put 'dired-find-alternate-file 'disabled nil)
    ;; always delete and copy recursively
    (setq dired-recursive-deletes 'always)
    (setq dired-recursive-copies 'always)
    ;; if there is a dired buffer displayed in the next window, use its
    ;; current subdir, instead of the current subdir of this dired buffer
    (setq dired-dwim-target t)
    ;; get rid of a message error
    (when (eq system-type 'darwin)
      (require 'ls-lisp)
      (setq ls-lisp-use-insert-directory-program nil))
    ;; enable some really cool extensions like C-x C-j(dired-jump)
    (use-package dired-x)))

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
   (treemacs-filewatch-mode t) ))

(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status))

(use-package magithub
  :ensure t
  ;; :after magit
  :defer t
  :config
  (magithub-feature-autoinject t)
  (setq magithub-clone-default-directory "~/github"))

(use-package projectile
  :ensure t
  :bind ([f5] . projectile-compile-project))

(use-package deft
  :ensure t
  ;:bind ("<f7>" . deft)
  :commands (deft)
  :config
  (progn
    (setq deft-directory         "~/Dropbox/Org"
	  deft-extensions        '("org")
	  deft-default-extension "org"
	  deft-text-mode         'org-mode)))

(use-package bibliothek
  :ensure t
  :commands bibliothek
  :init (setq bibliothek-path (list "~/Desktop")))

(provide 'du-project-manager)
