;; packages to install before starting:
;; org
;; magit
;; window-number
;; window-numbering-mode
;; tern-mode
;; company-mode (if you cannot find it, try company)

(setq company-backends '(company-clang
			 company-capf
			 company-c-headers
			 company-jedi))

;; Create a useful notes buffer
((lambda ()
  (with-temp-buffer
    (insert-file-contents "~/.emacs.d/notes.txt")
    (setq initial-scratch-message (buffer-string)))))

(package-initialize)
(autoload 'window-number-mode "window-number")
(autoload 'company-mode "company")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes (quote (tronesque)))
  ;; Emacs themes I use:
	;;cyberpunk
  ;;material
  ;;solarized
  ;;tronesque
	;;zerodark
 '(custom-safe-themes
   (quote
    ("a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "5dc0ae2d193460de979a463b907b4b2c6d2c9c4657b2e9e66b8898d2592e3de5" "cedd3b4295ac0a41ef48376e16b4745c25fa8e7b4f706173083f16d5792bb379" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "38e64ea9b3a5e512ae9547063ee491c20bd717fe59d9c12219a0b1050b439cdd" "98cc377af705c0f2133bb6d340bf0becd08944a588804ee655809da5d8140de6" "f5ad3af69f2b6b7c547208b8708d4fa7928b5697ca0845633d1d67c2d145952a" default)))
 '(menu-bar-mode nil)
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa" . "https://melpa.org/packages/"))))
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))
;;Javasript hook
;;Packages needed to be installed here
;; js2-mode
;; js2-jsx-mode
;; json-mode
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-jsx-mode))
(add-to-list 'auto-mode-alist '("\\.json\\'" . json-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . js2-jsx-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-jsx-mode))

(add-hook 'js2-mode-hook
	  (lambda ()
	    (setq-local company-async-timeout 5)
	    (company-mode)
	    (setq-local js2-global-externs
			'("fetch" "async" "Headers" "await" "WebSocket" "FormData"))
	    (setq-local js2-basic-offset 2)
	    (define-key js2-mode-map (kbd "M-/")
	      'company-tern)
	    (tern-mode)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
