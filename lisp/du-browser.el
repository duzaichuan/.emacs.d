(use-package eww
  :bind (("C-x m" . browse-url-at-point)
	 ("C-x ," . shr-copy-url)
	 ([f7] . eww))
  :init (setq browse-url-browser-function #'eww-browse-url)
  :config
  (add-hook 'eww-mode-hook (lambda () (linum-mode -1) (evil-emacs-state))))

(use-package w3m
  :ensure t
  :bind (([f3]      . w3m)
	 :map w3m-mode-map
	 ("n" . w3m-next-buffer)
	 ("p" . w3m-previous-buffer))
  :config
  (progn
    (add-hook 'w3m-mode-hook (lambda () (linum-mode -1)))
    (setq w3m-command "w3m"
	  w3m-home-page "about://bookmark/")
    (setq w3m-coding-system 'utf-8
          w3m-file-coding-system 'utf-8
          w3m-file-name-coding-system 'utf-8
          w3m-input-coding-system 'utf-8
          w3m-output-coding-system 'utf-8
          w3m-terminal-coding-system 'utf-8)
    (setq w3m-use-cookies t
	  w3m-view-this-url-new-session-in-background t
	  w3m-command-arguments '("-cookie" "-F")
	  browse-url-browser-function 'w3m-browse-url)
    (eval-when-compile
      (autoload 'w3m-search-escape-query-string "w3m-search"))
        ))

(use-package pdf-view
  :ensure pdf-tools
  :commands pdf-tools-install
  :mode ("\\.pdf\\'" . pdf-view-mode)
  :init (setq pdf-annot-activate-created-annotations t) ; automatically annotate highlights
  :bind
  (:map pdf-view-mode-map
	       ("d"  . pdf-view-next-page)
               ("u"  . pdf-view-previous-page)
	       ("j" .  pdf-view-scroll-up-or-next-page)
	       ("k" .  pdf-view-scroll-down-or-previous-page)
	       ("g"  . pdf-view-first-page)
               ("G"  . pdf-view-last-page)
	       ("e"  . pdf-view-goto-page)
               ("l"  . image-forward-hscroll)
               ("h"  . image-backward-hscroll)
	       ("C-s" . isearch-forward)
	       ("s"  . pdf-occur)
	       ("aa" . pdf-annot-attachment-dired)
	       ("al" . pdf-annot-list-annotations)
	       ("af" . pdf-annot-list-follow-minor-mode) ; shows the text of the current annot
               ("ad" . pdf-annot-delete)
               ("am" . pdf-annot-add-markup-annotation)
               ("at" . pdf-annot-add-text-annotation)
	       ("ah" . pdf-annot-add-highlight-markup-annotation)
	       ("au" . pdf-annot-add-underline-markup-annotation)
	       ("M" . pdf-view-midnight-minor-mode)
	       ;; Trim margins
	       ("b"  . pdf-view-set-slice-from-bounding-box)
	       ("r"  . pdf-view-reset-slice)
	       ("SPC" . image-next-line))
  :config
  (progn
    (pdf-tools-install)
    ;; remove linum and blink-cursor-mode
    (add-hook 'pdf-view-mode-hook (lambda () (linum-mode -1)))
    (evil-set-initial-state 'pdf-view-mode 'emacs)
    (add-hook 'pdf-view-mode-hook
	      (lambda () (set (make-local-variable 'evil-emacs-state-cursor) (list nil))))
    (setq-default pdf-view-display-size 'fit-page) ; fit page by default
    (setq pdf-view-resize-factor 1.10)
    (use-package org-pdfview :ensure t)
    (setq pdf-view-midnight-colors `(,(face-attribute 'default :foreground) .
                                     ,(face-attribute 'default :background)))
    ))

(provide 'du-browser)
