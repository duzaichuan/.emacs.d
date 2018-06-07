;; == LaTex / Org ==
(use-package tex
  :ensure auctex
  :mode ("\\.tex\\'" . TeX-latex-mode)
  :config
  (progn
    (setq TeX-auto-save t
	  TeX-parse-self t
	  font-latex-fontify-script nil
	  preview-image-type 'dvipng
	  reftex-plug-into-AUCTeX t
	  TeX-PDF-mode nil
	  reftex-plug-into-AUCTeX t)
    (setq-default TeX-master nil)
    (fset 'tex-font-lock-suscript 'ignore)
    (add-hook 'LaTeX-mode-hook 'visual-line-mode)
    (add-hook 'LaTeX-mode-hook 'flyspell-mode)
    (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
    (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
    (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
    (add-hook 'LaTeX-mode-hook 'turn-on-cdlatex)
    (add-hook 'LaTeX-mode-hook '(lambda () (setq compile-command "latexmk -pdf")))
    (add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)))

(use-package cdlatex
  :ensure t
  :commands (turn-on-cdlatex cdlatex-mode))

(use-package magic-latex-buffer
  :ensure t
  :hook LaTeX-mode)

(use-package org
  :ensure t
  :defer 0.1
  :mode ("\\.org\\'" . org-mode)
  :bind (("C-c l" . org-store-link)
         ("C-c a" . org-agenda)
	 ("C-c c" . org-capture)
         ("C-c b" . org-iswitchb)
         ("C-c C-w" . org-refile)
         ("C-c j" . org-clock-goto)
         ("C-c C-x C-o" . org-clock-out))
  :init (global-set-key (kbd "<f3>") (lambda () (interactive) (find-file "~/Dropbox/Org/captures.org")))
        (setq org-directory "~/Dropbox/Org"
	      org-default-notes-file (concat org-directory "/notes.org")
	      org-agenda-files (list "~/Dropbox/Org")
	      org-refile-targets (quote ((nil :maxlevel . 3)
					 (org-agenda-files :maxlevel . 3)))
	      org-capture-templates (quote (("t" "TODO" entry (file+datetree "~/Dropbox/Org/captures.org")
					     "* TODO %?")
					    ("a" "Appointment" entry (file+datetree "~/Dropbox/Org/captures.org")
					     "* %?")
					    ("n" "note" entry (file+headline "~/Dropbox/Org/captures.org" "IDEAS")
					     "* %?\nCaptured on %U\n  %i")
					    ("j" "Journal" entry (file+olp+datetree "~/Dropbox/journal.org")
					     "* %?\nEntered on %U\n  %i")))
	      org-tag-alist (quote (("BUDD"    . ?b)
				    ("PHIL"    . ?p)
				    ("ENGL"    . ?e)))
	      org-todo-keywords '((sequence "TODO(t)" "STARTED(s)" "WAITING(w)" "|" "DONE(d)" "CANCELED(c)")
				  (sequence "QUESTION(q)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)"))
	      org-log-done 'time
	      org-refile-use-outline-path 'file
	      org-outline-path-complete-in-steps nil
	      org-refile-allow-creating-parent-nodes 'confirm)
  :config
  (progn
    (setq org-image-actual-width (/ (display-pixel-width) 3)
	  org-latex-create-formula-image-program 'dvipng
	  org-pretty-entities t ; render UTF8 characters
	  org-confirm-babel-evaluate nil
	  org-src-fontify-natively t ; syntax highlight in org mode
	  org-highlight-latex-and-related '(latex) ; org-mode buffer latex syntax highlighting
	  org-footnote-auto-adjust t ; renumber footnotes when new ones are inserted
	  ;; set value of the variable org-latex-pdf-process
	  org-latex-pdf-process
	  '("pdflatex -interaction nonstopmode -output-directory %o %f"
	    "bibtex %b"
	    "pdflatex -interaction nonstopmode -output-directory %o %f"
	    "pdflatex -interaction nonstopmode -output-directory %o %f"))
    (plist-put org-format-latex-options :scale 1.70) ; bigger latex fragment
    (set-default 'truncate-lines nil) ; line wrap in org mode
    ;; Quickly insert blocks
    (add-to-list 'org-structure-template-alist '("s" "#+NAME: ?\n#+BEGIN_SRC \n\n#+END_SRC"))
    (add-hook 'org-babel-after-execute-hook 'org-display-inline-images) ; images auto-load
    (add-hook 'org-mode-hook (lambda () (linum-mode -1) (setq ispell-parser 'tex)))
    (add-hook 'org-mode-hook 'org-display-inline-images)
    (add-hook 'org-mode-hook 'turn-on-org-cdlatex)
    (add-hook 'org-mode-hook 'visual-line-mode)
    (add-hook 'org-mode-hook (lambda () (use-package helm-bibtex :ensure t
				     :config
				     ;; open pdf with system pdf viewer (works on mac)
				     (setq bibtex-completion-pdf-open-function
					   (lambda (fpath) (start-process "open" "*open*" "open" fpath))))))
    (add-hook 'org-mode-hook (lambda () (use-package org-download :ensure t
				     :config (add-hook 'dired-mode-hook 'org-download-enable))))
    (add-hook 'org-mode-hook (lambda () (use-package smartparens-org)))
    (add-hook 'org-mode-hook (lambda () (use-package smartparens-Tex-org :load-path "lib/")))
    (add-hook 'org-mode-hook (lambda () (use-package org-auto-formula :load-path "lib/"
				     :init (add-hook 'post-command-hook 'cw/org-auto-toggle-fragment-display))))
    ))

