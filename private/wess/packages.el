;;; packages.el --- ESS (R) Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(setq wess-packages
  '(
    ess
    ess-R-data-view
    ess-smart-equals
    org
    polymode
    ))

(defun wess/init-ess ()
  (use-package ess-site
    :mode (("\\.sp\\'"           . S-mode)
           ("/R/.*\\.q\\'"       . R-mode)
           ("\\.[qsS]\\'"        . S-mode)
           ("\\.ssc\\'"          . S-mode)
           ("\\.SSC\\'"          . S-mode)
           ("\\.[rR]\\'"         . R-mode)
           ("\\.[rR]md\\'"       . poly-rmd-mode)
           ("\\.[rsRS]nw\\'"     . poly-noweb+r-mode)
           ("\\.[rR]profile\\'"  . R-mode)
           ("NAMESPACE\\'"       . R-mode)
           ("DESCRIPTION\\'"     . R-mode)
           ("CITATION\\'"        . R-mode)
           ("README\\.md\\'"     . markdown-mode)
           ("\\.omg\\'"          . omegahat-mode)
           ("\\.hat\\'"          . omegahat-mode)
           ("\\.lsp\\'"          . XLS-mode)
           ("\\.do\\'"           . STA-mode)
           ("\\.ado\\'"          . STA-mode)
           ("\\.[Ss][Aa][Ss]\\'" . SAS-mode)
           ("\\.jl\\'"           . ess-julia-mode)
           ("\\.[Ss]t\\'"        . S-transcript-mode)
           ("\\.Sout"            . S-transcript-mode)
           ("\\.[Rr]out"         . R-transcript-mode)
           ("\\.Rd\\'"           . Rd-mode)
           ("\\.[Bb][Uu][Gg]\\'" . ess-bugs-mode)
           ("\\.[Bb][Oo][Gg]\\'" . ess-bugs-mode)
           ("\\.[Bb][Mm][Dd]\\'" . ess-bugs-mode)
           ("\\.[Jj][Aa][Gg]\\'" . ess-jags-mode)
           ("\\.[Jj][Oo][Gg]\\'" . ess-jags-mode)
           ("\\.[Jj][Mm][Dd]\\'" . ess-jags-mode))
    :commands (R stata julia SAS)
    :init
    (progn
      (spacemacs/register-repl 'ess-site 'julia)
      (spacemacs/register-repl 'ess-site 'R)
      (spacemacs/register-repl 'ess-site 'SAS)
      (spacemacs/register-repl 'ess-site 'stata)
      ;; Explicitly run prog-mode hooks since ess-mode does not derive from
      ;; prog-mode major-mode
      (add-hook 'ess-mode-hook 'spacemacs/run-prog-mode-hooks)
      (when (configuration-layer/package-usedp 'company)
          (add-hook 'ess-mode-hook 'company-mode))))

  ;; R --------------------------------------------------------------------------
  (setq spacemacs/ess-config
        '(progn
           (setq ess-first-continued-statement-offset 2
                 ess-continued-statement-offset 0
                 ess-expression-offset 2
                 ess-nuke-trailing-whitespace-p t
                 ess-default-style 'RStudio
                 ansi-color-for-comint-mode 'filter
                 comint-scroll-to-bottom-on-input t
                 comint-scroll-to-bottom-on-output t
                 comint-move-point-for-output t
                 ess-execute-in-process-buffer t
                 ess-eval-visibly-p 'nowait
                 ess-toggle-S-assign nil)
           (ess-toggle-underscore nil)
           (defun spacemacs/ess-start-repl ()
             "Start a REPL corresponding to the ess-language of the current buffer."
             (interactive)
             (cond
              ((string= "S" ess-language) (call-interactively 'R))
              ((string= "STA" ess-language) (call-interactively 'stata))
              ((string= "SAS" ess-language) (call-interactively 'SAS))))

           (spacemacs/set-leader-keys-for-major-mode 'ess-julia-mode
             "'"  'julia
             "si" 'julia)
           (spacemacs/declare-prefix-for-mode 'ess-mode "mh" "help")
           (spacemacs/set-leader-keys-for-major-mode 'ess-mode
             "ha" 'ess-display-help-apropos
             "hh" 'ess-display-help-on-object
             "he" 'ess-describe-object-at-point
             "hi" 'ess-display-package-index
             "hm" 'ess-manual-lookup
             "ho" 'ess-display-demos
             "hr" 'ess-reference-lookup
             "hv" 'ess-display-vignettes
             "hw" 'ess-help-web-search
             )
           (spacemacs/declare-prefix-for-mode 'ess-mode "me" "eval")
           (spacemacs/set-leader-keys-for-major-mode 'ess-mode
             "eb" 'ess-eval-buffer
             "eB" 'ess-load-file
             "ec" 'ess-eval-chunk-and-step
             "eC" 'ess-eval-chunk
             "ee" 'ess-eval-region-or-function-or-paragraph-and-step
             "ef" 'ess-eval-function-or-paragraph-and-step
             "eF" 'ess-eval-function-or-paragraph
             "eh" 'ess-eval-buffer-from-beg-to-here
             "eH" 'ess-eval-buffer-from-here-to-end
             "el" 'ess-eval-line-and-step
             "eL" 'ess-eval-line
             "ep" 'ess-eval-paragraph
             "eP" 'ess-eval-paragraph-and-step
             "er" 'ess-eval-region-or-line-and-step
             "eR" 'ess-eval-region
             "et" 'ess-eval-thread
             )
           (spacemacs/declare-prefix-for-mode 'ess-mode "mb" "build")
           (spacemacs/declare-prefix-for-mode 'ess-mode "mp" "package")
           (spacemacs/declare-prefix-for-mode 'ess-mode "mt" "test")
           (spacemacs/set-leader-keys-for-minor-mode 'ess-r-package-mode
             "bb" 'ess-r-devtools-build
             "bd" 'ess-r-devtools-document-package
             "be" 'ess-r-devtools-execute-command
             "bi" 'ess-r-devtools-install-package
             "pi" 'ess-r-devtools-install-package
             "pl" 'ess-r-devtools-load-package
             "pu" 'ess-r-devtools-unload-package
             "pg" 'ess-r-devtools-install-github
             "tc" 'ess-r-devtools-check-package
             "tw" 'ess-r-devtools-check-with-winbuilder
             "th" 'ess-r-rhub-check-package
             "tt" 'ess-r-devtools-test-package
             )
           (spacemacs/declare-prefix-for-mode 'ess-mode "ms" "session")
           (spacemacs/set-leader-keys-for-major-mode 'ess-mode
             "se" 'ess-execute
             "si" 'ess-install-library
             "sl" 'ess-load-library
             "sq" 'ess-quit
             "sr" 'inferior-ess-reload
             "ss" 'ess-switch-process
             "sw" 'ess-set-working-directory
             )
           ;; (spacemacs/declare-prefix-for-mode 'ess-mode "mn" "noweb")
           ;; (spacemacs/set-leader-keys-for-major-mode 'ess-mode
           ;;   "nC" 'ess-eval-chunk-and-go
           ;;   "nc" 'ess-eval-chunk
           ;;   "nd" 'ess-eval-chunk-and-step
           ;;   "nm" 'ess-noweb-mark-chunk
           ;;   "nN" 'ess-noweb-previous-chunk
           ;;   "nn" 'ess-noweb-next-chunk
           ;;   )
           (define-key ess-mode-map (kbd "<s-return>") 'ess-eval-line)
           (define-key inferior-ess-mode-map (kbd "C-j") 'comint-next-input)
           (define-key inferior-ess-mode-map (kbd "C-k") 'comint-previous-input)
           ))

  (eval-after-load "ess-r-mode" spacemacs/ess-config)
  (eval-after-load "ess-julia" spacemacs/ess-config)
  (spacemacs|define-jump-handlers ess-mode 'xref-find-definitions))

(defun wess/init-ess-R-data-view ())

(defun wess/init-ess-smart-equals ()
  (use-package ess-smart-equals
    :defer t
    :if ess-enable-smart-equals
    :init
    (progn
      (add-hook 'ess-mode-hook 'ess-smart-equals-mode)
      (add-hook 'inferior-ess-mode-hook 'ess-smart-equals-mode))))

(defun wess/init-polymode ()
  (progn
    (defun poly-rmd-mode ()
      (interactive)
      (require 'poly-R)
      (require 'poly-markdown)
      (poly-markdown+r-mode)
      (markdown-mode)
      )))


;; (defun wess/pre-init-golden-ratio ()
;;   (spacemacs|use-package-add-hook golden-ratio
;;     :post-config
;;     (dolist (f '(ess-eval-buffer-and-go
;;                  ess-eval-function-and-go
;;                  ess-eval-line-and-go))
;;       (add-to-list 'golden-ratio-extra-commands f))))

(defun wess/pre-init-org ()
  (spacemacs|use-package-add-hook org
    :post-config (add-to-list 'org-babel-load-languages '(R . t))))
