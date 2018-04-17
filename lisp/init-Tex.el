;; Auctex
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(setq TeX-PDF-mode nil)
(setq preview-image-type 'dvipng)
(add-hook 'LaTeX-mode-hook '(lambda () (setq compile-command "latexmk -pdf")))
(add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)

(require 'magic-latex-buffer)
(add-hook 'LaTeX-mode-hook 'magic-latex-buffer)
(add-hook 'LaTeX-mode-hook (lambda () (set (make-variable-buffer-local 'TeX-electric-math) (cons "$" "$"))))
;;(add-hook 'LaTeX-mode-hook (lambda () (set (make-variable-buffer-local 'TeX-electric-math) (cons "\\(" "\\)"))))
(require 'latex-unicode-math-mode)
;; Enable latex-unicode-mode automatically for all LaTeX files.
;; This converts LaTeX to Unicode everwhere, not only in math
;; environments.(org-mode)
;;(add-hook 'org-mode-hook 'latex-unicode-mode)

(provide 'init-Tex)
