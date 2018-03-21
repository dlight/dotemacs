;;; run command at save (will move to another file?)


;(add-hook
; 'after-save-hook
					; 'reload-extension)

(defun string/starts-with (string prefix)
  "Return t if STRING starts with prefix."
  (and (string-match (rx-to-string `(: bos ,prefix) t)
		     string)
       t))

(defun reload-extension ()
  (interactive)
  (let ((default-directory "/x/code/nuevo/"))
    (shell-command "echo $PWD && make && chromium http://reload.extensions")))

;  (if (string/starts-with (file-name-directory (buffer-file-name))
;			  "/x/code/nuevo/chrome")
;      ; (equal "/x/code/nuevo/chrome/" (file-name-directory (buffer-file-name)))
					;      (shell-command "make && chromium http://reload.extensions")))

;(global-set-key (read-kbd-macro "s-'") #'reload-extension)
