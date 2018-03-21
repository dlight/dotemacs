;(setq haskell-process-auto-import-loaded-modules t)
;(setq haskell-process-log t)
;(setq haskell-process-suggest-remove-import-lines t)
;(setq haskell-process-type (quote cabal-repl))

(setq haskell-interactive-popup-errors nil)


(require 'haskell-interactive-mode)
(require 'haskell-process)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)


(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)

(eval-after-load "company"
  '(progn
     (add-to-list 'company-backends 'company-ghc)
     (add-to-list 'company-backends 'company-ghci)))

(custom-set-variables '(company-ghc-show-info t))


(require 'hi2)

;(add-hook 'haskell-mode-hook 'turn-on-hi2)
;(add-hook 'haskell-mode-hook (lambda () (ghc-init)))

;(add-hook 'haskell-mode-hook (lambda () (ghc-init)))

;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)
;(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

(add-hook 'haskell-mode-hook 'my-haskell-mode-hook)
(defun my-haskell-mode-hook ()
  (setq ghc-report-errors nil)
  ;(haskell-indentation-mode 1)
  ;(turn-on-hi2)
  (ghc-init))

(eval-after-load 'haskell-mode '(progn
  (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
  (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
  (define-key haskell-mode-map (kbd "C-c C-n C-t") 'haskell-process-do-type)
  (define-key haskell-mode-map (kbd "C-c C-n C-i") 'haskell-process-do-info)
  (define-key haskell-mode-map (kbd "C-c C-n C-c") 'haskell-process-cabal-build)
  (define-key haskell-mode-map (kbd "C-c C-n c") 'haskell-process-cabal)))
;  (define-key haskell-mode-map (kbd "SPC") 'haskell-mode-contextual-space)))
(eval-after-load 'haskell-cabal '(progn
  (define-key haskell-cabal-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
  (define-key haskell-cabal-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
  (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
  (define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal)))
