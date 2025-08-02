#--------------------------------------#
#- CONFIG -----------------------------#
#--------------------------------------#

CC			:= cc
CFLAGS		:= -Wall -Wextra -Werror
CFLAGS		+= $(DBG)	# make DBG="-g"

APP			:= main

INC_DIR		:= include
BIN_DIR		:= bin

LIB_DIR		:= lib
LIB_CODES	:= $(shell find $(LIB_DIR) -name '*.c')
LIB_OBJS	:= $(LIB_CODES:.c=.o)
LIB			:= lib.a

SRC_DIR		:= src
SRC_CODES	:= $(shell find $(SRC_DIR) -name '*.c')
SRC_OBJS	:= $(SRC_CODES:.c=.o)
SRCS		:= $(subst $(SRC_DIR)/,,$(SRC_CODES:.c=))

TEST_DIR	:= test
TEST_CODES	:= $(shell find $(TEST_DIR) -name '*.c')
TESTS		:= $(subst $(TEST_DIR)/,,$(TEST_CODES:.c=))

#--------------------------------------#
#- CMD --------------------------------#
#--------------------------------------#

.PHONY: all app test lib
all: app $(TESTS)

clean:
	rm -f **/*.o

lclean: clean
	rm -f $(LIB)

fclean: lclean
	rm -f $(BIN_DIR)/*

re: fclean all

#--------------------------------------#
#- APP, SRC ---------------------------#
#--------------------------------------#

app: $(APP)

$(APP): $(SRC_OBJS) $(LIB) | $(BIN_DIR)
	$(CC) $(CFLAGS) -o $(BIN_DIR)/$@ $(SRC_OBJS) $(LIB)

#--------------------------------------#
#- LIB --------------------------------#
#--------------------------------------#

lib: $(LIB)

$(LIB): $(LIB_OBJS)
	ar crs $(LIB) $(LIB_OBJS)

#--------------------------------------#
#- TEST -------------------------------#
#--------------------------------------#

test: $(TESTS)

%_test: $(TEST_DIR)/%_test.o $(LIB)
	$(CC) $(CFLAGS) -o $(BIN_DIR)/$@ $< $(LIB)

#--------------------------------------#
#- COMMONS ----------------------------#
#--------------------------------------#

$(BIN_DIR):
	mkdir $(BIN_DIR)

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $< -I$(INC_DIR)
