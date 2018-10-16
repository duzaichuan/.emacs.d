(use-package emms
  
  :commands (emms)
  :custom
  (mpc-host "localhost:6610")
  (emms-seek-seconds 5)
  (emms-player-list '(emms-player-mpd))
  (emms-info-functions '(emms-info-mpd))
  (emms-player-mpd-server-name "localhost")
  (emms-player-mpd-server-port "6610")

  :config
  (progn
    (require 'emms-setup)
    (require 'emms-player-mpd)
    (emms-all) ))

(use-package du-emms-functions
  :straight nil
  :load-path "lib/"
  :after emms)

(use-package bongo
  
  :commands bongo-playlist
  :custom (bongo-enabled-backends '(mplayer)))

(use-package simple-mpc
  
  :commands (simple-mpc)
  :custom
  (simple-mpc-playlist-format "%artist%	%album%	%title%	%file%")
  (simple-mpc-table-separator " "))

(use-package volume
  
  :after bongo)

(use-package netease-music
  
  :defer t
  :init
  (setq netease-music-username "18811472076")
  (setq netease-music-user-password "Du2046Du")
  (setq netease-music-user-id "66148971")
  (setq netease-music-api "http://localhost:3000"))

(provide 'init-media)
