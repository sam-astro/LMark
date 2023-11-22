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
	variables[".sqrt"] = "\\sqrt";
	variables[".frac"] = "\\frac";
	variables[".f"] = "\\frac";
	variables[".sum"] = "\\sum";
	variables[".E"] = "\\sum";
	variables[".latex"] = "\\LaTeX{}";
	variables["-->"] = "$\\rightarrow$";
	variables["<--"] = "$\\leftarrow$";
	variables["==>"] = "$\\Rightarrow$";
	variables["<=="] = "$\\Leftarrow$";

	outFile += "\\documentclass{article}\n\\usepackage{listings}\n";


	bool openCode = false;

	std::string line;
	while (std::getline(infile, line))
	{
		line += " ";
		string oldline = line;

		if(!openCode)
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
			else if(split(line, ':')[1] == ":pkg")
				outFile += "\\usepackage{" + split(line, ':')[2] + "}";
		}
		else if(startsWith(line, "```")){
			if(openCode){
				outFile += "\\end{lstlisting}\n";
			}
			else{
				outFile += "\\begin{lstlisting}";
			}
			openCode = !openCode;
		}
		else if(line[0] == '#'){
			int headingLevel = count(split(line, ' ')[0], '#');
			outFile += "\\section*{" + fontSizes[headingLevel] + "{" + trim(rangeInStr(line, headingLevel + 1, -1)) + "}}\n\\normalsize{}";
		}
		// normal text, do processing
		else{
			// Check for bold text modifier
			int symbolInstances = countStr(line, "**");
			vector<string> splitSymbolSections = split(line, "**");
			if(symbolInstances > 0){
				printf("\tboldsections: %d, %d\n", symbolInstances, splitSymbolSections.size());
				printf("\t\t- line after edits: \"%s\"\n", line.c_str());
			}
			bool toggleEffect = false;
			if(startsWith(line, "**"))
				toggleEffect = true;
			
			line = makeSectionsFromDelim(splitSymbolSections, "\\textbf{", "}", toggleEffect);
			
			

			// Check for underline text modifier
			symbolInstances = countStr(line, "_");
			splitSymbolSections = split(line, "_");
			if(symbolInstances > 0){
				printf("\tunderlinedsections: %d, %d\n", symbolInstances, splitSymbolSections.size());
				printf("\t\t- line after edits: \"%s\"\n", line.c_str());
			}
			toggleEffect = false;
			if(startsWith(line, "_"))
				toggleEffect = true;

			line = makeSectionsFromDelim(splitSymbolSections, "\\underline{", "}", toggleEffect);

			

			// Check for italic text modifier
			symbolInstances = countStr(line, "*");
			splitSymbolSections = split(line, "*");
			if(symbolInstances > 0){
				printf("\titalicsections: %d, %d\n", symbolInstances, splitSymbolSections.size());
				printf("\t\t- line after edits: \"%s\"\n", line.c_str());
			}
			toggleEffect = false;
			if(startsWith(line, "*"))
				toggleEffect = true;

			line = makeSectionsFromDelim(splitSymbolSections, "\\textit{", "}", toggleEffect);



			// Check for code text modifier
			symbolInstances = countStr(line, "`");
			splitSymbolSections = split(line, "`");
			if(symbolInstances > 0){
				printf("\tcodesections: %d, %d\n", symbolInstances, splitSymbolSections.size());
				printf("\t\t- line after edits: \"%s\"\n", line.c_str());
			}
			toggleEffect = false;
			if(startsWith(line, "`"))
				toggleEffect = true;

			line = makeSectionsFromDelim(splitSymbolSections, "\\texttt{", "}", toggleEffect);


			// Finally add the edited line to the output string
			outFile += line;
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
