;; open init.el 
(global-set-key (kbd "<f2>") (lambda () (interactive) (find-file user-init-file)))

(global-set-key (kbd "<f1>")
  (lambda ()
    (interactive)
    (dired "~/")))

(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-h f") 'counsel-describe-function)
(global-set-key (kbd "C-h v") 'counsel-describe-variable)

;; help menu
(global-set-key (kbd "C-h C-f") 'find-function)
(global-set-key (kbd "C-h C-v") 'find-variable)
(global-set-key (kbd "C-h C-k") 'find-function-on-key)

;; open recent files
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; org commands
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)
;; org ref
(add-hook 'org-mode-hook
          (lambda ()
            (define-key org-mode-map (kbd "C-c i r") 'org-ref-helm-insert-ref-link)))
(add-hook 'org-mode-hook
          (lambda ()
            (define-key org-mode-map (kbd "C-c i l") 'org-ref-helm-insert-label-link)))

(global-set-key (kbd "C-=") 'er/expand-region)

;; imenu everywhere
(global-set-key (kbd "C-.") #'imenu-anywhere)

;; git
(global-set-key (kbd "C-x p f") 'counsel-git)

;; dired
;; 主动加载 Dired Mode
;; (require 'dired)
;; (defined-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)

;; 延迟加载
(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))

;; Racket mode
(add-hook 'racket-mode-hook
          (lambda ()
            (define-key racket-mode-map (kbd "C-c r") 'racket-run)))

(global-set-key (kbd "C-c d") 'paredit-delete-region)

;; appropriate org-mime function in both email and Org-mode buffers
(add-hook 'message-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c M-o") 'org-mime-htmlize)))
(add-hook 'org-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c M-o") 'org-mime-org-buffer-htmlize)))

(global-set-key "\C-e" 'mu4e)

(provide 'init-keybindings)
