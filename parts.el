;;tide
(el-get-bundle tide)
(add-hook 'typescript-mode-hook
          (lambda ()
            (tide-setup)
            (flycheck-mode t)
            (setq flycheck-check-syntax-automatically '(save mode-enabled))
            (eldoc-mode t)
            (company-mode-on)))

;;web-mode
(el-get-bundle web-mode)
;########################################
; web-mode setting
;########################################
(require 'web-mode)

(add-to-list 'auto-mode-alist '("\\.jsp$"       . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?$"     . web-mode))

(defun web-mode-hook ()
  "Hooks for Web mode."

  ;; indent
  (setq web-mode-html-offset   2)
  (setq web-mode-style-padding 2)
  (setq web-mode-css-offset    2)
  (setq web-mode-script-offset 2)
  (setq web-mode-java-offset   2)
  (setq web-mode-asp-offset    2)

  (local-set-key (kbd "C-m") 'newline-and-indent)
  
  ;; auto tag closing
  ;0=no auto-closing
  ;1=auto-close with </
  ;2=auto-close with > and </
  (setq web-mode-tag-auto-close-style 2)
)
(add-hook 'web-mode-hook 'web-mode-hook)
  
;;js2-mode
(el-get-bundle js2-mode)
;;;js2-modeの設定
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;;company-ternインストール
(el-get-bundle company-tern)
(require 'company-tern)

(add-to-list 'company-backends 'company-tern)
(add-hook 'js2-mode-hook (lambda ()
                           (tern-mode)
                           (company-mode-on)))

;;ensime
(el-get-bundle ensime)

;;typescript-mode
(el-get-bundle typescript-mode)
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))

;;cc-mode
(require 'cc-mode)
;; c-mode-common-hook は C/C++ の設定
(add-hook 'c-mode-common-hook
          (lambda ()
            (setq c-default-style "k&r") ;; カーニハン・リッチースタイル
            (setq indent-tabs-mode nil)  ;; タブは利用しない
            (setq c-basic-offset 2)      ;; indent は 2 スペース
            ))
(add-hook 'c-mode-common-hook 'flycheck-mode)

;;irony
(el-get-bundle irony-mode)
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (irony company))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;;20171101 >>

;; neotree をインストールする
(el-get-bundle neotree)
;; F8でnetreee-windowが開くようにする
(global-set-key [f8] 'neotree-toggle)

;;company
(el-get-bundle company)
(require 'company)
;;; C-n, C-pで補完候補を選べるように
(define-key company-active-map (kbd "M-n") nil)
(define-key company-active-map (kbd "M-p") nil)
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
;;; C-hがデフォルトでドキュメント表示にmapされているので、文字を消せるようにmapを外す
(define-key company-active-map (kbd "C-h") nil)
;;; ドキュメント表示
(define-key company-active-map (kbd "M-d") 'company-show-doc-buffer)

(setq company-minimum-prefix-length 1) ;; 1文字入力で補完されるように
 ;;; 候補の一番上でselect-previousしたら一番下に、一番下でselect-nextしたら一番上に行くように
(setq company-selection-wrap-around t)

;; TABで候補を設定
(define-key company-active-map (kbd "C-i") 'company-complete-selection)
;;色の設定
(set-face-attribute 'company-tooltip nil
                    :foreground "black" :background "lightgrey")
(set-face-attribute 'company-tooltip-common nil
                    :foreground "black" :background "lightgrey")
(set-face-attribute 'company-tooltip-common-selection nil
                    :foreground "white" :background "steelblue")
(set-face-attribute 'company-tooltip-selection nil
                    :foreground "black" :background "steelblue")
(set-face-attribute 'company-preview-common nil
                    :background nil :foreground "lightgrey" :underline t)
(set-face-attribute 'company-scrollbar-fg nil
                    :background "orange")
(set-face-attribute 'company-scrollbar-bg nil
                    :background "gray40")
;;fly-check
(el-get-bundle flycheck)

;;PlantUML設定
(el-get-bundle plantuml-mode)
;; plantuml.jar の path を設定
(setq org-plantuml-jar-path "~/.emacs.d/plantuml.jar")
(add-to-list 'auto-mode-alist '("\\.puml\\'" . plantuml-mode))
(add-to-list 'auto-mode-alist '("\\.plantuml\\'" . plantuml-mode))

;;ensime
(el-get-bundle ensime)
(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
(setq ensime-startup-notification nil)
