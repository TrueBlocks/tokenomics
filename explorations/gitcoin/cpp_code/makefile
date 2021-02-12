#-------------------------------------------------
libraries=/Users/jrush/Development/trueblocks-core/src/libs
bin=bin
cflags=-std=c++11 -Werror -Wall -O2 -I. -I$(libraries)/utillib -I$(libraries)/etherlib -I$(libraries)/acctlib
curl=/Library/Developer/CommandLineTools/SDKs/MacOSX11.1.sdk/usr/lib/libcurl.4.tbd

#-------------------------------------------------
# for mac builds
libs=$(libraries)/*.a $(curl)

#-------------------------------------------------
exec=grants
product=objs/$(exec)
dest=$(bin)/$(exec)

#-------------------------------------------------
src= \
$(exec).cpp \
classes/profile.cpp \
classes/counter.cpp \
classes/point3d.cpp \
classes/point2d.cpp \
classes/metadata.cpp \
classes/organization.cpp \
classes/grant.cpp

#-------------------------------------------------
all:
	@mkdir -p objs
	@mkdir -p objs/classes
	@make app

every:
	@cd ../../../build ; make ; cd -
	@make app

app:
	@mkdir -p bin
	@make $(product)
	mv $(product) $(dest)

test:
	@make
	@./do_tests

#-------------------------------------------------
# probably don't have to change below this line

objects = $(patsubst %.cpp,objs/%.o,$(src))

$(product): $(objects) $(libs)
	g++ -o $(product) $(objects) $(libs)
	@strip $(product)

$(objects): | objs

objs:
	@mkdir -p $@

objs/%.o : %.cpp
	$(CXX) $(CXXFLAGS) $(cflags) -c $< -o $@

cleanall:
	@cd $(libraries) ; make clean ; cd -
	@make clean

clean:
	-@$(RM) -fR $(product) objs 2> /dev/null
