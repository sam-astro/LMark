#include <iostream>
#include <string>
#include <fstream>
#include <filesystem>
#include <map>
#include "strops.h"

using namespace std;

string replaceVarInstances(string& str, map<string, string>& vars){

	if(vars.size() > 0)
		for (const auto & [key, value] : vars)
		{
			// if var is two dots (..varName) then it has much more replacing power
			if(key[1] == '.')
				str = replace(str, key, value);
			// Otherwise, normal var
			else
				str = replaceIfOneWord(str, key, value);
		}
	return str;
}


string replaceFuncInstances(string& str, map<string, string>& functions){

	str = trim(str);
	std::string newStr = str;
	if(functions.size() > 0)
		for (const auto & [key, value] : functions)
		{
			std::vector<int> positions = strPositions(str, key);
			for(int i = 0; i < positions.size(); i++)
			{
				int argPos = key.size() + positions[i];
				if(str[argPos] == '('){ // If there is a parenthesi, it is a function.
					std::string betweenP = firstLevelInDelim(str, '(', ')', argPos);
					std::string outValue = value;
					//if(count(betweenP, ',') >= 1){
						std::vector<std::string> argsStrs = split(betweenP, ',');
						for(int j = 0; j < argsStrs.size(); j++){
							outValue = replace(outValue, "%" + std::to_string(j+1), argsStrs[j]);
						}
					//}
					printf("\t calling function `%s`, on input: \"%s\"\n", key.c_str(), str.c_str());
					newStr = replace(newStr, key + "(" + betweenP + ")", outValue);
					printf("\t\t > replace: `%s`\n", (key + "(" + betweenP + ")").c_str());
					printf("\t\t > with outValue: `%s`\n", outValue.c_str());
					printf("\t\t > new line: `%s`\n", newStr.c_str());
				}
			}
		}
	return newStr;
}

