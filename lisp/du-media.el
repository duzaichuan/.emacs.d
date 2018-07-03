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
  :init (setq circe-network-options
	      '(("127.0.0.1"
		 :port "6667"
		 :tls t
		 :nick "Z.Du"))))

(provide 'du-media)
