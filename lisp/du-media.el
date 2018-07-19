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

(defun mpd/start-music-daemon ()
  "Start MPD, connects to it and syncs the metadata cache."
  (interactive)
  (shell-command "mpd")
  (mpd/update-database)
  (emms-player-mpd-connect)
  (emms-cache-set-from-mpd-all)
  (message "MPD Started!"))

(defun mpd/kill-music-daemon ()
  "Stops playback and kill the music daemon."
  (interactive)
  (emms-stop)
  (call-process "killall" nil nil nil "mpd")
  (message "MPD Killed!"))

(defun mpd/update-database ()
  "Updates the MPD database synchronously."
  (interactive)
  (call-process "mpc" nil nil nil "update")
  (message "MPD Database Updated!"))

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

(provide 'du-media)
