(use-package org-ref
  
  :bind (("C-c r" . org-ref-helm-insert-cite-link)
	 ("C-c ir" . org-ref-helm-insert-ref-link)
	 ("C-c il" . org-ref-helm-insert-label-link))

  :custom
  (org-ref-bibliography-notes "~/Dropbox/bibliography/Notes.org")
  (org-ref-default-bibliography '("~/Dropbox/bibliography/references.bib"))
  (org-ref-pdf-directory "~/Dropbox/bibliography/bibtex-pdfs/")
  (org-ref-show-broken-links nil)
  (org-ref-default-ref-type "eqref")
  (org-ref-default-citation-link "citet")
  (org-ref-ref-color "Brown")
  (org-ref-label-color "light green")

  :config
  (require 'org-ref-citeproc))

(use-package helm-bibtex
  
  :defer t

  :custom
  (bibtex-completion-bibliography "~/Dropbox/bibliography/references.bib")
  (bibtex-completion-library-path "~/Dropbox/bibliography/bibtex-pdfs")
  (bibtex-completion-notes-path "~/Dropbox/bibliography/Notes.org") )

(use-package org-noter
  
  :commands org-noter)

(use-package org-mind-map
  
  :commands org-mind-map-write)

(use-package demo-it
   :defer t)

(use-package org-tree-slide
  
  :commands org-tree-slide-mode

  :custom-face
  (org-tree-slide-header-overlay-face ((t (:foreground "#7F9F7F" :weight bold))))

  :config
  (progn

    (defun du-org-present-big ()
      "Make font size larger."
      (interactive)
      (text-scale-increase 0)
      (text-scale-increase 5)) ;MAKE THIS BUFFER-LOCAL

    (defun du-org-present-small ()
      "Change font size back to original."
      (interactive)
      (text-scale-increase 0))

    (add-hook 'org-tree-slide-play-hook
              (lambda ()
		(du-org-present-big)
		(org-display-inline-images)
		(writeroom--disable)
		(hide-mode-line-mode +1)))

    (add-hook 'org-tree-slide-stop-hook
              (lambda ()
		(du-org-present-small)
		(org-remove-inline-images)
		(writeroom--enable)))
    ))

(use-package org-wiki
  
  :defer t

  :straight (org-wiki :host github :repo "caiorss/org-wiki")

  :init (setq org-wiki-location "~/Dropbox/org/wiki/"))

(provide 'init-wiki-lib)
