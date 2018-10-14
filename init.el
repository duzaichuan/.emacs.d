(setq package-enable-at-startup nil
      file-name-handler-alist nil
      message-log-max 16384
      gc-cons-threshold 64102410241024
      gc-cons-percentage 0.9
      auto-window-vscroll nil
      straight-check-for-modifications 'live
      straight-recipes-gnu-elpa-use-mirror t
      straight-use-package-by-default t)

(defun du-reset-gc-cons ()
  "Return the garbage collection threshold to default values."
  (setq gc-cons-threshold
	(car (get 'gc-cons-threshold 'standard-value))
	gc-cons-percentage
	(car (get 'gc-cons-percentage 'standard-value))))

(add-hook 'after-init-hook 'du-reset-gc-cons)

(eval-when-compile (require 'cl-lib))

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(straight-use-package 'diminish)
(straight-use-package 'bind-key)

(use-package exec-path-from-shell
  :if (memq window-system '(ns mac))
  :straight t
  :config
  (progn
    (when (string-match-p "/zsh$" (getenv "SHELL"))
      ;; Use a non-interactive login shell. A login shell, because my environment variables are mostly set in `.zprofile'.
      (setq exec-path-from-shell-arguments '("-l")))
    (exec-path-from-shell-initialize)))

(add-to-list 'load-path (expand-file-name "init" user-emacs-directory))

;; Libraries
(require 'init-appearance)
(require 'init-operating-assist)
(require 'init-key-navigator)
(require 'init-project-manager)
(require 'init-prog-langs)
(require 'init-text-editor)
(require 'init-browse-reader)
(require 'init-shell)
(require 'init-mail)
(require 'init-media)
(require 'init-sns-client)
(require 'init-data-manipulator)

;; Customizations
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file) (load custom-file))
