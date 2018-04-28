;; use mu4e for e-mail in emacs
(require 'mu4e)
(setq mail-user-agent 'mu4e-user-agent)

;; default
;; (setq mu4e-maildir "~/Maildir")

;; CONFIGURING MU4E
(setq mu4e-contexts
 `( ,(make-mu4e-context
     :name "Outlook"
     :match-func (lambda (msg) (when msg
       (string-prefix-p "/Outlook" (mu4e-message-field msg :maildir))))
     :vars '(
       (mu4e-trash-folder . "/Outlook/[Outlook].Trash")
       (mu4e-refile-folder . "/Outlook/[Outlook].Archive")
       ))
   ,(make-mu4e-context
     :name "Exchange"
     :match-func (lambda (msg) (when msg
       (string-prefix-p "/Exchange" (mu4e-message-field msg :maildir))))
     :vars '(
       (mu4e-trash-folder . "/Exchange/Deleted Items")
       (mu4e-refile-folder . exchange-mu4e-refile-folder)
       ))
   ))

(defun exchange-mu4e-refile-folder (msg)
  "Function for chosing the refile folder for my Exchange email.
   MSG is a message p-list from mu4e."
  (cond
   ;; FLA messages
   ((string-match "\\[some-mailing-list\\]"
          (mu4e-message-field msg :subject))
    "/Exchange/mailing-list")
   (t "/Exchange/Archive")
   )
  )

;; Alerts for new mails
(use-package mu4e-alert
  :ensure t
  :after mu4e
  :init
  (setq mu4e-alert-interesting-mail-query
    (concat
     "flag:unread maildir:/Exchange/INBOX "
     "OR "
     "flag:unread maildir:/Outlook/INBOX"
     ))
  (mu4e-alert-enable-mode-line-display)
  (defun gjstein-refresh-mu4e-alert-mode-line ()
    (interactive)
    (mu4e~proc-kill)
    (mu4e-alert-enable-mode-line-display)
    )
  (run-with-timer 0 60 'gjstein-refresh-mu4e-alert-mode-line)
  )

;; USING MU4E TO SEND MAIL
(setq mu4e-sent-folder "/sent"
      ;; mu4e-sent-messages-behavior 'delete ;; Unsure how this should be configured
      mu4e-drafts-folder "/drafts"
      user-mail-address "duzaichuan@hotmail.com"
      smtpmail-default-smtp-server "smtp.live.com"
      smtpmail-smtp-server "smtp.live.com"
      smtpmail-smtp-service 25
      user-full-name  "Zaichuan Du"
      mu4e-compose-signature
      (concat
       "Best\n"
       "Zaichuan Du\n"))

(defvar my-mu4e-account-alist
  '(("Outlook"
     (mu4e-sent-folder "/Outlook/sent")
     (user-mail-address "duzaichuan@hotmail.com")
     (smtpmail-smtp-user "duzaichuan")
     (smtpmail-local-domain "hotmail.com")
     (smtpmail-default-smtp-server "smtp.live.com")
     (smtpmail-smtp-server "smtp.live.com")
     (smtpmail-smtp-service 25)
     (user-full-name  "Zaichuan Du")
     (mu4e-compose-signature
       (concat
	"Best\n"
	"Zaichuan Du\n")))
    ("Exchange"
     (mu4e-sent-folder "/Exchange/sent")
     (user-mail-address "cjq192@alumni.ku.dk")
     (smtpmail-default-smtp-server "exchange.ku.dk")
     (smtpmail-smtp-server "exchange.ku.dk")
     (smtpmail-smtp-service 465)
     (user-full-name  "Zaichuan Du")
     (mu4e-compose-signature
       (concat
	"Best\n"
	"Zaichuan Du\n")))
     ))

(defun my-mu4e-set-account ()
  "Set the account for composing a message.
   This function is taken from: 
     https://www.djcbsoftware.nl/code/mu/mu4e/Multiple-accounts.html"
  (let* ((account
    (if mu4e-compose-parent-message
        (let ((maildir (mu4e-message-field mu4e-compose-parent-message :maildir)))
    (string-match "/\\(.*?\\)/" maildir)
    (match-string 1 maildir))
      (completing-read (format "Compose with account: (%s) "
             (mapconcat #'(lambda (var) (car var))
            my-mu4e-account-alist "/"))
           (mapcar #'(lambda (var) (car var)) my-mu4e-account-alist)
           nil t nil nil (caar my-mu4e-account-alist))))
   (account-vars (cdr (assoc account my-mu4e-account-alist))))
    (if account-vars
  (mapc #'(lambda (var)
      (set (car var) (cadr var)))
        account-vars)
      (error "No email account found"))))
(add-hook 'mu4e-compose-pre-hook 'my-mu4e-set-account)

;; PITFALLS AND ADDITIONAL TWEAKS
(defun remove-nth-element (nth list)
  (if (zerop nth) (cdr list)
    (let ((last (nthcdr (1- nth) list)))
      (setcdr last (cddr last))
      list)))
(setq mu4e-marks (remove-nth-element 5 mu4e-marks))
(add-to-list 'mu4e-marks
     '(trash
       :char ("d" . "▼")
       :prompt "dtrash"
       :dyn-target (lambda (target msg) (mu4e-get-trash-folder msg))
       :action (lambda (docid msg target) 
                 (mu4e~proc-move docid
				 (mu4e~mark-check-target target) "-N"))))

;; Include a bookmark to open all of my inboxes
(add-to-list 'mu4e-bookmarks
       (make-mu4e-bookmark
        :name "All Inboxes"
        :query "maildir:/Exchange/INBOX OR maildir:/Outlook/INBOX"
        :key ?i))

;; This allows me to use 'helm' to select mailboxes
(setq mu4e-completing-read-function 'completing-read)
;; Why would I want to leave my message open after I've sent it?
(setq message-kill-buffer-on-exit t)
;; Don't ask for a 'context' upon opening mu4e
(setq mu4e-context-policy 'pick-first)
;; Don't ask to quit... why is this the default?
(setq mu4e-confirm-quit nil)

(require 'outlook-mu4e)

(provide 'init-mail)
