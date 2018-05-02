;; This is only needed once, near the top of the file
(eval-when-compile
  (require 'use-package)
  (setq use-package-verbose t))

;; path consistency between shell and emacs
(when (and (memq window-system '(mac ns))
           (require 'exec-path-from-shell nil t))
  (setq exec-path-from-shell-debug t)
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-envs '("LANG" "GPG_AGENT_INFO" "SSH_AUTH_SOCK"))
  (message "Initialized PATH and other variables from SHELL."))

(global-company-mode t)

;; paredit
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'clojure-mode-hook          #'enable-paredit-mode)
(add-hook 'racket-mode-hook           #'enable-paredit-mode)

(ido-mode 1)
(setq ido-separator "\n")

(ivy-mode 1)
(setq ivy-use-virtual-buffers t)

(smartparens-global-mode t)

;; ESS julia
(require 'ess-site)

;; Matlab-mode
(setq matlab-shell-command "/Applications/MATLAB/MATLAB_R2017b.app/bin/matlab")
(setq matlab-shell-command-switches (list "-nodesktop"))

;; polymode
;;; MARKDOWN
(add-to-list 'auto-mode-alist '("\\.md" . poly-markdown-mode))
;;; R modes
(add-to-list 'auto-mode-alist '("\\.Snw" . poly-noweb+r-mode))
(add-to-list 'auto-mode-alist '("\\.Rnw" . poly-noweb+r-mode))
(add-to-list 'auto-mode-alist '("\\.Rmd" . poly-markdown+r-mode))
(require 'poly-R)
(require 'poly-markdown)

;; pdf-tools
(pdf-tools-install)
;; automatically annotate highlights
(setq pdf-annot-activate-created-annotations t)
(add-hook 'pdf-view-mode-hook (lambda() (linum-mode -1)))

;; expand-region
(require 'expand-region)

;; popwin help window is annoying
(require 'popwin)
(popwin-mode t)

;; overlay
(require 'ov)

;; automaticly update packages at start-up
(auto-package-update-maybe)
;; show a manual prompt before automatic updates
(setq auto-package-update-prompt-before-update t)
(setq auto-package-update-hide-results t)

;; typo mode
(typo-global-mode 1)
(add-hook 'text-mode-hook 'typo-mode)

(use-package writeroom-mode
  :ensure t
  :bind ("C-c w" . writeroom-mode))

(use-package pallet
  :ensure t)

(provide 'init-packages)
