;;Fancy Titlebar
(setq ns-use-proxy-icon nil)
(set-frame-name "Sub Specie Aeternitatis")
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))

;; fringe width
(fringe-mode '(nil . 0))

;; Default minibuffer message
(defun display-startup-echo-area-message ()
  (message "Write!"))

;; font and format
(set-face-attribute 'default nil :font "DejaVu Sans Mono")
(tool-bar-mode -1)
(scroll-bar-mode -1)
(set-face-attribute 'default nil :height 160)
(setq inhibit-startup-screen t)
(setq-default cursor-type 'bar)
(global-visual-line-mode)
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

  :custom
  (zenburn-use-variable-pitch t "use variable-pitch fonts for some headings and titles")

  (zenburn-scale-org-headlines t "scale headings in org-mode")

  (zenburn-scale-outline-headlines t "scale headings in outline-mode")

  :config
  (load-theme 'zenburn t))

(use-package powerline

  :custom (powerline-default-separator 'butt)
  :hook (after-init . powerline-center-evil-theme))

;; (use-package org-beautify-theme)

(use-package rainbow-delimiters

  :diminish t
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package visual-fill-column

  :custom
  (visual-fill-column-center-text t)
  (visual-fill-column-width 90)

  :hook
  ((eww-mode nov-mode ein:notebook-multilang-mode mu4e-compose-mode mu4e-view-mode) . visual-fill-column-mode))

(use-package hide-mode-line

  :commands hide-mode-line-mode)

(provide 'init-appearance)
