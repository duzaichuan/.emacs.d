;; Spreadsheet
(use-package ses-mode

  :straight nil
  :mode ("\\.ses\\'" . ses-mode)
  :config
  (progn
    (defun du-ses-export-buffer-to-tsv nil
      "Export the current SES buffer to a TSV file.  The file name
    will be derived from the current buffer name."
      (interactive)
      (let* ((fname (or (buffer-file-name) "export"))
             (bcell (get-text-property (point-min) 'intangible))
             (ecell (get-text-property (- (point-max) 2) 'intangible))
             (ses--curcell (cons bcell ecell)))
	(setq fname
              (if (string-match "\\..*$" fname)
                  (replace-match ".tsv" nil nil fname)
		(concat fname ".tsv")))
	(ses-export-tab nil)
	(with-temp-file fname (insert (car kill-ring)))))

    (add-hook 'ses-mode-hook
	      (lambda () (add-hook 'after-save-hook 'du-ses-export-buffer-to-tsv t t))) ))

(provide 'init-data-manipulator)
