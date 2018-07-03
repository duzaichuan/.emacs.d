(use-package eshell
  :ensure t
  :bind (([f1] . eshell)
	 :map comint-mode-map
	 ([up] . comint-previous-input)
	 ([down] . comint-next-input))
  :hook (eshell-mode . visual-line-mode)
  :commands eshell-mode
  :init
  (progn
    (setq eshell-visual-subcommands '(("git" "log" "diff" "show")))
    (setq  eshell-highlight-promp nil
	   eshell-buffer-shorthand t
	   eshell-history-size 5000
	   ;;  ;; auto truncate after 12k lines
	   eshell-buffer-maximum-lines 12000
	   eshell-hist-ignoredups t
	   eshell-error-if-no-glob t
	   eshell-glob-case-insensitive t
	   eshell-scroll-to-bottom-on-input 'all
	   eshell-list-files-after-cd t))
  :config
  (progn
    (add-hook 'eshell-mode-hook
	      (lambda ()(eshell-cmpl-initialize))) ))

(use-package virtualenvwrapper
  :ensure t
  :defer t)

(use-package eshell-prompt-extras
  :ensure t
  :after eshell
  :config
  (with-eval-after-load "esh-opt"
    (require 'virtualenvwrapper)
    (venv-initialize-eshell)
    (autoload 'epe-theme-lambda "eshell-prompt-extras")
    (setq eshell-highlight-prompt nil
          eshell-prompt-function 'epe-theme-lambda)))

(use-package eshell-fringe-status
  :ensure t
  :hook (eshell-mode . eshell-fringe-status-mode))

(use-package esh-autosuggest
  :ensure t
  :hook (eshell-mode . esh-autosuggest-mode))

(use-package shell-pop
  :ensure t
  :commands shell-pop
  :config
  (progn
    (setq shell-pop-window-position "bottom"
	  shell-pop-window-size 35) ))

(provide 'du-shell)
