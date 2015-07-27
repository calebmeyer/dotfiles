(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("bdaab014ec6785f64b72efbea80808b762d8971247aacf2ffc6b76a39b9ed97c" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(defconst my-home-directory (concat (getenv "HOME") "/"))
(defconst dot-emacs (concat my-home-directory ".emacs.d/init.el"))
(defconst keymaps-file (concat my-home-directory ".emacs.d/my-keymaps.el"))
(defconst functions-file (concat my-home-directory ".emacs.d/my-functions.el"))

(require 'bytecomp)
(setq compiled-dot-emacs (byte-compile-dest-file dot-emacs))

(if (or (not (file-exists-p compiled-dot-emacs))
    (file-newer-than-file-p dot-emacs compiled-dot-emacs)
        (equal (nth 4 (file-attributes dot-emacs)) (list 0 0)))
    (load dot-emacs)
  (load compiled-dot-emacs))

(add-hook 'kill-emacs-hook
          '(lambda () (and (or
                            (file-newer-than-file-p dot-emacs compiled-dot-emacs)
                            (file-newer-than-file-p keymaps-file compiled-dot-emacs)
                            (file-newer-than-file-p functions-file compiled-dot-emacs))
                           (byte-compile-file dot-emacs))))

