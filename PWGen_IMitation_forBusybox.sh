#!/bin/sh

# PWGen_IMitation_forBusybox.sh
# Reference
# どの環境でも使えるシェルスクリプトを書くためのメモ ver4.60 - Qiita
# https://qiita.com/richmikan@github/items/bd4b21cf1fe503ab2e5c

# sedで改行を扱うための定義
# Definition for handling line breaks with sed
LF=$(printf '\\\n_')
LF=${LF%_}

genRand () {
	# psの実行結果を変化させるため
	# Implemented to change the execution result of ps
	usleep 1000
	# 乱数源(プロセス情報一覧+日時) 
	# Random number source (process information list + date and time)
	(ps -Ao user,group,comm,args,pid,ppid,etime,time;date) | \
	# 数値化
	# Convert to number
	od -t d4 -A n -v | \
	sed 's/[^0-9]\{1,\}/'"$LF"'/g' | \
	grep '[0-9]' | \
	# 100,000,000未満の数字を42個まで用意(2^32未満にするため)
	# Prepare up to 42 numbers less than 100,000,000(For less than 2^32)
	tail -n 42 | \
	sed 's/.*\(.\{8\}\)$/\1/g' | \
	# signed long値を生成
	# Generate signed long value
	awk 'BEGIN{a=-2147483648;}{a+=$1;}END{srand(a);print rand();}'
	
}

Rand1=`genRand`
Rand2=`genRand`
Rand3=`genRand`
Rand4=`genRand`
Rand5=`genRand`

printf "%s\n%s\n%s\n%s\n%s" $Rand1 $Rand2 $Rand3 $Rand4 $Rand5 | \
tr -dc 'a-zA-Z0-9' | \
shuf | \
tr -d '\n' | \
sha512sum | \
tr -dc 'a-zA-Z0-9' | \
awk '{for(i=1;i < length($0);i++){print substr($0,i,1)}}' | \
# AES256で実行する攪拌処理のように14回シャッフルする
# Shuffle 14 times like the stirring process executed with AES256
shuf | \
shuf | \
shuf | \
shuf | \
shuf | \
shuf | \
shuf | \
shuf | \
shuf | \
shuf | \
shuf | \
shuf | \
shuf | \
shuf | \
tr -d '\n' | \
cut -b 1-13

