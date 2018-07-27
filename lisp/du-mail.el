(use-package mu4e
  :load-path "/usr/local/share/emacs/site-lisp/mu/mu4e"
  :bind (([f9] . mu4e)
	 :map mu4e-compose-mode-map
	 ("C-x C-a" . mail-add-attachment))
  :hook ((mu4e-compose-mode . flyspell-mode)
	 ((mu4e-compose-mode mu4e-view-mode) . visual-fill-column-mode))
  :init (add-hook 'mu4e-compose-mode-hook 'turn-off-auto-fill)
  :config
  (progn
    (setq mu4e-maildir "~/Maildir"
	  mu4e-get-mail-command "mbsync -a"
	  mu4e-html2text-command "w3m -dump -s -T text/html"
	  mu4e-attachment-dir  "~/Downloads"
	  ;; Speeding up indexing
	  mu4e-index-cleanup nil      ;; don't do a full cleanup check
	  mu4e-index-lazy-check t ;; don't consider up-to-date dirs
  
	  mu4e-split-view 'single-window ;;make the mu4e-main view into a minibuffer prompt
	  mu4e-hide-index-messages t ;; disable the message in the minibuffer 
	  mu4e-view-show-addresses t ;; Display email addresses (not just names)
	  mu4e-update-interval 60               ;; update every 1 minutes 
	  mu4e-change-filenames-when-moving t ; needed in mbsync
	  mu4e-view-show-images t ;; enable inline images
	  mu4e-completing-read-function 'completing-read  ; This allows me to use 'helm' to select mailboxes
	  message-kill-buffer-on-exit t ; Why would I want to leave my message open after I've sent it?
	  mu4e-context-policy 'pick-first ; Don't ask for a 'context' upon opening mu4e
	  mu4e-confirm-quit nil ; Don't ask to quit... why is this the default?
	  message-citation-line-format "On %a %d %b %Y at %R, %f wrote:\n" ; customize the reply-quote-string
	  message-citation-line-function 'message-insert-formatted-citation-line ; choose to use the formatted string
	  message-cite-reply-position 'above
	  mu4e-maildir-shortcuts '( ("/Exchange/Inbox"  . ?I)
				    ("/Exchange/Sent"   . ?S)
				    ("/Outlook/Inbox"   . ?i)
				    ("/Outlook/Sent"    . ?s)))   
    ;; Multiple accounts
    (setq mu4e-contexts
	  `( ,(make-mu4e-context
	       :name "Outlook"
	       :enter-func (lambda () (mu4e-message "Entering Private context"))
               :leave-func (lambda () (mu4e-message "Leaving Private context"))
	       :match-func (lambda (msg) (when msg
					   (string-prefix-p "/Outlook" (mu4e-message-field msg :maildir))))
	       :vars '( (mu4e-trash-folder . "/Outlook/Trash")
			(mu4e-refile-folder . "/Outlook/Archive")
			(mu4e-sent-folder . "/Outlook/Sent")
			(mu4e-drafts-folder . "/Outlook/Drafts")
			(user-mail-address . "duzaichuan@hotmail.com")
			(smtpmail-default-smtp-server . "smtp.live.com")
			(smtpmail-smtp-server . "smtp.live.com")
			(smtpmail-smtp-service . 25)
			(user-full-name . "Zaichuan Du")
			;; don't save messages to Sent Messages, Oulook/IMAP takes care of this
			(mu4e-sent-messages-behavior . delete)
			(mu4e-compose-signature . (concat
						   "Best\n"
						   "Zaichuan\n")) ))
	     ,(make-mu4e-context
	       :name "Exchange"
	       :enter-func (lambda () (mu4e-message "Switch to the Work context"))
	       :match-func (lambda (msg) (when msg
					   (string-prefix-p "/Exchange" (mu4e-message-field msg :maildir))))
	       :vars '( (mu4e-sent-folder . "/Exchange/Sent")
			(mu4e-trash-folder . "/Exchange/Trash")
			(mu4e-refile-folder . "/Exchange/Archive")
			(mu4e-drafts-folder . "/Exchange/Drafts")
			(user-mail-address . "cjq192@alumni.ku.dk")
			(smtpmail-default-smtp-server . "exchange.ku.dk")
			(smtpmail-smtp-server . "exchange.ku.dk")
			(smtpmail-smtp-service . 465)
			(user-full-name . "Zaichuan Du")
			(mu4e-compose-signature . (concat
						   "Best regards\n"
						   "Zaichuan Du\n")) )) ))
    
    (add-to-list 'mu4e-bookmarks
		 (make-mu4e-bookmark
		  :name "All Inboxes"
		  :query "maildir:/Exchange/Inbox OR maildir:/Outlook/Inbox"
		  :key ?i))   
    (add-to-list 'mu4e-bookmarks
		 (make-mu4e-bookmark
		  :name "All Archives"
		  :query "maildir:/Exchange/Archive OR maildir:/Outlook/Archive"
		  :key ?a))   
    ;; use imagemagick, if available
    (when (fboundp 'imagemagick-register-types)
      (imagemagick-register-types)) ))

(use-package org-mu4e
  :after mu4e
  :config
  (setq org-mu4e-link-query-in-headers-mode nil))

;; Alerts for new mails
(use-package mu4e-alert
  :ensure t
  :after mu4e
  :init (mu4e-alert-set-default-style 'notifications)
  :config
  (progn
    (mu4e-alert-enable-mode-line-display)
    (setq mu4e-alert-interesting-mail-query
	  (concat
	   "flag:unread"
	   " AND NOT flag:trashed")) ))

;; An attachment reminder in mu4e
(defun mbork/message-attachment-present-p ()
  "Return t if an attachment is found in the current message."
  (save-excursion
    (save-restriction
      (widen)
      (goto-char (point-min))
      (when (search-forward "<#part" nil t) t))))

(defcustom mbork/message-attachment-intent-re
  (regexp-opt '("I attach"
		"I attached"
		"I have attached"
		"I've attached"
		"I have included"
		"I've included"
		"see the attached"
		"see the attachment"
		"attached file"))
  "A regex which - if found in the message, and if there is no
attachment - should launch the no-attachment warning.")

(defcustom mbork/message-attachment-reminder
  "Are you sure you want to send this message without any attachment? "
  "The default question asked when trying to send a message
containing `mbork/message-attachment-intent-re' without an
actual attachment.")

(defun mbork/message-warn-if-no-attachments ()
  "Ask the user if s?he wants to send the message even though
there are no attachments."
  (when (and (save-excursion
	       (save-restriction
		 (widen)
		 (goto-char (point-min))
		 (re-search-forward mbork/message-attachment-intent-re nil t)))
	     (not (mbork/message-attachment-present-p)))
    (unless (y-or-n-p mbork/message-attachment-reminder)
      (keyboard-quit))))

(add-hook 'message-send-hook #'mbork/message-warn-if-no-attachments)

(provide 'du-mail)
