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

(use-package twittering-mode
  :ensure t
  :commands twit
  :init (setq twittering-use-master-password t
	      epa-pinentry-mode 'loopback
	      twittering-icon-mode t
	      twittering-use-icon-storage t))

(use-package circe
  :ensure t
  :commands circe
  :init
  (setq circe-network-options
	'(("127.0.0.1"
	   :port "6667"
	   :nick "Solatle")))
  (setq lui-time-stamp-position 'right-margin
	lui-fill-type nil
	lui-time-stamp-format "%H:%M"
	)
  :config
  (progn
    (add-hook 'circe-chat-mode-hook 'my-circe-prompt)
    (defun my-circe-prompt ()
      (lui-set-prompt
       (concat (propertize (concat (buffer-name) ">")
			   'face 'circe-prompt-face)
               " ")))

    (add-hook 'lui-mode-hook 'my-lui-setup)
    (defun my-lui-setup ()
      (setq
       fringes-outside-margins t
       right-margin-width 5
       word-wrap t
       wrap-prefix "    ")) ))

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
