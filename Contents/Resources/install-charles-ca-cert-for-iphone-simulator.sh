#/bin/bash
#
# Installs the Charles Root certificate into the iOS Simulators for the current user.

SHA1=$1
SUBJ=$2
TSET=$3
DATA=$4

install() {
if [ -f "$SQLITEDBPATH" ]; then
cp -n "$SQLITEDBPATH" "$SQLITEDBPATH.charlesbackup"
sqlite3 "$SQLITEDBPATH" <<EOF
INSERT INTO "tsettings" VALUES(X'$SHA1',X'$SUBJ',X'$TSET',X'$DATA');
EOF
fi
}

for SQLITEDBPATH in ~/Library/Application\ Support/iPhone\ Simulator/3.*/Library/Keychains/TrustStore.sqlite3
do install
done

for SQLITEDBPATH in ~/Library/Application\ Support/iPhone\ Simulator/4.*/Library/Keychains/TrustStore.sqlite3
do install
done

for SQLITEDBPATH in ~/Library/Developer/CoreSimulator/Devices/*/data/Library/Keychains/TrustStore.sqlite3
do install
done

SQLITEDBPATH=~/Library/Application\ Support/iPhone\ Simulator/User/Library/Keychains/TrustStore.sqlite3
install

echo "The Charles Root Certificate has been installed for the iPhone Simulator"
