;; disable audio bell
(setq ring-bell-function 'ignore)

;; link to git
(global-auto-revert-mode t)

;; Find recent files
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 10)


(set-keyboard-coding-system nil)
(delete-selection-mode t)

;; eliminate backup and auto-save files in .emacs.d
(setq make-backup-files nil)
(setq auto-save-default nil)

;; return word at the end of lines
(global-visual-line-mode t)

;; change reminder "yes" to "y"
(fset 'yes-or-no-p 'y-or-n-p)

;; delete and copy all files in a directory in dired-mode
(setq dired-recursive-deletes 'always)
(setq dired-recursive-copies 'always)

;; let dired-mode use only one buffer to open files
(put 'dired-find-alternate-file 'disabled nil)

;; C-x C-j to open current directory from dired-mode
(require 'dired-x)

;; do what I mean in dired-mode
(setq dired-dwim-target t)

;; single "'" in emacs-lisp mode 
(sp-local-pair '(emacs-lisp-mode lisp-interaction-mode) "'" nil :actions nil)

;; show paren highlight inside
(define-advice show-paren-function (:around (fn) fix-show-paren-function)
  "Highlight enclosing parens."
  (cond ((looking-at-p "\\s(") (funcall fn))
        (t (save-excursion
             (ignore-errors (backward-up-list))
             (funcall fn)))))

(provide 'init-better-defaults)
