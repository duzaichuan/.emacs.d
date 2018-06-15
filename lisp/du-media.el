(use-package emms
  :ensure t
  :commands emms
  :config
  (progn
    (require 'emms-setup)
    (require 'emms-player-mpd)
    (emms-all) ; don't change this to values you see on stackoverflow questions if you expect emms to work
    (setq emms-seek-seconds 5)
    (setq emms-player-list '(emms-player-mpd))
    (setq emms-info-functions '(emms-info-mpd))
    (setq emms-player-mpd-server-name "localhost")
    (setq emms-player-mpd-server-port "6601")))

(use-package twittering-mode
  :ensure t
  :bind ([f3] . twit)
  :init (setq twittering-use-master-password t
	      epa-pinentry-mode 'loopback
	      twittering-icon-mode t
	      twittering-use-icon-storage t))

(provide 'du-media)
