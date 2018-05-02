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
  :commands lsp-ui-mode
  :hook (lsp-mode-hook . lsp-ui-mode)
  :config (require 'lsp-flycheck))

(use-package lsp-julia
  :load-path "lib/"
  :after lsp-mode)

(provide 'init-proglangs)
