#include <filesystem>
#include <fstream>
#include <iostream>
#include <map>
#include <string>

#include "strops.h"

using namespace std;

string replaceVarInstances(string& str, map<string, string>& vars)
{

	if (vars.size() > 0)
		for (const auto& [key, value] : vars) {
			// If var name is 3 dots, it will replace all instances of the var, name without dots
			if (key.size() > 3) {
				if (key[2] == '.') {
					str = replace(str, key.substr(3, key.size() - 3), value);
					continue;
				}
			}
			// if var is two dots (..varName) then it has much more replacing power
			if (key.size() > 2) {
				if (key[1] == '.') {
					str = replace(str, key, value);
					continue;
				}
			}
			// Otherwise, normal var
			str = replaceIfOneWord(str, key, value);
		}
	return str;
}


string replaceFuncInstances(string& str, map<string, string>& functions)
{

	str = trim(str);
	std::string newStr = str;
	if (functions.size() > 0)
		for (const auto& [key, value] : functions) {
			std::vector<int> positions = strPositions(str, key);
			for (int i = 0; i < positions.size(); i++) {
				int argPos = key.size() + positions[i];
				if (str[argPos] == '(') {  // If there is a parenthesi, it is a function.
					std::string betweenP = firstLevelInDelim(str, '(', ')', argPos);
					std::string outValue = value;
					//if(count(betweenP, ',') >= 1){
					std::vector<std::string> argsStrs = split(betweenP, ',');
					for (int j = 0; j < argsStrs.size(); j++) {
						outValue = replace(outValue, "%" + std::to_string(j + 1), argsStrs[j]);
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

void processNormalLine(string& line)
{

	// Check for bold text modifier
	int symbolInstances = countOutsideDelim(line, "**", '$');
	vector<string> splitSymbolSections = splitOutsideDelim(line, "**", '$');
	bool toggleEffect = false;
	if (symbolInstances > 0) {
		printf("\tboldsections: %d, %d\n", symbolInstances, splitSymbolSections.size());

		//if(startsWith(line, "**"))
		//	toggleEffect = true;

		line = makeSectionsFromDelim(splitSymbolSections, "\\textbf{", "}", toggleEffect);
		printf("\t\t- line after edits: \"%s\"\n", line.c_str());
	}


	// Check for underline text modifier
	symbolInstances = countOutsideDelim(line, "_", '$');
	splitSymbolSections = splitOutsideDelim(line, "_", '$');
	if (symbolInstances > 0) {
		printf("\tunderlinedsections: %d, %d\n", symbolInstances, splitSymbolSections.size());

		toggleEffect = false;
		//if(startsWith(line, "_"))
		//	toggleEffect = true;

		line = makeSectionsFromDelim(splitSymbolSections, "\\underline{", "}", toggleEffect);
		printf("\t\t- line after edits: \"%s\"\n", line.c_str());
	}

	// Check for italic text modifier
	symbolInstances = countOutsideDelim(line, "*", '$');
	splitSymbolSections = splitOutsideDelim(line, "*", '$');
	if (symbolInstances > 0) {
		printf("\titalicsections: %d, %d\n", symbolInstances, splitSymbolSections.size());

		toggleEffect = false;
		//if(startsWith(line, "*"))
		//	toggleEffect = true;

		line = makeSectionsFromDelim(splitSymbolSections, "\\textit{", "}", toggleEffect);
		printf("\t\t- line after edits: \"%s\"\n", line.c_str());
	}

	// Check for code text modifier
	symbolInstances = countOutsideDelim(line, "`", '$');
	splitSymbolSections = splitOutsideDelim(line, "`", '$');
	if (symbolInstances > 0) {
		printf("\tcodesections: %d, %d\n", symbolInstances, splitSymbolSections.size());

		toggleEffect = false;
		//if(startsWith(line, "`"))
		//	toggleEffect = true;

		line = makeSectionsFromDelim(splitSymbolSections, "\\texttt{", "}", toggleEffect);
		printf("\t\t- line after edits: \"%s\"\n", line.c_str());
	}
}

void closeList(string& outFile, bool& openList)
{
	// stop list if open
	if (openList) {
		openList = !openList;
		outFile += "\\end{itemize}\n";
	}
}

string fontSizes[] = {"\\Huge", "\\huge", "\\LARGE", "\\Large", "\\large"};
string sectionDepths[] = {"section", "subsection", "subsubsection", "paragraph", "subparagraph"};

int main(int argc, char** argv)
{

	string lMarkPath = "";

	if (argc == 1) {
		cout << "Please provide required arguments\n";
		cout << "lmarkcompile <pathtofile>\n";
		cout << "               ^^^^^^^^^^^^\n";
	}
	if (argc == 2) {
		lMarkPath = argv[1];
	}

	ifstream infile(lMarkPath);

	std::filesystem::path p(lMarkPath);
	string workingdir = p.parent_path().string();

	std::string outFile;
	std::string mdFile;
	std::map<std::string, std::string> variables;
	std::map<std::string, std::string> functions;
	variables[".sqrt"] = "\\sqrt";
	variables[".frac"] = "\\frac";
	variables[".f"] = "\\frac";
	variables[".latex"] = "\\LaTeX{}";
	variables[".hrfull"] = "\\noindent \\makebox[\\linewidth]{\\rule{\\paperwidth}{0.4pt}}";
	variables[".hrhalf"] = "\\noindent \\makebox[\\linewidth]{\\rule{15cm}{0.4pt}}";
	variables[".hr"] = "\\noindent \\makebox[\\linewidth]{\\rule{15cm}{0.4pt}}";
	variables[".tableofcontents"] = "\\tableofcontents";
	variables[".space"] = "\\vspace{5mm} %5mm vertical space";
	variables[".filename"] = replace(capitalize(split(lMarkPath, '.')[0]), "_", " ");
	variables[".newpage"] = "\\newpage";
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

	//std::vector<std::string> markdownVec = std::vector<std::string>();
	std::vector<std::string> linesVec = std::vector<std::string>();
	std::string l;
	int newlineInARow = 0;
	linesVec.push_back(":pkg:hyperref ");
	linesVec.push_back(":pkg:graphicx ");
	linesVec.push_back(":pkg:indentfirst ");
	linesVec.push_back(":pkg:color ");
	linesVec.push_back(":pkg:listings ");
	linesVec.push_back("\\graphicspath{ {~/Pictures} {./Images}} ");
	linesVec.push_back(":func:img \\includegraphics[width=\\textwidth]{%1} ");
	linesVec.push_back(":func:imgh \\includegraphics[width=0.5\\textwidth]{%1} ");
	linesVec.push_back(":func:url \\url{%1} ");
	while (std::getline(infile, l)) {
		if (l == "\n" || l == "") {
			newlineInARow++;
			if (newlineInARow >= 2) {
				l = ".space";
				newlineInARow = 0;
			}
		}
		else
			newlineInARow = 0;
		l += " ";
		linesVec.push_back(l);
	}

	for (int i = 0; i < linesVec.size(); i++) {
		string line = linesVec[i];

		string oldline = line;


		if (!openCode) {
			line = replaceVarInstances(line, variables);
			if (oldline != line)
				printf("\t replaced variables:\n\t\t- old line: \"%s\"\n\t\t+ new line: \"%s\"\n", oldline.c_str(), line.c_str());
			line = replaceFuncInstances(line, functions);
		}

		bool nospace = false;

		if (line.length() <= 1) {
			outFile += '\n';
			mdFile += "\n";
			continue;
		}

		if (replace(line, "\\end{document}", "") != line)
			hasDocumentEnd = true;
		if (replace(line, "\\documentclass", "") != line) {
			hasDocumentClass = true;
			outFile = line + "\n" + outFile;
			continue;
		}


		// Look for other leading character modifiers
		if (line[0] == '?') {
			closeList(outFile, openList);
			outFile += trim(rangeInStr(line, 1, -1));
		}
		else if (line[0] == '.') {
			closeList(outFile, openList);
			variables[split(line, ' ')[0]] = trim(line.substr((split(line, ' ')[0]).size(), line.size() - (split(line, ' ')[0]).size()));
			//variables[split(line, ' ')[0]] = trim(rangeInStr(line, (split(line, ' ')[0]).size()+1, -1));
			printf("\t + new var: %s  as  \"%s\" \n", split(line, ' ')[0].c_str(), variables[split(line, ' ')[0]].c_str());
			//printf("\t\t ? expected value: \"%s\" \n", oldline.c_str());
			nospace = true;
		}
		else if (line[0] == ':') {
			closeList(outFile, openList);
			if (split(line, ' ')[0] == ":content") {
				outFile += "\\begin{document}";
				hasBegunDocument = true;
			}
			else if (split(line, ':')[1] == "pkg")
				outFile += "\\usepackage{" + split(line, ':')[2] + "}";
			else if (split(line, ':')[1] == "func") {
				functions[split(split(line, ':')[2], ' ')[0]] = trim(rangeInStr(line, (split(line, ' ')[0]).size() + 1, -1));
				printf("\t + new function: %s  as  \"%s\" \n", split(split(line, ':')[2], ' ')[0].c_str(), functions[split(split(line, ':')[2], ' ')[0]].c_str());
				printf("\t\t ? expected value: \"%s\" \n", oldline.c_str());
				nospace = true;
			}
			else if (split(line, ':')[1] == "include") {
				string filepath = workingdir + "./" + trim(split(line, ':')[2]);
				printf("\t ^ including file: \"%s\"\n", filepath.c_str());
				if (std::filesystem::exists(filepath)) {
					ifstream includefile(filepath);

					std::string l;
					while (std::getline(includefile, l)) {
						linesVec.insert(linesVec.begin() + i + 1, l + " ");
						printf("\t\t + adding line: \"%s\"\n", l.c_str());
					}
					includefile.close();
				}
				else
					printf("\t ! file not found! \"%s\"\n", filepath.c_str());
			}
			else if (split(line, ':')[1] == "includevars") {
				string filepath = workingdir + "./" + trim(split(line, ':')[2]);
				printf("\t ^ including variables from file: \"%s\"\n", filepath.c_str());
				std::map<std::string, bool> varMap = std::map<std::string, bool>();
				if (std::filesystem::exists(filepath)) {
					ifstream includefile(filepath);

					std::string l;
					while (std::getline(includefile, l)) {
						if (startsWith(l, ".")) {
							if (split(l, ' ').size() == 1)	// Only var definitions, not uses
								continue;
							std::string vName = split(l, ' ')[0];
							// If the variable isnt defined yet
							if (varMap.find(vName) == varMap.end()) {
								linesVec.insert(linesVec.begin() + i + 1, l + " ");
								varMap[vName] = true;
							}
						}
						else if (startsWith(l, ":func") || startsWith(l, ":pkg")) {
							linesVec.insert(linesVec.begin() + i + 1, l + " ");
							printf("\t\t + adding line: \"%s\"\n", l.c_str());
						}
					}
					includefile.close();
				}
				else
					printf("\t ! file not found! \"%s\"\n", filepath.c_str());
			}
		}
		else if (startsWith(line, "* ")) {
			if (!openList) {
				outFile += "\\begin{itemize}\n";
				openList = !openList;
			}
			line = line.substr(2, line.size());
			printf("\t list item: \"%s\"\n", line.c_str());
			processNormalLine(line);
			outFile += "\\item " + line;
			mdFile += oldline + "\n";
		}
		else if (startsWith(line, "```")) {
			closeList(outFile, openList);
			if (openCode) {
				outFile += "\\end{lstlisting}\n";
			}
			else {
				outFile += "\\begin{lstlisting}";
			}
			mdFile += oldline + "\n";
			openCode = !openCode;
		}
		else if (line[0] == '#') {
			closeList(outFile, openList);
			int headingLevel = count(split(line, ' ')[0], '#');
			std::string headerValue = trim(rangeInStr(line, headingLevel + 1, -1));
			outFile += "\\section*{" + fontSizes[headingLevel] + "{" + headerValue + "}}\n\\normalsize{} \n";
			mdFile += oldline + "\n";
			// The largest of section headers will not count towards the table of contents,
			// since they are usually only used for the title
			if (headingLevel > 1) {
				outFile += "\\phantomsection \n";
				outFile += "\\addtocontents{toc}{\\protect\\setcounter{tocdepth}{" + std::to_string(headingLevel) + "}} \n";
				outFile += "\\addcontentsline{toc}{" + sectionDepths[headingLevel - 2] + "}{" + headerValue + "} \n";
			}
		}
		// normal text, do processing
		else {
			closeList(outFile, openList);

			// Add indent if tab char, don't if no tab char
			if (oldline[0] != '\t' && oldline[0] != ' ' && oldline[0] != '\\' && oldline[0] != '%' && hasBegunDocument) {
				if (!openCode)
					outFile += "\\noindent ";
			}
			else {
				outFile += "\n";
			}

			// Finally add the edited line to the output string
			if (line[0] != '\\')
				mdFile += "\n" + oldline;
			processNormalLine(line);
			outFile += line;
		}

		if (!nospace) {
			outFile += "\n";
			//mdFile += "\n";
		}
	}
	infile.close();
	closeList(outFile, openList);
	printf("\nkey/values:\n");
	for (const auto& [key, value] : variables) {
		printf("\t #  key: \"%s\"  value: \"%s\"\n", key.c_str(), value.c_str());
	}
	if (!hasDocumentClass)
		outFile = "\\documentclass{article}\n" + outFile;
	if (!hasDocumentEnd)
		outFile += "\\end{document}";

	if (!std::filesystem::exists("./markdown"))
		std::filesystem::create_directory("./markdown");
	if (!std::filesystem::exists("./output"))
		std::filesystem::create_directory("./output");
	if (!std::filesystem::exists("./LMarkFiles"))
		std::filesystem::create_directory("./LMarkFiles");
	std::ofstream out("./LMarkFiles/" + split(lMarkPath, '.')[0] + ".tex");
	out << outFile;
	out.close();
	std::printf("\n\nSuccessfully wrote LaTeX file to %s\n", ("./LMarkFiles/" + split(lMarkPath, '.')[0] + ".tex").c_str());

	std::ofstream outMD("./LMarkFiles/" + split(lMarkPath, '.')[0] + ".md");
	outMD << mdFile;
	outMD.close();
	std::printf("\n\nSuccessfully wrote Markdown file to %s\n", ("./LMarkFiles/" + split(lMarkPath, '.')[0] + ".md").c_str());


	return 0;
}
