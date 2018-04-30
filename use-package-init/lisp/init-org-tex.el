;; Auctex and Org
;; == LaTex / AucTeX ==
(use-package tex
  :defer t
  :ensure auctex
  :config
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq-default TeX-master nil)
  (add-hook 'LaTeX-mode-hook 'visual-line-mode)
  (add-hook 'LaTeX-mode-hook 'flyspell-mode)
  (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
  (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
  (fset 'tex-font-lock-suscript 'ignore)
  (setq font-latex-fontify-script nil)
  (setq reftex-plug-into-AUCTeX t)
  (setq TeX-PDF-mode nil)
  (setq reftex-bibliography-commands '("bibliography" "nobibliography" "addbibresource")
  (setq preview-image-type 'dvipng)
  (add-hook 'LaTeX-mode-hook '(lambda () (setq        compile-command "latexmk -pdf")))
  (add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer))

  (general-define-key
   :keymaps 'LaTeX-mode-map
   :prefix (concat gjs-leader-key "c")
   :states '(normal visual)
   "c" 'TeX-command-master
   "v" 'TeX-view
   "e" 'LaTeX-environment
   "s" 'LaTeX-section
   "m" 'TeX-insert-macro
   "=" 'reftex-toc
   )
  
  ;; Don't use Helm for the reftex-citation lookup
  (eval-after-load 'helm-mode
    '(add-to-list 'helm-completing-read-handlers-alist '(reftex-citation . nil))
    )
  
  )

(use-package magic-latex-buffer
  :ensure t
  :after auctex)

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
    ;; The GTD part of this config is heavily inspired by
    ;; https://emacs.cafe/emacs/orgmode/gtd/2017/06/30/orgmode-gtd.html
    (setq org-directory "~/org")
    (setq org-agenda-files
          (mapcar (lambda (path) (concat org-directory path))
                  '("/org.org"
                    "/gtd/gtd.org"
                    "/gtd/inbox.org"
                    "/gtd/tickler.org")))
    (setq org-log-done 'time)
    (setq org-src-fontify-natively t)
    (setq org-use-speed-commands t)
    (setq org-capture-templates
          '(("t" "Todo [inbox]" entry
             (file+headline "~/org/gtd/inbox.org" "Tasks")
             "* TODO %i%?")
            ("T" "Tickler" entry
             (file+headline "~/org/gtd/tickler.org" "Tickler")
             "* %i%? \n %^t")))
    (setq org-refile-targets
          '(("~/org/gtd/gtd.org" :maxlevel . 3)
            ("~/org/gtd/someday.org" :level . 1)
            ("~/org/gtd/tickler.org" :maxlevel . 2)))
    (setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))
    (setq org-agenda-custom-commands
          '(("@" "Contexts"
             ((tags-todo "@email"
                         ((org-agenda-overriding-header "Emails")))
              (tags-todo "@phone"
                         ((org-agenda-overriding-header "Phone")))))))
    (setq org-clock-persist t)
    (org-clock-persistence-insinuate)
    (setq org-time-clocksum-format '(:hours "%d" :require-hours t :minutes ":%02d" :require-minutes t))))

(use-package org-inlinetask
  :bind (:map org-mode-map
              ("C-c C-x t" . org-inlinetask-insert-task))
  :after (org)
  :commands (org-inlinetask-insert-task))

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
  (require 'org-ref-citeproc)
  (setq org-ref-default-citation-link "citet")
  ;; set value of the variable org-latex-pdf-process
  (setq org-latex-pdf-process
      '("pdflatex -interaction nonstopmode -output-directory %o %f"
	"bibtex %b"
	"pdflatex -interaction nonstopmode -output-directory %o %f"
	"pdflatex -interaction nonstopmode -output-directory %o %f")))


(use-package org-mime
  :ensure t
  :after org
  :config
  (setq org-mime-library 'mml)
  (setq org-mime-export-options '(:section-numbers nil
                                :with-author nil
                                :with-toc nil)))

;; private-package
;(use-package org-auto-formula
;  :after org
;  :load-path "lisp/")

;(use-package smartparens-Tex-org
;  :after (:any Tex org)
;  :load-path "lisp/")

;(use-package ob-julia
;  :after org
;  :load-path "lisp/")

(provide 'init-org-tex)
