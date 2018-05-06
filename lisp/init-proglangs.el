;; Language support
(use-package ess-site
  :ensure ess
  :mode (("\\.jl$" . ess-julia-mode)
         ("\\.R$"  . R-mode))
  :config
  (progn
    (add-hook 'ess-mode-hook 'company-mode)
    (add-hook 'ess-julia-mode-hook
              (lambda()
		(define-key
                  ess-julia-mode-map (kbd "TAB") 'julia-latexsub-or-indent)))
    (ess-toggle-underscore nil)
    (setq ess-fancy-comments nil)
					; Make ESS use RStudio's indenting style
    (add-hook 'ess-mode-hook (lambda() (ess-set-style 'RStudio)))
					; Make ESS use more horizontal screen			       
    (add-hook 'ess-R-post-run-hook 'ess-execute-screen-options) 
    (define-key inferior-ess-mode-map "\C-cw" 'ess-execute-screen-options)
    ))

(use-package matlab-mode
  :ensure t
  :mode "\\.m\\'"
  :bind (:map matlab-shell-mode-map
              ("C-c C-c" . term-interrupt-subjob))
  :commands matlab-shell
  :init
  ;; workaround for emacs 26
   (if (version< emacs-version "26")
       (message "Tracking stable Emacs")
     (defvar default-fill-column (default-value 'fill-column))
     (defalias 'string-to-int 'string-to-number))
   (setq matlab-indent-function t)
   (setq matlab-shell-command "/Applications/MATLAB/MATLAB_R2017b.app/bin/matlab")
   (eval-after-load 'matlab
     '(add-to-list 'matlab-shell-command-switches "-nodesktop -nosplash"))
   :config
   (defun matlab-shell-here ()
     "opens up a new matlab shell in the directory associated with the current buffer's file."
     (interactive)
     (split-window-right)
     (other-window 1)
     (matlab-shell))
  )

(use-package dynare
  :load-path "/lib"
  :mode ("\\.mod\\'" . dynare-mode))

(use-package python
  :ensure t
  :mode ("\\.py\\'" . python-mode)
  :interpreter ("python" . python-mode))

(use-package clojure-mode
  :ensure t
  :commands (clojure-mode)
  :mode ("\\.clj\\'" "\\.cljs\\'" "\\.edn\\'" "\\.boot\\'")
  :interpreter "clojure")

(use-package cider
  :ensure t
  :hook clojure-mode)

(use-package polymode
  :ensure t
  :mode (("\\.md" . poly-markdown-mode)
	 ("\\.Rmd" . poly-markdown+r-mode)))

(use-package lsp-mode
  :ensure  t
  :hook prog-mode)

(use-package lsp-ui
  ;;:commands lsp-ui-mode
  :hook (lsp-mode-hook . lsp-ui-mode)
  :config (require 'lsp-flycheck))

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

(provide 'init-proglangs)
