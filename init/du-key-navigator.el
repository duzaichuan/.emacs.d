;; open init.el 
(global-set-key (kbd "<f2>") (lambda () (interactive) (find-file user-init-file)))

;; org capture
(global-set-key (kbd "<f4>") (lambda () (interactive) (find-file "~/Dropbox/Org/captures.org")))

;; help menu
(global-set-key (kbd "C-h C-f") 'find-function)
(global-set-key (kbd "C-h C-v") 'find-variable)
(global-set-key (kbd "C-h C-k") 'find-function-on-key)

;; grow shrink windows
(global-set-key (kbd "M-[") 'shrink-window-horizontally)
(global-set-key (kbd "M-]") 'enlarge-window-horizontally)

(use-package key-chord
  :ensure t
  :commands key-chord-mode)

(use-package which-key
      :ensure t
      :diminish which-key-mode
      :config
      (progn
	(which-key-mode)
	(which-key-setup-side-window-right-bottom)))

(use-package avy
  :ensure t
  :bind ("C-;" . avy-goto-char)
  :commands (avy-goto-char avy-goto-char-2 avy-goto-line))

(use-package evil
  :ensure t
  :diminish evil-mode
  :init
  (progn
    (setq evil-want-integration nil) 
    (use-package evil-leader
      :ensure t
      :init (global-evil-leader-mode)
      :config
      (progn
    	(evil-leader/set-leader "SPC")
    	(evil-leader/set-key "gs" 'magit-status)
    	(evil-leader/set-key "gu" 'browse-url-at-point)	
    	;; window edit
    	(evil-leader/set-key
    	  "wd" 'delete-window
    	  "wo" 'delete-other-windows
    	  "wh" 'split-window-horizontally
    	  "wv" 'split-window-vertically
    	  "ww" 'other-window)
    	;; buffer switch
    	(evil-leader/set-key
    	  "bb" 'ivy-switch-buffer
    	  "bq" 'kill-buffer
    	  "bj" 'next-buffer
    	  "bk" 'previous-buffer)
    	;; file navigate and formatting region
    	(evil-leader/set-key
    	  "ff" 'counsel-find-file
    	  "fr" 'recentf-open-files
    	  "fc" 'evilnc-comment-or-uncomment-lines
    	  "fi" 'indent-region)
    	;; org
    	(evil-leader/set-key
    	  "oa" 'org-agenda
    	  "oc" 'org-capture
    	  "ob" 'org-iswitchb
    	  "or" 'org-refile
    	  "ol" 'org-store-link
    	  "oe" 'org-export-dispatch
    	  "of" 'writeroom-mode
    	  "of" 'org-footnote-action
    	  "ot" 'org-time-stamp
    	  "on" 'org-noter
    	  "oi" 'org-noter-insert-note
    	  "os" 'ispell-buffer
	  "ow" 'org-wc-display
	  "od" 'org-wc-remove-overlays)
    	;; dictionary
    	(evil-leader/set-key
    	  "dd" 'osx-dictionary-search-word-at-point
    	  "di" 'osx-dictionary-search-input)
    	;; Media
    	(evil-leader/set-key
    	  "mb" 'bongo-playlist
    	  "me" 'emms
    	  "mt" 'twit
    	  "mm" 'simple-mpc
    	  "mc" 'circe
    	  "mr" 'md4rd)
    	;; emms media
    	(evil-leader/set-key
    	  "ec" 'mpd/start-music-daemon
    	  "ee" 'mpd/kill-music-daemon
    	  "eu" 'mpd/update-database
    	  "ej" 'emms-next
    	  "ek" 'emms-previous
    	  "ep" 'emms-pause)
    	;; pdf reader
    	(evil-leader/set-key
    	  "pu" 'pdf-annot-add-underline-markup-annotation
    	  "ph" 'pdf-annot-add-highlight-markup-annotation
    	  "pd" 'pdf-annot-delete
    	  "pg" 'pdf-view-goto-page)
    	;; avy jump
    	(evil-leader/set-key
    	  "SPC" 'avy-goto-char
    	  "jj" 'avy-goto-char-2
    	  "jl" 'avy-goto-line)
    	;; lookup
    	(evil-leader/set-key
    	  "lw" 'xah-lookup-wikipedia
    	  "ld" 'xah-lookup-word-definition)
	))
    )
  :config
  (progn
    (evil-mode 1)
    (setq evil-cross-lines t)
    (setq evil-move-cursor-back nil)
    (setq evil-want-C-u-scroll t)
    (setcdr evil-insert-state-map nil)
    (define-key evil-insert-state-map [escape] 'evil-normal-state)
    
    ;; Make evil-mode up/down operate in screen lines instead of logical lines
    (define-key evil-motion-state-map "j" 'evil-next-visual-line)
    (define-key evil-motion-state-map "k" 'evil-previous-visual-line)
    ;; Also in visual mode
    (define-key evil-visual-state-map "j" 'evil-next-visual-line)
    (define-key evil-visual-state-map "k" 'evil-previous-visual-line)
    
    (evil-set-initial-state 'bongo-playlist-mode 'emacs)
    (evil-set-initial-state 'osx-dictionary-mode 'emacs)
    (evil-set-initial-state 'ein:notebook-multilang-mode 'emacs)
    (evil-add-hjkl-bindings osx-dictionary-mode-map 'emacs)
    (evil-add-hjkl-bindings bongo-playlist-mode-map 'emacs)
    (evil-add-hjkl-bindings recentf-dialog-mode-map 'emacs)
    
    (defun du/evil-record-macro ()
      (interactive)
      (if buffer-read-only
    	  (quit-window)
    	(call-interactively 'evil-record-macro)))
    ;; evil quit-window and evil-record-macro integration
    (with-eval-after-load 'evil-maps
      (define-key evil-normal-state-map (kbd "q") 'du/evil-record-macro))

    ))

(use-package evil-collection
  :ensure t
  :defer 0.1
  :custom (evil-collection-setup-minibuffer t)
  :config
  (progn
    (evil-collection-init)
    (with-eval-after-load 'pdf-tools
      (require 'evil-collection-pdf) (evil-collection-pdf-setup)) ))

(use-package evil-magit
        :ensure t
        :after magit)

(use-package evil-org
    :ensure t
    :after org
    :diminish t
    :config
    (progn
      (add-hook 'org-mode-hook 'evil-org-mode)
      (add-hook 'evil-org-mode-hook
		(lambda () (evil-org-set-key-theme '(textobjects insert navigation additional shift todo heading))))
      (require 'evil-org-agenda)
      (evil-org-agenda-set-keys)))

(use-package evil-cleverparens
    :ensure t
    :hook (paredit-mode . evil-cleverparens-mode)
    :config (setq evil-cleverparens-swap-move-by-word-and-symbol t))

(use-package evil-paredit
    :ensure t
    :hook (paredit-mode . evil-paredit-mode))

(use-package evil-nerd-commenter
    :ensure t
    :bind ("M-;" . evilnc-comment-or-uncomment-lines))

(use-package treemacs-evil
  :after treemacs evil
  :ensure t)

(provide 'du-key-navigator)
