;(require 'racer)
;(setq racer-cmd "~/.cargo/bin/racer")
;(setq racer-rust-src-path "/usr/src/rust")
(eval-after-load "rust-mode" '(require 'racer))

(add-hook 'rust-mode-hook #'my-rust-mode-hook)

(add-hook 'racer-mode-hook #'eldoc-mode)

(defun my-rust-mode-hook ()
  (interactive)
  (flycheck-mode)
  (setq fill-column 100)
  ;(load-theme-buffer-local 'ritchie (current-buffer))
  (setq compile-command "cargo build")


  (racer-activate)
  (set (make-local-variable 'company-backends) '(company-racer))
  (setq company-tooltip-align-annotations t)
  (local-set-key (kbd "M-.") #'racer-find-definition)
  (local-set-key (kbd "s-/") #'company-complete)
)

(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)

(require 'mmm-mode)
(setq mmm-global-mode 'maybe)

(defun my-mmm-markdown-auto-class (lang &optional submode)
  "Define a mmm-mode class for LANG in `markdown-mode' using SUBMODE.
If SUBMODE is not provided, use `LANG-mode' by default."
  (let ((class (intern (concat "markdown-" lang)))
        (submode (or submode (intern (concat lang "-mode"))))
        (front (concat "^```" lang "[\n\r]+"))
        (back "^```"))
    (mmm-add-classes (list (list class :submode submode :front front :back back)))
    (mmm-add-mode-ext-class 'markdown-mode nil class)))

(my-mmm-markdown-auto-class "rust")

(setq mmm-parse-when-idle 't)
