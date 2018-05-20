;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want (setq  initial-frame-alist (quote ((fullscreen . maximized))))it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

(require 'cask "/usr/local/share/emacs/site-lisp/cask/cask.el")
(cask-initialize) ;; analogous to (package-initialize)
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
  :if (memq window-system '(mac ns))
  :ensure t
  :config
  (exec-path-from-shell-initialize))

(use-package auto-package-update
  :ensure t
  :config
  (progn
    (setq auto-package-update-delete-old-versions t)
    (setq auto-package-update-hide-results t)
    (auto-package-update-maybe)
    ))

;; Require files under ~/.emacs.d/lisp
(use-package du-better-defaults)
(use-package du-toolkit)
(use-package du-ui)
(use-package du-proglangs)
(use-package du-writing)
(use-package du-mail)
(use-package du-media)

(load-file custom-file)
