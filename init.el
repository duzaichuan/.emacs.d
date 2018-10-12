;; Startup speed
(setq package-enable-at-startup nil ; :mode :interpreter is needed if set to nil
      file-name-handler-alist nil
      message-log-max 16384
      gc-cons-threshold 64102410241024
      gc-cons-percentage 0.9
      auto-window-vscroll nil)

(defun du-reset-gc-cons ()
  "Return the garbage collection threshold to default values."
  (setq gc-cons-threshold
	(car (get 'gc-cons-threshold 'standard-value))
	gc-cons-percentage
	(car (get 'gc-cons-percentage 'standard-value))))

(add-hook 'after-init-hook 'du-reset-gc-cons)

(eval-when-compile (require 'cl-lib))

(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")             
                         ("melpa" . "https://melpa.org/packages/")
			 ("org" . "http://orgmode.org/elpa/")))
(package-initialize)

;; Bootstrap 'use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package)
  ;; (setq use-package-verbose t)
  )

(use-package dash :defer t)                ; A modern list library
(use-package diminish :ensure t :defer t)  ; Hide modes in the mode-line
(use-package bind-key :ensure t :defer t)  ; if you use any :bind variant

(use-package exec-path-from-shell
  :if (memq window-system '(ns mac))
  :ensure t
  :config
  (progn
    (when (string-match-p "/zsh$" (getenv "SHELL"))
      ;; Use a non-interactive login shell. A login shell, because my environment variables are mostly set in `.zprofile'.
      (setq exec-path-from-shell-arguments '("-l")))
    (exec-path-from-shell-initialize)))

(add-to-list 'load-path (expand-file-name "init" user-emacs-directory))

;; Libraries
(use-package init-appearance)
(use-package init-operating-assist)
(use-package init-key-navigator)
(use-package init-project-manager)
(use-package init-prog-langs)
(use-package init-text-editor)
(use-package init-browse-reader)
(use-package init-shell)
(use-package init-mail)
(use-package init-media)
(use-package init-sns-client)
(use-package init-data-manipulator)

;; Customisations
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file) (load custom-file))
