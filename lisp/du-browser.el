(use-package eww
  :bind (("C-x m" . browse-url-at-point)
	 ([f7] . eww)
	 :map eww-mode-map
	 ("C-c p" . eww-copy-page-url)
	 :map eww-link-keymap
	 ("p" . du/mpv-play))
  :init
  (setq browse-url-browser-function #'eww-browse-url)
  :config
  (defun du/mpv-play (url)
    "play youtube and bilibili at the url point"
    (interactive (list (shr-url-at-point current-prefix-arg)))
    (cond ((string-match "youtube" url)
           (call-process "mpv" nil nil nil url))
          ((string-match "bilibili" url)
           (call-process "bili" nil nil nil url)))))

(use-package w3m
  :ensure t
  :bind (([f3] . w3m)
	 :map w3m-mode-map
	 ("n" . w3m-next-buffer)
	 ("p" . w3m-previous-buffer))
  :config
  (progn
    (setq w3m-command "w3m"
	  w3m-home-page "about://bookmark/")
    (setq w3m-coding-system 'utf-8
          w3m-file-coding-system 'utf-8
          w3m-file-name-coding-system 'utf-8
          w3m-input-coding-system 'utf-8
          w3m-output-coding-system 'utf-8
          w3m-terminal-coding-system 'utf-8)
    (setq w3m-use-cookies t
	  w3m-default-display-inline-images t
	  w3m-view-this-url-new-session-in-background t
	  w3m-command-arguments '("-cookie" "-F"))
    (eval-when-compile
      (autoload 'w3m-search-escape-query-string "w3m-search")) ))

(use-package pdf-tools
  :ensure t
  :magic ("%PDF" . pdf-view-mode)
  :hook (pdf-view-mode . savehist-mode)
  :init
  (setq pdf-annot-activate-created-annotations t) ; automatically annotate highlights
  :config
  (progn
    (pdf-tools-install)
    (add-hook 'pdf-view-mode-hook
	      (lambda () (set (make-local-variable 'evil-normal-state-cursor) (list nil))
		(set (make-local-variable 'evil-visual-state-cursor) (list nil))))
    (setq-default pdf-view-display-size 'fit-width) ; fit page by default
    (setq pdf-view-resize-factor 1.10)
    (setq pdf-view-midnight-colors `(,(face-attribute 'default :foreground) .
                                     ,(face-attribute 'default :background)))
    ;; default annot color
    (push '(color . "dark cyan") pdf-annot-default-markup-annotation-properties)
    ;; wrapper for save-buffer ignoring arguments
    (defun du/save-buffer-no-args ()
      "Save buffer ignoring arguments"
      (save-buffer))
    ;; wait until map is available
    (with-eval-after-load "pdf-annot"
      (define-key pdf-annot-edit-contents-minor-mode-map (kbd "<return>") 'pdf-annot-edit-contents-commit)
      (define-key pdf-annot-edit-contents-minor-mode-map (kbd "<S-return>") 'newline)
      ;; save after adding comment
      (advice-add 'pdf-annot-edit-contents-commit :after 'du/save-buffer-no-args)) ))

(use-package nov
  :ensure t
  :mode ("\\.epub\\'" . nov-mode)
  :config
  (progn
    (setq nov-text-width 70)
    (defun du/nov-font-setup ()
      (face-remap-add-relative 'variable-pitch :family "Liberation Serif"
                               :height 1.1))
    (add-hook 'nov-mode-hook 'du/nov-font-setup) )) 

(use-package writeroom-mode
  :ensure t
  :hook (writeroom-mode . visual-line-mode))

(provide 'du-browser)
