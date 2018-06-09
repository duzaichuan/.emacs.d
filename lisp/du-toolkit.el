;; you only need to specify :defer if you know for a fact that some other package will do something to cause your package to load at the appropriate time
(use-package ov        :ensure t :defer t)
(use-package f    :ensure t :defer t)
(use-package s    :ensure t :defer t)
(use-package hydra :ensure t :defer t)
(use-package math-symbol-lists  :ensure t :defer t)

(use-package popwin
  :ensure t
  :diminish t
  :config
  (popwin-mode t))

(use-package key-chord
  :ensure t
  :commands key-chord-mode)

(use-package company
  :ensure t
  :diminish company-mode
  :config
  (progn
    (global-company-mode)
    (setq company-idle-delay 0.1
	  company-minimum-prefix-length 3)
    (with-eval-after-load 'company
      (define-key company-active-map (kbd "M-n") nil)
      (define-key company-active-map (kbd "M-p") nil)
      (define-key company-active-map (kbd "C-n") #'company-select-next)
      (define-key company-active-map (kbd "C-p") #'company-select-previous))))

(use-package paredit
  :ensure t
  :diminish paredit-mode
  :bind ("C-c d" . paredit-delete-region)
  :hook ((lisp-mode . paredit-mode)
	 (emacs-lisp-mode . paredit-mode)
	 (lisp-interaction-mode . paredit-mode)
	 (ielm-mode . paredit-mode)
	 (eval-expression-minibuffer-setup . paredit-mode)))

(use-package paren
  :config (show-paren-mode +1))

(use-package helm
  :ensure t
 ;:diminish t
  :demand t
  :bind (:map helm-map
              ("<tab>" . helm-execute-persistent-action)
              ("C-i"   . helm-execute-persistent-action)
              ("C-z"   . helm-select-action)
              ("A-v"   . helm-previous-page))
  :config (helm-autoresize-mode 1))

(use-package ivy
  :ensure t
  ;:diminish ivy-mode
  :bind (("C-x b" . ivy-switch-buffer)
         ("C-x B" . ivy-switch-buffer-other-window)
         ("M-H"   . ivy-resume))
  :bind (:map ivy-switch-buffer-map
              ("C-k" . ivy-switch-buffer-kill))
  :custom
  (ivy-dynamic-exhibit-delay-ms 200)
  (ivy-height 10)
  (ivy-initial-inputs-alist nil t)
  (ivy-magic-tilde nil)
  (ivy-re-builders-alist '((t . ivy--regex-ignore-order)))
  (ivy-use-virtual-buffers t)
  (ivy-wrap t)
  :config
  (progn
   (ivy-mode 1)
   (ivy-set-occur 'ivy-switch-buffer 'ivy-switch-buffer-occur)))

(use-package swiper
  :ensure t
  :bind ("\C-s" . swiper))

(use-package counsel
  :ensure t
  :demand t
  :custom (counsel-find-file-ignore-regexp
           (concat "\\(\\`\\.[^.]\\|"
                   (regexp-opt completion-ignored-extensions)
                   "\\'\\)"))
  :bind (("C-*"     . counsel-org-agenda-headlines)
         ("C-x C-f" . counsel-find-file)
         ("C-h f"   . counsel-describe-function)
	 ("C-h v"   . counsel-describe-variable)
         ("C-x r b" . counsel-bookmark)
         ("M-x"     . counsel-M-x)
         ("M-s f" . counsel-file-jump)
         ("M-s g" . counsel-rg)
         ("M-s j" . counsel-dired-jump)
	 ("C-x p f" . counsel-git))
  :commands counsel-minibuffer-history
  :init
  (bind-key "M-r" #'counsel-minibuffer-history minibuffer-local-map)
  :config
  (add-to-list 'ivy-sort-matches-functions-alist
               '(counsel-find-file . ivy--sort-files-by-date)))

(use-package smartparens
  :ensure t
  :diminish smartparens-mode
  :config
  (progn
    (smartparens-global-mode t)
    ;; single "'" in emacs-lisp mode 
    (sp-local-pair '(emacs-lisp-mode lisp-interaction-mode) "'" nil :actions nil)
    (sp-local-pair 'emacs-lisp-mode "`" nil :actions nil)))

(use-package recentf
  :bind ("\C-x\ \C-r" . recentf-open-files)
  :config
  (progn
    (setq 
        recentf-max-saved-items 500
        recentf-max-menu-items 15
        ;; disable recentf-cleanup on Emacs start, because it can cause problems with remote files
        recentf-auto-cleanup 'never)
    (recentf-mode +1)))

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
   (treemacs-filewatch-mode t)  
   ;; remove linum
   (add-hook 'treemacs-mode-hook (lambda () (linum-mode -1)))
   ))

(use-package undo-tree
  :ensure t
  :diminish undo-tree-mode
  :config
  (progn
    (global-undo-tree-mode 1)
    (defalias 'redo 'undo-tree-redo)
    (global-set-key (kbd "s-r") 'redo)))

(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status))

(use-package projectile
  :ensure t
  :bind ([f5] . projectile-compile-project))

(use-package deft
  :ensure t
  :bind ("<f7>" . deft)
  :commands (deft)
  :config
  (progn
    (setq deft-directory         "~/Dropbox/Org"
	  deft-extensions        '("org")
	  deft-default-extension "org"
	  deft-text-mode         'org-mode)))

(use-package which-key
      :ensure t
      :diminish which-key-mode
      :config
      (progn
	(which-key-mode)
	(which-key-setup-side-window-right-bottom)))

(use-package evil
  :ensure t
  :diminish evil-mode
  :init (setq evil-want-integration nil)
  :config
  (progn
    (evil-mode 1)
    (setq evil-cross-lines t)
    (setq evil-move-cursor-back nil)
    (setcdr evil-insert-state-map nil)
    (define-key evil-insert-state-map [escape] 'evil-normal-state)
    (setq evil-want-C-u-scroll t)
    (evil-add-hjkl-bindings recentf-dialog-mode-map 'emacs)
    (evil-add-hjkl-bindings package-menu-mode-map 'emacs)
    (evil-add-hjkl-bindings pdf-outline-buffer-mode-map 'emacs)
    (use-package evil-leader
      :ensure t
      :init (global-evil-leader-mode)
      :config
      (progn
        (evil-leader/set-leader "SPC")
        (evil-leader/set-key "wd" 'delete-window)
        (evil-leader/set-key "wo" 'delete-other-windows)
        (evil-leader/set-key "wh" 'split-window-horizontally)
        (evil-leader/set-key "wv" 'split-window-vertically)
        (evil-leader/set-key "ww" 'other-window)
	(evil-leader/set-key "bb" 'ivy-switch-buffer)
	(evil-leader/set-key "bk" 'kill-buffer)
	(evil-leader/set-key ":" 'counsel-M-x)
	(evil-leader/set-key "ff" 'counsel-find-file)
	(evil-leader/set-key "fr" 'recentf-open-files)
	(evil-leader/set-key "gs" 'magit-status)
	(evil-leader/set-key "ci" 'evilnc-comment-or-uncomment-lines)
	(evil-leader/set-key "oc" 'org-capture)
	(evil-leader/set-key "oa" 'org-agenda)
	(evil-leader/set-key "or" 'org-refile)
	(evil-leader/set-key "ol" 'org-store-link)))
    ))

(use-package evil-magit
        :ensure t
        :after magit)

(use-package evil-org
    :ensure t
    :diminish  evil-org-mode
    :hook (org-mode . evil-org-mode)
    :config
    (progn
      (add-hook 'evil-org-mode-hook (lambda () (evil-org-set-key-theme)))
      (require 'evil-org-agenda)
      (evil-org-agenda-set-keys)))

(use-package evil-cleverparens
    :ensure t
    :hook (paredit-mode . evil-cleverparens-mode)
    :config (setq evil-cleverparens-swap-move-by-word-and-symbol t))

(use-package evil-paredit
    :ensure t
    :hook (paredit-mode . evil-paredit-mode))

(use-package evil-nerd-commenter
    :ensure t
    :bind ("M-;" . evilnc-comment-or-uncomment-lines))

(use-package evil-mu4e
    :ensure t
    :after mu4e)

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init '(eww eshell dired)))

(provide 'du-toolkit)
