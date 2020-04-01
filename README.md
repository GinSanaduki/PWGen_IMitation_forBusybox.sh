<p align="center">
    <a href="https://opensource.org/licenses/BSD-3-Clause"><img src="https://img.shields.io/badge/license-bsd-orange.svg" alt="Licenses"></a>
</p>

# PWGen_IMitation_forBusybox.sh
pwgenライクにランダムな文字列を生成する（Generate a random string for pwgen-like）

Windowsのフォルダ名称をランダムな英数字で13字生成したかったが、pwgenなどをインストールしたくない上に、
powershellの初回起動の遅さに頭を悩ませた結果生まれたものです。

sha512sumがなければ、sha256sumなどのコマンドで代替してください。

I wanted to generate 13 Windows folder names with random alphanumeric characters, but I don't want to install pwgen etc.
It was born as a result of worrying about the slow start of powershell.

If there is no sha512sum, use a command such as sha256sum.

Windowsで（何もインストールしたくない前提で）「/dev/urandom」の代わりを使うには？が気になるのに、MinGWを導入しろだの、CygWinを導入しろだのは、ほんとうによしてほしいですな。他人に使わせるときにどうするんだよ、って思わないのだろうか・・・。

/dev/urandomを使わない乱数は、「どの環境でも使えるシェルスクリプトを書くためのメモ ver4.60」
https://qiita.com/richmikan@github/items/bd4b21cf1fe503ab2e5c
にあったので、その乱数を5個つないだ文字列を元手にハッシュ値を生成し、ハッシュ値の文字列を攪拌してランダムな英数字を取得する手法をとりました。
自分の調べた限りでは、このやりかたはなかったような。
