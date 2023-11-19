#include <iostream>
#include <string>
#include <fstream>
#include <map>
#include "strops.h"

using namespace std;

string replaceVarInstances(string& str, map<string, string>& vars){

	if(vars.size() > 0)
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
		cout << "lmarkcompile <pathtofile>\n";
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
		line += " ";
		string oldline = line;
		line = trim(replaceVarInstances(line, variables));
		bool nospace = false;

			if(line[0] == '?'){
				outFile += trim(rangeInStr(line, 1, -1));
			}
			else if(line[0] == '.'){
				variables[split(line, ' ')[0]] = trim(rangeInStr(line, (split(line, ' ')[0]).size()+1, -1));
				printf("\t + new var: %s  as  \"%s\" \n", split(line, ' ')[0].c_str(), variables[split(line, ' ')[0]].c_str());
				printf("\t\t ? expected value: \"%s\" \n", oldline.c_str());
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
			// normal text, do processing
			else{
				int numBold = countStr(line, "**");
				vector<string> splitBold = split(line, "**");
				if(numBold > 0){
					printf("\tboldsections: %d, %d\n", numBold, splitBold.size());
					printf("\t\t- line after edits: \"%s\"\n", line.c_str());
				}
				bool toggleEffect = false;
				if(startsWith(line, "**"))
					toggleEffect = true;
				
				line = makeSectionsFromDelim(splitBold, "\\textbf{", "}", toggleEffect);
				

				int numItalic = countStr(line, "*");
				vector<string> splitItalic = split(line, "*");
				if(numItalic > 0){
					printf("\titalicsections: %d, %d\n", numItalic, splitItalic.size());
					printf("\t\t- line after edits: \"%s\"\n", line.c_str());
				}
				toggleEffect = false;
				if(startsWith(line, "*"))
					toggleEffect = true;

				line = makeSectionsFromDelim(splitItalic, "\\textit{", "}", toggleEffect);

				outFile += line;
		//		int index = 0;
		//		for(string& s : splitBold){
		//			if(toggleEffect && index == 0){
		//				outFile += "\\textbf{" + s + "}";
		//				startBold = true;
		//			}
		//			else if(numBold > 0 && toggleEffect){
		//				outFile += "\\textbf{" + s + "}";
		//				numBold--;
		//			}
		//			else
		//				outFile += s;
		//			index++;
		//			toggleEffect = !toggleEffect;
		//		}
			}

		if(!nospace)
			outFile += "\n";
	}
	infile.close();
	printf("\nkey/values:\n");
	for (const auto & [key, value] : variables)
	{
		printf("\t #  key: \"%s\"  value: \"%s\"\n", key.c_str(), value.c_str());
	}
	outFile += "\\end{document}";

	std::ofstream out(split(lMarkPath, '.')[0] + ".tex");
    out << outFile;
    out.close();

	return 0;
}
