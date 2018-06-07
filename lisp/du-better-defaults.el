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

;; Define the global encoding as utf-8 english US related
(setq system-time-locale "en_US.utf8")
(prefer-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)

(provide 'du-better-defaults)
