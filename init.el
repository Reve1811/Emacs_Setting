;;���m�̖��
;;���m��̕�����C-m�Ŋm��ł��Ȃ�

;;~/.emacs.d/elisp�����[�h�p�X�ɒǉ�����
(add-to-list 'load-path "~/.emacs.d/elisp")
;; load-path ��ǉ�����֐����`

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

;;C-m��newline-and-indent�����蓖�Ă�i�����l�͂�����newline�Ȃ̂Łj
(global-set-key (kbd "C-m") 'newline-and-indent)

;;DEL��C-h�����ւ���
;;(keyboard-translate ?\C-h ?\C-?)
(keyboard-translate ?\C-h ?\C-?)

;;�w���v��C-z�Ɋ��蓖�Ă�
(define-key global-map (kbd "C-z") 'help-command)

;;�܂�Ԃ��g�O���R�}���h�i�g�����킩��Ȃ��j
(define-key global-map (kbd "C-c l") 'toggle-truncate-lines)

;;�����R�[�h�̐ݒ�
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)

;;�t�@�C�����̐ݒ�iwindows�̂�)
(when (eq window-system '32)
  (set-file-name-coding-system 'cp932)
  (set locale-coding-system 'cp932))

;;�J�����ԍ���\��
(column-number-mode t)

;;�t�@�C���T�C�Y��\��
(size-indication-mode t)

;;�I��͈͓��̍s���ƕ�������\������
(defun count-lines-and-chars ()
  (if mark-active
      (format "%d lines,%d chars "
              (count-lines (region-beginning) (region-end))
              (- (region-end) (region-beginning)))
    (count-lines-region (region-beginning) (region-end))
    ""))

;;(add-to-list 'default-mode-line-format
;;             '(:eval (count-lines-and-chars)))

;;�^�C�g���o�[�Ƀt�@�C���̃t���p�X��\��
(setq frame-title-format "%f")

;;�s�ԍ�����ɕ\������
(global-linum-mode t)

;;TAB�̕\����
(setq-default tab-width 4)

;;�C���f���g�Ƀ^�u�����𗘗p���Ȃ�
(setq-default indent-tabs-mode nil)

;;�s���n�C���C�g����
(defface my-hl-line-face
  ;;�w�i��dark�Ȃ�Δw�i�F������
  '((((class color) (background dark))
    (:background "NavyBlue" t))
  ;;�w�i��light�Ȃ�Δw�i�F��΂�
  (((class color) (background light))
   (:background "LightGoldenrodYellow" t))
  (t (:bold t)))
  "hl-line's my face")
(setq hl-line-face 'my-hl-line-face)
(global-hl-line-mode t)

;;paren-mode:�Ή����銇�ʂ��������ĕ\������
(setq show-paren-delay 0)
(show-paren-mode t)

;;�o�b�N�A�b�v�t�@�C���̍쐬�ꏊ��~/.emacs.d/backup/�֏W�߂�
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

;;undo-tree�̐ݒ�
(when (require 'undo-tree nil t)
  (global-undo-tree-mode))

;;auto-complete�̐ݒ�

(when (require 'auto-complete-config nil t)
  (add-to-list 'ac-dictionary-directories "-/.emacs.d/elisp/ac-dict")
  (define-key ac-mode-map (kbd "M-p") 'auto-complete)
  (ac-config-default))

;;elscreen�̐ݒ�
(setq elscreen-prefix-key (kbd "C-t"))
(elscreen-start)
(when (require 'elscreen nil t)
  (if window-system
      (define-key elscreen-map (kbd "C-z") 'iconify-or-deiconify-frame)
    (define-key elscreen-map (kbd "C-z") 'help-command)))

;;hown�̐ݒ�ȂǂȂ�
(setq howm-directory (concat user-emacs-directory "howm"))
(setq howm-menu-lang 'ja)
(setq howm-file-name-format "%Y/%m/%Y-%m-%d.howm")
(when (require 'howm-mode nil t)
  (define-key global-map (kbd "C-c ,,") 'howm-menu))

;;cua-mode(��`�@�\����)
(cua-mode t)
(setq cua-enable-cua-keys nil)

;;Plantuml-mode��L��������
(add-to-list 'auto-mode-alist '("\\.plantuml\\'" . plantuml-mode))
;; .pu�g���q�̃t�@�C����plantuml-mode�ŊJ��
(add-to-list 'auto-mode-alist '("\.pu$" . plantuml-mode))
;; java�ɃI�v�V������n�������ꍇ�͂����ɂ���
(setq plantuml-java-options "")
;; plantuml�̃v���r���[��svg, png�ɂ������ꍇ�͂������R�����g�C��
;; �f�t�H���g�ŃA�X�L�[�A�[�g
;;(setq plantuml-output-type "svg")
;; ���{����܂�UML�������ꍇ��UTF-8���w��
(setq plantuml-options "-charset UTF-8")
