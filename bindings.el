;;; dependencies

(require 'multi-term)
(require 'windmove)
(require 'icicles)

;;

(require 'undo-tree)
(global-undo-tree-mode 1)

;; cua / selection stuff

(delete-selection-mode t)

(cua-mode t)
(setq cua-auto-tabify-rectangles nil)
(setq cua-keep-region-after-copy t)

;;;

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


(defun keys (a)
  (when a
    (global-set-key (read-kbd-macro (nth 0 a)) (nth 1 a))
    (keys (cddr a))))

(setq compilation-only-one-window nil)

(setq compilation-exit t)
(setq compilation-run-special nil)
(setq compilation-build-special nil)

(defun my-compile (&rest s)
  (interactive)
  (setq compilation-only-one-window (eq 1 (length (window-list))))
  (if (eq 0 (length s))
      (call-interactively 'compile)
    (apply 'compile s)))

(defun my-recompile ()
  (interactive)
  (setq compilation-only-one-window (eq 1 (length (window-list))))
  (recompile)
  (if (eq major-mode 'graphviz-dot-mode)
      (graphviz-dot-preview)))


(defun toggle-close-compile-on-exit ()
  (interactive)
  (setq compilation-exit (not compilation-exit))
  (message "Will a successful compile close on exit? %s"
	   compilation-exit))

(defun my-cargo-run ()
  (interactive)
  (setq compilation-run-special t)
  (my-compile "cargo run"))

(defun my-cargo-build ()
  (interactive)
  (setq compilation-build-special t)
  (my-compile "cargo build"))



(setq compilation-exit-message-function
      (lambda (status code msg)
	;; If M-x compile exists with a 0
	(when (and (not compilation-run-special) (or compilation-exit compilation-build-special) (eq status 'exit) (zerop code))
	  ;;

  	  (bury-buffer "*compilation*")
  	  ;; and return to whatever were looking at before

	  (if compilation-only-one-window
	      (delete-window (get-buffer-window (get-buffer "*compilation*")))
	    (replace-buffer-in-windows "*compilation*")))
	(setq compilation-only-one-window nil)
	(setq compilation-run-special nil)
	(setq compilation-build-special nil)
	;; Always return the anticipated result of compilation-exit-message-function
  	(cons msg code)))

(defun touch-r-restart ()
  (interactive)
  (shell-command-to-string "touch /r/restart")
  (message "/r restarted"))

(define-key isearch-mode-map "\C-f" 'isearch-repeat-forward)

(global-set-key [f11] 'toggle-fullscreen)

(keys '(;"[f11]" 'toggle-fullscreen
        ;"s-1" touch-r-restart
        "C-z" undo
        "C-y" redo
        "C-S-z" redo

	"C-x C-a" delete-frame

        ;; http://ergoemacs.org/emacs/emacs_make_modern.html
        ;; http://ergoemacs.org/features.html

        ;"C-w" kill-buffer-now

        "C-w" backward-kill-word

	"C-x t" restart-emacs


        ;"C-o" find-file

        "C-f" isearch-forward
        "C-s" save-buffer
        "C-S-s" write-file
        "C-a" mark-whole-buffer


	; http://aaronbedra.com/emacs.d/#key-bindings

	;"RET" newline-and-indent
	"C-;" comment-or-uncomment-region


	;"C-y" clipboard-yank
	;"C-w" clipboard-kill-region

	"<menu>" company-complete

	"M-x" smex
	"M-X" smex-major-mode-commands

	"C-c <C-left>" winner-undo
	"C-c <C-right>" winner-redo
	"C-x C-b" buffer-menu
	"M-w" clipboard-kill-ring-save
	"s-<tab>" switch-to-previous-buffer
	"s-x" my-recompile
	"s-M-q" toggle-close-compile-on-exit
	"s-b" my-compile
	"s-q" my-cargo-run
	"s-w" my-cargo-build
	"s-a" previous-error
	"s-s" next-error
	"s-e" my-term
	;"s-'" ido-switch-buffer ;icicles-buffer
	"C-x b" ido-switch-buffer
	"s-o 1" setup-1
	"s-o 2" setup-2
	"s-o 3" setup-3
	;"s-g" egg-status
	"s-g" magit-status
	"s-v" hs-toggle-hiding
	;"s-g" hs-show-block
	;"s-h" hs-hide-block
	;"s-j" hs-show-all
	;"s-k" hs-hide-all
	"s-r" goto-line

	"<C-tab>" switch-to-previous-buffer
	"<kp-decimal>" switch-to-previous-buffer

	"<kp-left>" my-previous-buffer
	"<kp-right>" my-next-buffer
	"<kp-begin>" next-regular-buffer
	"<kp-down>" previous-star-buffer
	"<kp-home>" windmove-left
	"<kp-prior>" windmove-right
	"<kp-divide>"  windmove-up
	"<kp-up>" windmove-down

	"<s-left>" my-previous-buffer
	"<s-right>" my-next-buffer
	"<s-up>" next-regular-buffer
	"<s-down>" previous-star-buffer
	"<M-left>" windmove-left
	"<M-right>" windmove-right
	"<M-up>"  windmove-up
	"<M-down>" windmove-down



	"<M-home>" windmove-left
	"<M-end>" windmove-right



	"<mouse-8>" my-previous-buffer
	"<mouse-9>" my-next-buffer

	"s-f 1" fold-dwim-hide-all
	"s-f 2" fold-dwim-show-all
	"s-SPC" fold-dwim-toggle
	"M-Q" unfill-paragraph
))

(defun restart-emacs ()
  (interactive)
  (shell-command "~/bin/restart-emacs"))

(defun kill-buffer-now ()
  (interactive)
  (let (kill-buffer-query-functions) (kill-buffer)))

;(defun my-term ()
; (interactive)
;  (let ((b (get-buffer "*terminal<1>*")))
;    (if b (switch-to-buffer b)
;      (multi-term))))

(defun last-term-buffer (l)
  "Return most recently used term buffer."
  (when l
    (if (eq 'term-mode (with-current-buffer (car l) major-mode))
        (car l) (last-term-buffer (cdr l)))))

(defun my-term ()
  "Switch to the term buffer last used, or create a new one if
    none exists, or if the current buffer is already a term."
  (interactive)
  (let ((b (last-term-buffer (buffer-list))))
    (if (or (not b) (eq 'term-mode major-mode))
        (multi-term)
      (switch-to-buffer b))))

;(add-hook 'multi-term (lambda () (setq-local show-trailing-whitespace nil)))


;(add-hook 'multi-term (lambda () (custom-set-variables '(show-trailing-whitespace nil))))

(add-hook 'term-mode-hook (lambda () (setq show-trailing-whitespace  nil)))


(defun switch-to-previous-buffer ()
  (interactive)
  (switch-to-buffer (other-buffer)))

(defun matching-buffer ()
  ;(string-match "^\\*.*\\*$" (buffer-name)))
  (string-match "^\\*.*$" (buffer-name)))

(defun my-next-buffer ()
  (interactive)
  (if (matching-buffer)
      (next-star-buffer)
    (next-regular-buffer)))

(defun my-previous-buffer ()
  (interactive)
  (if (matching-buffer)
      (previous-star-buffer)
    (previous-regular-buffer)))

(defun next-regular-buffer ()
  (interactive)
  (next-buffer)
  (if (matching-buffer)
      (next-regular-buffer)))

(defun next-regular-buffer-or-scratch ()
  (interactive)
  (next-buffer)
  (if (and (matching-buffer)
	  (not (equal "*scratch*" (buffer-name))))
      (next-regular-buffer-or-scratch)))

(defun previous-regular-buffer ()
  (interactive)
  (previous-buffer)
  (if (matching-buffer)
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
  (if (or (not (matching-buffer))
	  (bad-buffer (buffer-name)))
      (next-star-buffer)))

(defun previous-star-buffer ()
  (interactive)
  (previous-buffer)
  (if (or (not (matching-buffer))
	  (bad-buffer (buffer-name)))
      (previous-star-buffer)))


(defun unfill-paragraph (&optional region)
  "Takes a multi-line paragraph and makes it into a single line of text."
  (interactive (progn (barf-if-buffer-read-only) '(t)))
  (let ((fill-column (point-max)))
    (fill-paragraph nil region)))
