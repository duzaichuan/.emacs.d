;; use mu4e for e-mail in emacs
(require 'mu4e)
(setq mail-user-agent 'mu4e-user-agent)

;; default
;; (setq mu4e-maildir "~/Maildir")

(setq mu4e-drafts-folder "/[Outlook].Drafts")
(setq mu4e-sent-folder   "/[Outlook].Sent Mail")
(setq mu4e-trash-folder  "/[Outlook].Trash")

;; don't save message to Sent Messages, Gmail/IMAP takes care of this
;;(setq mu4e-sent-messages-behavior 'delete)

;; setup some handy shortcuts
(setq mu4e-maildir-shortcuts
    '( ("/INBOX"               . ?i)
       ("/[Outlook].Sent Mail"   . ?s)
       ("/[Outlook].Trash"       . ?t)
       ("/[Outlook].All Mail"    . ?a)))

;; allow for updating mail using 'U' in the main view:
(setq
  mu4e-get-mail-command "offlineimap"   ;; or fetchmail, or ...
  mu4e-update-interval 300)             ;; update every 5 minutes

;; something about ourselves
(setq
   user-mail-address "duzaichuan@hotmail.com"
   user-full-name  "Zaichuan Du"
   mu4e-compose-signature
    (concat
      "Best\n"
      "Zaichuan Du\n"))

;; sending mail
(require 'smtpmail)
(setq message-send-mail-function 'smtpmail-send-it
   starttls-use-gnutls t
   smtpmail-default-smtp-server "smtp.live.com"
   smtpmail-smtp-server "smtp.live.com"
   smtpmail-smtp-service 25
   smtpmail-queue-mail  nil
   smtpmail-queue-dir  "~/Maildir/queue/cur")

;; don't keep message buffers around
(setq message-kill-buffer-on-exit t)

(require 'outlook-mu4e)

(provide 'init-mail)