;; open init.el 
(global-set-key (kbd "<f2>") (lambda () (interactive) (find-file user-init-file)))

;; help menu
(global-set-key (kbd "C-h C-f") 'find-function)
(global-set-key (kbd "C-h C-v") 'find-variable)
(global-set-key (kbd "C-h C-k") 'find-function-on-key)

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
	(evil-leader/set-key "cc" 'evilnc-comment-or-uncomment-lines)
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
	;; file navigate
	(evil-leader/set-key
	  "ff" 'counsel-find-file
	  "fr" 'recentf-open-files)
	;; org
	(evil-leader/set-key
	  "oa" 'org-agenda
	  "oc" 'org-capture
	  "ob" 'org-iswitchb
	  "or" 'org-refile
	  "ol" 'org-store-link
	  "oe" 'org-export-dispatch
	  "of" 'writeroom-mode
	  "ot" 'org-time-stamp)
	;; dictionary
	(evil-leader/set-key
	  "dd" 'osx-dictionary-search-word-at-point
	  "di" 'osx-dictionary-search-input)
	;; emms media
	(evil-leader/set-key
	  "ej" 'emms-next
	  "ek" 'emms-previous
	  "ep" 'emms-pause) )) )
  :config
  (progn
    (evil-mode 1)
    (setq evil-cross-lines t)
    (setq evil-move-cursor-back nil)
    (setq evil-want-C-u-scroll t)
    (setcdr evil-insert-state-map nil)
    (define-key evil-insert-state-map [escape] 'evil-normal-state)
    (evil-add-hjkl-bindings recentf-dialog-mode-map 'emacs)
    (evil-add-hjkl-bindings package-menu-mode-map 'emacs)
    (evil-add-hjkl-bindings osx-dictionary-mode-map 'emacs)
    (evil-add-hjkl-bindings emms-playlist-mode-map 'emacs)
    
    (defun du/evil-record-macro ()
      (interactive)
      (if buffer-read-only
	  (quit-window)
	(call-interactively 'evil-record-macro)))
    ;; evil quit-window and evil-record-macro integration
    (with-eval-after-load 'evil-maps
      (define-key evil-normal-state-map (kbd "q") 'du/evil-record-macro)) ))

(use-package evil-collection
  :after evil
  :ensure t
  :custom (evil-collection-setup-minibuffer t)
  :config
  (evil-collection-init '(eww eshell cider company dired package-menu))
  (with-eval-after-load 'pdf-tools
    (require 'evil-collection-pdf) (evil-collection-pdf-setup)))

(use-package evil-magit
        :ensure t
        :after magit)

(use-package evil-org
    :ensure t
    :after org
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

(use-package evil-mu4e
    :ensure t
    :after mu4e)

(provide 'du-key-navigate)
