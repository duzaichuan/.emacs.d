(use-package eww
  :bind (("C-x m" . browse-url-at-point)
	 ("C-x ," . shr-copy-url)
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

(use-package pdf-view
  :ensure pdf-tools
  :mode ("\\.pdf\\'" . pdf-view-mode)
  :hook (pdf-view-mode . pdf-view-midnight-minor-mode)
  :init
  (setq pdf-annot-activate-created-annotations t) ; automatically annotate highlights
  (evil-set-initial-state 'pdf-view-mode 'emacs)
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
    (add-hook 'pdf-view-mode-hook
	      (lambda () (set (make-local-variable 'evil-emacs-state-cursor) (list nil))))
    (setq-default pdf-view-display-size 'fit-page) ; fit page by default
    (setq pdf-view-resize-factor 1.10)
    (setq pdf-view-midnight-colors `(,(face-attribute 'default :foreground) .
                                     ,(face-attribute 'default :background))) ))

(provide 'du-browser)
