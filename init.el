;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want (setq  initial-frame-alist (quote ((fullscreen . maximized))))it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

(require 'package)
(package-initialize)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)

(require 'cl)

;;add whatever packages you want here
(defvar duzaichuan/packages '(
				   company
				   swiper
				   counsel
				   smartparens
				   exec-path-from-shell
				   auto-package-update
				   polymode
				   auctex
				   ess
				   org
				   use-package
				   matlab-mode
				   eziam-theme
				   solarized-theme
				   ob-ipython
				   racket-mode
				   yaml-mode
				   pdf-tools
				   markdown-mode
				   expand-region
				   imenu-anywhere
				   company-math
				   popwin
				   )  "Default packages")

(setq package-selected-packages duzaichuan/packages)

(defun duzaichuan/packages-installed-p ()
    (loop for pkg in duzaichuan/packages
          when (not (package-installed-p pkg)) do (return nil)
          finally (return t)))

(unless (duzaichuan/packages-installed-p)
    (message "%s" "Refreshing package database...")
    (package-refresh-contents)
    (dolist (pkg duzaichuan/packages)
      (when (not (package-installed-p pkg))
        (package-install pkg))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(company-math-allow-latex-symbols-in-faces t)
 '(company-minimum-prefix-length 1)
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#657b83")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-enabled-themes (quote (eziam-light)))
 '(custom-safe-themes
   (quote
    ("a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "1f3113447a652b8436a9938bbac71ecaf022cc73ecd0d76182eb9713aa781f17" "086970da368bb95e42fd4ddac3149e84ce5f165e90dfc6ce6baceae30cf581ef" "3e335d794ed3030fefd0dbd7ff2d3555e29481fe4bbb0106ea11c660d6001767" "0ee3fc6d2e0fc8715ff59aed2432510d98f7e76fe81d183a0eb96789f4d897ca" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "55d31108a7dc4a268a1432cd60a7558824223684afecefa6fae327212c40f8d3" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" default)))
 '(eziam-scale-headings t)
 '(fci-rule-color "#eee8d5" t)
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
 '(nrepl-message-colors
   (quote
    ("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D" "#2aa198" "#d33682" "#6c71c4")))
 '(org-latex-create-formula-image-program (quote dvipng))
 '(org-preview-latex-default-process (quote dvipng))
 '(org-startup-truncated nil)
 '(package-selected-packages
   (quote
    (org org-edna 0blayout pdf-tools eziam-theme tao-theme matlab-mode ob-ipython smartparens company auto-package-update polymode pandoc-mode auctex solarized-theme)))
 '(pdf-view-midnight-colors (quote ("#DCDCCC" . "#383838")))
 '(pos-tip-background-color "#eee8d5")
 '(pos-tip-foreground-color "#586e75")
 '(preview-auto-cache-preamble t)
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#eee8d5" 0.2))
 '(tao-theme-use-height t)
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

;; appearance setting
(add-to-list 'default-frame-alist '(fullscreen . maximized))
;;(add-to-list 'default-frame-alist '(height . 40))
;;(add-to-list 'default-frame-alist '(width . 85))

