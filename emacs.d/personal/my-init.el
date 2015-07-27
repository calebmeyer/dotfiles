;; Make home and end do what you expect
(global-set-key [home] 'beginning-of-line)
(global-set-key [end] 'end-of-line)

;; Maximize
(toggle-frame-maximized)

;; Always show line numbers
(setq linum-format "%4d |")
(linum-mode)

