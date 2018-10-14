(use-package language-detection

  :commands (language-detection-buffer language-detection-string))

(use-package eww

  :straight nil
  :bind (([f7] . eww)
	 :map eww-link-keymap
	 ("p" . du-mpv-play))
  :custom
  (shr-width 90)
  (browse-url-browser-function #'du-browse-url)
  (shr-external-rendering-functions '((pre . eww-tag-pre)))
  :config
  (language-detection-buffer))

(use-package du-eww-functions

  :straight nil
  :load-path "lib/")

(use-package web-search

  :bind ("C-c w" . web-search))

(use-package xah-lookup

  :commands (xah-lookup-wikipedia xah-lookup-word-definition xah-lookup-wiktionary)
  :custom (xah-lookup-browser-function 'eww))

(use-package pdf-tools

  :magic ("%PDF" . pdf-view-mode)
  :hook (pdf-view-mode . savehist-mode)
  :custom
  (pdf-annot-activate-created-annotations t "automatically annotate highlights")
  (pdf-view-resize-factor 1.10)
  (pdf-view-midnight-colors `(,(face-attribute 'default :foreground) .
                                     ,(face-attribute 'default :background)))
  (pdf-annot-default-markup-annotation-properties '((color . "#90ee90")))
  (pdf-view-display-size 'fit-page "fit page by default")

  :config
  (progn
    (pdf-tools-install)
    (add-hook 'pdf-view-mode-hook
	      (lambda () (set (make-local-variable 'evil-normal-state-cursor) (list nil))
		(set (make-local-variable 'evil-visual-state-cursor) (list nil))))
    ;; wait until map is available
    (with-eval-after-load "pdf-annot"
      (define-key pdf-annot-edit-contents-minor-mode-map (kbd "<return>") 'pdf-annot-edit-contents-commit)
      (define-key pdf-annot-edit-contents-minor-mode-map (kbd "<S-return>") 'newline)) ))

(use-package nov

  :mode ("\\.epub\\'" . nov-mode)
  :custom (nov-text-width most-positive-fixnum)
  :config
  (progn
    
    (defun du-nov-font-setup ()
      (face-remap-add-relative 'variable-pitch :family "Liberation Serif"
                               :height 1.1))
    
    (add-hook 'nov-mode-hook 'du-nov-font-setup) )) 

(use-package elfeed

  :bind ("<f10>" . elfeed)
  :config
  (progn
    
    (defun du-feed-font-setup ()
      (face-remap-add-relative 'variable-pitch :family "Liberation Serif"
                               :height 1.1))
    
    (add-hook 'elfeed-show-mode-hook 'du-feed-font-setup) ))

(use-package elfeed-org

  :after elfeed
  :custom (rmh-elfeed-org-files (list "~/.emacs.d/elfeed.org"))
  :config (elfeed-org))

(use-package elfeed-goodies

  :after elfeed
  :custom (elfeed-goodies/powerline-default-separator 'bar)
  :config
  (elfeed-goodies/setup))

(use-package chinese-word-at-point :defer t)

(use-package osx-dictionary

  :commands (osx-dictionary-search-word-at-point osx-dictionary-search-word-at-point) ; kbd in evil module
  :custom (osx-dictionary-use-chinese-text-segmentation t "Support Chinese word")
  :config
  (push "*osx-dictionary*" popwin:special-display-config) ;; Work with popwin-el (https://github.com/m2ym/popwin-el)
  )

(provide 'init-browse-reader)
