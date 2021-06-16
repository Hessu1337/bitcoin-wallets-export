for i in ./*.dat; do
	cp $i $HOME/.bitcoin/wallets/${i##*/}
	echo "Loading wallet $i"
	bitcoin-cli loadwallet ${i##*/}

	echo "----- Fichier ${i##*/} -----" >> errors.txt
	for OUTPUT in $(bitcoin-cli -rpcwallet=${i##*/} listreceivedbyaddress 1 true | jq -r .[].address)
	do
		echo "Dumping for $OUTPUT"
		bitcoin-cli -rpcwallet=${i##*/} dumpprivkey $OUTPUT >>pvkeys.txt 2>>errors.txt
		sleep 1
	done

done