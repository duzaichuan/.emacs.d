;; org mode
(require 'org)
(setq org-latex-create-formula-image-program 'dvisvgm)

(setq org-confirm-babel-evaluate nil)
;; bigger latex fragment
(plist-put org-format-latex-options :scale 1.70)
;; syntax highlight in org mode
(setq org-src-fontify-natively t)
;; line wrap in org mode
(set-default 'truncate-lines nil)

;; Quickly insert blocks
(add-to-list 'org-structure-template-alist '("s" "#+NAME: ?\n#+BEGIN_SRC \n\n#+END_SRC"))

;; bibliography
(require 'org-ref)
(setq reftex-default-bibliography '("~/Dropbox/bibliography/references.bib"))

;; see org-ref for use of these variables
(setq org-ref-bibliography-notes "~/Dropbox/bibliography/notes.org"
      org-ref-default-bibliography '("~/Dropbox/bibliography/references.bib")
      org-ref-pdf-directory "~/Dropbox/bibliography/bibtex-pdfs/")

;; open pdf with system pdf viewer (works on mac)
(setq bibtex-completion-pdf-open-function
  (lambda (fpath)
    (start-process "open" "*open*" "open" fpath)))

;; images auto-load
(add-hook 'org-babel-after-execute-hook 'org-display-inline-images)   
(add-hook 'org-mode-hook 'org-display-inline-images)
(add-hook 'post-command-hook 'cw/org-auto-toggle-fragment-display)

;; Add julia and ipython to babel languages (you need an entry for each 
;; language you want to submit code for)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((ipython . t)
   (julia . t)
   ))

;; Automatic latex image toggling when cursor is on a fragment
(defvar cw/org-last-fragment nil
  "Holds the type and position of last valid fragment we were on. Format: (FRAGMENT_TYPE FRAGMENT_POINT_BEGIN)"
  )

(setq cw/org-valid-fragment-type
      '(latex-fragment
        latex-environment
        link))

(defun cw/org-curr-fragment ()
  "Returns the type and position of the current fragment available for preview inside org-mode. Returns nil at non-displayable fragments"
  (let* ((fr (org-element-context))
         (fr-type (car fr)))
    (when (memq fr-type cw/org-valid-fragment-type)
      (list fr-type
            (org-element-property :begin fr))))
  )

(defun cw/org-remove-fragment-overlay (fr)
  "Remove fragment overlay at fr"
  (let ((fr-type (nth 0 fr))
        (fr-begin (nth 1 fr)))
    (goto-char fr-begin)
    (cond ((or (eq 'latex-fragment fr-type)
               (eq 'latex-environment fr-type))
           (let ((ov (loop for ov in (org--list-latex-overlays)
                           if
                           (and
                            (<= (overlay-start ov) (point))
                            (>= (overlay-end ov) (point)))
                           return ov)))
             (when ov
               (delete-overlay ov))))
          ((eq 'link fr-type)
           nil;; delete image overlay here?
           ))
    ))

(defun cw/org-preview-fragment (fr)
  "Preview org fragment at fr"
  (let ((fr-type (nth 0 fr))
        (fr-begin (nth 1 fr)))
    (goto-char fr-begin)
    (cond ((or (eq 'latex-fragment fr-type) ;; latex stuffs
               (eq 'latex-environment fr-type))
           (when (cw/org-curr-fragment) (org-preview-latex-fragment))) ;; only toggle preview when we're in a valid region (for inserting in the front of a fragment)


          ((eq 'link fr-type) ;; for images
           (let ((fr-end (org-element-property :end (org-element-context))))
             (org-display-inline-images nil t fr-begin fr-end))))
    ))

(defun cw/org-auto-toggle-fragment-display ()
  "Automatically toggle a displayable org mode fragment"
  (and (eq 'org-mode major-mode)
       (let ((curr (cw/org-curr-fragment)))
         (cond
          ;; were on a fragment and now on a new fragment
          ((and
            ;; fragment we were on
            cw/org-last-fragment
            ;; and are on a fragment now
            curr
            ;; but not on the last one this is a little tricky. as you edit the
            ;; fragment, it is not equal to the last one. We use the begin
            ;; property which is less likely to change for the comparison.
            (not (equal curr cw/org-last-fragment)))

           ;; go back to last one and put image back, provided there is still a fragment there
           (save-excursion
             (cw/org-preview-fragment cw/org-last-fragment)
             ;; now remove current image
             (cw/org-remove-fragment-overlay curr)
             ;; and save new fragment
             )
           (setq cw/org-last-fragment curr))

          ;; were on a fragment and now are not on a fragment
          ((and
            ;; not on a fragment now
            (not curr)
            ;; but we were on one
            cw/org-last-fragment)
           ;; put image back on, provided that there is still a fragment here.
           (save-excursion
             (cw/org-preview-fragment cw/org-last-fragment))

           ;; unset last fragment
           (setq cw/org-last-fragment nil))

          ;; were not on a fragment, and now are
          ((and
            ;; we were not one one
            (not cw/org-last-fragment)
            ;; but now we are
            curr)
           ;; remove image
           (save-excursion
             (cw/org-remove-fragment-overlay curr)
             )
           (setq cw/org-last-fragment curr))

          ))))

(provide 'init-org)
