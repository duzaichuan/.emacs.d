(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(beacon-color "#f2777a")
 '(company-math-allow-latex-symbols-in-faces t)
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(compilation-message-face (quote default))
 '(counsel-find-file-ignore-regexp
   "\\(\\`\\.[^.]\\|\\(?:\\.\\(?:aux\\|b\\(?:bl\\|in\\|lg\\|zr/\\)\\|c\\(?:lass\\|ps?\\)\\|d\\(?:\\(?:64fs\\|fs\\|x\\(?:\\(?:32\\|64\\)fs\\)?\\)l\\)\\|elc\\|f\\(?:asl?\\|mt\\|ns?\\|\\(?:x\\(?:\\(?:32\\|64\\)f\\)\\)?sl\\)\\|g\\(?:it/\\|[lm]o\\)\\|hg/\\|idx\\|kys?\\|l\\(?:bin\\|ib\\|o[ft]\\|x\\(?:\\(?:32\\|64\\)fsl\\)\\|[ano]\\)\\|m\\(?:em\\|o\\)\\|p\\(?:64fsl\\|fsl\\|gs?\\|y[co]\\)\\|s\\(?:o\\|parcf\\|vn/\\|x\\(?:\\(?:32\\|64\\)fsl\\)\\)\\|t\\(?:fm\\|oc\\|ps?\\)\\|ufsl\\|vrs?\\|wx\\(?:\\(?:32\\|64\\)fsl\\)\\|x86f\\|[ao]\\)\\|CVS/\\|_\\(?:\\(?:MTN\\|darcs\\)/\\)\\|~\\)\\'\\)")
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#657b83")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-enabled-themes (quote (zenburn)))
 '(custom-safe-themes
   (quote
    ("628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "190a9882bef28d7e944aa610aa68fe1ee34ecea6127239178c7ac848754992df" "9fcac3986e3550baac55dc6175195a4c7537e8aa082043dcbe3f93f548a3a1e0" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "1f3113447a652b8436a9938bbac71ecaf022cc73ecd0d76182eb9713aa781f17" "086970da368bb95e42fd4ddac3149e84ce5f165e90dfc6ce6baceae30cf581ef" "3e335d794ed3030fefd0dbd7ff2d3555e29481fe4bbb0106ea11c660d6001767" "0ee3fc6d2e0fc8715ff59aed2432510d98f7e76fe81d183a0eb96789f4d897ca" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "55d31108a7dc4a268a1432cd60a7558824223684afecefa6fae327212c40f8d3" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" default)))
 '(evil-collection-setup-minibuffer t)
 '(evil-want-C-u-scroll t)
 '(eziam-scale-headings t)
 '(fci-rule-color "#eee8d5" t)
 '(flycheck-color-mode-line-face-to-color (quote mode-line-buffer-id))
 '(frame-background-mode (quote dark))
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#fdf6e3" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#586e75")
 '(highlight-tail-colors
   (quote
    (("#eee8d5" . 0)
     ("#B4C342" . 20)
     ("#69CABF" . 30)
     ("#69B7F0" . 50)
     ("#DEB542" . 60)
     ("#F2804F" . 70)
     ("#F771AC" . 85)
     ("#eee8d5" . 100))))
 '(hl-bg-colors
   (quote
    ("#DEB542" "#F2804F" "#FF6E64" "#F771AC" "#9EA0E5" "#69B7F0" "#69CABF" "#B4C342")))
 '(hl-fg-colors
   (quote
    ("#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3")))
 '(ivy-dynamic-exhibit-delay-ms 200)
 '(ivy-height 10)
 '(ivy-initial-inputs-alist nil t)
 '(ivy-magic-tilde nil)
 '(ivy-re-builders-alist (quote ((t . ivy--regex-ignore-order))) t)
 '(ivy-use-virtual-buffers t)
 '(ivy-wrap t)
 '(magit-diff-use-overlays nil)
 '(mu4e-headers-include-related nil)
 '(neo-theme (quote icons))
 '(nrepl-message-colors
   (quote
    ("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D" "#2aa198" "#d33682" "#6c71c4")))
 '(org-startup-truncated nil)
 '(package-selected-packages
   (quote
    (xah-lookup language-detection magithub simple-mpc bongo posframe circe skewer-mode org-beautify-theme evil-collection clj-refactor rainbow-delimiters org-download org-pdfview writeroom-mode org-bullets matlab-mode org org-edna 0blayout pdf-tools ob-ipython smartparens company auto-package-update polymode pandoc-mode auctex)))
 '(pdf-view-midnight-colors (quote ("#DCDCCC" . "#383838")))
 '(pos-tip-background-color "#eee8d5")
 '(pos-tip-foreground-color "#586e75")
 '(preview-auto-cache-preamble t)
 '(send-mail-function (quote smtpmail-send-it))
 '(term-default-bg-color "#fdf6e3")
 '(term-default-fg-color "#657b83")
 '(truncate-lines nil)
 '(vc-annotate-background nil)
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#dc322f")
     (40 . "#c85d17")
     (60 . "#be730b")
     (80 . "#b58900")
     (100 . "#a58e00")
     (120 . "#9d9100")
     (140 . "#959300")
     (160 . "#8d9600")
     (180 . "#859900")
     (200 . "#669b32")
     (220 . "#579d4c")
     (240 . "#489e65")
     (260 . "#399f7e")
     (280 . "#2aa198")
     (300 . "#2898af")
     (320 . "#2793ba")
     (340 . "#268fc6")
     (360 . "#268bd2"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#fdf6e3" "#eee8d5" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#657b83" "#839496")))
 '(xterm-color-names
   ["#eee8d5" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#073642"])
 '(xterm-color-names-bright
   ["#fdf6e3" "#cb4b16" "#93a1a1" "#839496" "#657b83" "#6c71c4" "#586e75" "#002b36"]))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(neo-banner-face ((t (:foreground "dark cyan"))))
 '(neo-header-face ((t (:foreground "dark gray" :weight semi-bold))))
 '(pdf-occur-document-face ((t (:foreground "dark magenta")))))
