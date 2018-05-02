;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want (setq  initial-frame-alist (quote ((fullscreen . maximized))))it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

(require 'cask "/usr/local/share/emacs/site-lisp/cask/cask.el")
(cask-initialize) ;; analogous to (package-initialize)
(require 'pallet)
(pallet-mode t)
(add-to-list 'load-path "~/.emacs.d/lisp/")

(require 'init-toolkit)
(require 'init-better-defaults)
(require 'init-ui)
(require 'init-proglangs)
(require 'init-writing)
(require 'init-mail)
(setq custom-file (expand-file-name "lisp/custom.el" user-emacs-directory))
(load-file custom-file)

