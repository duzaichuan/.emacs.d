;; appearance setting
(add-to-list 'default-frame-alist '(fullscreen . maximized))
;; font
(set-face-attribute 'default nil :font "DejaVu Sans Mono")
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-linum-mode 1)
(set-face-attribute 'default nil :height 170)
(setq inhibit-startup-screen t)
(setq-default cursor-type 'bar)
(global-hl-line-mode t)
(global-prettify-symbols-mode)

(use-package zenburn-theme
  :ensure t
  :config
  (setf custom-safe-themes t)
  (load-theme 'zenburn))

(use-package powerline
  :ensure t
  :config
  (setq powerline-image-apple-rgb t
	powerline-default-separator 'butt)
  (powerline-center-evil-theme))

(use-package neotree
  :ensure t
  :defer t)

(provide 'du-ui)
