#!/bin/sh

# PWGen_IMitation_forBusybox.sh
# Reference
# �ǂ̊��ł��g����V�F���X�N���v�g���������߂̃��� ver4.60 - Qiita
# https://qiita.com/richmikan@github/items/bd4b21cf1fe503ab2e5c

# sed�ŉ��s���������߂̒�`
# Definition for handling line breaks with sed
LF=$(printf '\\\n_')
LF=${LF%_}

genRand () {
	# ps�̎��s���ʂ�ω������邽��
	# Implemented to change the execution result of ps
	usleep 1000
	# ������(�v���Z�X���ꗗ+����) 
	# Random number source (process information list + date and time)
	(ps -Ao user,group,comm,args,pid,ppid,etime,time;date) | \
	# ���l��
	# Convert to number
	od -t d4 -A n -v | \
	sed 's/[^0-9]\{1,\}/'"$LF"'/g' | \
	grep '[0-9]' | \
	# 100,000,000�����̐�����42�܂ŗp��(2^32�����ɂ��邽��)
	# Prepare up to 42 numbers less than 100,000,000(For less than 2^32)
	tail -n 42 | \
	sed 's/.*\(.\{8\}\)$/\1/g' | \
	# signed long�l�𐶐�
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
# AES256�Ŏ��s���靘�a�����̂悤��14��V���b�t������
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

