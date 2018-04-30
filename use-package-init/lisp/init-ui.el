;; init-ui
(use-package tao-theme
  :ensure t
  :config
  (load-theme 'tao-yang t))

(use-package color-identifiers-mode
  :ensure
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
(setq line-number-mode 1)
(setq column-number-mode 1)
(setq ns-use-srgb-colorspace nil)
(use-package spaceline-config
  :ensure spaceline
  :config
  ;; Set some parameters of the spaceline
  (setq spaceline-highlight-face-func 'spaceline-highlight-face-evil-state)
  (setq powerline-default-separator 'bar)

  ;; Define a better buffer position line
  (spaceline-define-segment gjstein-buffer-position
    "a better buffer position display"
    (let ((buffer-position (format-mode-line "%p")))
      (if (string= buffer-position "Top") "top"
	(if (string= buffer-position "Bottom") "bot"
	  (if (string= buffer-position "All") "all"
	    "%p")))
      )
    )

  ;; Removes the " Git:" from the 'version-control' segment.
  (spaceline-define-segment gjstein-version-control
    "Version control information."
    (when vc-mode
      (powerline-raw
       (s-trim (concat
		(let ((backend (symbol-name (vc-backend (buffer-file-name)))))
		  (substring vc-mode (+ (length backend) 2)))
		(when (buffer-file-name)
		  (pcase (vc-state (buffer-file-name))
		    (`up-to-date " ")
		    (`edited "*")
		    (`added "@")
		    (`unregistered "?")
		    (`removed "-")
		    (`needs-merge " Con")
		    (`needs-update " Upd")
		    (`ignored "!")
		    (_ " Unk"))))))))

  ;; Makes a shorter org-clock string.
  (defun gjstein-org-clock-get-clock-string ()
    "Makes a clock string for org."
    (let ((clocked-time (org-clock-get-clocked-time)))
      (if org-clock-effort
	  (let* ((effort-in-minutes
		  (org-duration-string-to-minutes org-clock-effort))
		 (work-done-str
		  (propertize
		   (org-minutes-to-clocksum-string clocked-time)
		   'face (if (and org-clock-task-overrun (not org-clock-task-overrun-text))
			     'org-mode-line-clock-overrun 'org-mode-line-clock)))
		 (effort-str (org-minutes-to-clocksum-string effort-in-minutes))
		 (clockstr (propertize
			    (concat  "%s/" effort-str
				     " " (replace-regexp-in-string "%" "%%" org-clock-heading))
			    'face 'org-mode-line-clock)))
	    (format clockstr work-done-str))
	(propertize (concat (org-minutes-to-clocksum-string clocked-time)
			    (format " %s" org-clock-heading))
		    'face 'org-mode-line-clock))))
  (setq spaceline-org-clock-format-function 'gjstein-org-clock-get-clock-string)

  (spaceline-compile
   'gjstein
   ;; Left side of the mode line (all the important stuff)
   '(((buffer-modified buffer-size input-method) :face highlight-face)
     '(buffer-id remote-host major-mode)
     ((point-position line-column gjstein-buffer-position) :separator "|" )
     process
     ((flycheck-error flycheck-warning flycheck-info) :separator "" :when active)
     ((which-function projectile-root (gjstein-version-control :when active)) :separator ":")
     )
   ;; Right segment (the unimportant stuff)
   '((org-clock)
     ((minor-modes :separator " ") :when active)
     (mu4e-alert-segment)))

  (spaceline-helm-mode)
  (setq-default mode-line-format '("%e" (:eval (spaceline-ml-gjstein)))))

(use-package powerline
  :ensure t
  :after spaceline-config
  :config
  (setq
   powerline-height (truncate (* 1.0 (frame-char-height)))
   powerline-default-separator 'utf-8)
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
