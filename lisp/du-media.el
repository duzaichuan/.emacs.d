(use-package emms
  :ensure t
  :bind (([f10] . emms))
  :init
  (add-to-list 'load-path "~/.emacs.d/emms/")
  (setq emms-source-file-default-directory "~/Music/")
  :config
  (progn
    (require 'emms-setup)
    (emms-all)
    (emms-default-players) ))

(use-package bongo
  :ensure t
  :commands bongo)

(use-package twittering-mode
  :ensure t
  :commands twit
  :init
  (setq twittering-use-master-password t
	epa-pinentry-mode 'loopback
	twittering-icon-mode t
	twittering-use-icon-storage t))

(use-package circe
  :ensure t
  :commands circe
  :init
  (progn
    (setq circe-use-cycle-completion t)
    (setq my-credentials-file "~/.private.el")

    (defun du/nickserv-password (server)
      (with-temp-buffer
	(insert-file-contents-literally my-credentials-file)
	(plist-get (read (buffer-string)) :nickserv-password)))

    (setq circe-network-options
	  '(("Freenode"
             :nick "Solatle"
             :channels ("#org-mode" "#evil-mode" :after-auth "#emacs")
             :nickserv-password du/nickserv-password))) ))

(use-package circe-notifications
  :ensure t
  :after circe
  :config
  (progn
    (autoload 'enable-circe-notifications "circe-notifications" nil t)
    
    (eval-after-load "circe-notifications"
      '(setq circe-notifications-watch-strings
             '("people" "you" "like" "to" "hear" "from")
             circe-notifications-alert-style 'osx-notifier)) ;; see alert-styles for more!
    
    (add-hook 'circe-server-connected-hook 'enable-circe-notifications) ))

(provide 'du-media)
