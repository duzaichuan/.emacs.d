(use-package recentf
  :bind ("\C-x\ \C-r" . recentf-open-files)
  :custom
  (recentf-max-saved-items 500)
  (recentf-max-menu-items 15)
  (recentf-auto-cleanup 'never "disable recentf-cleanup on Emacs start, because it can cause problems with remote files")
  :config
  (recentf-mode t))

(use-package imenu-anywhere
  
  :bind ("C-." . imenu-anywhere))

(use-package dired
  :straight nil
  :defer t
  :custom
  (dired-recursive-deletes 'always "always delete and copy recursively")
  (dired-recursive-copies 'always)
  (dired-dwim-target t)
  :config
  (progn
    ;; dired - reuse current buffer by pressing 'a'
    (put 'dired-find-alternate-file 'disabled nil)
   ;; get rid of a message error in osx
    (when (eq system-type 'darwin)
      (require 'ls-lisp)
      (setq ls-lisp-use-insert-directory-program nil
	    dired-listing-switches "-alhG"
	    ls-lisp-ignore-case t
	    ls-lisp-use-string-collate nil
	    ls-lisp-verbosity '(links uid)
	    ls-lisp-format-time-list '("%b %e %H:%M" "%b %e  %Y")
	    ls-lisp-use-localized-time-format t))
    ))

(use-package dired-x
  :straight nil
  :bind ("C-x C-j" . dired-jump))

(use-package treemacs
  
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
  
  :bind ("C-x g" . magit-status))

(use-package magithub
  
  ;; :after magit
  :defer t
  :custom (magithub-clone-default-directory "~/github")
  :config
  (magithub-feature-autoinject t)
  )

(use-package projectile
  
  :bind ([f5] . projectile-compile-project))

(use-package deft
  
  :commands (deft)
  :custom
  (deft-directory "~/Dropbox/Org")
  (deft-extensions        '("org"))
  (deft-default-extension "org")
  (deft-text-mode         'org-mode)
  )

(use-package bibliothek
  
  :commands bibliothek
  :custom (bibliothek-path (list "~/Desktop")))

(provide 'init-project-manager)
