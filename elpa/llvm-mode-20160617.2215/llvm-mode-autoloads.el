;;; llvm-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "llvm-mode" "llvm-mode.el" (22376 42364 90838
;;;;;;  319000))
;;; Generated autoloads from llvm-mode.el

(autoload 'llvm-mode "llvm-mode" "\
Major mode for editing LLVM source files.
\\{llvm-mode-map}
  Runs `llvm-mode-hook' on startup.

\(fn)" t nil)

(add-to-list 'auto-mode-alist (cons (purecopy "\\.ll\\'") 'llvm-mode))

;;;***

;;;### (autoloads nil "tablegen-mode" "tablegen-mode.el" (22376 42363
;;;;;;  990836 896000))
;;; Generated autoloads from tablegen-mode.el

(autoload 'tablegen-mode "tablegen-mode" "\
Major mode for editing TableGen description files.
\\{tablegen-mode-map}
  Runs `tablegen-mode-hook' on startup.

\(fn)" t nil)

(add-to-list 'auto-mode-alist (cons (purecopy "\\.td\\'") 'tablegen-mode))

;;;***

;;;### (autoloads nil nil ("llvm-mode-pkg.el") (22376 42364 448444
;;;;;;  532000))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; llvm-mode-autoloads.el ends here
