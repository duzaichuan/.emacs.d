(delete-selection-mode t)
(setq tab-always-indent 'complete)
(global-set-key (kbd "C-w") 'backward-kill-word)
;; change reminder "yes" to "y"
(fset 'yes-or-no-p 'y-or-n-p)
;; disable audio bell
(setq ring-bell-function 'ignore)
;; store all backup and autosave files in the current dir
(setq backup-directory-alist
          `(("." . ,(concat user-emacs-directory "backups"))))

(use-package real-auto-save
  
  :diminish real-auto-save-mode
  :init (setq save-silently t)
  :hook ((org-mode emacs-lisp-mode) . real-auto-save-mode))

(use-package ov    :defer t)
(use-package f     :defer t)
(use-package s     :defer t)
(use-package hydra :defer t)
(use-package math-symbol-lists   :defer t)

(use-package popwin
  
  :diminish t
  :config
  (popwin-mode t))

(use-package company
  
  :diminish company-mode
  :defer 0.1
  :custom
  (company-idle-delay 0.1)
  (company-minimum-prefix-length 3)
  :config
  (progn
    (global-company-mode)
    (with-eval-after-load 'company
      (define-key company-active-map (kbd "M-n") nil)
      (define-key company-active-map (kbd "M-p") nil)
      (define-key company-active-map (kbd "C-n") #'company-select-next)
      (define-key company-active-map (kbd "C-p") #'company-select-previous))))

(use-package paredit
  
  :diminish paredit-mode
  :bind ("C-c d" . paredit-delete-region)
  :hook ((lisp-mode emacs-lisp-mode clojure-mode ielm-mode eval-expression-minibuffer-setup) . paredit-mode))

(use-package smartparens
  
  :diminish smartparens-mode
  :custom (show-paren-when-point-inside-paren t)
  :init
  (progn
    (show-paren-mode t)
    (define-advice show-paren-function (:around (fn) fix)
      "Highlight enclosing parens."
      (cond ((looking-at-p "\\s(") (funcall fn))
            (t (save-excursion
		 (ignore-errors (backward-up-list))
		 (funcall fn))))) )
  
  :hook (after-init . smartparens-global-mode)
  :config
  (progn
    ;; single "'" in emacs-lisp mode 
    (sp-local-pair '(emacs-lisp-mode lisp-interaction-mode) "'" nil :actions nil)
    (sp-local-pair 'emacs-lisp-mode "`" nil :actions nil) ))

(use-package helm
  
  :commands helm-mini
  :bind (:map helm-map
              ("<tab>" . helm-execute-persistent-action)
              ("C-z"   . helm-select-action)
              ("A-v"   . helm-previous-page))
  :config (helm-autoresize-mode 1))

(use-package ivy
  
  :diminish ivy-mode
  :bind (("C-x b" . ivy-switch-buffer)
         ("C-x B" . ivy-switch-buffer-other-window)
         ("M-H"   . ivy-resume)
	 :map ivy-switch-buffer-map
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
  
  :bind ("\C-s" . swiper))

(use-package counsel
  
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
  :config
  (add-to-list 'ivy-sort-matches-functions-alist
               '(counsel-find-file . ivy--sort-files-by-date)))

(use-package undo-tree
  
  :diminish undo-tree-mode
  :bind ("s-z" . undo-tree-undo)
  :config
  (progn
    (global-undo-tree-mode 1)
    (defalias 'redo 'undo-tree-redo)
    (global-set-key (kbd "s-r") 'redo) ))

(use-package expand-region
  
  :bind ("C-=" . er/expand-region)
  :config
  (defun er/add-text-mode-expansions ()
    (make-variable-buffer-local 'er/try-expand-list)
    (setq er/try-expand-list (append
                              er/try-expand-list
                              '(mark-paragraph
				mark-page))))
  (add-hook 'text-mode-hook 'er/add-text-mode-expansions))

(provide 'init-operating-assist)
