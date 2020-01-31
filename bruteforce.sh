#!/bin/bash

LIST1=(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z a b c d e f g h i j k l m n o p q r s t u v w x y z 0 1 2 3 4 5 6 7 8 9)
LIST2=(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)
LIST3=(a b c d e f g h i j k l m n o p q r s t u v w x y z)
LIST4=(0 1 2 3 4 5 6 7 8 9)
LIST5=('~' '!' '@' '#' '$' '%' '^' '&' '*' '_' '+')
LIST6=('[' ']' '{' '}' '<' '>' '(' ')')
LIST7=(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z a b c d e f g h i j k l m n o p q r s t u v w x y z 0 1 2 3 4 5 6 7 8 9 '~' '!' '@' '#' '$' '%' '^' '&' '*' '_' '+' '[' ']' '{' '}' '<' '>' '(' ')')

md5_encr=`grep -i "$1" hackfour.pwd | cut -d"$" -f1,2,3,4`
md5_salt=`grep -i "$1" hackfour.pwd | cut -d"$" -f3`

des_encr=`grep -i "$1" hackfour.pwd | cut -d"$" -f5`

sha2_encr=`grep -i "$1" hackfour.pwd | cut -d"$" -f6,7,8,9`
sha2_salt=`grep -i "$1" hackfour.pwd | cut -d"$" -f8`

sha5_encr=`grep -i "$1" hackfour.pwd | cut -d"$" -f10,11,12,13`
sha5_salt=`grep -i "$1" hackfour.pwd | cut -d"$" -f12`


#echo $md5_encr
#echo $md5_salt
#echo $des_encr
#echo $sha2_encr
#echo $sha2_salt
#echo $sha5_encr
#echo $sha5_salt	

for i in "${LIST2[@]}"
  do
   for j in "${LIST3[@]}"
    do
	for k in "${LIST5[@]}" 
	 do
	   for l in "${LIST6[@]}"
	    do	
	      echo -n "$i$j$k$l "
	    md5_test=`mkpasswd -m md5 $i$j$k$l -s $md5_salt`

		if [ $md5_test == $md5_encr ] ; then
			hash1="$i$j$k$l"
		echo "The md5 hashpassword is: $hash1"
	
		fi
		
	  done
	done
    done
done

for i in "${LIST1[@]}"
  do
   for j in "${LIST1[@]}"
    do
	for k in "${LIST5[@]}" 
	 do		  	
	      echo -n "$i$j$k "
	    
	    des_test=`mkpasswd -m des $i$j$k -s "By"`
		
		if [ "$des_test" == "$des_encr" ] ; then
			hash2="$i$j$k"
			echo "The des hashpassword is: $hash2"
			
		fi
	
	done
    done
done

for i in "${LIST1[@]}"
  do
   for j in "${LIST6[@]}"
    do
	for k in "${LIST1[@]}" 
	 do	
	      echo -n "$i$j$k "
	    
	    sha2_test=`mkpasswd -m sha-256 $i$j$k -s $sha2_salt`
	    

		if [ $sha2_test == $sha2_encr ] ; then
			hash3=$i$j$k
			echo "The sha-256 hashpassword is: $hash3"
			
		fi
	done
    done
done

for i in "${LIST5[@]}"
  do
   for j in "${LIST4[@]}"
    do
	for k in "${LIST7[@]}" 
	 do
	   for l in "${LIST6[@]}"
	    do	
	      echo -n "$i$j$k$l "
	    
	    sha5_test=`mkpasswd -m sha-512 $i$j$k$l -s $sha5_salt`

		
		if [ $sha5_test == $sha5_encr ] ; then
			hash4=$i$j$k$l
			echo "The sha-512 password is: $hash4"
			
		fi
		
	  done
	done
    done
done


echo "The md5 hashpassword is: $hash1"
echo "The des hashpassword is: $hash2"
echo "The sha-256 hashpassword is: $hash3"
echo "The sha-512 password is: $hash4"
