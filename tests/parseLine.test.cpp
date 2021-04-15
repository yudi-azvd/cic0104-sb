#include <iostream>
#include <vector>

#include "../lib/doctest/doctest.h"

struct LineAndItsTokens {
  std::string line;
  std::vector<std::string> tokens;

  friend std::ostream &operator<<(std::ostream& os, const LineAndItsTokens& line);

  friend std::ostream &operator<<(std::ostream& os, const LineAndItsTokens& line) {
    std::string tokens = "";
    for(auto token : line.tokens)
      tokens.append("\"" + token + "\", ");
    return os << "\"" << line.line << "\"" << ", {" << tokens << "}";
  }
};

std::vector<std::string> parseLine(std::string line) {
  int labelIndex = 0, operationIndex = 0, operand1Index = 0, operand2Index = 0;
  bool labelFound = false;
  std::vector<std::string> tokens;


  // encontrar label 
  // encontrar operando 
  for (int i = 0; i < line.length(); i++) {
    if (line[i] == ':' && !labelFound) {
      labelFound = true;
      labelIndex = i;

      std::string label = "";

      // label mal escrito vai dar ruim!!!
      while (std::isalpha(line[labelIndex])) {
        label.append("" + line[labelIndex]);
      }
      
      tokens.push_back(label);
    }
  }
  
  return tokens;
}

TEST_CASE("parse line") {
  std::string line;
  std::vector<std::string> expectedTokens;
  std::vector<std::string> gotTokens;

  std::vector<LineAndItsTokens> lineAndItsTokens {
    {"COPY SRC DST", {"COPY", "SRC", "DST"}},
    {"N2: SPACE", {"N2", "SPACE"}},
  };

  int i = 0;
  for (auto ln : lineAndItsTokens) {
    line = ln.line;
    expectedTokens = ln.tokens;
    gotTokens = parseLine(line);
    INFO(i++, ": ", ln);
    CHECK_EQ(gotTokens, expectedTokens);
  }
  
  CHECK("essa string" != "dessa outr string");
}


TEST_CASE("parse line") {
  std::string line;
  std::vector<std::string> expectedTokens;
  std::vector<std::string> gotTokens;

  std::vector<LineAndItsTokens> lineAndItsTokens {
    {"N2: SPACE", {"N2", "SPACE"}},
  };

  gotTokens = parseLine(lineAndItsTokens[0].line);
  
  CHECK_EQ(gotTokens[0], "N2");
}
