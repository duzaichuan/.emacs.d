(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#E8E8E8" "#3C3C3C" "#616161" "#0E0E0E" "#252525" "#3C3C3C" "#171717" "#0E0E0E"])
 '(company-idle-delay 0.1)
 '(company-math-allow-latex-symbols-in-faces t)
 '(company-minimum-prefix-length 2)
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#657b83")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-enabled-themes (quote (tao-yang)))
 '(custom-safe-themes
   (quote
    ("9fcac3986e3550baac55dc6175195a4c7537e8aa082043dcbe3f93f548a3a1e0" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "1f3113447a652b8436a9938bbac71ecaf022cc73ecd0d76182eb9713aa781f17" "086970da368bb95e42fd4ddac3149e84ce5f165e90dfc6ce6baceae30cf581ef" "3e335d794ed3030fefd0dbd7ff2d3555e29481fe4bbb0106ea11c660d6001767" "0ee3fc6d2e0fc8715ff59aed2432510d98f7e76fe81d183a0eb96789f4d897ca" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "55d31108a7dc4a268a1432cd60a7558824223684afecefa6fae327212c40f8d3" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" default)))
 '(eziam-scale-headings t)
 '(fci-rule-color "#F1F1F1" t)
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
 '(magit-diff-use-overlays nil)
 '(mu4e-headers-include-related nil)
 '(neo-mode-line-type (quote none) t)
 '(neo-theme (quote icons))
 '(nrepl-message-colors
   (quote
    ("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D" "#2aa198" "#d33682" "#6c71c4")))
 '(org-fontify-quote-and-verse-blocks t)
 '(org-latex-default-packages-alist
   (quote
    (("AUTO" "inputenc" t
      ("pdflatex"))
     ("T1" "fontenc" t
      ("pdflatex"))
     ("" "graphicx" t nil)
     ("" "grffile" t nil)
     ("" "longtable" nil nil)
     ("" "wrapfig" nil nil)
     ("" "rotating" nil nil)
     ("normalem" "ulem" t nil)
     ("" "amsmath" t nil)
     ("" "textcomp" t nil)
     ("" "amssymb" t nil)
     ("" "capt-of" nil nil)
     ("hidelinks = true" "hyperref" nil nil)
     ("" "cleveref" nil nil))))
 '(org-preview-latex-default-process (quote dvipng))
 '(org-startup-truncated nil)
 '(package-selected-packages
   (quote
    (2048-game cider citeproc clojure-mode color-identifiers-mode counsel ess exec-path-from-shell expand-region geiser highlight-parentheses imenu-anywhere julia-mode latex-unicode-math-mode load-theme-buffer-local magic-latex-buffer markdown-mode math-symbol-lists mu4e-alert neotree org-beautify-theme org-mime org-ref outlook ov pallet paredit parsebib pkg-info popup popwin queue racket-mode reveal-in-osx-finder shut-up spaceline-all-the-icons spinner string-inflection swiper tablist typo use-package yaml-mode writeroom-mode org-bullets matlab-mode org org-edna 0blayout pdf-tools eziam-theme tao-theme ob-ipython smartparens company auto-package-update polymode pandoc-mode auctex solarized-theme)))
 '(pdf-view-midnight-colors (quote ("#DCDCCC" . "#383838")))
 '(pos-tip-background-color "#eee8d5")
 '(pos-tip-foreground-color "#586e75")
 '(preview-auto-cache-preamble t)
 '(send-mail-function (quote smtpmail-send-it))
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#eee8d5" 0.2))
 '(spaceline-all-the-icons-separator-type (quote arrow))
 '(spaceline-all-the-icons-slim-render nil)
 '(tao-theme-use-height nil)
 '(term-default-bg-color "#fdf6e3")
 '(term-default-fg-color "#657b83")
 '(truncate-lines nil)
 '(vc-annotate-background "#F6F6F6")
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#C3C3C3")
     (40 . "#9E9E9E")
     (60 . "#9E9E9E")
     (80 . "#616161")
     (100 . "#616161")
     (120 . "#3C3C3C")
     (140 . "#3C3C3C")
     (160 . "#252525")
     (180 . "#252525")
     (200 . "#252525")
     (220 . "#171717")
     (240 . "#171717")
     (260 . "#171717")
     (280 . "#0E0E0E")
     (300 . "#0E0E0E")
     (320 . "#0E0E0E")
     (340 . "#090909")
     (360 . "#090909"))))
 '(vc-annotate-very-old-color "#3C3C3C")
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
 '(org-block ((t (:background "gray96" :foreground "#616161" :height 0.95))))
 '(org-block-begin-line ((t (:inherit org-meta-line))))
 '(org-block-end-line ((t (:inherit org-block-begin-line))))
 '(org-code ((t (:inherit shadow))))
 '(org-document-info ((t (:foreground "#C3C3C3"))))
 '(org-document-info-keyword ((t (:foreground "#C3C3C3"))))
 '(org-document-title ((t (:foreground "Black" :weight semi-bold :height 1.4))))
 '(org-inlinetask ((t (:inherit shadow))))
 '(org-level-1 ((t (:background "gray93" :foreground "black" :overline nil :weight semi-bold :height 1.25))))
 '(org-level-2 ((t (:background "gray93" :foreground "gray25" :overline nil :weight semi-bold :height 1.2))))
 '(org-level-3 ((t (:background "gray93" :foreground "gray40" :overline nil :weight semi-bold :height 1.1))))
 '(org-meta-line ((t (:foreground "#9E9E9E" :height 0.95))))
 '(org-quote ((t (:inherit org-block))))
 '(org-ref-cite-face ((t (:inherit org-link :foreground "dark red"))))
 '(org-special-keyword ((t (:inherit org-meta-line))))
 '(org-verbatim ((t (:inherit shadow))))
 '(org-verse ((t (:inherit org-block)))))
