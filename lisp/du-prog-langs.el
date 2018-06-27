(use-package prog-mode
  :hook (prog-mode . linum-mode))

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
  :bind (:map inferior-ess-mode-map
	      ("C-c w" . ess-execute-screen-options))
  :config
  (progn
    (add-hook 'ess-julia-mode-hook
              (lambda()
		(define-key
                  ess-julia-mode-map (kbd "TAB") 'julia-latexsub-or-indent)))
    (setq ess-fancy-comments nil) ; Make ESS use RStudio's indenting style
    (add-hook 'ess-mode-hook (lambda() (ess-set-style 'RStudio))) ; Make ESS use more horizontal screen	     
    (add-hook 'ess-R-post-run-hook 'ess-execute-screen-options) ))

(use-package matlab-mode
  :ensure t
  :mode "\\.m\\'"
  :bind (:map matlab-shell-mode-map
              ("C-c C-c" . term-interrupt-subjob))
  :commands matlab-shell
  :hook (matlab-mode . linum-mode)
  :init
  (progn
    ;; workaround for emacs 26
    (if (version< emacs-version "26")
	(message "Tracking stable Emacs")
      (defvar default-fill-column (default-value 'fill-column))
      (defalias 'string-to-int 'string-to-number))
    (setq matlab-indent-function t)
    (setq matlab-shell-command "/Applications/MATLAB/MATLAB_R2017b.app/bin/matlab")
    (eval-after-load 'matlab
      '(add-to-list 'matlab-shell-command-switches "-nodesktop -nosplash"))
    
    (defun du/matlab-shell-here ()
      "opens up a new matlab shell in the directory associated with the current buffer's file."
      (interactive)
      (split-window-right)
      (other-window 1)
      (matlab-shell)) ))

(use-package dynare
  :load-path "/lib"
  :mode ("\\.mod\\'" . dynare-mode))

(use-package python
  :ensure t
  :mode ("\\.py\\'" . python-mode)
  :interpreter ("python" . python-mode))

(use-package ein
  :ensure t
  :commands (ein:notebooklist-open)
  :hook (ein:notebook-multilang-mode . visual-line-mode)
  :init
  (setq ein:jupyter-default-server-command "~/anaconda/bin/jupyter"
	ein:jupyter-default-notebook-directory "~/Jupyter/"))

(use-package clojure-mode
  :ensure t
  :commands (clojure-mode)
  :mode ("\\.clj\\'" "\\.cljs\\'" "\\.edn\\'" "\\.boot\\'")
  :interpreter "clojure"
  :hook (clojure-mode . paredit-mode)
  :bind (:map clojure-mode-map
	      ("C-<return>" . eir-eval-in-cider))
  :config
  (progn
    ;; single "'" and "`" 
    (sp-local-pair '(clojure-mode cider-repl-mode) "'" nil :actions nil)
    (sp-local-pair '(clojure-mode cider-repl-mode) "`" nil :actions nil)
    (require 'eval-in-repl-cider) ))

(use-package rainbow-delimiters
  :ensure t
  :diminish t
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

(provide 'du-prog-langs)
