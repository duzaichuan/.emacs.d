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

(provide 'init-better-defaults)
