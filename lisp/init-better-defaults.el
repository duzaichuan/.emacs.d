;; disable audio bell
(setq ring-bell-function 'ignore)

(global-auto-revert-mode t)

;; Find recent files
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 10)


(set-keyboard-coding-system nil)

(setq make-backup-files nil)
(setq auto-save-default nil)

(delete-selection-mode t)

(global-visual-line-mode t)

(fset 'yes-or-no-p 'y-or-n-p)

(setq dired-recursive-deletes 'always)
(setq dired-recursive-copies 'always)

(put 'dired-find-alternate-file 'disabled nil)

(require 'dired-x)
(setq dired-dwim-target t)

;;(sp-local-pair '(emacs-lisp-mode lisp-interaction-mode) "'" nil :actions nil)

(provide 'init-better-defaults)
