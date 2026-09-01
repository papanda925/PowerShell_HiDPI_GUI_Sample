# PowerShell High-DPI Windows Forms Samples

PowerShellからWindows Formsのダイアログを作成し、高DPIディスプレイでも文字やボタンが見切れにくい画面配置を学ぶためのサンプル集です。

各サンプルは1ファイルで実行できます。外部PowerShellモジュールやVisual Studioは不要です。

## 改善したポイント

- 96 DPIを設計時の基準として`AutoScaleDimensions`を設定
- `AutoScaleMode = Dpi`による自動スケーリング
- 固定の巨大なピクセルフォントをやめ、Windowsのダイアログ用フォントを使用
- `TableLayoutPanel`と`FlowLayoutPanel`を使い、DPIや文字サイズが変わっても部品を再配置
- `ClientSize`と`MinimumSize`を使用し、フォーム外にボタンが出ないように修正
- OK／キャンセル、Enter／Escの標準的なダイアログ操作に対応
- フォームとフォントを`finally`で確実に破棄

## 動作環境

- Windows
- Windows PowerShell 5.1、またはWindows上のPowerShell 7
- .NETの`System.Windows.Forms`と`System.Drawing`

Windows Formsを使用するため、macOSとLinuxでは動作しません。

## サンプル一覧

| ファイル | 内容 | OKを押したときの出力 |
| --- | --- | --- |
| `HiDPICustomGraphicalInputBoxSample.ps1` | 文字入力ダイアログ | 入力した文字列 |
| `HiDPIGraphicalDatePickerSample.ps1` | カレンダー形式の日付選択 | 選択した`DateTime`値 |
| `HiDPIMultiple-selectionListBoxesSample.ps1` | リストから複数選択 | 選択した項目の配列 |
| `HiDPISelectingItemsFromListBoxSample.ps1` | リストから1つ選択 | 選択した項目 |

## 実行方法

PowerShellでリポジトリのフォルダーへ移動し、実行するファイルを指定します。

```powershell
Set-Location .\PowerShell_HiDPI_GUI_Sample
.\HiDPICustomGraphicalInputBoxSample.ps1
```

他の例：

```powershell
$selectedDate = .\HiDPIGraphicalDatePickerSample.ps1
$selectedItems = .\HiDPIMultiple-selectionListBoxesSample.ps1
$selectedComputer = .\HiDPISelectingItemsFromListBoxSample.ps1
```

キャンセルした場合は値を出力しません。

### 実行ポリシーでブロックされた場合

まず、現在の設定を確認します。

```powershell
Get-ExecutionPolicy -List
```

組織管理のPCでは管理者の方針に従ってください。このリポジトリのサンプルは実行ポリシーを自動変更しません。

## 高DPI対応の要点

### 1. 96 DPIを基準値として記録する

```powershell
$form.AutoScaleDimensions = [System.Drawing.SizeF]::new(96.0, 96.0)
$form.AutoScaleMode = [System.Windows.Forms.AutoScaleMode]::Dpi
```

96 DPIはWindows Forms上の設計基準です。実行時のDPIが異なる場合、Windows Formsがフォームと子コントロールの拡大率を計算します。

### 2. 固定座標だけに依存しない

高DPI環境では、文字だけが大きくなってボタンや入力欄と重なることがあります。このサンプルでは、行と列で配置する`TableLayoutPanel`と、ボタンを順番に並べる`FlowLayoutPanel`を使っています。

### 3. フォントサイズをピクセルで固定しない

```powershell
$uiFont = [System.Drawing.SystemFonts]::MessageBoxFont.Clone()
$form.Font = $uiFont
```

現在のWindows設定に合うダイアログ用フォントを使用します。個別に大きなフォントが必要な場合も、レイアウトパネルや`AutoSize`と組み合わせてください。

## 制限事項

- サンプルはWindows Forms向けであり、WPF/XAMLのDPI処理とは異なります。
- PowerShellスクリプト単体では、通常の`.exe`アプリと同じ方法でDPI Awarenessマニフェストを埋め込めません。
- 複数の異なるDPIのモニター間を移動する挙動は、PowerShellと.NETのバージョン、Windowsの設定によって異なる場合があります。
- GUIの実表示はWindows環境で確認する必要があります。

## トラブルシューティング

### 画面が表示されない

Windows上で実行していることを確認してください。PowerShell 7を使う場合も、Windows版が必要です。

### 文字や部品の大きさが想定と違う

Windowsの「設定」→「システム」→「ディスプレイ」で拡大率を確認してください。100%、125%、150%、200%など複数の拡大率で確認すると違いを把握しやすくなります。

### スクリプトの結果を再利用したい

標準出力を変数へ代入します。

```powershell
$value = .\HiDPICustomGraphicalInputBoxSample.ps1
```

## 参考資料

- [Windows Forms - Automatic scaling](https://learn.microsoft.com/dotnet/desktop/winforms/forms/autoscale)
- [ContainerControl.AutoScaleDimensions](https://learn.microsoft.com/dotnet/api/system.windows.forms.containercontrol.autoscaledimensions)
- [ContainerControl.AutoScaleMode](https://learn.microsoft.com/dotnet/api/system.windows.forms.containercontrol.autoscalemode)
- [Creating a custom input box](https://learn.microsoft.com/powershell/scripting/samples/creating-a-custom-input-box)
- [Creating a graphical date picker](https://learn.microsoft.com/powershell/scripting/samples/creating-a-graphical-date-picker)

## English summary

Standalone PowerShell/Windows Forms examples that demonstrate DPI-based automatic scaling, system dialog fonts, responsive layout panels, standard dialog behavior, and deterministic cleanup.


