;; Consistent ESS-like eval interface for various REPLs
(use-package eval-in-repl
  
  :defer t
  :custom
  (eir-repl-placement 'left "Place REPL on the left of the script window when splitting."))

(use-package sly
  
  :custom (inferior-lisp-program "/usr/local/bin/clisp")
  :commands sly)

(use-package geiser
  
  :custom (geiser-active-implementations '(guile chez))
  :commands geiser)

(use-package clojure-mode
  
  :commands (clojure-mode)
  :mode ("\\.clj\\'" "\\.cljs\\'" "\\.edn\\'" "\\.boot\\'")
  :interpreter "clojure"
  :bind (:map clojure-mode-map
	      ("C-<return>" . eir-eval-in-cider))
  :config
  (progn
    ;; single "'" and "`" 
    (sp-local-pair '(clojure-mode cider-repl-mode) "'" nil :actions nil)
    (sp-local-pair '(clojure-mode cider-repl-mode) "`" nil :actions nil)
    (require 'eval-in-repl-cider) ))

(use-package cider
  
  :commands (cider-connect cider-jack-in)
  :custom
  (cider-auto-select-error-buffer t)
  (cider-repl-pop-to-buffer-on-connect nil)
  (cider-repl-use-clojure-font-lock t)
  (cider-repl-wrap-history t)
  (cider-repl-history-size 1000)
  (cider-show-error-buffer t)
  (nrepl-hide-special-buffers t))

(use-package julia-mode
  
  :mode ("\\.jl$" . julia-mode)
  :hook (julia-mode . display-line-numbers-mode))

(use-package julia-repl
  
  :hook (julia-mode . julia-repl-mode))

(use-package ess
  
  :mode ("\\.R$"  . R-mode)
  :bind (:map inferior-ess-mode-map
	      ("C-c w" . ess-execute-screen-options))
  :custom (ess-fancy-comments nil "Make ESS use RStudio's indenting style")
  :config
  (progn
    (add-hook 'ess-mode-hook (lambda () (ess-set-style 'RStudio))) ; Make ESS use more horizontal screen	     
    (add-hook 'ess-R-post-run-hook 'ess-execute-screen-options) ))

(use-package polymode  :defer t)
(use-package poly-noweb  :defer t)
(use-package poly-markdown  :defer t)

(use-package poly-R
  
  :mode (("\\.md" . poly-markdown-mode)
	 ("\\.[rR]md\\'" . poly-markdown+r-mode)))

(use-package matlab-mode
  
  :mode "\\.m\\'"
  :bind (:map matlab-shell-mode-map
              ("C-c C-c" . term-interrupt-subjob))
  :commands matlab-shell
  :hook (matlab-mode . display-line-numbers-mode)
  :custom
  (matlab-indent-function t)
  (semantic-matlab-root-directory "/Applications/MATLAB/MATLAB_R2017b.app")
  (matlab-mode-install-path "/Applications/MATLAB/MATLAB_R2017b.app/toolbox")
  (matlab-shell-command "/Applications/MATLAB/MATLAB_R2017b.app/bin/matlab")
  :init
  (progn
    ;; workaround for emacs 26
    (if (version< emacs-version "26")
	(message "Tracking stable Emacs")
      (defvar default-fill-column (default-value 'fill-column))
      (defalias 'string-to-int 'string-to-number))
    (eval-after-load 'matlab
      '(add-to-list 'matlab-shell-command-switches "-nodesktop -nosplash"))
    
    (defun du-matlab-shell-here ()
      "opens up a new matlab shell in the directory associated with the current buffer's file."
      (interactive)
      (split-window-below)
      (other-window 1)
      (matlab-shell))
    )
  :config (matlab-cedet-setup))

(use-package dynare

  :straight nil
  :load-path "lib/"
  :mode ("\\.mod\\'" . dynare-mode))

(use-package python
  
  :mode ("\\.py\\'" . python-mode)
  :hook (python-mode . display-line-numbers-mode)
  :interpreter ("python" . python-mode))

(use-package ein
  
  :bind ([f6] . ein:jupyter-server-start)
  :custom (ein:jupyter-default-notebook-directory "~/Jupyter/"))

(provide 'init-prog-langs)
