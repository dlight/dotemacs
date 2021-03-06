Demos: see https://github.com/cute-jumper/ace-jump-helm-line

#+TITLE: ace-jump-helm-line
*Ace-jump to a candidate in helm window.*

This package makes use of the =avy-jump.el= provided in [[https://github.com/abo-abo/ace-window/][ace-window]].

* Setup
  : (add-to-list 'load-path "/path/to/ace-jump-helm-line.el")
  : (require 'ace-jump-helm-line)

  You can use the following code to bind =ace-jump-helm-line= to a key(say,
  "C-'"):
  : (eval-after-load "helm"
  : '(define-key helm-map (kbd "C-'") 'ace-jump-helm-line))


* Usage
  When in a helm session, for example, after you call =helm-M-x=, you can use
  your key binding(for example, "C-'") to invoke =ace-jump-helm-line=.

  There are two kinds of styles: avy-jump style and ace-jump-mode style. By
  default, this package uses =avy-jump= style(anyway, it uses
  =avy-jump.el=!). You can certainly change to =ace-jump-mode-style= by:
  : (setq ace-jump-helm-line-use-avy-style nil)

* Acknowledgment
  - Thank [[https://github.com/abo-abo/ace-window/][Oleh Krehel]] for the awesome [[https://github.com/abo-abo/ace-window/][ace-window]] package.
  - Thank @hick for the original idea.
