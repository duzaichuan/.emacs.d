(require 'package)
(require 'cl)
;;(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)

;;(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; This is only needed once, near the top of the file
(eval-when-compile
  (require 'use-package)
  (setq use-package-verbose t))
;;(require 'diminish)                ;; if you use :diminish
;;(require 'bind-key)                ;; if you use any :bind variant

(use-package exec-path-from-shell
  :if (memq window-system '(mac ns))
  :ensure t
  :config
  (exec-path-from-shell-initialize))

;; ensure system binaries exist alongside your package declarations.
(use-package use-package-ensure-system-package :ensure t)

(use-package auto-package-update
  :emsure t
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

;; you only need to specify :defer if you know for a fact that some other package will do something to cause your package to load at the appropriate time
(use-package ov        :ensure t        :defer t)
(use-package popwin    :ensure t        :defer t)
(use-package dash    :ensure t        :defer t)
(use-package popwin    :ensure t        :defer t)
(use-package f    :ensure t        :defer t)
(use-package s    :ensure t        :defer t)
(use-package parent-mode   :defer t)
(use-package hydra :ensure t   :defer t)
(use-package math-symbol-lists  :defer t)

(use-package key-chord
  :ensure t
  :commands key-chord-mode)

(use-package company
  :ensure t
  :defer t
  :config (global-company-mode))

(use-package paredit
  :ensure t
  :bind ("C-c d" . paredit-delete-region)
  :hook (emacs-lisp-mode eval-expression-minibuffer-setup ielm-mode lisp-mode lisp-interaction-mode clojure-mode racket-mode))

(use-package helm
  :ensure t
  :defer t
  :bind (:map helm-map
              ("<tab>" . helm-execute-persistent-action)
              ("C-i"   . helm-execute-persistent-action)
              ("C-z"   . helm-select-action)
              ("A-v"   . helm-previous-page))
  :config
  (helm-autoresize-mode 1))

(use-package ivy
  :ensure t
  :diminish
  :demand t
  :bind (("C-x b" . ivy-switch-buffer)
         ("C-x B" . ivy-switch-buffer-other-window)
         ("M-H"   . ivy-resume))
  :bind (:map ivy-switch-buffer-map
              ("C-k" . ivy-switch-buffer-kill))
  :custom
  (ivy-dynamic-exhibit-delay-ms 200)
  (ivy-height 10)
  (ivy-initial-inputs-alist nil t)
  (ivy-magic-tilde nil)
  (ivy-re-builders-alist '((t . ivy--regex-ignore-order)))
  (ivy-use-virtual-buffers t)
  (ivy-wrap t)
  :config
  (ivy-mode 1)
  (ivy-set-occur 'ivy-switch-buffer 'ivy-switch-buffer-occur))

(use-package swiper
  :after ivy
  :bind ("\C-s" . swiper)
  :config
  (defun haba/swiper-mc-fixed ()
    (interactive)
    (setq swiper--current-window-start nil)
    (swiper-mc)))

(use-package counsel
  :ensure
  :after ivy
  :demand t
  :diminish
  :custom (counsel-find-file-ignore-regexp
           (concat "\\(\\`\\.[^.]\\|"
                   (regexp-opt completion-ignored-extensions)
                   "\\'\\)"))
  :bind (("C-*"     . counsel-org-agenda-headlines)
         ("C-x C-f" . counsel-find-file)
         ("C-c e l" . counsel-find-library)
         ("C-c e q" . counsel-set-variable)
         ("C-h e l" . counsel-find-library)
         ("C-h e u" . counsel-unicode-char)
         ("C-h f"   . counsel-describe-function)
	 ("C-h v"   . counsel-describe-variable)
         ("C-x r b" . counsel-bookmark)
         ("M-x"     . counsel-M-x)
         ("M-s f" . counsel-file-jump)
         ("M-s g" . counsel-rg)
         ("M-s j" . counsel-dired-jump))
  :commands counsel-minibuffer-history
  :init
  (bind-key "M-r" #'counsel-minibuffer-history minibuffer-local-map)
  :config
  (add-to-list 'ivy-sort-matches-functions-alist
               '(counsel-find-file . ivy--sort-files-by-date)))

(use-package smartparens
  :ensure t
  :config
  (smartparens-global-mode t)
  ;; single "'" in emacs-lisp mode 
  (sp-local-pair '(emacs-lisp-mode lisp-interaction-mode) "'" nil :actions nil))

(use-package pdf-tools
  :ensure t
  :magic ("%PDF" . pdf-view-mode)
  :config
  (dolist
      (pkg
       '(pdf-annot pdf-cache pdf-dev pdf-history pdf-info pdf-isearch
                   pdf-links pdf-misc pdf-occur pdf-outline pdf-sync
                   pdf-util pdf-view pdf-virtual))
    (require pkg))
  (pdf-tools-install))

(use-package expand-region
  :ensure t
  :bind ("C-=" . er/expand-region))

(use-package typo
  :ensure t
  :hook text-mode)

(use-package yaml-mode
  :ensure t
  :mode "\\.yaml\\'")

(use-package recentf
  :ensure t
  :bind ("\C-x\ \C-r" . recentf-open-files)
  :hook (dired-mode . recentf-add-dired-directory)
  :config
  (recentf-mode 1)
  (setq recentf-max-menu-items 10))

(use-package imenu-anywhere
  :ensure t
  :bind ("C-." . imenu-anywhere))

(use-package dired
  :bind ("C-c j" . dired-two-pane)
  :bind (:map dired-mode-map
              ("j"     . dired)
              ("z"     . pop-window-configuration)
              ("e"     . ora-ediff-files)
              ("l"     . dired-up-directory)
              ("q"     . dired-up-directory)
              ("Y"     . ora-dired-rsync)
              ("M-!"   . async-shell-command)
              ("<tab>" . dired-next-window)
              ("M-G")
              ("M-s f"))
  :diminish dired-omit-mode
  :hook (dired-mode . dired-hide-details-mode)
  :config
  ;; delete and copy all files in a directory in dired-mode
  (setq dired-recursive-deletes 'always)
  (setq dired-recursive-copies 'always)
  ;; let dired-mode use only one buffer to open files
  (put 'dired-find-alternate-file 'disabled nil))

;; C-x C-j to open current directory from dired-mode
(use-package dired-x
  :after dired
  :config (setq dired-dwim-target t);; do what I mean in dired-mode
  )

;; Language support
(use-package ess-site
  :ensure t
  :mode ("\\.jl\\'" . ess-mode)
  :interpreter ("julia" . ess-mode))

(use-package matlab-mode
  :ensure t
  :mode "\\.m\\'"
  :interpreter "matlab"
  :config
  (setq matlab-shell-command "/Applications/MATLAB/MATLAB_R2017b.app/bin/matlab")
  (setq matlab-shell-command-switches (list "-nodesktop")))

(use-package dynare
  :load-path "/lisp"
  :mode "\\.mod\\'")

(use-package clojure-mode
  :ensure t
  :mode ("\\.clj\\'" "\\.cljs\\'" "\\.edn\\'" "\\.boot\\'")
  :interpreter "clojure")

(use-package cider
  :ensure t
  :hook clojure-mode)

(use-package polymode
  :ensure t
  :mode (("\\.md" . poly-markdown-mode)
	 ("\\.Rmd" . poly-markdown+r-mode)))

(use-package markdown-mode
  :ensure t
  :mode (("\\`README\\.md\\'" . gfm-mode)
         ("\\.md\\'"          . markdown-mode)
         ("\\.markdown\\'"    . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(provide 'init-packages)

;; better defaults
;; open init.el 
(global-set-key (kbd "<f2>") (lambda () (interactive) (find-file user-init-file)))

;; help menu
(global-set-key (kbd "C-h C-f") 'find-function)
(global-set-key (kbd "C-h C-v") 'find-variable)
(global-set-key (kbd "C-h C-k") 'find-function-on-key)

;; paren-mode
(show-paren-mode t)
;; disable audio bell
(setq ring-bell-function 'ignore)

(set-keyboard-coding-system nil)
(delete-selection-mode t)

;; eliminate backup and auto-save files in .emacs.d
(setq make-backup-files nil)
(setq auto-save-default nil)

;; return word at the end of lines
(global-visual-line-mode t)

;; change reminder "yes" to "y"
(fset 'yes-or-no-p 'y-or-n-p)

(setq tab-always-indent 'complete)

;; show paren highlight inside
(define-advice show-paren-function (:around (fn) fix-show-paren-function)
  "Highlight enclosing parens."
  (cond ((looking-at-p "\\s(") (funcall fn))
        (t (save-excursion
             (ignore-errors (backward-up-list))
             (funcall fn)))))

(provide 'init-better-defaults)

;; init-ui
;; appearance setting
(add-to-list 'default-frame-alist '(fullscreen . maximized))
;;(add-to-list 'default-frame-alist '(height . 40))
;;(add-to-list 'default-frame-alist '(width . 85))

;; font
(set-face-attribute 'default nil
		    :font "DejaVu Sans Mono")

(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-linum-mode 1)
(set-face-attribute 'default nil :height 170)
(setq inhibit-startup-screen t)
(setq-default cursor-type 'bar)
(global-hl-line-mode t)

(use-package tao-theme
  :ensure t
  :config
  (load-theme 'tao t))

(use-package  color-identifiers-mode
  :ensure
  :defer t
  :init (add-hook 'after-init-hook 'global-color-identifiers-mode))

(use-package neotree
  :ensure t
  :bind ([f8] . neotree-toggle)
  :config
  (setq neo-theme (if (display-graphic-p) 'icons 'none)))

(use-package all-the-icons
  :ensure t
  :config
  (all-the-icons-octicon "file-binary")  ;; GitHub Octicon for Binary File
  (all-the-icons-faicon  "cogs")         ;; FontAwesome icon for cogs
  (all-the-icons-wicon   "tornado"))

(use-package spaceline-all-the-icons
  :ensure t
  :config
  (spaceline-all-the-icons-theme)
  (setq spaceline-all-the-icons-icon-set-bookmark 'heart
        spaceline-all-the-icons-icon-set-modified 'toggle
        spaceline-all-the-icons-icon-set-dedicated 'pin
        spaceline-all-the-icons-separator-type 'none
        spaceline-all-the-icons-icon-set-flycheck-slim 'dots
        spaceline-all-the-icons-flycheck-alternate t
        spaceline-all-the-icons-highlight-file-name t
        spaceline-all-the-icons-hide-long-buffer-path t)
  (spaceline-toggle-all-the-icons-bookmark-on)
  (spaceline-toggle-all-the-icons-dedicated-on)
  (spaceline-toggle-all-the-icons-fullscreen-on)
  (spaceline-toggle-all-the-icons-buffer-position-on)
  (spaceline-all-the-icons--setup-package-updates)
  (spaceline-all-the-icons--setup-paradox)
  (spaceline-all-the-icons--setup-neotree))

(provide init-ui)

;; Auctex and Org
(use-package auctex
  :mode ("\\.tex\\'" . TeX-latex-mode)
  :config
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq-default TeX-master nil)
  (add-hook 'LaTeX-mode-hook 'visual-line-mode)
  (add-hook 'LaTeX-mode-hook 'flyspell-mode)
  (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
  (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
  (setq reftex-plug-into-AUCTeX t)
  (setq TeX-PDF-mode nil)
  (setq preview-image-type 'dvipng)
  (add-hook 'LaTeX-mode-hook '(lambda () (setq        compile-command "latexmk -pdf")))
  (add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer))

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
  :mode "\\.org\\'"
  :bind (("C-c l" . org-store-link)
         ("C-c a" . org-agenda)
         ("C-c c" . org-capture)
         ("C-c b" . org-iswitchb))
  :config
   ;; remove linum in org mode
  (defun nolinum ()
    (linum-mode 0))
  (add-hook 'org-mode-hook 'nolinum)
  
  (setq org-latex-create-formula-image-program 'dvisvgm)
  (setq org-confirm-babel-evaluate nil)
  ;; bigger latex fragment
  (plist-put org-format-latex-options :scale 1.70)
  ;; syntax highlight in org mode
  (setq org-src-fontify-natively t)
  ;; line wrap in org mode
  (set-default 'truncate-lines nil)
  ;; org-mode buffer latex syntax highlighting
  (setq org-highlight-latex-and-related '(latex))
  (setq org-footnote-auto-adjust t)
  ;; Quickly insert blocks
  (add-to-list 'org-structure-template-alist '("s" "#+NAME: ?\n#+BEGIN_SRC \n\n#+END_SRC"))

  ;; set value of the variable org-latex-pdf-process
  (setq org-latex-pdf-process
      '("pdflatex -interaction nonstopmode -output-directory %o %f"
	"bibtex %b"
	"pdflatex -interaction nonstopmode -output-directory %o %f"
	"pdflatex -interaction nonstopmode -output-directory %o %f"))
  
  (require 'smartparens-org)

  ;; language you want to submit code for)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((ipython . t)
     (julia . t)))

  ;; images auto-load
  (add-hook 'org-babel-after-execute-hook 'org-display-inline-images)   
  (add-hook 'org-mode-hook 'org-display-inline-images)
  (add-hook 'post-command-hook 'cw/org-auto-toggle-fragment-display))

(use-package org-bullets
  :ensure t
  :hook (org-mode . org-bullets-mode))

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
(use-package org-auto-formula
  :after org
  :load-path "lisp/")

(use-package smartparens-Tex-org
  :after (:any Tex org)
  :load-path "lisp/")


;;Mail
(use-package mu4e
  :ensure-system-package (mu4e . mu)
  :commands (mu4e)
  :bind (("<f9>" . mu4e))
  :defer 15
  :config
  (setq
  mu4e-get-mail-command "offlineimap"   ;; or fetchmail, or ...
  mu4e-update-interval 300)             ;; update every 5 minutes
  
  (setq mu4e-contexts
    `( ,(make-mu4e-context
     :name "Outlook"
     :match-func (lambda (msg) (when msg
       (string-prefix-p "/Outlook" (mu4e-message-field msg :maildir))))
     :vars '(
       (mu4e-trash-folder . "/Outlook/[Outlook].Trash")
       (mu4e-refile-folder . "/Outlook/[Outlook].Archive")
       ))
   ,(make-mu4e-context
     :name "Exchange"
     :match-func (lambda (msg) (when msg
       (string-prefix-p "/Exchange" (mu4e-message-field msg :maildir))))
     :vars '(
       (mu4e-trash-folder . "/Exchange/Deleted Items")
       (mu4e-refile-folder . exchange-mu4e-refile-folder)
       ))
   ))
  
  (defun exchange-mu4e-refile-folder (msg)
  "Function for chosing the refile folder for my Exchange email.
   MSG is a message p-list from mu4e."
  (cond
   ;; FLA messages
   ((string-match "\\[some-mailing-list\\]"
          (mu4e-message-field msg :subject))
    "/Exchange/mailing-list")
   (t "/Exchange/Archive")
   )
  )
  ;; USING MU4E TO SEND MAIL
(setq mu4e-sent-folder "/sent"
      ;; mu4e-sent-messages-behavior 'delete ;; Unsure how this should be configured
      mu4e-drafts-folder "/drafts"
      user-mail-address "duzaichuan@hotmail.com"
      smtpmail-default-smtp-server "smtp.live.com"
      smtpmail-smtp-server "smtp.live.com"
      smtpmail-smtp-service 25
      user-full-name  "Zaichuan Du"
      mu4e-compose-signature
      (concat
       "Best\n"
       "Zaichuan Du\n"))

(defvar my-mu4e-account-alist
  '(("Outlook"
     (mu4e-sent-folder "/Outlook/sent")
     (user-mail-address "duzaichuan@hotmail.com")
     (smtpmail-default-smtp-server "smtp.live.com")
     (smtpmail-smtp-server "smtp.live.com")
     (smtpmail-smtp-service 25)
     (user-full-name  "Zaichuan Du")
     (mu4e-compose-signature
       (concat
	"Best\n"
	"Zaichuan Du\n")))
    ("Exchange"
     (mu4e-sent-folder "/Exchange/sent")
     (user-mail-address "cjq192@alumni.ku.dk")
     (smtpmail-default-smtp-server "exchange.ku.dk")
     (smtpmail-smtp-server "exchange.ku.dk")
     (smtpmail-smtp-service 465)
     (user-full-name  "Zaichuan Du")
     (mu4e-compose-signature
       (concat
	"Best\n"
	"Zaichuan Du\n")))
    ))
(defun my-mu4e-set-account ()
  "Set the account for composing a message.
   This function is taken from: 
     https://www.djcbsoftware.nl/code/mu/mu4e/Multiple-accounts.html"
  (let* ((account
    (if mu4e-compose-parent-message
        (let ((maildir (mu4e-message-field mu4e-compose-parent-message :maildir)))
    (string-match "/\\(.*?\\)/" maildir)
    (match-string 1 maildir))
      (completing-read (format "Compose with account: (%s) "
             (mapconcat #'(lambda (var) (car var))
            my-mu4e-account-alist "/"))
           (mapcar #'(lambda (var) (car var)) my-mu4e-account-alist)
           nil t nil nil (caar my-mu4e-account-alist))))
   (account-vars (cdr (assoc account my-mu4e-account-alist))))
    (if account-vars
  (mapc #'(lambda (var)
      (set (car var) (cadr var)))
        account-vars)
      (error "No email account found"))))
(add-hook 'mu4e-compose-pre-hook 'my-mu4e-set-account)

;; PITFALLS AND ADDITIONAL TWEAKS
(defun remove-nth-element (nth list)
  (if (zerop nth) (cdr list)
    (let ((last (nthcdr (1- nth) list)))
      (setcdr last (cddr last))
      list)))
(setq mu4e-marks (remove-nth-element 5 mu4e-marks))
(add-to-list 'mu4e-marks
     '(trash
       :char ("d" . "▼")
       :prompt "dtrash"
       :dyn-target (lambda (target msg) (mu4e-get-trash-folder msg))
       :action (lambda (docid msg target) 
                 (mu4e~proc-move docid
				 (mu4e~mark-check-target target) "-N"))))

;; Include a bookmark to open all of my inboxes
(add-to-list 'mu4e-bookmarks
       (make-mu4e-bookmark
        :name "All Inboxes"
        :query "maildir:/Exchange/INBOX OR maildir:/Outlook/INBOX"
        :key ?i))

;; This allows me to use 'helm' to select mailboxes
(setq mu4e-completing-read-function 'completing-read)
;; Why would I want to leave my message open after I've sent it?
(setq message-kill-buffer-on-exit t)
;; Don't ask for a 'context' upon opening mu4e
(setq mu4e-context-policy 'pick-first)
;; Don't ask to quit... why is this the default?
(setq mu4e-confirm-quit nil)

;; setup some handy shortcuts
(setq mu4e-maildir-shortcuts
    '( ("/Exchange/INBOX"               . ?I)
       ("/Exchange/sent"   . ?S)
       ("/Outlook/Inbox"       . ?i)
       ("/Outlook/sent"    . ?s)))
)

;; Alerts for new mails
(use-package mu4e-alert
  :ensure t
  :after mu4e
  :config
  (setq mu4e-alert-interesting-mail-query
    (concat
     "flag:unread maildir:/Exchange/INBOX "
     "OR "
     "flag:unread maildir:/Outlook/INBOX"
     ))
  (mu4e-alert-enable-mode-line-display)
  (defun gjstein-refresh-mu4e-alert-mode-line ()
    (interactive)
    (mu4e~proc-kill)
    (mu4e-alert-enable-mode-line-display)
    )
  (run-with-timer 0 60 'gjstein-refresh-mu4e-alert-mode-line)
  )

(provide 'init-mail)

