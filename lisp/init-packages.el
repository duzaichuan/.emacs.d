(require 'package)

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

(show-paren-mode t)

(when (and (memq window-system '(mac ns))
           (require 'exec-path-from-shell nil t))
  (setq exec-path-from-shell-debug t)
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-envs '("LANG" "GPG_AGENT_INFO" "SSH_AUTH_SOCK"))
  (message "Initialized PATH and other variables from SHELL."))

(global-company-mode t)
;; global activation of the unicode symbol completion 
(add-to-list 'company-backends 'company-math-symbols-unicode)

(ido-mode 1)
(setq ido-separator "\n")

(ivy-mode 1)
(setq ivy-use-virtual-buffers t)

(require 'smartparens-config)
;;(add-hook 'emacs-lisp-mode-hook 'smartparens-mode)
(smartparens-global-mode t)

(require 'ess-site)
(setq  inferior-julia-program-name "/Applications/JuliaPro-0.6.1.1.app/Contents/Resources/julia/Contents/Resources/julia/bin/julia")

;; ESS tracing bugs
(add-to-list 'ess-tracebug-search-path "/Applications/JuliaPro-0.6.1.1.app/Contents/Resources/julia/Contents/Resources/julia/bin/julia")

;; Matlab-mode
(setq matlab-shell-command "/Applications/MATLAB/MATLAB_R2017b.app/bin/matlab")
(setq matlab-shell-command-switches (list "-nodesktop"))

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

;; popwin help window is annoying
(require 'popwin)
(popwin-mode t)

(provide 'init-packages)
