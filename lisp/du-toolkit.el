;; you only need to specify :defer if you know for a fact that some other package will do something to cause your package to load at the appropriate time
(use-package ov        :ensure t :defer t)
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
    (setq company-idle-delay 0.1
	  company-minimum-prefix-length 3)
    (with-eval-after-load 'company
      (define-key company-active-map (kbd "M-n") nil)
      (define-key company-active-map (kbd "M-p") nil)
      (define-key company-active-map (kbd "C-n") #'company-select-next)
      (define-key company-active-map (kbd "C-p") #'company-select-previous))
    ))

(use-package paredit
  :ensure t
  :bind ("C-c d" . paredit-delete-region)
  :hook ((lisp-mode . paredit-mode)
	 (emacs-lisp-mode . paredit-mode)
	 (lisp-interaction-mode . paredit-mode)
	 (ielm-mode . paredit-mode)
	 (eval-expression-minibuffer-setup . paredit-mode))
  )

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
  :bind ("\C-s" . swiper)
  :config
  (defun haba/swiper-mc-fixed ()
    (interactive)
    (setq swiper--current-window-start nil)
    (swiper-mc)))

(use-package counsel
  :ensure t
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
               '(counsel-find-file . ivy--sort-files-by-date))
  )

(use-package smartparens
  :ensure t
  :config
  (progn
    (smartparens-global-mode t)
    ;; single "'" in emacs-lisp mode 
    (sp-local-pair '(emacs-lisp-mode lisp-interaction-mode) "'" nil :actions nil)
    (sp-local-pair 'emacs-lisp-mode "`" nil :actions nil)
    ))

(use-package recentf
  :bind ("\C-x\ \C-r" . recentf-open-files)
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
  :bind ("C-x g" . magit-status))

(use-package projectile
  :ensure t
  :bind ([f5] . projectile-compile-project))

(use-package eshell
  :ensure t
  :bind ([f1] . eshell)
  :commands eshell-mode
  :init
  (add-hook 'eshell-mode-hook
            (lambda ()
              (eshell/export "NODE_NO_READLINE=1")))
  ;; remove linum
  (add-hook 'eshell-mode-hook (lambda () (linum-mode -1)))
  :config
  (progn
    (require 'magit)
    (defmacro with-face (STR &rest PROPS)
      "Return STR propertized with PROPS."
      `(propertize ,STR 'face (list ,@PROPS)))

    (defmacro esh-section (NAME ICON FORM &rest PROPS)
      "Build eshell section NAME with ICON prepended to evaled FORM with PROPS."
      `(setq ,NAME
             (lambda () (when ,FORM
			  (-> ,ICON
			      (concat esh-section-delim ,FORM)
			      (with-face ,@PROPS))))
	     ))

    (defun esh-acc (acc x)
      "Accumulator for evaluating and concatenating esh-sections."
      (--if-let (funcall x)
	  (if (s-blank? acc)
              it
            (concat acc esh-sep it))
	acc))

    (defun esh-prompt-func ()
      "Build `eshell-prompt-function'"
      (concat esh-header
              (-reduce-from 'esh-acc "" eshell-funcs)
              "\n"
              eshell-prompt-string))

    (esh-section esh-dir
		 "\xf07c"  ;  (faicon folder)
		 (abbreviate-file-name (eshell/pwd))
		 '(:foreground "black" :bold ultra-bold :underline t))

    (esh-section esh-git
		 "\xe907"  ;  (git icon)
		 (magit-get-current-branch)
		 '(:foreground "grey40"))

    ;; Below I implement a "prompt number" section
    (setq esh-prompt-num 0)
    (add-hook 'eshell-exit-hook (lambda () (setq esh-prompt-num 0)))
    (advice-add 'eshell-send-input :before
		(lambda (&rest args) (setq esh-prompt-num (incf esh-prompt-num))))

    (esh-section esh-num
		 "\xf0c9"  ;  (list icon)
		 (number-to-string esh-prompt-num)
		 '(:foreground "grey60"))

    ;; Separator between esh-sections
    (setq esh-sep "  ")  ; or " | "

    ;; Separator between an esh-section icon and form
    (setq esh-section-delim " ")

    ;; Eshell prompt header
    (setq esh-header " ")  ; or "\n┌─"

    ;; Eshell prompt regexp and string. Unless you are varying the prompt by eg.
    ;; your login, these can be the same.
    (setq eshell-prompt-regexp "$ ")   ; or "└─> "
    (setq eshell-prompt-string "$ ")   ; or "└─> "

    ;; Choose which eshell-funcs to enable
    (setq eshell-funcs (list esh-dir esh-git esh-num))

    ;; Enable the new eshell prompt
    (setq eshell-prompt-function 'esh-prompt-func)

  ))

(use-package eshell-fringe-status
  :ensure t
  :hook (eshell-mode . eshell-fringe-status-mode))

(use-package esh-autosuggest
  :ensure t
  :hook (eshell-mode . esh-autosuggest-mode))

(provide 'du-toolkit)
