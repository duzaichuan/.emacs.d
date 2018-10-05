(use-package eshell
  :ensure t
  :bind (([f1] . eshell)
	 :map comint-mode-map
	 ([up] . comint-previous-input)
	 ([down] . comint-next-input))
  :commands eshell-mode
  :init
  (setq eshell-highlight-prompt nil
	eshell-visual-subcommands '(("git" "log" "diff" "show"))
	comint-prompt-read-only t
	eshell-buffer-shorthand t
	eshell-history-size 5000
	;; auto truncate after 12k lines
	eshell-buffer-maximum-lines 12000
	eshell-hist-ignoredups t
	eshell-error-if-no-glob t
	eshell-glob-case-insensitive t
	eshell-scroll-to-bottom-on-input 'all
	eshell-list-files-after-cd t)
  :config
  (add-hook 'eshell-mode-hook
	    (lambda ()(eshell-cmpl-initialize)))
  )

(use-package virtualenvwrapper
  :ensure t
  :defer t)

(use-package eshell-prompt-extras
  :ensure t
  :after eshell
  :custom (eshell-prompt-function 'epe-theme-lambda)
  :config
  (with-eval-after-load "esh-opt"
    (require 'virtualenvwrapper)
    (venv-initialize-eshell)
    (autoload 'epe-theme-lambda "eshell-prompt-extras"))
  )

(use-package eshell-fringe-status
  :ensure t
  :hook (eshell-mode . eshell-fringe-status-mode))

(use-package esh-autosuggest
  :ensure t
  :hook (eshell-mode . esh-autosuggest-mode))

(provide 'du-shell)
