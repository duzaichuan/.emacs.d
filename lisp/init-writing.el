;; == LaTex / AucTeX ==
(use-package tex-site
  :ensure auctex
  :after tex
  :after latex
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
   (setq reftex-plug-into-AUCTeX t)
   (add-hook 'LaTeX-mode-hook '(lambda () (setq compile-command "latexmk -pdf")))
   (add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)
   ))

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
    (defun nolinum ()
      (linum-mode 0))
    (add-hook 'org-mode-hook 'nolinum)

    ;; images auto-load
    (add-hook 'org-babel-after-execute-hook 'org-display-inline-images)   
    (add-hook 'org-mode-hook 'org-display-inline-images)
    (setq org-latex-create-formula-image-program 'dvipng)

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
    ;; open pdf with system pdf viewer (works on mac)
    (setq bibtex-completion-pdf-open-function
	  (lambda (fpath)
	    (start-process "open" "*open*" "open" fpath)))

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

(use-package org-mime
  :ensure t
  :after org
  :config
  (progn
   (setq org-mime-library 'mml)
   (setq org-mime-export-options '(:section-numbers nil
						    :with-author nil
						    :with-toc nil))
   ))

(use-package smartparens-Tex-org
    :after (:any Tex org)
    :load-path "lib/")

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

(use-package writeroom-mode
  :ensure t
  :bind ("C-c w" . writeroom-mode))

(use-package typo
  :ensure t
  :demand t
  :hook (text-mode . typo-mode))

(provide 'init-writing)
