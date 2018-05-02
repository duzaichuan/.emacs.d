;; appearance setting
(add-to-list 'default-frame-alist '(fullscreen . maximized))
;; font
(set-face-attribute 'default nil
		    :font "DejaVu Sans Mono")
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-linum-mode 1)
(set-face-attribute 'default nil :height 170)
(setq inhibit-startup-screen t)
(setq-default cursor-type 'bar)
(global-hl-line-mode t)

;; better defaults
;; open init.el 
(global-set-key (kbd "<f2>") (lambda () (interactive) (find-file user-init-file)))

;; help menu
(global-set-key (kbd "C-h C-f") 'find-function)
(global-set-key (kbd "C-h C-v") 'find-variable)
(global-set-key (kbd "C-h C-k") 'find-function-on-key)

;; paren-mode
(show-paren-mode t)
;; disable audio bell
(setq ring-bell-function 'ignore)

(set-keyboard-coding-system nil)
(delete-selection-mode t)

;; eliminate backup and auto-save files in .emacs.d
(setq make-backup-files nil)
(setq auto-save-default nil)

;; return word at the end of lines
(global-visual-line-mode t)

;; change reminder "yes" to "y"
(fset 'yes-or-no-p 'y-or-n-p)

(setq tab-always-indent 'complete)

;; show paren highlight inside
(define-advice show-paren-function (:around (fn) fix-show-paren-function)
  "Highlight enclosing parens."
  (cond ((looking-at-p "\\s(") (funcall fn))
        (t (save-excursion
             (ignore-errors (backward-up-list))
             (funcall fn)))))

(global-set-key (kbd "C-w") 'backward-kill-word)

;; single "'" in emacs-lisp mode 
(sp-local-pair '(emacs-lisp-mode lisp-interaction-mode) "'" nil :actions nil)
(sp-local-pair 'emacs-lisp-mode "`" nil :actions nil)

(provide 'init-better-defaults)
