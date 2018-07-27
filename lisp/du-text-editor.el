(use-package persistent-scratch
  :ensure t
  :defer 0.4
  :config
  (persistent-scratch-setup-default))

(use-package tex
  :ensure auctex
  :mode ("\\.tex\\'" . TeX-latex-mode)
  :config
  (progn
    (setq TeX-auto-save t
	  TeX-parse-self t
	  font-latex-fontify-script nil
	  preview-image-type 'imagemagick
	  reftex-plug-into-AUCTeX t
	  TeX-PDF-mode nil
	  reftex-plug-into-AUCTeX t
	  LaTeX-electric-left-right-brace t)
    (fset 'tex-font-lock-suscript 'ignore)
    (setq-default TeX-master nil)
    (use-package smartparens-latex :ensure smartparens)
    (add-hook 'LaTeX-mode-hook 'flyspell-mode)
    (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
    (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
    (add-hook 'LaTeX-mode-hook 'turn-on-cdlatex)
    (add-hook 'LaTeX-mode-hook '(lambda () (setq compile-command "latexmk -pdf")))
    (add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer) ))

(use-package magic-latex-buffer
  :ensure t
  :hook LaTeX-mode)

(use-package cdlatex
  :ensure t
  :commands (turn-on-cdlatex cdlatex-mode))

(use-package org
  :ensure t
  :defer 0.2
  :mode ("\\.org\\'" . org-mode)
  :hook (org-mode . turn-on-org-cdlatex)
  :bind (("C-c l" . org-store-link)
         ("C-c a" . org-agenda)
	 ("C-c c" . org-capture)
         ("C-c b" . org-iswitchb)
         ("C-c C-w" . org-refile)
         ("C-c j" . org-clock-goto)
         ("C-c C-x C-o" . org-clock-out))
  :init (global-set-key (kbd "<f4>") (lambda () (interactive) (find-file "~/Dropbox/Org/captures.org")))
        (setq org-directory "~/Dropbox/Org"
	      org-default-notes-file (concat org-directory "/notes.org")
	      org-agenda-files (list "~/Dropbox/Org")
	      org-refile-targets '((org-agenda-files :maxlevel . 3))
	      org-capture-templates (quote (("t" "TODO" entry (file+olp+datetree "~/Dropbox/Org/captures.org")
					     "* TODO %?")
					    ("m" "Mail-to-do" entry (file+headline "~/Dropbox/Org/captures.org" "Tasks")
					     "* TODO [#A] %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n%a\n")
					    ("a" "Appointment" entry (file+olp+datetree "~/Dropbox/Org/captures.org")
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
    (setq org-preview-latex-default-process 'imagemagick
	  org-image-actual-width (/ (display-pixel-width) 2)
	 ; org-pretty-entities t ; render UTF8 characters
	  org-confirm-babel-evaluate nil
	  org-src-fontify-natively t ; syntax highlight in org mode
	  org-highlight-latex-and-related '(latex) ; org-mode buffer latex syntax highlighting
	  org-footnote-auto-adjust t ; renumber footnotes when new ones are inserted
	  org-export-with-smart-quotes t ; export pretty double quotation marks
	  ;; set value of the variable org-latex-pdf-process
	  org-latex-pdf-process
	  '("pdflatex -interaction nonstopmode -output-directory %o %f"
	    "bibtex %b"
	    "pdflatex -interaction nonstopmode -output-directory %o %f"
	    "pdflatex -interaction nonstopmode -output-directory %o %f")
	  ispell-parser 'tex)
    (plist-put org-format-latex-options :scale 1.70) ; bigger latex fragment
    (set-default 'truncate-lines nil) ; line wrap in org mode
    ;; Quickly insert blocks
    (add-to-list 'org-structure-template-alist '("s" "#+NAME: ?\n#+BEGIN_SRC \n\n#+END_SRC"))
    (add-hook 'org-babel-after-execute-hook 'org-display-inline-images) ; images auto-load
    (add-hook 'org-mode-hook 'org-display-inline-images)
    (use-package smartparens-org)
    (use-package smartparens-Tex-org :load-path "lib/") ))

(use-package org-auto-formula
  :load-path "lib/"
  :after org
  :config
  (add-hook 'post-command-hook 'cw/org-auto-toggle-fragment-display))

(use-package org-download
  :ensure t
  :hook ((org-mode dired-mode) . org-download-enable))

(use-package org-bullets
  :ensure t
  :hook (org-mode . org-bullets-mode)
  :config
  (setq org-bullets-bullet-list '("◉" "○" "●" "◆" "♦")))

(use-package org-ref
  :ensure t
  :bind (("C-c r" . org-ref-helm-insert-cite-link)
	 ("C-c ir" . org-ref-helm-insert-ref-link)
	 ("C-c il" . org-ref-helm-insert-label-link))
  :init
  (setq org-ref-bibliography-notes "~/Dropbox/bibliography/Notes.org"
	org-ref-default-bibliography '("~/Dropbox/bibliography/references.bib")
	org-ref-pdf-directory "~/Dropbox/bibliography/bibtex-pdfs/")
  :config
  (require 'org-ref-citeproc)
  (setq org-ref-default-citation-link "citet"
	org-ref-default-ref-type "eqref"))

(use-package helm-bibtex
  :ensure t
  :defer t
  :init
  (setq bibtex-completion-bibliography "~/Dropbox/bibliography/references.bib" 
	bibtex-completion-library-path "~/Dropbox/bibliography/bibtex-pdfs"
	bibtex-completion-notes-path "~/Dropbox/bibliography/Notes.org"))

;; a WYSiWYG HTML mail editor that can be useful for sending tables, fontified source code, and inline images in email. 
(use-package org-mime
  :ensure t
  :commands (org-mime-htmlize)
  :init (setq org-mime-up-subtree-heading 'org-back-to-heading
	      org-mime-export-options '(:section-numbers nil
							 :with-author nil
							 :with-toc nil
							 :with-latex imagemagick)))

(use-package org-noter
  :ensure t
  :commands org-noter)

(use-package org-babel-eval-in-repl
  :ensure t
  :after ob
  :bind (:map org-mode-map
	      ("C-<return>" . ober-eval-in-repl)
	      ("M-<return>" . ober-eval-block-in-repl)))

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
    (add-to-list 'ispell-skip-region-alist '("#\\+BEGIN_EXPORT" . "#\\+END_EXPORT")) ))

(use-package flyspell
  :commands flyspell-buffers
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

(use-package pyim
  :ensure t
  :bind (("M-p" . pyim-convert-code-at-point)
	 ("M-f" . pyim-forward-word)
	 ("M-b" . pyim-backward-word))
  :init
  (progn
    (setq default-input-method "pyim"
	  pyim-default-scheme 'quanpin
	  pyim-page-tooltip 'posframe
	  pyim-page-length 5)

    (setq pyim-dicts
	  '((:name "default" :file "~/pyim-dicts/pyim-bigdict.pyim")
            (:name "eng abbriv" :file "~/pyim-dicts/eng-abbrev.pyim")))
    
    (setq-default pyim-english-input-switch-functions
                '(pyim-probe-dynamic-english
                  ;pyim-probe-isearch-mode
                  pyim-probe-program-mode
                  pyim-probe-org-structure-template))

    (setq-default pyim-punctuation-half-width-functions
                '(pyim-probe-punctuation-line-beginning
                  pyim-probe-punctuation-after-punctuation)) )
  :config
  (progn
    ;(pyim-isearch-mode 1)
    ;; 激活 basedict 拼音词库
    (use-package pyim-basedict
      :config (pyim-basedict-enable)) ))

(use-package academic-phrases
  :ensure t
  :commands (academic-phrases academic-phrases-by-section))

(provide 'du-text-editor)
