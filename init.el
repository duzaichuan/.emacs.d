(setq gc-cons-threshold 100000000) ;; speed up Emacs start up time
(require 'cask "/usr/local/share/emacs/site-lisp/cask/cask.el")
(cask-initialize)
(require 'cl)
(require 'pallet)
(pallet-mode t)
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(setq custom-file (expand-file-name "lisp/custom.el" user-emacs-directory))

;; Bootstrap 'use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; This is only needed once, near the top of the file
(eval-when-compile
  (require 'use-package)
  (setq use-package-verbose t))

(use-package dash :ensure t)      ; A modern list library
(use-package diminish :ensure t)  ; Hide modes in the mode-line
(use-package bind-key)            ; if you use any :bind variant

(use-package exec-path-from-shell
  :if (memq window-system '(ns mac))
  :ensure t
  :config
  (progn
    (when (string-match-p "/zsh$" (getenv "SHELL"))
      ;; Use a non-interactive login shell. A login shell, because my environment variables are mostly set in `.zprofile'.
      (setq exec-path-from-shell-arguments '("-l")))
    (exec-path-from-shell-initialize)))

(use-package auto-package-update
  :ensure t
  :config
  (progn
    (setq auto-package-update-delete-old-versions t)
    (setq auto-package-update-hide-results t)
    (auto-package-update-maybe)))

;; Require files under ~/.emacs.d/lisp
(use-package du-appearance)
(use-package du-operating-assist)
(use-package du-key-navigator)
(use-package du-project-manager)
(use-package du-prog-langs)
(use-package du-text-editor)
(use-package du-browse-reader)
(use-package du-shell)
(use-package du-mail)
(use-package du-media)
(use-package du-sns-client)
(use-package du-data-manipulator)

(load-file custom-file)
