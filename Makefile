# https://codereview.stackexchange.com/questions/157780/generic-makefile-handling-unit-testing-and-folder-structure
# A pergunta desse post me ajudou MUITO.

## Não colocar './' no começo dos nomes de diretórios.

## É aconselhável que o nome do target seja diferente do nome do arquivo

# Deve mesmo nome do arquivo com a função main
MAIN_EXEC ?= main

TESTS_EXEC ?= test_exec

CXX = g++

# Foi assistindo esse cara que consegui
# https://www.youtube.com/watch?v=9VpiGwp8Vos
# Como eu faria pra tirar -g para o código em produção?
# Mas como que no projeto da calculadora eu não uso -g e ainda consigo depurar c
# o Testmate?
CXXFLAGS = -g

# Mais detalhes sobre depuração no VSCode
# https://stackoverflow.com/questions/58581500/how-to-fix-debugger-in-vscode-if-you-have-makefile-project-on-c

BUILD_DIR ?= build
SRC_DIRS ?= src 

MAIN := src/$(MAIN_EXEC).cpp
SRCS := $(wildcard src/*.cpp)
OBJS := $(SRCS:%=$(BUILD_DIR)/%.o)

TEST_SRCS := $(wildcard tests/*.test.cpp)
TEST_OBJS := $(filter-out build/src/$(MAIN_EXEC).cpp.o, $(OBJS)) \
						 $(TEST_SRCS:%=$(BUILD_DIR)/%.o) # Não pode colocar espaços ao redor do =
# Outro jeito de diferenciar obj de src/ dos objs de tests/ sem usar .test.cpp
#            $(TEST_SRCS:tests/% = $(BUILD_DIR)/tests/%.o)


all: main tests


####################################
# Executável principal             #
####################################
main: $(BUILD_DIR)/$(MAIN_EXEC) 
	@echo "  > main: Done $@ => $<"
	@echo "  ------------------------\n"

$(BUILD_DIR)/$(MAIN_EXEC): $(OBJS) $(MAIN)
	@echo ">> main: Building executable"
	@$(CXX) $(CXXFLAGS) $(OBJS) -o $@

# cpp sources
$(BUILD_DIR)/%.cpp.o: %.cpp
	@echo ">> main: Building source file: $< | | match: $*"
	@echo " > main: Output file: $@\n"
	@$(MKDIR_P) $(dir $@)
	@$(CXX) $(CXXFLAGS) -c $< -o $@


####################################
# Executável do testes unitários	 #
####################################
tests: $(BUILD_DIR)/$(TESTS_EXEC)
	@echo " > test: Build done"

$(BUILD_DIR)/$(TESTS_EXEC): $(TEST_OBJS)
	@echo ">> test: Building TEST executable $@"
	@$(CXX) $(CXXFLAGS) $(TEST_OBJS) -o $@

# test sources
$(BUILD_DIR)/%.test.cpp.o: %.test.cpp
	@echo ">> test: Building test source: $< | match: $*"
	@echo " > test: Output file: $@\n"
	@$(MKDIR_P) $(dir $@)
	@$(CXX) $(CXXFLAGS) -c $< -o $@


.PHONY: clean test main

clean:
	rm -fr $(BUILD_DIR)/* $(MAIN_EXEC) $(TESTS_EXEC)


MKDIR_P ?= mkdir -p