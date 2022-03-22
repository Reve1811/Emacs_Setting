;;既知の問題
;;未確定の文字をC-mで確定できない

;;~/.emacs.d/elispをロードパスに追加する
(add-to-list 'load-path "~/.emacs.d/elisp")
;; load-path を追加する関数を定義

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)

(package-initialize)

(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
              (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))

;;(add-to-load-path "elisp" "conf" "public_repos")
(add-to-load-path "elisp")

;;C-mにnewline-and-indentを割り当てる（初期値はただのnewlineなので）
(global-set-key (kbd "C-m") 'newline-and-indent)

;;DELとC-hを入れ替える
;;(keyboard-translate ?\C-h ?\C-?)
(keyboard-translate ?\C-h ?\C-?)

;;ヘルプをC-zに割り当てる
(define-key global-map (kbd "C-z") 'help-command)

;;折り返しトグルコマンド（使うかわからない）
(define-key global-map (kbd "C-c l") 'toggle-truncate-lines)

;;文字コードの設定
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)

;;ファイル名の設定（windowsのみ)
(when (eq window-system '32)
  (set-file-name-coding-system 'cp932)
  (set locale-coding-system 'cp932))

;;カラム番号を表示
(column-number-mode t)

;;ファイルサイズを表示
(size-indication-mode t)

;;選択範囲内の行数と文字数を表示する
(defun count-lines-and-chars ()
  (if mark-active
      (format "%d lines,%d chars "
              (count-lines (region-beginning) (region-end))
              (- (region-end) (region-beginning)))
    (count-lines-region (region-beginning) (region-end))
    ""))

;;(add-to-list 'default-mode-line-format
;;             '(:eval (count-lines-and-chars)))

;;タイトルバーにファイルのフルパスを表示
(setq frame-title-format "%f")

;;行番号を常に表示する
(global-linum-mode t)

;;TABの表示幅
(setq-default tab-width 4)

;;インデントにタブ文字を利用しない
(setq-default indent-tabs-mode nil)

;;行をハイライトする
(defface my-hl-line-face
  ;;背景がdarkならば背景色を紺に
  '((((class color) (background dark))
    (:background "NavyBlue" t))
  ;;背景がlightならば背景色を緑に
  (((class color) (background light))
   (:background "LightGoldenrodYellow" t))
  (t (:bold t)))
  "hl-line's my face")
(setq hl-line-face 'my-hl-line-face)
(global-hl-line-mode t)

;;paren-mode:対応する括弧を強調して表示する
(setq show-paren-delay 0)
(show-paren-mode t)

;;バックアップファイルの作成場所を~/.emacs.d/backup/へ集める
(add-to-list 'backup-directory-alist
             (cons "." "~/.emacs.d/backups/"))
(setq auto-save-file-name-transform
      '((".*",(expand-file-name "~/.emacs.d/backups/") t)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (plantuml-mode elscreen auto-complete undo-tree))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;undo-treeの設定
(when (require 'undo-tree nil t)
  (global-undo-tree-mode))

;;auto-completeの設定

(when (require 'auto-complete-config nil t)
  (add-to-list 'ac-dictionary-directories "-/.emacs.d/elisp/ac-dict")
  (define-key ac-mode-map (kbd "M-p") 'auto-complete)
  (ac-config-default))

;;elscreenの設定
(setq elscreen-prefix-key (kbd "C-t"))
(elscreen-start)
(when (require 'elscreen nil t)
  (if window-system
      (define-key elscreen-map (kbd "C-z") 'iconify-or-deiconify-frame)
    (define-key elscreen-map (kbd "C-z") 'help-command)))

;;hownの設定などなど
(setq howm-directory (concat user-emacs-directory "howm"))
(setq howm-menu-lang 'ja)
(setq howm-file-name-format "%Y/%m/%Y-%m-%d.howm")
(when (require 'howm-mode nil t)
  (define-key global-map (kbd "C-c ,,") 'howm-menu))

;;cua-mode(矩形機能だけ)
(cua-mode t)
(setq cua-enable-cua-keys nil)

;;Plantuml-modeを有効化する
(add-to-list 'auto-mode-alist '("\\.plantuml\\'" . plantuml-mode))
;; .pu拡張子のファイルをplantuml-modeで開く
(add-to-list 'auto-mode-alist '("\.pu$" . plantuml-mode))
;; javaにオプションを渡したい場合はここにかく
(setq plantuml-java-options "")
;; plantumlのプレビューをsvg, pngにしたい場合はここをコメントイン
;; デフォルトでアスキーアート
;;(setq plantuml-output-type "svg")
;; 日本語を含むUMLを書く場合はUTF-8を指定
(setq plantuml-options "-charset UTF-8")
