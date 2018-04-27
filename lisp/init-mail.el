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

;; (See the documentation for `mu4e-sent-messages-behavior' if you have
;; additional non-Gmail addresses and want assign them different
;; behavior.)

;; setup some handy shortcuts
;; you can quickly switch to your Inbox -- press ``ji''
;; then, when you want archive some messages, move them to
;; the 'All Mail' folder by pressing ``ma''.

(setq mu4e-maildir-shortcuts
    '( ("/INBOX"               . ?i)
       ("/[Outlook].Sent Mail"   . ?s)
       ("/[Outlook].Trash"       . ?t)
       ("/[Outlook].All Mail"    . ?a)))

;; allow for updating mail using 'U' in the main view:
(setq mu4e-get-mail-command "offlineimap")

;; something about ourselves
(setq
   user-mail-address "duzaichuan@hotmail.com"
   user-full-name  "Zaichuan Du"
   mu4e-compose-signature
    (concat
      "Zaichuan Du\n"
      "http://www.example.com\n"))

;; sending mail -- replace USERNAME with your gmail username
;; also, make sure the gnutls command line utils are installed
;; package 'gnutls-bin' in Debian/Ubuntu

(require 'smtpmail)
(setq message-send-mail-function 'smtpmail-send-it
   starttls-use-gnutls t
   smtpmail-starttls-credentials '(("smtp.live.com" 587 nil nil))
   smtpmail-auth-credentials
     '(("smtp.live.com" 587 "duzaichuan@hotmail.com" nil))
   smtpmail-default-smtp-server "smtp.live.com"
   smtpmail-smtp-server "smtp.live.com"
   smtpmail-smtp-service 587)

;; alternatively, for emacs-24 you can use:
;;(setq message-send-mail-function 'smtpmail-send-it
;;     smtpmail-stream-type 'starttls
;;     smtpmail-default-smtp-server "smtp.gmail.com"
;;     smtpmail-smtp-server "smtp.gmail.com"
;;     smtpmail-smtp-service 587)

;; don't keep message buffers around
(setq message-kill-buffer-on-exit t)

(require 'outlook-mu4e)

(provide 'init-mail)
