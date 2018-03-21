(add-to-list 'default-frame-alist '(font . "Inconsolata-14"))

;; disable themes:
;; (mapcar #'disable-theme custom-enabled-themes)

(mapcar #'disable-theme custom-enabled-themes)

(setq custom-safe-themes t)

; to simplify https://github.com/jwiegley/use-package

;(require 'cycle-themes)

;(setq cycle-themes-theme-list
;      '(bliss dracula afternoon bubbleberry boron wheatgrass hc-zenburn ; dark
;	      autumn-light leuven ritchie ; light
;	      ))

;(cycle-themes-mode)

(load-theme 'dracula)

;(load-theme 'solarized)

;(load-theme 'leuven)

; list all themes
;(pp (custom-available-themes))


;(dracula flatland-black flatland foggy-night sanityinc-tomorrow-blue
;sanityinc-tomorrow-bright sanityinc-tomorrow-day
;sanityinc-tomorrow-eighties sanityinc-tomorrow-night afternoon
;ahungry alect-black-alt alect-black alect-dark-alt alect-dark
;alect-light-alt alect-light ample-flat ample-light ample ample-zen
;anti-zenburn apropospriate-dark apropospriate-light apropospriate
;autumn-light basic bliss boron bubbleberry busybee calmer-forest
;cherry-blossom clues solarized green-phosphor hc-zenburn labburn
;naquadah brin dorsey fogus graham granger hickey junio mccarthy
;odersky ritchie spolsky wilson tangotango twilight-bright zenburn
;adwaita deeper-blue dichromacy leuven light-blue manoj-dark
;misterioso tango-dark tango tsdh-dark tsdh-light wheatgrass
;whiteboard wombat)

;(load-theme 'sanityinc-tomorrow-eighties)

;(load-theme 'solarized)


;(setq cycle-themes-theme-list '(ample tangotango))

					;      '(naquadah
;	ample
;	ample-zen
;	ample-light
;	tangotango
;	sanityinc-tomorrow-eighties
;	solarized
					;	zenburn))

;(load-theme 'tangotango)

;(load-theme 'tangotango)

;(load-theme 'leuven)

@;(require 'cycle-themes)

;(load-theme 'tangotango)

;; white, good default

;(load-theme 'leuven)

;(cycle-themes-mode)
