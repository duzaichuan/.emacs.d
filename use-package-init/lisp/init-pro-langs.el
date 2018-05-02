;; Language support
(use-package ess
  :ensure t
  :config
  (require 'ess-site))

(use-package matlab-mode
  :ensure t
  :mode "\\.m\\'"
  :config
 (setq matlab-indent-function t)
 (setq matlab-shell-command "matlab"))

(use-package dynare
  :load-path "/lib"
  :mode ("\\.mod\\'" . dynare-mode))

(use-package python
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

(provide 'init-pro-langs)
