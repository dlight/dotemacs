;; idea: check out this config
;; http://aaronbedra.com/emacs.d/

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

;; my things

;; i join bindings with some stuff because the bindings depend on
;; those stuff and I don't want to create an implicit dependency
;; between files

(load "~/.emacs.d/bindings.el")

;;;;(load "~/.emacs.d/chromium.el")

;; other stuff?

; https://emacs.stackexchange.com/questions/5939/how-to-disable-auto-indentation-of-new-lines

(when (fboundp 'electric-indent-mode) (electric-indent-mode -1))

(electric-pair-mode)


;(require 'which-key)
(which-key-mode)

;;
;;

; https://www.masteringemacs.org/article/disabling-prompts-emacs

(fset 'yes-or-no-p 'y-or-n-p)
(setq confirm-nonexistent-file-or-buffer nil)

;(setq ido-create-new-buffer 'always) ??



;; https://stackoverflow.com/questions/5138110/emacs-create-new-file-with-ido-enabled

;; https://stackoverflow.com/questions/16121151/any-way-to-make-ido-find-file-switch-to-another-recently-opened-file-if-there-is

;; (setq ido-auto-merge-work-directories-length -1)

;(defun ido-my-keys ()
;  "Add my keybindings for ido."
;  (define-key ido-completion-map (kbd "M-<return>")
;    'ido-invoke-in-vertical-split)
;  (define-key ido-completion-map (kbd "C-z")
;    'ido-undo-merge-work-directory)
;)

;(add-hook 'ido-setup-hook 'ido-my-keys)

(setq ido-enable-flex-matching t
      ido-use-virtual-buffers t
      ido-create-new-buffer 'always
      ido-auto-merge-work-directories-length -1
)

(ido-mode t)


;(autopair-global-mode)


;(setq kill-buffer-query-functions nil)
;(setq kill-emacs-query-function nil)

;(setq kill-buffer-query-functions
;  (remq 'process-kill-buffer-query-function
;         kill-buffer-query-functions))


;(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)

;;; maximized


(add-to-list 'default-frame-alist '(fullscreen . maximized))

;;;
;;;
;;;;

; uh?
   (setq system-uses-terminfo nil)
; ..?

;(setq linum-format "%d ")
(global-linum-mode t)


(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(column-number-mode t)

(add-hook 'after-init-hook 'global-company-mode)

(setq inhibit-splash-screen t)
(setq compile-command "make")
      ;c-default-style "k&r"
      ;c-basic-offset 4


(setq-default line-spacing 1)


;;; whitespace

; so funciona no *scratch* :/
(setq-default show-trailing-whitespace t)

(require 'whitespace)
(setq-default whitespace-style '(face trailing))
(global-whitespace-mode 1)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;;

(setq process-query-on-exit-flag t)

(setq compilation-always-kill t)
(setq compilation-scroll-output t)
(setq compilation-auto-jump-to-first-error t)


;; temporary windows

;(require 'popwin)
;(popwin-mode 1)

; :position

; The value must be one of (left top right bottom). The popup window
; will shown at the position of the frame. If no position specified,
; popwin:popup-window-position will be used.


; consider using shackle
; https://github.com/wasamasa/shackle

; <EliasAmaral> how can I set where the "side" window (with *compilation*, *Help*, etc) opens?
; <EliasAmaral> if there's only one window, it used to open in the bottom by default. it now opens in the right side. I'm not sure what caused this change
; <YoungFrog> did you get a bigger screen recently ?
; <EliasAmaral> no, not really
; <YoungFrog> EliasAmaral: split-height-threshold and split-width-threshold might help.
; <EliasAmaral> I did change the font size
; <EliasAmaral> to a smaller font so more text would fit
; <EliasAmaral> I think compilation-mode has its own config though
; <EliasAmaral> apart from what emacs does by default
; <wasamasa> I doubt it has
; <wasamasa> (setq outwin (display-buffer outbuf '(nil (allow-no-window . t))))
; <YoungFrog> my guess is that it was an excerpt from compilation-mode
; wasamasa> indeed
; EliasAmaral> I think that installing popwin made the compilation window appear on the bottom
; <EliasAmaral> actually I'm not sure popwin works correctly here
; <wasamasa> yes, popwin does that by default
; * wasamasa eventually got annoyed enough with popwin to write a less buggy replacement
; <EliasAmaral> is your less buggy thing on melpa or something?
; <wasamasa> ,shackle
; <EliasAmaral> Oh, the buffers/modes that popwin applies are defined in popwin:special-display-config
; <EliasAmaral> it doesn't automatically appear for all "temporary" buffers
; <EliasAmaral> so popwin puts the ones it knows in the bottom, and others appears in the side because of the thresholds

;; fold


(require 'fold-dwim)

(add-hook 'prog-mode-hook #'hs-minor-mode)

;; magit.. ahn

(add-hook 'magit-status-mode-hook #'magit-filenotify-mode)

;;-- config

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#454545" "#cd5542" "#6aaf50" "#baba36" "#5180b3" "#ab75c3" "#68a5e9" "#bdbdb3"])
 '(company-ghc-show-info t)
 '(company-idle-delay nil)
 '(global-company-mode t)
 '(package-selected-packages
   (quote
    (elm-mode which-key psc-ide dracula-theme flatland-black-theme flatland-theme foggy-night-theme company-ghc company-ghci ghc labburn-theme zenburn-theme company flycheck icicles undo-tree web-mode fsharp-mode google google-maps glsl-mode markdown-mode markdown-mode+ mmm-mode flycheck-rust racer rust-mode rustfmt twilight-bright-theme tangotango-theme sublime-themes smex psci popwin naquadah-theme multi-term magit-filenotify load-theme-buffer-local llvm-mode hi2 hc-zenburn-theme green-phosphor-theme ghc-imported-from fold-dwim fill-column-indicator cycle-themes company-racer color-theme-solarized color-theme-sanityinc-tomorrow coffee-mode clues-theme cherry-blossom-theme calmer-forest-theme busybee-theme bubbleberry-theme boron-theme bliss-theme basic-theme autumn-light-theme auctex apropospriate-theme anti-zenburn-theme android-mode ample-zen-theme ample-theme alect-themes ahungry-theme afternoon-theme ac-js2 ac-html-bootstrap ac-html ac-haskell-process)))
 '(require-final-newline t))

;; theme

(load "~/.emacs.d/theme.el")

;;
;; indentation

(setq tab-width 4
      indent-tabs-mode nil)

;;;;;;;;
;;;;;;;;

;;;;;;;; platforms

;;;
;;; android

(require 'android-mode)
(setq android-mode-sdk-dir "/opt/android-sdk")


;;;;;;;; programming languages

;;;
;;; glsl

(autoload 'glsl-mode "glsl-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.frag\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.vert\\'" . glsl-mode))

;;;
;;; web
;;;

(load "~/.emacs.d/web.el")

;;;
;;; javascript (js-mode)

(setq js-indent-level 2)

;;;
;;; coffeescript

(setq coffee-tab-width 2)

;;;
;;; haskell

(load "~/.emacs.d/haskell.el")

;;;
;;; purescript

(add-hook 'purescript-mode-hook 'turn-on-purescript-indentation)

;;;
;;; rust

(load "~/.emacs.d/rust.el")

;;;
;;; tex

(setq reftex-plug-into-AUCTeX t)

(add-hook 'reftex-mode-hook 'imenu-add-menubar-index)


;;qq


;;;;;;;;;;;;;; fill-column mode must be the last?
;;;;;;;;;;;;;; nope

(require 'fill-column-indicator)
(define-globalized-minor-mode global-fci-mode
  fci-mode (lambda ()
             (when (not (memq major-mode
                              (list 'web-mode)))
               (fci-mode 1))))


(global-fci-mode 1)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil)))))
