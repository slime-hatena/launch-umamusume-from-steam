Add-Type -Assembly System.Windows.Forms;

# ゲーム起動
Start-Process "dmmgameplayer://umamusume/cl/general/umamusume";
$c = 0;
do {
    # 60回プロセスを取得できなかったら起動失敗ということにする
    if (++$c -ge 60) {
        [System.Windows.Forms.MessageBox]::Show("起動を確認できませんでした。", "起動失敗", "OK", "Error");
        exit;
    }
    Start-Sleep -s 2;
    Get-Process -Name umamusume;
} while (!$?);

do {
    # プロセスが取得できなくなったら終了したと見なす
    Start-Sleep -s 5;
    Get-Process -Name umamusume;
} while ($?);
