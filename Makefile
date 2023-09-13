NAME		= a.out

SRCS		= main.cpp

OBJS_PATH	= ./objs/
OBJS_FILES	= ${SRCS:.cpp=.o}
OBJS		= ${patsubst %,${OBJS_PATH}%,${OBJS_FILES}}

INC			= stack vector iterator list doctest/doctest
INCLUDE		= $(INC:%=-I ./%)

CXX			= g++
CXXFLAGS	= -std=c++17 #-g -fsanitize=address -fsanitize=leak -fsanitize=undefined

RM			= rm -rf

all: ${NAME}

${NAME}: ${OBJS_PATH} ${OBJS}
	@ ${CXX} ${CXXFLAGS} ${INCLUDE} ${OBJS} -o ${NAME}
	@ ./${NAME}
	@ ${RM} ${OBJS_PATH} ${NAME}

${OBJS_PATH}%.o : %.cpp
	@ ${CXX} ${CXXFLAGS} ${INCLUDE} -MMD -MP -c $< -o $@

${OBJS_PATH}:
	@ mkdir -p ${OBJS_PATH}

format:
	clang-format -i $(INC:%= ./%/*)

.PHONY: all format