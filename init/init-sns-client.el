(use-package twittering-mode
  
  :commands twit

  :custom
  (twittering-use-master-password t)
  (epa-pinentry-mode 'loopback)
  (twittering-icon-mode t)
  (twittering-use-icon-storage t))

(use-package md4rd
  
  :commands md4rd

  :hook (md4rd-mode . visual-fill-column-mode)

  :custom
  (md4rd-subs-active '(emacs Economics writing))
  (md4rd--oauth-refresh-token "147565326956-dDXMWAq0SSME9Qvb6-hafaRsD-s")
  (md4rd--oauth-access-token "147565326956-VPG767JAGLr9uxHu6KgzWKoYxeg"))

(use-package circe
  
  :commands circe

  :custom
  (circe-use-cycle-completion t)
  (my-credentials-file "~/.private.el")
  (circe-network-options
	  '(("Freenode"
             :nick "Solatle"
             :channels ("#org-mode" "#evil-mode" :after-auth "#emacs")
             :nickserv-password du/nickserv-password)))

  :init
  (defun du/nickserv-password (server)
      (with-temp-buffer
	(insert-file-contents-literally my-credentials-file)
	(plist-get (read (buffer-string)) :nickserv-password)))
  )

(use-package circe-notifications
  
  :after circe

  :config
  (progn
    (autoload 'enable-circe-notifications "circe-notifications" nil t)
    
    (eval-after-load "circe-notifications"
      '(setq circe-notifications-watch-strings
             '("people" "you" "like" "to" "hear" "from")
             circe-notifications-alert-style 'osx-notifier)) ;; see alert-styles for more!
    
    (add-hook 'circe-server-connected-hook 'enable-circe-notifications) ))

(provide 'init-sns-client)
