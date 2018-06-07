;;Mail
(use-package mu4e
 ;:defer 0.15
  :commands mu4e
  :bind ([f9] . mu4e)
  :config
  (progn
    (add-hook 'mu4e-view-mode-hook (lambda () (linum-mode -1)))
    (add-hook 'mu4e-compose-mode-hook (lambda () (linum-mode -1)))
    (add-hook 'mu4e-headers-mode-hook (lambda () (linum-mode -1)))
    (add-hook 'mu4e-main-mode-hook (lambda () (linum-mode -1)))
    (add-hook 'mu4e-compose-mode-hook 'turn-off-auto-fill)
    (add-hook 'mu4e-compose-mode-hook 'visual-line-mode)
    (add-hook 'mu4e-view-mode-hook 'visual-line-mode)

    (setq mu4e-maildir "~/Mail"
	  mu4e-get-mail-command "mbsync -a"
	  mu4e-html2text-command "w3m -T text/html"
	  mu4e-update-interval 90               ;; update every 1.5 minutes 
	  mu4e-change-filenames-when-moving t ; needed in mbsync
	  mu4e-completing-read-function 'completing-read  ; This allows me to use 'helm' to select mailboxes
	  message-kill-buffer-on-exit t ; Why would I want to leave my message open after I've sent it?
	  mu4e-context-policy 'pick-first ; Don't ask for a 'context' upon opening mu4e
	  mu4e-confirm-quit nil ; Don't ask to quit... why is this the default?
	  message-citation-line-format "On %a %d %b %Y at %R, %f wrote:\n" ; customize the reply-quote-string
	  message-citation-line-function 'message-insert-formatted-citation-line ; choose to use the formatted string
	  message-cite-reply-position 'above
	  mu4e-maildir-shortcuts '( ("/Exchange/inbox"  . ?I)
				    ("/Exchange/sent"   . ?S)
				    ("/Outlook/inbox"   . ?i)
				    ("/Outlook/sent"    . ?s)))   
    ;; Multiple accounts
    (setq mu4e-contexts
	  `( ,(make-mu4e-context
	       :name "Outlook"
	       :enter-func (lambda () (mu4e-message "Entering Private context"))
               :leave-func (lambda () (mu4e-message "Leaving Private context"))
	       :match-func (lambda (msg) (when msg
					   (string-prefix-p "/Outlook" (mu4e-message-field msg :maildir))))
	       :vars '( (mu4e-trash-folder . "/Outlook/trash")
			(mu4e-refile-folder . "/Outlook/archive")
			(mu4e-sent-folder . "/Outlook/sent")
			(mu4e-drafts-folder . "/Outlook/drafts")
			(mu4e-sent-messages-behavior . delete)
			(user-mail-address . "duzaichuan@hotmail.com")
			(smtpmail-default-smtp-server . "smtp.live.com")
			(smtpmail-smtp-server . "smtp.live.com")
			(smtpmail-smtp-service . 25)
			(user-full-name . "Zaichuan Du")
			(mu4e-compose-signature . (concat
						   "Best\n"
						   "Zaichuan\n")) ))
	     ,(make-mu4e-context
	       :name "Exchange"
	       :enter-func (lambda () (mu4e-message "Switch to the Work context"))
	       :match-func (lambda (msg) (when msg
					   (string-prefix-p "/Exchange" (mu4e-message-field msg :maildir))))
	       :vars '( (mu4e-sent-folder . "/Exchange/sent")
			(mu4e-trash-folder . "/Exchange/trash")
			(mu4e-refile-folder . "/Exchange/archive")
			(mu4e-drafts-folder . "/Exchange/drafts")
			(user-mail-address . "cjq192@alumni.ku.dk")
			(smtpmail-default-smtp-server . "exchange.ku.dk")
			(smtpmail-smtp-server . "exchange.ku.dk")
			(smtpmail-smtp-service . 465)
			(user-full-name . "Zaichuan Du")
			(mu4e-compose-signature . (concat
						   "Best regards\n"
						   "Zaichuan Du\n")) ))
	     ))
   
    ;; enable inline images
    (setq mu4e-view-show-images t)
    ;; use imagemagick, if available
    (when (fboundp 'imagemagick-register-types)
      (imagemagick-register-types))

    (setq mu4e-attachment-dir
	  (lambda (fname mtype)
	    (cond
             ;; docfiles go to ~/Desktop
	     ((and fname (string-match "\\.doc$" fname))  "~/Desktop")
	     ;; ... other cases  ...
	     (t "~/Downloads")))) ;; everything else
    
    ;; Include a bookmark to open all of my inboxes
    (add-to-list 'mu4e-bookmarks
		 (make-mu4e-bookmark
		  :name "All Inboxes"
		  :query "maildir:/Exchange/inbox OR maildir:/Outlook/inbox"
		  :key ?i))
    ))

;; Alerts for new mails
(use-package mu4e-alert
  :ensure t
  :after mu4e
  :init (mu4e-alert-set-default-style 'notifications)
  :hook ((after-init . mu4e-alert-enable-mode-line-display)
         (after-init . mu4e-alert-enable-notifications))
  :config
  (progn
    (setq mu4e-alert-interesting-mail-query
	  (concat
	   "flag:unread maildir:/Exchange/inbox"
	   "OR "
	   "flag:unread maildir:/Outlook/inbox"))))

(provide 'du-mail)
