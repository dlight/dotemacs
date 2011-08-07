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

(delete-selection-mode t)

(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

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

(keys '("C-z" undo
	"C-y" clipboard-yank
	"C-w" clipboard-kill-region
	"C-c <C-left>" winner-undo
	"C-c <C-right>" winner-redo
	"C-x C-b" buffer-menu
	"M-w" clipboard-kill-ring-save
	"<C-tab>" switch-to-previous-buffer
	"s-q" recompile
	"s-c" compile
	"s-a" previous-error
	"s-s" next-error
	"s-e" my-term
	"s-w" ido-switch-buffer
	"s-1" setup-1
	"s-2" setup-2
	"s-3" setup-3
	"s-g" egg-status
	"<s-left>" my-previous-buffer
	"<s-right>" my-next-buffer
	"<s-up>" next-regular-buffer
	"<s-down>" previous-star-buffer
	"<M-left>" windmove-left
	"<M-right>" windmove-right
	"<M-up>" windmove-up
	"<M-down>" windmove-down))

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
  

(global-set-key [f11] 'toggle-fullscreen)
