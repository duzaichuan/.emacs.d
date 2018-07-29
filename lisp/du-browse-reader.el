(defun eww-tag-pre (dom)
  (let ((shr-folding-mode 'none)
        (shr-current-font 'default))
    (shr-ensure-newline)
    (insert (eww-fontify-pre dom))
    (shr-ensure-newline)))

(defun eww-fontify-pre (dom)
  (with-temp-buffer
    (shr-generic dom)
    (let ((mode (eww-buffer-auto-detect-mode)))
      (when mode
        (eww-fontify-buffer mode)))
    (buffer-string)))

(defun eww-fontify-buffer (mode)
  (delay-mode-hooks (funcall mode))
  (font-lock-default-function mode)
  (font-lock-default-fontify-region (point-min)
                                    (point-max)
                                    nil))

(defun eww-buffer-auto-detect-mode ()
  (let* ((map '((ada ada-mode)
                (awk awk-mode)
                (c c-mode)
                (cpp c++-mode)
                (clojure clojure-mode lisp-mode)
                (csharp csharp-mode java-mode)
                (css css-mode)
                (dart dart-mode)
                (delphi delphi-mode)
                (emacslisp emacs-lisp-mode)
                (erlang erlang-mode)
                (fortran fortran-mode)
                (fsharp fsharp-mode)
                (go go-mode)
                (groovy groovy-mode)
                (haskell haskell-mode)
                (html html-mode)
                (java java-mode)
                (javascript javascript-mode)
                (json json-mode javascript-mode)
                (latex latex-mode)
                (lisp lisp-mode)
                (lua lua-mode)
                (matlab matlab-mode octave-mode)
                (objc objc-mode c-mode)
                (perl perl-mode)
                (php php-mode)
                (prolog prolog-mode)
                (python python-mode)
                (r r-mode)
                (ruby ruby-mode)
                (rust rust-mode)
                (scala scala-mode)
                (shell shell-script-mode)
                (smalltalk smalltalk-mode)
                (sql sql-mode)
                (swift swift-mode)
                (visualbasic visual-basic-mode)
                (xml sgml-mode)))
         (language (language-detection-string
                    (buffer-substring-no-properties (point-min) (point-max))))
         (modes (cdr (assoc language map)))
         (mode (cl-loop for mode in modes
                        when (fboundp mode)
                        return mode)))
    (message (format "%s" language))
    (when (fboundp mode)
      mode)))

(defun du/mpv-play (url)
  "play youtube and bilibili at the url point"
  (interactive (list (shr-url-at-point current-prefix-arg)))
  (cond ((string-match "youtube" url)
         (call-process "mpv" nil nil nil url))
        ((string-match "bilibili" url)
         (call-process "bili" nil nil nil url))))

(defalias 'du-urls-external-browser 'browse-url-default-browser)

(defun du-browse-url (&rest args)
  "Prompt for whether or not to browse with EWW, if no browse with external browser."
  (apply
   (if (y-or-n-p "Browse with EWW? ")
       'eww-browse-url
     #'du-urls-external-browser)
   args))

(use-package eww
  :bind (([f7] . eww)
	 :map eww-link-keymap
	 ("p" . du/mpv-play))
  :hook (eww-mode . visual-fill-column-mode)
  :init
  (progn
    (setq shr-external-rendering-functions '((pre . eww-tag-pre)))
    (setq browse-url-browser-function #'du-browse-url) ))

(use-package w3m
  :ensure t
  :bind (([f3] . w3m)
	 :map w3m-mode-map
	 ("n" . w3m-next-buffer)
	 ("p" . w3m-previous-buffer))
  :config
  (progn
    (setq w3m-command "w3m"
	  w3m-home-page "about://bookmark/")
    (setq w3m-coding-system 'utf-8
          w3m-file-coding-system 'utf-8
          w3m-file-name-coding-system 'utf-8
          w3m-input-coding-system 'utf-8
          w3m-output-coding-system 'utf-8
          w3m-terminal-coding-system 'utf-8)
    (setq w3m-use-cookies t
	  w3m-default-display-inline-images t
	  w3m-view-this-url-new-session-in-background t
	  w3m-command-arguments '("-cookie" "-F"))
    (eval-when-compile
      (autoload 'w3m-search-escape-query-string "w3m-search")) ))

(use-package elfeed
  :ensure t
  :bind ("C-x w" . elfeed)
  :hook (elfeed-show-mode . visual-fill-column-mode))

(use-package elfeed-org
  :ensure t
  :after elfeed
  :init (setq rmh-elfeed-org-files (list "~/.emacs.d/elfeed.org")))

(use-package pdf-tools
  :ensure t
  :magic ("%PDF" . pdf-view-mode)
  :hook (pdf-view-mode . savehist-mode)
  :init
  (setq pdf-annot-activate-created-annotations t) ; automatically annotate highlights
  :config
  (progn
    (pdf-tools-install)
    (add-hook 'pdf-view-mode-hook
	      (lambda () (set (make-local-variable 'evil-normal-state-cursor) (list nil))
		(set (make-local-variable 'evil-visual-state-cursor) (list nil))))
    (setq-default pdf-view-display-size 'fit-width) ; fit page by default
    (setq pdf-view-resize-factor 1.10)
    (setq pdf-view-midnight-colors `(,(face-attribute 'default :foreground) .
                                     ,(face-attribute 'default :background)))
    ;; default annot color
    (push '(color . "light green") pdf-annot-default-markup-annotation-properties)
    ;; wait until map is available
    (with-eval-after-load "pdf-annot"
      (define-key pdf-annot-edit-contents-minor-mode-map (kbd "<return>") 'pdf-annot-edit-contents-commit)
      (define-key pdf-annot-edit-contents-minor-mode-map (kbd "<S-return>") 'newline)) ))

(use-package nov
  :ensure t
  :mode ("\\.epub\\'" . nov-mode)
  :config
  (progn
    (setq nov-text-width 70)
    (defun du/nov-font-setup ()
      (face-remap-add-relative 'variable-pitch :family "Liberation Serif"
                               :height 1.1))
    (add-hook 'nov-mode-hook 'du/nov-font-setup) )) 

(use-package writeroom-mode
  :ensure t
  :commands writeroom-mode)

(use-package chinese-word-at-point
  :ensure t
  :defer t)

(use-package osx-dictionary
  :ensure t
  :commands (osx-dictionary-search-word-at-point osx-dictionary-search-word-at-point) ; kbd in evil module
  :config
  (progn
    ;; Support Chinese word
    (setq osx-dictionary-use-chinese-text-segmentation t)
    ;; Work with popwin-el (https://github.com/m2ym/popwin-el)
    (push "*osx-dictionary*" popwin:special-display-config) ))

(provide 'du-browse-reader)
