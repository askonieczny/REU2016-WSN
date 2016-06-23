COMPONENT=RadioCountToLedsAppC
BUILD_EXTRA_DEPS = RadioCountMsg.py RadioCountMsg.class PathMsg.py PathMsg.class RoutMsg.py RoutMsg.class
CLEAN_EXTRA = RadioCountMsg.py RadioCountMsg.class RadioCountMsg.java PathMsg.py PathMsg.class PathMsg.java RoutMsg.pu RoutMsg.class RoutMsg.java

RadioCountMsg.py: RadioCountToLeds.h
	mig python -target=$(PLATFORM) $(CFLAGS) -python-classname=RadioCountMsg RadioCountToLeds.h radio_count_msg -o $@

RadioCountMsg.class: RadioCountMsg.java
	javac RadioCountMsg.java

RadioCountMsg.java: RadioCountToLeds.h
	mig java -target=$(PLATFORM) $(CFLAGS) -java-classname=RadioCountMsg RadioCountToLeds.h radio_count_msg -o $@

PathMsg.py: RadioCountToLeds.h
	mig python -target=$(PLATFORM) $(CFLAGS) -python-classname=PathMsg RadioCountToLeds.h path_msg -o $@

PathMsg.class: PathMsg.java
	javac PathMsg.java

PathMsg.java: RadioCountToLeds.h
	mig java -target=$(PLATFORM) $(CFLAGS) -java-classname=PathMsg RadioCountToLeds.h path_msg -o $@

RoutMsg.py: RadioCountToLeds.h
	mig python -target=$(PLATFORM) $(CFLAGS) -python-classname=RoutMsg RadioCountToLeds.h rout_msg -o $@

RoutMsg.class: RoutMsg.java
	javac RoutMsg.java

RoutMsg.java: RadioCountToLeds.h
	mig java -target=$(PLATFORM) $(CFLAGS) -java-classname=RoutMsg RadioCountToLeds.h rout_msg -o $@


include $(MAKERULES)