(use-package org-bullets
  :ensure t
  :hook (org-mode . org-bullets-mode))

(use-package org-ref
  :ensure t
  :bind (("C-c r" . org-ref-helm-insert-cite-link)
	 ("C-c i r" . org-ref-helm-insert-ref-link)
	 ("C-c i l" . org-ref-helm-insert-label-link))
  :init
  (setq reftex-default-bibliography '("~/Dropbox/bibliography/references.bib")
	org-ref-bibliography-notes "~/Dropbox/bibliography/notes.org"
	org-ref-default-bibliography '("~/Dropbox/bibliography/references.bib")
	org-ref-pdf-directory "~/Dropbox/bibliography/bibtex-pdfs/")
  :config
  (progn
   (require 'org-ref-citeproc)
   (setq org-ref-default-citation-link "citet"
	 org-ref-default-ref-type "eqref")
   (add-hook 'org-mode-hook
             (lambda () (define-key org-mode-map (kbd "C-c i r") 'org-ref-helm-insert-ref-link)))
   (add-hook 'org-mode-hook
             (lambda () (define-key org-mode-map (kbd "C-c i l") 'org-ref-helm-insert-label-link)))
   ))

;; a WYSiWYG HTML mail editor that can be useful for sending tables, fontified source code, and inline images in email. 
(use-package org-mime
  :ensure t
  :commands (org-mime-htmlize)
  :init (setq org-mime-up-subtree-heading 'org-back-to-heading
	      org-mime-export-options '(:section-numbers nil
							 :with-author nil
							 :with-toc nil
							 :with-latex dvipng)))

(use-package org-babel-eval-in-repl
  :ensure t
  :after ob
  :bind (:map org-mode-map
	      ("C-<return>" . ober-eval-in-repl)
	      ("M-<return>" . ober-eval-block-in-repl))
  )

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
  :diminish typo-mode
  :hook (text-mode . typo-mode))

(use-package ispell
  :commands ispell
  :config
  (progn
    (setq ispell-program-name (executable-find "hunspell")
	  ispell-choices-win-default-height 5
	  ispell-dictionary "en_US")
    (setenv "DICTIONARY" "en_US")
    (add-to-list 'ispell-skip-region-alist '(org-property-drawer-re))
    (add-to-list 'ispell-skip-region-alist '("#\\+BEGIN_SRC" . "#\\+END_SRC"))
    (add-to-list 'ispell-skip-region-alist '("#\\+BEGIN_EXPORT" . "#\\+END_EXPORT"))))

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

(use-package deft
  :ensure t
  :bind ("<f7>" . deft)
  :commands (deft)
  :config
  (progn
    (setq deft-directory         "~/Dropbox/Org"
	  deft-extensions        '("org")
	  deft-default-extension "org"
	  deft-text-mode         'org-mode)))

(provide 'du-writing)
