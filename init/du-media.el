(use-package emms
  :ensure t
  :commands (emms)
  :init
  (setq mpc-host "localhost:6610")
  :config
  (progn
    (require 'emms-setup)
    (require 'emms-player-mpd)
    (emms-all)
    (setq emms-seek-seconds 5)
    (setq emms-player-list '(emms-player-mpd)
	  emms-info-functions '(emms-info-mpd)
	  emms-player-mpd-server-name "localhost"
	  emms-player-mpd-server-port "6610") ))

(use-package du-emms-functions
  :load-path "lib/"
  :after emms)

(use-package bongo
  :ensure t
  :commands bongo-playlist
  :config (setq-default bongo-enabled-backends '(mplayer)))

(use-package simple-mpc
  :ensure t
  :commands (simple-mpc)
  :config
  (setq simple-mpc-playlist-format "%artist%	%album%	%title%	%file%"
	simple-mpc-table-separator " "))

(use-package volume
  :ensure t
  :after bongo)

(provide 'du-media)
