;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; This is only needed once, near the top of the file
(eval-when-compile
  (require 'use-package)
  (setq use-package-verbose t))
;;(require 'diminish)                ;; if you use :diminish
(require 'bind-key)                ;; if you use any :bind variant

(use-package exec-path-from-shell
  :if (memq window-system '(mac ns))
  :ensure t
  :config
  (exec-path-from-shell-initialize))

(use-package auto-package-update
  :ensure t
  :config
  (progn
    (setq auto-package-update-delete-old-versions t)
    (setq auto-package-update-hide-results t)
    (auto-package-update-maybe)
    ))

;; you only need to specify :defer if you know for a fact that some other package will do something to cause your package to load at the appropriate time
(use-package ov        :ensure t :defer t)
(use-package dash    :ensure t :defer t)
(use-package f    :ensure t :defer t)
(use-package s    :ensure t :defer t)
(use-package hydra :ensure t :defer t)
(use-package math-symbol-lists  :ensure t :defer t)

(use-package popwin
  :ensure t
  :config
  (popwin-mode t))

(use-package key-chord
  :ensure t
  :commands key-chord-mode)

(use-package company
  :ensure t
  :config
  (progn
    (global-company-mode)
    (with-eval-after-load 'company
      (define-key company-active-map (kbd "M-n") nil)
      (define-key company-active-map (kbd "M-p") nil)
      (define-key company-active-map (kbd "C-n") #'company-select-next)
      (define-key company-active-map (kbd "C-p") #'company-select-previous))
    ))

(use-package paredit
  :ensure t
  :bind ("C-c d" . paredit-delete-region)
  :demand t
  :config
  (progn
    (add-hook 'emacs-lisp-mode-hook #'paredit-mode)
    ;; enable in the *scratch* buffer
    (add-hook 'lisp-interaction-mode-hook #'paredit-mode)
    (add-hook 'ielm-mode-hook #'paredit-mode)
    (add-hook 'lisp-mode-hook #'paredit-mode)
    (add-hook 'eval-expression-minibuffer-setup-hook #'paredit-mode)
    ))

(use-package paren
  :config
  (show-paren-mode +1))

(use-package helm
  :ensure t
  :defer t
  :bind (:map helm-map
              ("<tab>" . helm-execute-persistent-action)
              ("C-i"   . helm-execute-persistent-action)
              ("C-z"   . helm-select-action)
              ("A-v"   . helm-previous-page))
  :config
  (helm-autoresize-mode 1))

(use-package ivy
  :ensure t
  :demand t
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
  :after ivy
  :bind ("\C-s" . swiper)
  :config
  (defun haba/swiper-mc-fixed ()
    (interactive)
    (setq swiper--current-window-start nil)
    (swiper-mc)))

(use-package counsel
  :ensure t
  :after ivy
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
         ("M-s j" . counsel-dired-jump))
  :commands counsel-minibuffer-history
  :init
  (bind-key "M-r" #'counsel-minibuffer-history minibuffer-local-map)
  :config
  (add-to-list 'ivy-sort-matches-functions-alist
               '(counsel-find-file . ivy--sort-files-by-date)))

(use-package smartparens
  :ensure t
  :config
  (progn
    (smartparens-global-mode t)
    ;; single "'" in emacs-lisp mode
    (sp-local-pair '(emacs-lisp-mode lisp-interaction-mode) "'" nil :actions nil)
    ))

(use-package expand-region
  :ensure t
  :bind ("C-=" . er/expand-region))

(use-package recentf
  :bind ("\C-x\ \C-r" . recentf-open-files)
  :demand t
  :config
  (progn
    (setq 
        recentf-max-saved-items 500
        recentf-max-menu-items 15
        ;; disable recentf-cleanup on Emacs start, because it can cause
        ;; problems with remote files
        recentf-auto-cleanup 'never)
    (recentf-mode +1)
    ))

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
    (use-package dired-x)
    ))

(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode))

(use-package magit
  :ensure t
  :demand t
  :bind ("C-x g" . magit-status))

(provide 'init-toolkit)
