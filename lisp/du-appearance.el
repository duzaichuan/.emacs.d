;; appearance setting
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))

;; font
(set-face-attribute 'default nil :font "DejaVu Sans Mono")
(tool-bar-mode -1)
(scroll-bar-mode -1)
(set-face-attribute 'default nil :height 170)
(setq inhibit-startup-screen t)
(setq-default cursor-type 'bar)
(global-hl-line-mode t)
(global-prettify-symbols-mode)

;;;; 设置编辑环境
;; 设置为中文简体语言环境
(setenv "LANG" "zh_CN.UTF-8")
;; 设置emacs 使用 utf-8
(setq locale-coding-system 'utf-8)
;; 设置键盘输入时的字符编码
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
;; 文件默认保存为 utf-8
(set-buffer-file-coding-system 'utf-8)
(set-default buffer-file-coding-system 'utf8)
(set-default-coding-systems 'utf-8)
;; 解决粘贴中文出现乱码的问题
(set-clipboard-coding-system 'utf-8)
;; 终端中文乱码
(set-terminal-coding-system 'utf-8)
(modify-coding-system-alist 'process "*" 'utf-8)
(setq default-process-coding-system '(utf-8 . utf-8))
;; 解决文件目录的中文名乱码
(setq-default pathname-coding-system 'utf-8)
(set-file-name-coding-system 'utf-8)

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

(use-package org-beautify-theme
  :ensure t)

(use-package golden-ratio
  :ensure t
  :diminish golden-ratio-mode
  :config
  (golden-ratio-mode 1))

(provide 'du-appearance)
