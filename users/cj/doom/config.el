;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq inhibit-startup-screen t)

(setq user-full-name "Carlos José Ruiz-Henestrosa Ruiz"
      user-mail-address "ruizh.cj@gmail.com")

(setq doom-font (font-spec :family "Fira Code" :size 16))

(setq doom-theme 'doom-dracula)

(setq org-directory "~/org/")

(after! org
  (setq org-agenda-start-on-weekday 1)
  (setq calendar-week-start-day 1)
  (add-to-list 'org-latex-packages-alist '("AUTO" "babel"       t ("pdflatex")))
  (add-to-list 'org-latex-packages-alist '("AUTO" "polyglossia" t ("xelatex" "lualatex"))))

(use-package! org-noter
  :after (:any org pdf-view)
  :config
  (setq
   org-noter-notes-window-location 'other-frame
   org-noter-always-create-frame nil
   org-noter-hide-other nil
   org-noter-notes-search-path (list "/home/cj/org/notes/")))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

(after! latex

  (setq-hook! 'plain-tex-mode-hook
    TeX-electric-math (cons "$" ""))
  (setq-hook! 'LaTeX-mode-hook
    TeX-electric-math (cons "\\(" ""))

  (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

  (add-hook! 'LaTeX-math-mode-hook
    (define-key LaTeX-math-mode-map
      (LaTeX-math-abbrev-prefix) t)                  ; Unbind "`"
    (set-default 'LaTeX-math-abbrev-prefix "ç")      ; Set "ç" as new prefix
    (define-key LaTeX-math-mode-map
      (LaTeX-math-abbrev-prefix) LaTeX-math-keymap)) ; Bind "ç"

)

(after! conda
  (setq conda-anaconda-home "~/.conda"))

;; (after! python
;;   (setq python-shell-interpreter "ipython"))

(after! hideshow
  (add-to-list 'hs-special-modes-alist
               '(conf-mode "{{{" "}}}" "\"")))

(when (eq window-system 'pgtk)
  (pgtk-use-im-context t))

(after! ess-r-mode
  (appendq! +pretty-code-symbols
            '(:assign "⟵"
              :multiply "×"))
  (set-pretty-symbols! 'ess-r-mode
    ;; Functional
    :def "function"
    ;; Types
    :null "NULL"
    :true "TRUE"
    :false "FALSE"
    :int "int"
    :float "float"
    :bool "bool"
    ;; Flow
    :not "!"
    :and "&&" :or "||"
    :for "for"
    :in "%in%"
    :return "return"
    ;; Other
    :assign "<-"
    :multiply "%*%"))

(after! mu4e
  (setq mu4e-view-use-gnus t)
  ;; Each path is relative to `+mu4e-mu4e-mail-path', which is ~/.mail by default
  (set-email-account! "GMail"
    '((mu4e-sent-folder       . "/gmail/[Gmail]/Enviados")
      (mu4e-drafts-folder     . "/gmail/[Gmail]/Borradores")
      (mu4e-trash-folder      . "/gmail/[Gmail]/Papelera")
      (mu4e-refile-folder     . "/gmail/[Gmail]/Todos")
      (smtpmail-smtp-user     . "ruizh.cj@gmail.com")
      (mu4e-compose-signature . "--\nCarlos José Ruiz-Henestrosa Ruiz")) t))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values '((TeX-engine . xelatex))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
