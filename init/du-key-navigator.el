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
    (which-key-setup-side-window-bottom)))

(use-package avy
  :ensure t
  :bind ("C-;" . avy-goto-char)
  :commands (avy-goto-char avy-goto-char-2 avy-goto-line))

(use-package evil
  :ensure t
  :diminish evil-mode
  :init (setq evil-want-integration nil) 
  :config
  (progn
    (evil-mode 1)
    (setq evil-cross-lines t
	  evil-respect-visual-line-mode t
	  evil-move-cursor-back nil
	  evil-want-C-u-scroll t)
    (setcdr evil-insert-state-map nil)
    (define-key evil-insert-state-map [escape] 'evil-normal-state)
    
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

(use-package evil-escape
  :ensure t
  :config
  (progn
    (evil-escape-mode)
    (setq-default evil-escape-delay 0.2) ))

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

(use-package general
  :ensure t
  :after evil-collection
  :config
  (general-define-key
   :keymaps '(normal visual insert emacs)
   :prefix "SPC"
   :non-normal-prefix "M-SPC"

   "b" '(:ignore t :which-key "buffers")
   "bb" 'ivy-switch-buffer
   "bj" 'next-buffer
   "bk" 'previous-buffer
   "bd" 'kill-buffer-and-window
   
   "w" '(:ignore t :which-key "windows")
   "wd" 'delete-window
   "wo" 'delete-other-windows
   "wh" 'split-window-horizontally
   "wv" 'split-window-vertically
   "ww" 'other-window

   "f" '(:ignore t :which-key "file/format")
   "ff" 'counsel-find-file
   "fr" 'recentf-open-files
   "fc" 'evilnc-comment-or-uncomment-lines
   "fi" 'indent-region

   "g" '(:ignore t :which-key "magit")
   "gs" 'magit-status
   
   "o" '(:ignore t :which-key "org")
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
   "om" 'org-mind-map-write
   "ow" 'writeroom-mode

   "p" '(:ignore t :which-key "pdf")
   "pu" 'pdf-annot-add-underline-markup-annotation
   "ph" 'pdf-annot-add-highlight-markup-annotation
   "pd" 'pdf-annot-delete
   "pg" 'pdf-view-goto-page

   "m" '(:ignore t :which-key "media")
   "mb" 'bongo-playlist
   "me" 'emms
   "mt" 'twit
   "mm" 'simple-mpc
   "mc" 'circe
   "mr" 'md4rd

   "j" '(:ignore t :which-key "avy-jump")
   "SPC" 'avy-goto-char
   "jj" 'avy-goto-char-2
   "jl" 'avy-goto-line

   "d" '(:ignore t :which-key "dictionary")
   "dd" 'osx-dictionary-search-word-at-point
   "di" 'osx-dictionary-search-input
   
   "l" '(:ignore t :which-key "look-up")
   "lw" 'xah-lookup-wikipedia
   "ld" 'xah-lookup-word-definition

   ))

(provide 'du-key-navigator)
