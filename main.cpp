#include <iostream>
#include <string>
#include <fstream>
#include <map>
#include "strops.h"

using namespace std;

string replaceVarInstances(string& str, map<string, string>& vars){

	for (const auto & [key, value] : vars)
	{
		str = replace(str, key, value);
	}
	return str;
}

string fontSizes[] = {"\\Huge", "\\huge", "\\LARGE", "\\Large", "\\large"};

int main(int argc, char** argv){
	
	string lMarkPath = "";

	if(argc == 1){
		cout << "Please provide required arguments\n";
		cout << "lmarknotes.exe <pathtofile>\n";
		cout << "               ^^^^^^^^^^^^\n";
	}
	if(argc == 2){
		lMarkPath = argv[1];
	}

	ifstream infile(lMarkPath);

	std::string outFile;
	std::map<std::string, std::string> variables;

	outFile += "\\documentclass{article}\n";

	std::string line;
	while (std::getline(infile, line))
	{
		line = trim(replaceVarInstances(line, variables));
		bool nospace = false;

		if(line[0] == '?'){
			outFile += trim(rangeInStr(line, 1, -1));
		}
		else if(line[0] == '.'){
			variables[split(trim(line), ' ')[0]] = trim(rangeInStr(line, (split(trim(line), ' ')[0]).size(), trim(line).size()));
			nospace = true;
		}
		else if(line[0] == ':'){
			if(split(line, ' ')[0] == ":content")
				outFile += "\\begin{document}";
			nospace = true;
		}
		else if(line[0] == '#'){
			int headingLevel = count(split(line, ' ')[0], '#');
			outFile += "\\section*{" + fontSizes[headingLevel] + "{" + trim(rangeInStr(line, headingLevel + 1, -1)) + "}}\n\\normalsize{}";
		}
		else{
			outFile += line;
		}

		if(!nospace)
			outFile += "\n";
	}
	infile.close();

	outFile += "\\end{document}";

	std::ofstream out(split(lMarkPath, '.')[0] + ".tex");
    out << outFile;
    out.close();

	return 0;
}
