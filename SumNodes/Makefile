COMPONENT=SumNodesAppC
BUILD_EXTRA_DEPS = RadioCountMsg.py RadioCountMsg.class
CLEAN_EXTRA = RadioCountMsg.py RadioCountMsg.class RadioCountMsg.java

RadioCountMsg.py: SumNodes.h
	mig python -target=$(PLATFORM) $(CFLAGS) -python-classname=RadioCountMsg SumNodes.h radio_count_msg -o $@

RadioCountMsg.class: RadioCountMsg.java
	javac RadioCountMsg.java

RadioCountMsg.java: SumNodes.h
	mig java -target=$(PLATFORM) $(CFLAGS) -java-classname=RadioCountMsg SumNodes.h radio_count_msg -o $@

PathMsg.py: SumNodes.h
	mig python -target=$(PLATFORM) $(CFLAGS) -python-classname=PathMsg SumNodes.h path_msg -o $@

PathMsg.class: PathMsg.java
	javac PathMsg.java

PathMsg.java: SumNodes.h
	mig java -target=$(PLATFORM) $(CFLAGS) -java-classname=PathMsg SumNodes.h path_msg -o $@


include $(MAKERULES)
