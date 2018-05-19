;; Consistent ESS-like eval interface for various REPLs
(use-package eval-in-repl
  :ensure t
  :defer t
  :init
  ;; Place REPL on the left of the script window when splitting.
  (setq eir-repl-placement 'left))

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
  :interpreter "clojure"
  :config
  (progn
    (add-hook 'clojure-mode-hook #'paredit-mode)
    ;; single "'" and "`" 
    (sp-local-pair '(clojure-mode cider-repl-mode) "'" nil :actions nil)
    (sp-local-pair '(clojure-mode cider-repl-mode) "`" nil :actions nil)
    (require 'eval-in-repl-cider)
    (define-key clojure-mode-map (kbd "<C-return>") 'eir-eval-in-cider)
    )
  )

(use-package rainbow-delimiters
  :ensure t
  :hook (cider-repl-mode . rainbow-delimiters-mode))

(use-package cider
  :ensure t
  :commands (cider-connect cider-jack-in)
  :init
  (setq cider-auto-select-error-buffer t
        cider-repl-pop-to-buffer-on-connect nil
        cider-repl-use-clojure-font-lock t
        cider-repl-wrap-history t
        cider-repl-history-size 1000
        cider-repl-history-file (f-expand ".cider-history"
				      user-emacs-directory)
        cider-show-error-buffer t
        nrepl-hide-special-buffers t))

(use-package lsp-mode
  :ensure  t
  :hook prog-mode)

(use-package lsp-ui
  ;;:commands lsp-ui-mode
  :hook (lsp-mode-hook . lsp-ui-mode)
  :config (require 'lsp-flycheck))

(provide 'du-proglangs)
