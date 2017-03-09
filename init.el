;; packages to install before starting:
;; org
;; magit
;; window-number
;; window-numbering-mode
;; tern-mode
;; tern-mode-autocomplete
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

(defun new-untitled-frame ()
  (interactive)
  (let ((bn "Untitled-")
        (num 1))
    (while
        (get-buffer (concat bn (number-to-string num))) 
      (setq num (1+ num))) 
    (switch-to-buffer-other-frame
     (concat bn (number-to-string num)))))

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
 '(js2-include-node-externs t)
 '(menu-bar-mode nil)
 '(org-startup-indented t)
 '(package-selected-packages
   (quote
    (zerodark-theme json-mode tern tern-auto-complete cyberpunk-theme company-shell company-web solarized-dark-theme ag magit web-mode window-number material-theme js2-mode exec-path-from-shell company-tern company-quickhelp company-jedi company-c-headers)))
 '(send-mail-function (quote mailclient-send-it))
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa" . "https://melpa.org/packages/"))))
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))

(define-skeleton my-org-defaults
  "Org defaults I use"
  nil
  "#+AUTHOR:   Robert Gevorgyan\n"
  "#+EMAIL:    robert1999.g@gmail.com\n"
  "#+LANGUAGE: en\n"
  "#+STARTUP: indent\n"
  "#+OPTIONS:  toc:nil num:0\n")

(define-skeleton my-html-defaults
  "Minimum HTML needed"
  nil
  "<!DOCTYPE html>\n"
  "<html>"
  "  <meta charset=\"utf-8\"/>\n"
  "  <link rel=\"stylesheet\" href=\"\""
  "</html>"
  "<body>\n"
  "  <script src=\"\"></script>\n"
  "</body>\n")

;; Keep the history between sessions, very nice to have.
(savehist-mode 1)
(global-set-key (kbd "M-/") 'company-complete)
;; ;; Just kill the shell, don't ask me.
;; ;; I do a lambda so that its not evaluated at init load time.
(add-hook 'shell-mode-hook (lambda ()
    (company-mode)))

(window-number-mode)
(window-number-meta-mode)
(mouse-avoidance-mode 'banish)
(fringe-mode 10)
(tool-bar-mode -1)
;; Gives me the full name of the buffer, hate just having foo.c
(add-hook 'find-file-hooks
  '(lambda ()
     (setq mode-line-buffer-identification 'buffer-file-truename)))
(setq-default indicate-empty-lines t)
;; Revert all buffers, usually related to a git stash/pull/*
(global-set-key (kbd "C-\\") 'revert-all-buffers)
;; Just for cycling through in the same buffer
(global-set-key (kbd "<C-return>") 'next-buffer)
(global-set-key (kbd "<C-M-left>") 'previous-multiframe-window)
;; Native full screen, pretty nice.
(global-set-key (kbd "<M-return>") 'toggle-frame-fullscreen)
;; Undefine the regex searches so that they can be better used elsewhere
(global-unset-key (kbd "C-M-s"))
(global-unset-key (kbd "C-M-r"))
;; Make searches be regex searches!
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-unset-key (kbd "C-n"))
(global-set-key (kbd "C-n") #'new-untitled-frame)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-t") 'term)
(global-set-key (kbd "<C-up>") 'shrink-window)
(global-set-key (kbd "<C-down>") 'enlarge-window)
(global-set-key (kbd "<C-left>") 'shrink-window-horizontally)
(global-set-key (kbd "<C-right>") 'enlarge-window-horizontally)
(setq global-linum-mode t)

(add-hook 'html-mode-hook
 (lambda ()
  (web-mode)
  (company-mode)
  (define-key web-mode-map (kbd "M-/") 'company-web-html)))

(add-hook 'css-mode-hook (lambda ()
 (company-mode)
 (define-key css-mode-map (kbd "M-/") 'company-css)))

(setq-default
 ;; js2-mode
 ;; web-mode
 css-indent-offset 2
 web-mode-markup-indent-offset 2
 web-mode-css-indent-offset 2
 web-mode-code-indent-offset 2
 web-mode-attr-indent-offset 2)

(with-eval-after-load 'web-mode
  (add-to-list 'web-mode-indentation-params '("lineup-args" . nil))
  (add-to-list 'web-mode-indentation-params '("lineup-concats" . nil))
  (add-to-list 'web-mode-indentation-params '("lineup-calls" . nil)))

(add-hook 'scss-mode-hook (lambda ()
 (setq-local scss-compile-at-save t)
 (setq-local scss-output-directory "../css")
 (auto-complete)
 (define-key css-mode-map (kbd "M-/")
   'ac-start )))

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


;; C++ stuff, basically just be aware of it.
(add-to-list 'auto-mode-alist '("\\.cc\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cpp\\'" . c++-mode))

;; emacs lisp stuff
(add-hook 'emacs-lisp-mode-hook
  '(lambda ()
     (global-set-key (kbd "C-M-s") 'eval-buffer)
     (flycheck-mode)
     (company-mode)
     (global-unset-key (kbd "C-x c"))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
