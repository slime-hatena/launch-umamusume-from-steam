Add-Type -Assembly System.Windows.Forms;

# dmmgames launcherは管理者権限で動くので昇格させる
If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    # steamがゲーム起動中の判定に使うためwaitしておく
    $arg = "-ExecutionPolicy Bypass `"& '" + $myinvocation.mycommand.definition + "' ; pause;`"";
    Start-Process powershell -Wait -Verb runAs -ArgumentList $arg;
    exit;
}

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

# 起動を確認したらゲーム終了まで待ち、dmmgames launcherを終了
Wait-Process -Name umamusume;
Stop-Process -Name DMMGamePlayer;
