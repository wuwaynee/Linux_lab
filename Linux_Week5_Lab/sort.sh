!/bin/bash
file='./student_id'

[ -d ./compressed_files/tar.gz ] || mkdir ./compressed_files/tar.gz
[ -d ./compressed_files/zip ] || mkdir ./compressed_files/zip
[ -d ./compressed_files/unknown ] || mkdir ./compressed_files/unknown
[ -d ./compressed_files/rar ] || mkdir ./compressed_files/rar
[ -a ./missing_list ] || touch ./missing_list
[ -a ./wrong_list ] || touch ./wrong_list


while read line
do 		
		if VAR=$(find ./compressed_files/ -name "${line}.*" | cut -d ' ' -f2 | cut -d '/' -f3); then
			if [ $VAR = "${line}.zip" ] ; then
				mv ./compressed_files/$VAR ./compressed_files/zip
				unzip ./compressed_files/zip/$VAR -d ./compressed_files/zip/
			elif [ $VAR = "${line}.tar.gz" ] ; then
				mv ./compressed_files/$VAR ./compressed_files/tar\.gz
				tar zxvf ./compressed_files/tar\.gz/$VAR --directory ./compressed_files/tar\.gz
			elif [ $VAR = "${line}.rar" ] ; then 
				mv ./compressed_files/$VAR ./compressed_files/rar	
				rar x ./compressed_files/rar/$VAR ./compressed_files/rar/
			elif [ -f ./compressed_files/$VAR ] ; then 
				mv ./compressed_files/"$VAR" ./compressed_files/unknown
				echo $line >> ./wrong_list
			else    # [$VAR -ne "${line}.zip"] && [$VAR -ne "${line}.tar.gz"] && [$VAR -ne "${line}.rar"] ;then
				echo $line >> ./missing_list
			fi
			
		fi


	
done < $file
