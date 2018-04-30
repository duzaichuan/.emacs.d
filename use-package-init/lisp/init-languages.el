;; Language support
(use-package ess
  :ensure t
  :mode ("\\.jl\\'" . ess-mode)
  :interpreter ("julia" . ess-mode))

(use-package matlab-mode
  :ensure t
  :mode "\\.m\\'"
  :interpreter "matlab"
  :config
  (setq matlab-shell-command "/Applications/MATLAB/MATLAB_R2017b.app/bin/matlab")
  (setq matlab-shell-command-switches (list "-nodesktop")))

(use-package dynare
  :load-path "/lisp"
  :mode "\\.mod\\'")

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

(provide 'init-languages)
