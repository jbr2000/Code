CXX = g++
CPPFLAGS = -std=c++11 -g

KERNEL_NAME := $(shell sh -c 'uname -s 2>/dev/null || echo not')

# if this is a Linux computer, set up Linux libraries
ifeq ($(KERNEL_NAME),Linux)
  LIBDIRS  = -L/usr/X11R6/lib
  LIBS = -lX11 -lglut -lGL -lGLU -lm -lfl
endif

# if this is a Mac computer, set up Mac libraries
ifeq ($(KERNEL_NAME),Darwin)
  LIBS = -framework GLUT -framework OpenGL -lobjc
  CPPFLAGS += -I/System/Library/Frameworks/GLUT.framework/Versions/A/Headers
endif

simple: simple.cpp
	$(CXX) $(CPPFLAGS) -o simple simple.cpp  $(LIBDIRS) $(LIBS)

clean:
	rm -f $(C++OBJ) simple 
