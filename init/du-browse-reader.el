(use-package language-detection
  :ensure t
  :commands (language-detection-buffer language-detection-string))

(use-package eww
  :bind (([f7] . eww)
	 :map eww-link-keymap
	 ("p" . du/mpv-play))
  :hook (eww-mode . visual-fill-column-mode)
  :init
  (progn
    (setq shr-width 75)
    (setq shr-external-rendering-functions '((pre . eww-tag-pre)))
    (setq browse-url-browser-function #'du-browse-url))
  :config (language-detection-buffer))

(use-package du-eww-functions
  :load-path "lib/")

(use-package web-search
  :ensure t
  :bind ("C-c w" . web-search))

(use-package xah-lookup
  :ensure t
  :commands (xah-lookup-wikipedia xah-lookup-word-definition xah-lookup-wiktionary)
  :init (setq xah-lookup-browser-function 'eww))

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
    (setq pdf-annot-default-markup-annotation-properties '((color . "#90ee90")))
    ;; wait until map is available
    (with-eval-after-load "pdf-annot"
      (define-key pdf-annot-edit-contents-minor-mode-map (kbd "<return>") 'pdf-annot-edit-contents-commit)
      (define-key pdf-annot-edit-contents-minor-mode-map (kbd "<S-return>") 'newline)) ))

(use-package nov
  :ensure t
  :mode ("\\.epub\\'" . nov-mode)
  :hook (nov-mode . visual-fill-column-mode)
  :init (setq nov-text-width most-positive-fixnum
	      visual-fill-column-center-text t)
  :config
  (progn
    
    (defun du/nov-font-setup ()
      (face-remap-add-relative 'variable-pitch :family "Liberation Serif"
                               :height 1.1))
    
    (add-hook 'nov-mode-hook 'du/nov-font-setup) )) 

(use-package elfeed
  :ensure t
  :bind ("<f10>" . elfeed)
  :config
  (progn
    
    (defun du/feed-font-setup ()
      (face-remap-add-relative 'variable-pitch :family "Liberation Serif"
                               :height 1.1))
    
    (add-hook 'elfeed-show-mode-hook 'du/feed-font-setup) ))

(use-package elfeed-org
  :ensure t
  :after elfeed
  :config
  (progn
    (elfeed-org)
    (setq rmh-elfeed-org-files (list "~/.emacs.d/elfeed.org")) ))

(use-package elfeed-goodies
  :ensure t
  :after elfeed
  :config
  (elfeed-goodies/setup))

(use-package writeroom-mode
  :ensure t
  :commands writeroom-mode
  :init
  (setq writeroom-fullscreen-effect 'maximized))

(use-package chinese-word-at-point
  :ensure t
  :defer t)

(use-package osx-dictionary
  :ensure t
  :commands (osx-dictionary-search-word-at-point osx-dictionary-search-word-at-point) ; kbd in evil module
  :config
  (progn
    ;; Support Chinese word
    (setq osx-dictionary-use-chinese-text-segmentation t)
    ;; Work with popwin-el (https://github.com/m2ym/popwin-el)
    (push "*osx-dictionary*" popwin:special-display-config) ))

(provide 'du-browse-reader)
