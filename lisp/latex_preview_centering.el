;; specify the justification you want: CENTERING
(plist-put org-format-latex-options :justify 'center)

(defun org-justify-fragment-overlay (beg end image imagetype)
  "Adjust the justification of a LaTeX fragment.
The justification is set by :justify in
`org-format-latex-options'. Only equations at the beginning of a
line are justified."
  (cond
   ;; Centered justification
   ((and (eq 'center (plist-get org-format-latex-options :justify)) 
	 (= beg (line-beginning-position)))
    (let* ((img (create-image image 'imagemagick t))
	   (width (car (image-size img)))
	   (offset (floor (- (/ (window-max-chars-per-line) 2) (/ width 2)))))
      (overlay-put (ov-at) 'before-string (make-string offset ? ))))
   ;; Right justification
   ((and (eq 'right (plist-get org-format-latex-options :justify)) 
	 (= beg (line-beginning-position)))
    (let* ((img (create-image image 'imagemagick t))
	   (width (car (image-display-size (overlay-get (ov-at) 'display))))
	   (offset (floor (- (window-max-chars-per-line) width (- (line-end-position) end)))))
      (overlay-put (ov-at) 'before-string (make-string offset ? ))))))

(defun org-latex-fragment-tooltip (beg end image imagetype)
  "Add the fragment tooltip to the overlay and set click function to toggle it."
  (overlay-put (ov-at) 'help-echo
	       (concat (buffer-substring beg end)
		       "mouse-1 to toggle."))
  (overlay-put (ov-at) 'local-map (let ((map (make-sparse-keymap)))
				    (define-key map [mouse-1]
				      `(lambda ()
					 (interactive)
					 (org-remove-latex-fragment-image-overlays ,beg ,end)))
				    map)))

;; advise the function to a
(advice-add 'org--format-latex-make-overlay :after 'org-justify-fragment-overlay)
(advice-add 'org--format-latex-make-overlay :after 'org-latex-fragment-tooltip)