(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-linum-mode 1)
(set-face-attribute 'default nil :height 170)
(setq inhibit-startup-screen t)
(setq-default cursor-type 'bar)
(show-paren-mode t)
(global-visual-line-mode t)

;; Locale setup
(when (and (memq window-system '(mac ns))
           (require 'exec-path-from-shell nil t))
  (setq exec-path-from-shell-debug t)
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-envs '("LANG" "GPG_AGENT_INFO" "SSH_AUTH_SOCK"))
  (message "Initialized PATH and other variables from SHELL."))

(global-set-key (kbd "<f2>") (lambda () (interactive) (find-file user-init-file)))

(ido-mode 1)
(setq ido-separator "\n")

(set-keyboard-coding-system nil)

(setq make-backup-files nil)
(setq auto-save-default nil)

(delete-selection-mode t)

(global-hl-line-mode t)

(global-set-key (kbd "<f1>")
  (lambda ()
    (interactive)
    (dired "~/")))

(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-h f") 'counsel-describe-function)
(global-set-key (kbd "C-h v") 'counsel-describe-variable)

(require 'smartparens-config)
;;(add-hook 'emacs-lisp-mode-hook 'smartparens-mode)
(smartparens-global-mode t)

(global-set-key (kbd "C-h C-f") 'find-function)
(global-set-key (kbd "C-h C-v") 'find-variable)
(global-set-key (kbd "C-h C-k") 'find-function-on-key)

;; Find recent files
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 10)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;Reproducible Research and Literate Programming for Econometrics
(require 'ess-site)
(setq  inferior-julia-program-name "/Applications/JuliaPro-0.6.1.1.app/Contents/Resources/julia/Contents/Resources/julia/bin/julia")

;; ESS tracing bugs
(add-to-list 'ess-tracebug-search-path "/Applications/JuliaPro-0.6.1.1.app/Contents/Resources/julia/Contents/Resources/julia/bin/julia")

;; Tell emacs location of your personal elisp lib dir
(add-to-list 'load-path "~/.emacs.d/lisp/")

(global-company-mode t)

;; global activation of the unicode symbol completion 
(add-to-list 'company-backends 'company-math-symbols-unicode)
(global-set-key (kbd "C-u") 'company-math-symbols-unicode)

;; Greek letters completion globally(except ess-julia)
(load "unicode-math-input")
(require 'unicode-math-input)

;; load ob-julia
(load "ob-julia")

;; Add julia and ipython to babel languages (you need an entry for each 
;; language you want to submit code for)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((ipython . t)
   (julia . t)
   ))

;; org mode
(require 'org)
(setq org-latex-create-formula-image-program 'dvipng)
(setq org-confirm-babel-evaluate nil)
;; bigger latex fragment
(plist-put org-format-latex-options :scale 1.65)
;; syntax highlight in org mode
(setq org-src-fontify-natively t)
;; line wrap in org mode
(set-default 'truncate-lines nil)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-document-title ((t (:foreground "#000000" :weight bold :height 1.5)))))

(defun my/org-mode-hook ()
  "Stop the org-level headers from increasing in height relative to the other text."
  (dolist (face '(org-level-1
                  org-level-2
                  org-level-3
                  org-level-4
                  org-level-5))
    (set-face-attribute face nil :weight 'semi-bold :height 1.1)))

(add-hook 'org-mode-hook 'my/org-mode-hook)
(add-hook 'org-babel-after-execute-hook 'org-display-inline-images)   
(add-hook 'org-mode-hook 'org-display-inline-images)
(add-hook 'post-command-hook 'cw/org-auto-toggle-fragment-display)

;; org commands
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

;; Automatic latex image toggling when cursor is on a fragment
(defvar cw/org-last-fragment nil
  "Holds the type and position of last valid fragment we were on. Format: (FRAGMENT_TYPE FRAGMENT_POINT_BEGIN)"
  )

(setq cw/org-valid-fragment-type
      '(latex-fragment
        latex-environment
        link))

(defun cw/org-curr-fragment ()
  "Returns the type and position of the current fragment available for preview inside org-mode. Returns nil at non-displayable fragments"
  (let* ((fr (org-element-context))
         (fr-type (car fr)))
    (when (memq fr-type cw/org-valid-fragment-type)
      (list fr-type
            (org-element-property :begin fr))))
  )

(defun cw/org-remove-fragment-overlay (fr)
  "Remove fragment overlay at fr"
  (let ((fr-type (nth 0 fr))
        (fr-begin (nth 1 fr)))
    (goto-char fr-begin)
    (cond ((or (eq 'latex-fragment fr-type)
               (eq 'latex-environment fr-type))
           (let ((ov (loop for ov in (org--list-latex-overlays)
                           if
                           (and
                            (<= (overlay-start ov) (point))
                            (>= (overlay-end ov) (point)))
                           return ov)))
             (when ov
               (delete-overlay ov))))
          ((eq 'link fr-type)
           nil;; delete image overlay here?
           ))
    ))

(defun cw/org-preview-fragment (fr)
  "Preview org fragment at fr"
  (let ((fr-type (nth 0 fr))
        (fr-begin (nth 1 fr)))
    (goto-char fr-begin)
    (cond ((or (eq 'latex-fragment fr-type) ;; latex stuffs
               (eq 'latex-environment fr-type))
           (when (cw/org-curr-fragment) (org-preview-latex-fragment))) ;; only toggle preview when we're in a valid region (for inserting in the front of a fragment)


          ((eq 'link fr-type) ;; for images
           (let ((fr-end (org-element-property :end (org-element-context))))
             (org-display-inline-images nil t fr-begin fr-end))))
    ))


(defun cw/org-auto-toggle-fragment-display ()
  "Automatically toggle a displayable org mode fragment"
  (and (eq 'org-mode major-mode)
       (let ((curr (cw/org-curr-fragment)))
         (cond
          ;; were on a fragment and now on a new fragment
          ((and
            ;; fragment we were on
            cw/org-last-fragment
            ;; and are on a fragment now
            curr
            ;; but not on the last one this is a little tricky. as you edit the
            ;; fragment, it is not equal to the last one. We use the begin
            ;; property which is less likely to change for the comparison.
            (not (equal curr cw/org-last-fragment)))

           ;; go back to last one and put image back, provided there is still a fragment there
           (save-excursion
             (cw/org-preview-fragment cw/org-last-fragment)
             ;; now remove current image
             (cw/org-remove-fragment-overlay curr)
             ;; and save new fragment
             )
           (setq cw/org-last-fragment curr))

          ;; were on a fragment and now are not on a fragment
          ((and
            ;; not on a fragment now
            (not curr)
            ;; but we were on one
            cw/org-last-fragment)
           ;; put image back on, provided that there is still a fragment here.
           (save-excursion
             (cw/org-preview-fragment cw/org-last-fragment))

           ;; unset last fragment
           (setq cw/org-last-fragment nil))

          ;; were not on a fragment, and now are
          ((and
            ;; we were not one one
            (not cw/org-last-fragment)
            ;; but now we are
            curr)
           ;; remove image
           (save-excursion
             (cw/org-remove-fragment-overlay curr)
             )
           (setq cw/org-last-fragment curr))

          ))))
	     

;; Matlab-mode
(setq matlab-shell-command "/Applications/MATLAB/MATLAB_R2017b.app/bin/matlab")
    (setq matlab-shell-command-switches (list "-nodesktop"))

;; dynare .mod file
(require 'dynare)

;; polymode
;;; MARKDOWN
(add-to-list 'auto-mode-alist '("\\.md" . poly-markdown-mode))
;;; R modes
(add-to-list 'auto-mode-alist '("\\.Snw" . poly-noweb+r-mode))
(add-to-list 'auto-mode-alist '("\\.Rnw" . poly-noweb+r-mode))
(add-to-list 'auto-mode-alist '("\\.Rmd" . poly-markdown+r-mode))
(require 'poly-R)
(require 'poly-markdown)

;; Auctex
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(setq TeX-PDF-mode nil)
(setq preview-image-type 'dvipng)
(add-hook 'LaTeX-mode-hook '(lambda () (setq compile-command "latexmk -pdf")))
(add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)

;; Racket mode
(add-hook 'racket-mode-hook
          (lambda ()
            (define-key racket-mode-map (kbd "C-c r") 'racket-run)))
(setq tab-always-indent 'complete)

;; pdf-tools
(pdf-tools-install)
;; automatically annotate highlights
(setq pdf-annot-activate-created-annotations t)
(add-hook 'pdf-view-mode-hook (lambda() (linum-mode -1)))

;; expand-region
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;; imenu everywhere
(global-set-key (kbd "C-.") #'imenu-anywhere)

;; popwin help window is annoying
(require 'popwin)
(popwin-mode t)

;; disable audio bell
(setq ring-bell-function 'ignore)

(global-auto-revert-mode t)