void processNormalLine(string& line){

	// Check for bold text modifier
	int symbolInstances = countOutsideDelim(line, "**", '$');
	vector<string> splitSymbolSections = splitOutsideDelim(line, "**", '$');
	bool toggleEffect = false;
	if(symbolInstances > 0){
		printf("\tboldsections: %d, %d\n", symbolInstances, splitSymbolSections.size());
		printf("\t\t- line after edits: \"%s\"\n", line.c_str());

		if(startsWith(line, "**"))
			toggleEffect = true;
		
		line = makeSectionsFromDelim(splitSymbolSections, "\\textbf{", "}", toggleEffect);
	}
	
	

	// Check for underline text modifier
	symbolInstances = countOutsideDelim(line, "_", '$');
	splitSymbolSections = splitOutsideDelim(line, "_", '$');
	if(symbolInstances > 0){
		printf("\tunderlinedsections: %d, %d\n", symbolInstances, splitSymbolSections.size());
		printf("\t\t- line after edits: \"%s\"\n", line.c_str());

		toggleEffect = false;
		if(startsWith(line, "_"))
			toggleEffect = true;

		line = makeSectionsFromDelim(splitSymbolSections, "\\underline{", "}", toggleEffect);
	}	

	// Check for italic text modifier
	symbolInstances = countOutsideDelim(line, "*", '$');
	splitSymbolSections = splitOutsideDelim(line, "*", '$');
	if(symbolInstances > 0){
		printf("\titalicsections: %d, %d\n", symbolInstances, splitSymbolSections.size());
		printf("\t\t- line after edits: \"%s\"\n", line.c_str());

		toggleEffect = false;
		if(startsWith(line, "*"))
			toggleEffect = true;

		line = makeSectionsFromDelim(splitSymbolSections, "\\textit{", "}", toggleEffect);
	}

	// Check for code text modifier
	symbolInstances = countOutsideDelim(line, "`", '$');
	splitSymbolSections = splitOutsideDelim(line, "`", '$');
	if(symbolInstances > 0){
		printf("\tcodesections: %d, %d\n", symbolInstances, splitSymbolSections.size());
		printf("\t\t- line after edits: \"%s\"\n", line.c_str());

		toggleEffect = false;
		if(startsWith(line, "`"))
			toggleEffect = true;

		line = makeSectionsFromDelim(splitSymbolSections, "\\texttt{", "}", toggleEffect);
	}
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

	std::filesystem::path p(lMarkPath);
	string workingdir = p.parent_path().string();

	std::string outFile;
	std::map<std::string, std::string> variables;
	std::map<std::string, std::string> functions;
	variables[".sqrt"] = "\\sqrt";
	variables[".frac"] = "\\frac";
	variables[".f"] = "\\frac";
	variables[".latex"] = "\\LaTeX{}";
	variables[".hrfull"] = "\\noindent \\makebox[\\linewidth]{\\rule{\\paperwidth}{0.4pt}}";
	variables[".hrhalf"] = "\\noindent \\makebox[\\linewidth]{\\rule{15cm}{0.4pt}}";
	variables[".filename"] = replace(capitalize(split(lMarkPath, '.')[0]), "_", " ");
	variables["-->"] = "$\\rightarrow$";
	variables["<--"] = "$\\leftarrow$";
	variables["==>"] = "$\\Rightarrow$";
	variables["<=="] = "$\\Leftarrow$";

	//outFile += "\\documentclass{article}\n\\usepackage{listings}\n";


	bool openCode = false;
	bool openList = false;

	bool hasDocumentClass = false;
	bool hasDocumentEnd = false;
	bool hasBegunDocument = false;

	std::vector<std::string> linesVec = std::vector<std::string>();
	std::string l;
	while (std::getline(infile, l))
	{
		l += " ";
		linesVec.push_back(l);
	}

	for(int i = 0; i < linesVec.size(); i++){
		string line = linesVec[i];

		string oldline = line;

		if(!openCode){
			line = replaceVarInstances(line, variables);
			line = replaceFuncInstances(line, functions);
		}

		bool nospace = false;

		if(line.length()<= 1){
				outFile += '\n';
			continue;
		}

		if(replace(line, "\\end{document}", "") != line)
			hasDocumentEnd = true;
		if(replace(line, "\\documentclass", "") != line)
			hasDocumentClass = true;
		
		
		// Look for other leading character modifiers
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
			if(split(line, ' ')[0] == ":content"){
				outFile += "\\begin{document}";
				hasBegunDocument = true;
			}
			else if(split(line, ':')[1] == "pkg")
				outFile += "\\usepackage{" + split(line, ':')[2] + "}";
			else if(split(line, ':')[1] == "func"){
				functions[split(split(line, ':')[2], ' ')[0]] = trim(rangeInStr(line, (split(line, ' ')[0]).size()+1, -1));
				printf("\t + new function: %s  as  \"%s\" \n", split(split(line, ':')[2], ' ')[0].c_str(), functions[split(split(line, ':')[2], ' ')[0]].c_str());
				printf("\t\t ? expected value: \"%s\" \n", oldline.c_str());
				nospace = true;
			}
			else if(split(line, ':')[1] == "include"){
				string filepath = workingdir+"./"+trim(split(line, ':')[2]);
				printf("\t ^ including file: \"%s\"\n", filepath.c_str());
				if(std::filesystem::exists(filepath)){
					ifstream includefile(filepath);

					std::string l;
					while (std::getline(includefile, l)){
						linesVec.insert(linesVec.begin() + i + 1, l);
						printf("\t\t + adding line: \"%s\"\n", l.c_str());
					}
					includefile.close();
				}
				else
					printf("\t ! file not found! \"%s\"\n", filepath.c_str());
			}
		}
		else if(startsWith(line, "* ")){
			if(!openList){
				outFile += "\\begin{itemize}\n";
				openList = !openList;
			}
			processNormalLine(line);
			outFile += "\\item " + line;
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
			// Stop list if open
			if(openList){
				outFile += "\\end{itemize}\n";
				openList = !openList;
			}

			// Add indent if tab char, don't if no tab char
			if(line[0] != '\t' && line[0] != ' ' && line[0] != '\\' && line[0] != '%' && hasBegunDocument){
				outFile += "\\noindent ";
			}
			else{
				outFile += "\n";
			}

			// Finally add the edited line to the output string
			processNormalLine(line);
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
	if(!hasDocumentClass)
		outFile = "\\documentclass{article}\n"+outFile;
	if(!hasDocumentEnd)
		outFile += "\\end{document}";

	if(!std::filesystem::exists("./LMarkFiles"))
		std::filesystem::create_directory("./LMarkFiles");
	std::ofstream out("./LMarkFiles/" + split(lMarkPath, '.')[0] + ".tex");
    out << outFile;
    out.close();

	return 0;
}
