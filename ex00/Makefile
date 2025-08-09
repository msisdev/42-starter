#--------------------------------------#
#- CONFIG -----------------------------#
#--------------------------------------#

APP				  := a.out
APP_DIR		  := app
APP_CODES   := $(shell find $(APP_DIR) -name '*.c')
APP_OBJS	  := $(APP_CODES:.c=.o)

BIN_DIR		  := bin
INC_DIR		  := include

CC				  := cc
CFLAGS		  := -Wall -Wextra -Werror
CFLAGS		  += -I $(INC_DIR)
CFLAGS		  += $(DBG)	# make DBG="-g"

LIB				  := lib.a
LIB_DIR		  := lib
LIB_CODES	  := $(shell find $(LIB_DIR) -name '*.c')
LIB_OBJS	  := $(LIB_CODES:.c=.o)

SRC_DIR		  := src
SRC_CODES	  := $(shell find $(SRC_DIR) -name '*.c')
SRC_OBJS	  := $(SRC_CODES:.c=.o)

TEST_DIR	  := test
TEST_NAMES  := $(shell find $(TEST_DIR) -mindepth 1 -maxdepth 1 -type d -printf '%f\n')

.PHONY: all app test lib

#--------------------------------------#
#- CMD --------------------------------#
#--------------------------------------#

all: app $(TEST_NAMES)

clean:
	rm -f **/*.o

lclean: clean
	rm -f $(LIB)

fclean: lclean
	rm -f $(APP)
	rm -f $(BIN_DIR)/*

re: fclean all

#--------------------------------------#
#- APP --------------------------------#
#--------------------------------------#

app: lib $(APP)

$(APP): $(LIB_OBJS) $(SRC_OBJS) $(APP_OBJS)
	$(CC) $(CFLAGS) -o $@ $^

#--------------------------------------#
#- LIB --------------------------------#
#--------------------------------------#

lib: $(LIB)
# lib: $(LIB_OBJS)

$(LIB): $(LIB_OBJS)
	ar crs $(LIB) $(LIB_OBJS)

#--------------------------------------#
#- SRC --------------------------------#
#--------------------------------------#

src: $(SRC_OBJS)

#--------------------------------------#
#- TEST -------------------------------#
#--------------------------------------#

test: $(BIN_DIR) $(TEST_NAMES)

.SECONDEXPANSION:
%_test: $(LIB_OBJS) $(SRC_OBJS)\
	$$(shell find $(TEST_DIR)/$$*_test -type f -name '*.c' | sed 's/\.c/\.o/') |\
	$(BIN_DIR)
	$(CC) $(CFLAGS) -o $(BIN_DIR)/$@ $^

#--------------------------------------#
#- COMMONS ----------------------------#
#--------------------------------------#

$(BIN_DIR):
	mkdir $(BIN_DIR)

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<
