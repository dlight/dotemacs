(let ((default-directory "~/.emacs.d/site-lisp/"))
  (normal-top-level-add-to-load-path '("."))
  (normal-top-level-add-subdirs-to-load-path))

(require 'multi-term)
(require 'windmove)
(require 'ido)
(require 'egg)

(autoload 'glsl-mode "glsl-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.vert\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.frag\\'" . glsl-mode))

(require 'multi-web-mode)
(setq mweb-default-major-mode 'html-mode)
(setq mweb-tags '((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
                  (espresso-mode "<script +\\(type=\"text/javascript\"\\|language=\"javascript\"\\)[^>]*>" "</script>")
                  (css-mode "<style +type=\"text/css\"[^>]*>" "</style>")))
(setq mweb-filename-extensions '("php" "htm" "html" "ctp" "phtml" "php4" "php5"))
(multi-web-global-mode 1)

(load "scilab-startup")


;(require 'multi-web-mode)
;(setq mweb-default-major-mode 'html-mode)
;(setq mweb-tags '((js-mode "<script[^>]+type=\"text/javascript\"[^>]*>" "</script>")
;		  ;(glsl-mode "<script[^>]+\\(type=\"x-shader/x-fragment\"\\|type=\"x-shader/x-vertex\"\\)[^>]*>" "</script>")
;                  (css-mode "<style[^>]+type=\"text/css\"[^>]*>" "</style>"))
;(setq mweb-filename-extensions '("htm" "html"))
;(multi-web-global-mode 1)

(delete-selection-mode t)

(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(column-number-mode t)

(ido-mode t)
(winner-mode 1)

(setq inhibit-splash-screen t
      c-default-style "k&r"
      c-basic-offset 4
      compile-command "make fs"
      ido-enable-flex-matching t)

(ido-everywhere 1)

(defun keys (a)
  (when a
    (global-set-key (read-kbd-macro (nth 0 a)) (nth 1 a))
    (keys (cddr a))))

;(autoload 'paredit-mode "paredit"
;  "Minor mode for pseudo-structurally editing Lisp code." t)
;(add-hook 'emacs-lisp-mode-hook       (lambda () (paredit-mode +1)))
;(add-hook 'lisp-mode-hook             (lambda () (paredit-mode +1)))
;(add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))

(defun my-recompile ()
  (interactive)
  (recompile)
  (if (eq major-mode 'graphviz-dot-mode)
      (graphviz-dot-preview)))

(keys '("C-z" undo
	"C-y" clipboard-yank
	"C-w" clipboard-kill-region
	"C-c <C-left>" winner-undo
	"C-c <C-right>" winner-redo
	"C-x C-b" buffer-menu
	"M-w" clipboard-kill-ring-save
	"<C-tab>" switch-to-previous-buffer
	"s-q" my-recompile
	"s-c" compile
	"s-a" previous-error
	"s-s" next-error
	"s-e" my-term
	"s-w" ido-switch-buffer
	"s-o 1" setup-1
	"s-o 2" setup-2
	"s-o 3" setup-3
	"s-g" egg-status
	"s-v" hs-toggle-hiding
	"s-g" hs-show-block
	"s-h" hs-hide-block
	"s-j" hs-show-all
	"s-k" hs-hide-all
	"<s-left>" my-previous-buffer
	"<s-right>" my-next-buffer
	"<s-up>" next-regular-buffer
	"<s-down>" previous-star-buffer
	"<M-left>" windmove-left
	"<M-right>" windmove-right
	"<M-up>"  windmove-up
	"<M-down>" windmove-down
	"<mouse-8>" my-previous-buffer
	"<mouse-9>" my-next-buffer))

(defun my-term ()
  (interactive)
  (let ((b (get-buffer "*terminal<1>*")))
    (if b (switch-to-buffer b)
      (multi-term))))

(defun switch-to-previous-buffer ()
  (interactive)
  (switch-to-buffer (other-buffer)))

(defun my-next-buffer ()
  (interactive)
  (if (string-match "^\\*.*\\*$" (buffer-name))
      (next-star-buffer)
    (next-regular-buffer)))

(defun my-previous-buffer ()
  (interactive)
  (if (string-match "^\\*.*\\*$" (buffer-name))
      (previous-star-buffer)
    (previous-regular-buffer)))

(defun next-regular-buffer ()
  (interactive)
  (next-buffer)
  (if (string-match "^\\*.*\\*$" (buffer-name))
      (next-regular-buffer)))

(defun next-regular-buffer-or-scratch ()
  (interactive)
  (next-buffer)
  (if (and (string-match "^\\*.*\\*$" (buffer-name))
	  (not (equal "*scratch*" (buffer-name))))
      (next-regular-buffer-or-scratch)))

(defun previous-regular-buffer ()
  (interactive)
  (previous-buffer)
  (if (string-match "^\\*.*\\*$" (buffer-name))
      (previous-regular-buffer)))

(defun bad-buffer (a)
  (member a '("*Backtrace*"
	      "*Completions*"
	      "*Messages*"
	      "*Help*"
	      "*Egg:Select Action*")))

(defun next-star-buffer ()
  (interactive)
  (next-buffer)
  (if (or (not (string-match "^\\*.*\\*$" (buffer-name)))
	  (bad-buffer (buffer-name)))
      (next-star-buffer)))

(defun previous-star-buffer ()
  (interactive)
  (previous-buffer)
  (if (or (not (string-match "^\\*.*\\*$" (buffer-name)))
	  (bad-buffer (buffer-name)))
      (previous-star-buffer)))

(add-hook 'eshell-mode-hook
	  '(lambda ()
	     (local-set-key (kbd "<home>") 'eshell-bol)
	     (local-set-key (kbd "C-d") 'eshell-send-eof-to-process)))

; http://www.emacswiki.org/cgi-bin/wiki?EmacsCodeBrowser compile window

(defun eshell-send-eof-to-process ()
  "Send EOF to process."
  (interactive)
  (eshell-send-input nil nil t)
  (eshell-process-interact 'process-send-eof))

(defun setup-1 ()
  (interactive)
  (delete-other-windows)
  (switch-to-buffer "*scratch*")
  (next-regular-buffer-or-scratch))

(defun setup-2 ()
  (interactive)
  (setup-1)
  (split-window-horizontally)
  (windmove-right)
  (my-term)
  (windmove-left))

(defun setup-3 ()
  (interactive)
  (setup-2)
  (windmove-right)
  (split-window-vertically)
  (windmove-down)
  (ielm)
  (windmove-left))

(defun toggle-fullscreen (&optional f)
  (interactive)
  (let ((current-value (frame-parameter nil 'fullscreen)))
    (set-frame-parameter nil 'fullscreen
			 (if (equal 'fullboth current-value)
			     (if (boundp 'old-fullscreen) old-fullscreen nil)
			   (progn (setq old-fullscreen current-value)
				  'fullboth)))))

(defun maximize (&optional f)
       (interactive)
       (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
	    		 '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
       (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
	    		 '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0)))
  

(global-set-key [f11] 'toggle-fullscreen)

;(maximize)

(require 'auto-complete-config)
(require 'auto-complete-clang)

(setq ac-auto-start nil)
(setq ac-quick-help-delay 0.5)
(ac-set-trigger-key "TAB")
;;(define-key ac-mode-map  [(control tab)] 'auto-complete)
(defun my-ac-config ()
  (setq-default ac-sources '(ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))
  (add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)
  ;; (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
  (add-hook 'ruby-mode-hook 'ac-ruby-mode-setup)
  (add-hook 'css-mode-hook 'ac-css-mode-setup)
  (add-hook 'auto-complete-mode-hook 'ac-common-setup)
  (global-auto-complete-mode t))
(defun my-ac-cc-mode-setup ()
  (setq ac-sources (append '(ac-source-clang ac-source-yasnippet) ac-sources)))
(add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)
;; ac-source-gtags
(my-ac-config)

(setq yas/prompt-functions '(yas/x-prompt))

;; Originally from stevey, adapted to support moving to a new directory.
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive
   (progn
     (if (not (buffer-file-name))
         (error "Buffer '%s' is not visiting a file!" (buffer-name)))
     (list (read-file-name (format "Rename %s to: " (file-name-nondirectory
                                                     (buffer-file-name)))))))
  (if (equal new-name "")
      (error "Aborted rename"))
  (setq new-name (if (file-directory-p new-name)
                     (expand-file-name (file-name-nondirectory
                                        (buffer-file-name))
                                       new-name)
                   (expand-file-name new-name)))
  ;; If the file isn't saved yet, skip the file rename, but still update the
  ;; buffer name and visited file.
  (if (file-exists-p (buffer-file-name))
      (rename-file (buffer-file-name) new-name 1))
  (let ((was-modified (buffer-modified-p)))
    ;; This also renames the buffer, and works with uniquify
    (set-visited-file-name new-name)
    (if was-modified
        (save-buffer)
      ;; Clear buffer-modified flag caused by set-visited-file-name
      (set-buffer-modified-p nil))
  (message "Renamed to %s." new-name)))


(setq scroll-step           1
scroll-conservatively 10000)

(setq graphviz-dot-view-command "xdot %s")

;(require 'smooth-scroll)
;(smooth-scroll-mode t)