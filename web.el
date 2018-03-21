(require 'web-mode)

(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))

(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 4)
  (setq-default indent-tabs-mode nil)
  (define-key web-mode-map (kbd "C-n") 'web-mode-tag-match)
  ;(setq web-mode-enable-current-element-highlight t)
  (setq web-mode-enable-current-column-highlight t)
  (setq web-mode-ac-sources-alist
	'(("css" . (ac-source-css-property))
	  ("html" . (ac-source-words-in-buffer ac-source-abbrev))))
)

(add-hook 'web-mode-hook  'my-web-mode-hook)
