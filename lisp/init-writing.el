;; == LaTex / Org ==
(use-package tex-site
  :ensure auctex
  :mode ("\\.tex\\'" . TeX-latex-mode)
  :config
  (progn
   (setq TeX-auto-save t)
   (setq TeX-parse-self t)
   (setq-default TeX-master nil)
   (add-hook 'LaTeX-mode-hook 'visual-line-mode)
   (add-hook 'LaTeX-mode-hook 'flyspell-mode)
   (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
   (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
   (fset 'tex-font-lock-suscript 'ignore)
   (setq font-latex-fontify-script nil)
   (setq preview-image-type 'dvipng)
   (setq reftex-plug-into-AUCTeX t)
   (setq TeX-PDF-mode nil)
   (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
   (add-hook 'LaTeX-mode-hook 'turn-on-cdlatex) 
   (setq reftex-plug-into-AUCTeX t)
   (add-hook 'LaTeX-mode-hook '(lambda () (setq compile-command "latexmk -pdf")))
   (add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)
   ))

(use-package cdlatex
  :ensure t
  :commands (turn-on-cdlatex cdlatex-mode))

(use-package magic-latex-buffer
  :ensure t
  :hook LaTeX-mode)

(use-package helm-bibtex
  :ensure t
  :after (:any (:all helm auctex) (:all helm org))
  :config
  ;; open pdf with system pdf viewer (works on mac)
  (setq bibtex-completion-pdf-open-function
	(lambda (fpath)
	  (start-process "open" "*open*" "open" fpath))))

(use-package org
  :ensure t
  :mode ("\\.org\\'" . org-mode)
  :bind (("C-c l" . org-store-link)
         ("C-c c" . org-capture)
         ("C-c a" . org-agenda)
         ("C-c b" . org-iswitchb)
         ("C-c C-w" . org-refile)
         ("C-c j" . org-clock-goto)
         ("C-c C-x C-o" . org-clock-out))
  :config
  (progn
    ;; remove linum in org mode
    (add-hook 'org-mode-hook (lambda () (linum-mode -1)))
    ;; images auto-load
    (add-hook 'org-babel-after-execute-hook 'org-display-inline-images)   
    (add-hook 'org-mode-hook 'org-display-inline-images)
    (setq org-image-actual-width (/ (display-pixel-width) 3))
    (setq org-latex-create-formula-image-program 'dvipng)
    (setq org-pretty-entities t) ;; render UTF8 characters
    (setq org-confirm-babel-evaluate nil)   
    ;; bigger latex fragment
    (plist-put org-format-latex-options :scale 1.70)
    ;; syntax highlight in org mode
    (setq org-src-fontify-natively t)
    ;; line wrap in org mode
    (set-default 'truncate-lines nil)
    ;; org-mode buffer latex syntax highlighting
    (setq org-highlight-latex-and-related '(latex))
    ;; renumber footnotes when new ones are inserted
    (setq org-footnote-auto-adjust t)
    (require 'smartparens-org)
    ;; Quickly insert blocks
    (add-to-list 'org-structure-template-alist '("s" "#+NAME: ?\n#+BEGIN_SRC \n\n#+END_SRC"))
    ;; set value of the variable org-latex-pdf-process
    (setq org-latex-pdf-process
	  '("pdflatex -interaction nonstopmode -output-directory %o %f"
	    "bibtex %b"
	    "pdflatex -interaction nonstopmode -output-directory %o %f"
	    "pdflatex -interaction nonstopmode -output-directory %o %f"))
    (add-hook 'post-command-hook 'cw/org-auto-toggle-fragment-display)
    (add-hook 'org-mode-hook 'turn-on-org-cdlatex) ;; speed-up insertion of environments
    ;; FlySpell in Org-Mode recognize latex syntax like auctex
    (add-hook 'org-mode-hook (lambda () (setq ispell-parser 'tex)))
    ;; return word at the end of lines
    (add-hook 'org-mode-hook 'visual-line-mode)
    ))

(use-package org-bullets
  :ensure t
  :commands (org-bullets-mode)
  :init (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package org-ref
  :ensure t
  :after org
  :init
  (setq reftex-default-bibliography '("~/Dropbox/bibliography/references.bib"))
  ;; see org-ref for use of these variables
  (setq org-ref-bibliography-notes "~/Dropbox/bibliography/notes.org"
      org-ref-default-bibliography '("~/Dropbox/bibliography/references.bib")
      org-ref-pdf-directory "~/Dropbox/bibliography/bibtex-pdfs/")
  :config
  (progn
   (require 'org-ref-citeproc)
   (setq org-ref-default-citation-link "citet")
   (setq org-ref-default-ref-type "eqref")
   ;; set value of the variable org-latex-pdf-process
   (add-hook 'org-mode-hook
             (lambda ()
               (define-key org-mode-map (kbd "C-c i r") 'org-ref-helm-insert-ref-link)))
   (add-hook 'org-mode-hook
             (lambda ()
               (define-key org-mode-map (kbd "C-c i l") 'org-ref-helm-insert-label-link)))
   ))

(use-package org-download
  :ensure t
  :after org
  :config (add-hook 'dired-mode-hook 'org-download-enable))

(use-package smartparens-Tex-org
    :after (:any Tex org)
    :load-path "lib/")

;; a WYSiWYG HTML mail editor that can be useful for sending tables, fontified source code, and inline images in email. 
(use-package org-mime
  :ensure t
  :after mu4e
  :init (setq org-mime-up-subtree-heading 'org-back-to-heading
	      org-mime-export-options '(:section-numbers nil
							 :with-author nil
							 :with-toc nil
							 :with-latex dvipng)))

(use-package org-auto-formula
  :after org
  :load-path "lib/")

(use-package yaml-mode
  :ensure t
  :mode "\\.yaml\\'")

(use-package markdown-mode
  :ensure t
  :mode (("\\`README\\.md\\'" . gfm-mode)
         ("\\.md\\'"          . markdown-mode)
         ("\\.markdown\\'"    . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package polymode
  :ensure t
  :mode (("\\.md" . poly-markdown-mode)
	 ("\\.Rmd" . poly-markdown+r-mode)))

(use-package writeroom-mode
  :ensure t
  :bind ("C-c w" . writeroom-mode))

(use-package typo
  :ensure t
  :demand t
  :hook (text-mode . typo-mode))

(use-package ispell
  :commands ispell
  :config
  (progn
    (setq
    ispell-program-name (executable-find "hunspell")
    ispell-choices-win-default-height 5
    ispell-dictionary "en_US")
    (setenv "DICTIONARY" "en_US")

    (add-to-list 'ispell-skip-region-alist '(org-property-drawer-re))
    (add-to-list 'ispell-skip-region-alist '("#\\+BEGIN_SRC" . "#\\+END_SRC"))
    (add-to-list 'ispell-skip-region-alist '("#\\+BEGIN_EXPORT" . "#\\+END_EXPORT")))
  )

(use-package flyspell
  :bind ([f6] . flyspell-buffer)
  :config
  (setq flyspell-issue-message-flag nil))

(use-package flyspell-correct-ivy
  :ensure t
  :after flyspell
  :bind (:map flyspell-mode-map
              ("C-c $" . flyspell-correct-word-generic)))

(use-package langtool
  :ensure t
  :commands langtool-check
  :config
  (setq langtool-default-language "en-US"
	langtool-language-tool-jar "/usr/local/Cellar/languagetool/4.1/libexec/languagetool-commandline.jar"))

(use-package pdf-view
  :ensure pdf-tools
  :commands pdf-tools-install
  :mode ("\\.pdf\\'" . pdf-view-mode)
  :bind
  (:map pdf-view-mode-map
	       ("j"  . pdf-view-next-page)
               ("k"  . pdf-view-previous-page))
  :config
  (progn
    ;; remove linum
    (add-hook 'pdf-view-mode-hook (lambda () (linum-mode -1)))
    (setq-default pdf-view-display-size 'fit-page) ; fit page by default
    (setq pdf-view-resize-factor 1.10)
    (use-package org-pdfview :ensure t)
    (setq pdf-view-midnight-colors `(,(face-attribute 'default :foreground) .
                                     ,(face-attribute 'default :background)))
    (add-hook 'pdf-view-mode-hook (lambda ()
                                    (pdf-view-midnight-minor-mode)))
    ))

(provide 'init-writing)
