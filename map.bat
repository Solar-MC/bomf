@echo off
del ignored -y
mkdir ignored
echo "Grabbing Badlion. Make sure you have ran the latest version of the client first!"
robocopy %AppData%/.minecraft/versions/BLClient18/ ignored/
cd ignored
rename BLClient.jar badlionOfficial.jar
cd ..
del ignored/BLClient.jar
echo "Remapping Badlion with Yarn"
mkdir tmp
java -jar tools/remapper.jar ignored/badlionOfficial.jar tmp/badlionHalfRemapped.jar misc/1.8.9.tiny official intermediary
java -jar tools/remapper.jar tmp/badlionHalfRemapped.jar tmp/badlionHalfRemapped2.jar misc/1.8.9.tiny intermediary named
echo "Remapping Badlion with Badlion Intermediaries"
java -jar tools/remapper.jar tmp/badlionHalfRemapped2.jar ignored/badlionCodeRemappedWithMc.jar misc/intermediaries.tiny official intermediary
del tmp
echo "Removing Minecraft code"
java -jar tools/minecraftSourceRemover.jar ignored/badlionCodeRemappedWithMc.jar ignored/badlionCodeRemapped.jar
echo "Opening Enigma"
java -jar tools/enigma.jar --jar ignored/badlionCodeRemapped.jar --mappings mappings