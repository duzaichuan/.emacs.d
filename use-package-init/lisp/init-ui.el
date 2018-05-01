;; init-ui
(use-package tao-theme
  :ensure t
  :config
  (load-theme 'tao-yang t))

(use-package color-identifiers-mode
  :ensure t
  :defer t
  :init (add-hook 'after-init-hook 'global-color-identifiers-mode))

(use-package all-the-icons
  :ensure t
  :config
  (all-the-icons-octicon "file-binary")  ;; GitHub Octicon for Binary File
  (all-the-icons-faicon  "cogs")         ;; FontAwesome icon for cogs
  (all-the-icons-wicon   "tornado"))

(use-package neotree
  :ensure t
  :bind ([f8] . neotree-toggle)
  :config
  (setq neo-theme (if (display-graphic-p) 'icons 'none)))

;;; Customize the modeline
(use-package powerline
  :ensure t
  :config
  (setq powerline-arrow-shape 'arrow)
  (setq powerline-color1 "grey22")
  (setq powerline-color2 "grey40")
  )

(defmacro rename-major-mode (package-name mode new-name)
  "Renames a major mode."
 `(eval-after-load ,package-name
   '(defadvice ,mode (after rename-modeline activate)
      (setq mode-name ,new-name))))
(rename-major-mode "python" python-mode "π")
(rename-major-mode "markdown-mode" markdown-mode "Md")
(rename-major-mode "shell" shell-mode "σ")
(rename-major-mode "org" org-mode "ω")
(rename-major-mode "Web" web-mode "w")

(add-hook 'web-mode-hook (lambda() (setq mode-name "w")))
(add-hook 'emacs-lisp-mode-hook (lambda() (setq mode-name "ελ")))

(provide 'init-ui)
