/*-------------------------------------------------------------------------------------------
 * qblocks - fast, easily-accessible, fully-decentralized data from blockchains
 * copyright (c) 2018, 2019 TrueBlocks, LLC (http://trueblocks.io)
 *
 * This program is free software: you may redistribute it and/or modify it under the terms
 * of the GNU General Public License as published by the Free Software Foundation, either
 * version 3 of the License, or (at your option) any later version. This program is
 * distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even
 * the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details. You should have received a copy of the GNU General
 * Public License along with this program. If not, see http://www.gnu.org/licenses/.
 *-------------------------------------------------------------------------------------------*/
#include "etherlib.h"

class COptions : public COptionsBase {
    public:
    COptions(void) : COptionsBase() {}
    bool parseArguments(string_q& command) { return true; };
    void Init(void) {};
};

bool visit(const string_q& path, void *ptr) {
    if (!contains(path, "out.csv"))
        return true;

    uint64_t n = 0;
    uint64_t cnt = 0;
    CStringArray lines;
    asciiFileToLines(path, lines);
    string_q start;
    for (auto line: lines) {
        if (cnt == 0 && line.empty()) { cout << "Error at line " << n << " in " << path << endl; return false; }
        if (cnt == 0) {
            start = trim(line.substr(40, 20));
        }
        if (cnt == 1 && line.empty()) { cout << "Error at line " << n << " in " << path << endl; return false; }
        if (cnt == 1) {
            CStringArray parts;
            explode(parts, line, ',');
            cout << parts[2] << "\t\"" << start << "\"" << endl;
        }
        if (cnt == 2 && !line.empty()) { cout << "Error at line " << n << " in " << path << endl; return false; }
        //cout << line << endl;
        cnt++;
        n++;
        if (cnt > 2) cnt = 0;
    }
    //cout << endl;

//    CStringArray lines;
//    asciiFileToLines(path, lines);
//    cout << path << ": " << endl;
//
//    CStringArray donations, txs;
//    for (auto line : lines) {
//        if (str_2_Uint(line) < 2000) {
//            donations.push_back(line);
//        } else {
//            txs.push_back(line);
//        }
//    }
//
//    CStringArray parts;
//    map <string_q, CStringArray> days;
//    string_q curDate;
//    for (auto donation : donations) {
//        parts.clear();
//        explode(parts, donation, ',');
//        if (curDate != parts[3])
//            curDate = parts[3];
//        days[curDate].push_back(donation);
//    }
//
//    ostringstream os;
//    for (auto day : days) {
//        string_q date;
//        for (auto row: day.second) {
//            parts.clear();
//            explode(parts, row, ',');
//            os << padRight(parts[5], 20) << padRight(parts[6], 20) << padRight(parts[4], 20) << row << endl;
//            date = parts[3];
//        }
//        for (auto tx : txs) {
//            if (contains(tx, date)) {
//                parts.clear();
//                explode(parts, tx, ',');
//                os << padRight(parts[4], 20) << padRight(parts[5], 20) << parts[1] << "\t" << tx << endl;
//            }
//        }
//        os << endl;
//    }
//    cerr << path << endl;
//    stringToAsciiFile(substitute(substitute(path, ".csv", ".out.csv"), "/data/", "/out/"), os.str());
//
    return true;
}

//----------------------------------------------------------------
int main(int argc, const char* argv[]) {
    etherlib_init(quickQuitHandler);
    //COptions options;
    //forEveryFileInFolder("./out/*", visit, &options);
    string_q contents = asciiFileToString("/Users/jrush/Desktop/Gitcoin12");
    CStringArray lines;
    explode(lines, contents, '\n');
    uint32_t cnt = 0;
    CAccountName name;
    for (auto line : lines) {
        if (cnt == 0) name.source = line;
        else if (cnt == 1) name.name = substitute(substitute(line, ":", ""), "-", "");
        else if (cnt == 2) name.description = line;
        else if (cnt == 3) name.address = line;
        cnt++;
        if (cnt == 5) {
            name.tags = "31-Gitcoin Grants:Grant";
            if (!name.name.empty()) {
                string_q s = substitute(name.source, "https://gitcoin.co/grants/", "");
                name.name = "Grant " + nextTokenClear(s, '/') + " " + name.name;
                cout << "addName \"";
                cout << name.address << "\" \"";
                cout << name.name << "\"\t\"";
                cout << name.tags << "\"\t\"";
                cout << name.source << "\"\t\"";
                cout << "\"\t\"";
                cout << "\"\t\"";
                cout << name.description << "\"";
                cout << endl;
            }
            cnt = 0;
            name = CAccountName();
        }
        /*
         ADDRESS=$1
         NAME=$2
         TAG=${3:-$defTag}
         SOURCE=${4:-$defSource}
         SYMBOL=$5
         DECIMALS=${6:-$defDecimals}
         DESCR=$7
        */
    }
    etherlib_cleanup();
}

#if 0
class COptions : public COptionsBase {
    public:
    COptions(void) : COptionsBase() {}
    bool parseArguments(string_q& command) { return true; };
    void Init(void) {};
};

bool findGrant(CAccountName& name, void *data) {
    if (contains(name.name, "Grant") && !name.source.empty()) {
        CAccountName *result = (CAccountName*)data;
        string_q search = "/grants/" + result->address + "/";
        if (contains(name.source, search)) {
            //cerr << search << "\t" << name.address << "\t" << name.source << endl;
            *result = name;
            return false;
        }
    }
    return true;
}

//----------------------------------------------------------------
bool visit(const string_q& path, void *ptr) {
    if (!contains(path, "tab_transactions.txt"))
        return true;

    string_q txFile = substitute(path, "tab_transactions", "txs");
    CStringArray txs;
    if (fileExists(txFile))
        asciiFileToLines(txFile, txs);

    COptions *options = (COptions*)ptr;
    CAccountName name;

    string_q content = trim(trim(trim(asciiFileToString(path)), '\n'), '\r');

    replaceAll(content, "<donation>", "");
    replaceAll(content, "</donation>", "|");
    CStringArray donations;
    explode(donations, content, '|');
    size_t cnt = 0;
    size_t inc = 0;
    for (auto donation : donations) {
        replaceAll(donation, "\n", "");
        replaceAll(donation, "\t", "");
        donation = substitute(trim(donation), ",", "");
        string_q date = snagFieldClear(donation, "date");
        string_q donor = snagFieldClear(donation, "donor");
        string_q amount = snagFieldClear(donation, "amount");
        string_q tip = substitute(snagFieldClear(donation, "tip"), " optional tip", "");

        string_q data = substitute(substitute(substitute(path, "_tab_transactions.txt", ""), "./data/", ""), "_", " ");
        CStringArray parts;
        explode(parts, data, ' ');
        string_q number = parts[0] + ' ' + parts[1];
        data = substitute(data, number + " ", "");
        number = substitute(number, "grant ", "");

        map<string_q,uint64_t> theMap;
        theMap["Jan"] = 1;
        theMap["Feb"] = 2;
        theMap["Mar"] = 3;
        theMap["Apr"] = 4;
        theMap["May"] = 5;
        theMap["Jun"] = 6;
        theMap["Jul"] = 7;
        theMap["Aug"] = 8;
        theMap["Sep"] = 9;
        theMap["Oct"] = 10;
        theMap["Nov"] = 11;
        theMap["Dec"] = 12;

        if (name.address.empty()) {
            name.address = number; // hack
            options->forEveryNamedAccount(findGrant, &name);
        }

        parts.clear();
        explode(parts, date, ' ');
        date = parts[2] + "-" + padNum2(theMap[parts[1]]) + "-" + parts[0];

        uint64_t index1 = uint64_t(donations.size() - 1) - cnt;
        uint64_t index2 = uint64_t(txs.size() - 1) - inc;

        cout << number << ",";
        cout << padNum5(index1) << ",";
        cout << name.address << ",";
        cout << date << ",";
        cout << donor << ",";
        cout << amount << ",";
        cout << substitute((contains(tip, "</amount>") ? "" : tip), "  ", " ") << ",";
        cout << substitute(substitute(name.name, ",", " "), "  ", " ") << ",";
        cout << "\"" << data << "\"" << endl;

        if (txs.size() > 0 && index2 < txs.size()) {
            string_q tx = txs[index2];
            string_q dd = nextTokenClear(tx, ',');
            dd = nextTokenClear(dd, ' ');
            string addr = nextTokenClear(tx, ',');

            cout << number << ",";
            cout << padNum5(index2) << ",";
            cout << name.address << ",";
            cout << dd << ",yy-";
            cout << addr << ",";
            cout << tx << endl;
            cout << endl;
        }

        inc++;
        cnt++;
    }
    return true;
}

//----------------------------------------------------------------
int main(int argc, const char* argv[]) {
    etherlib_init(quickQuitHandler);
    COptions options;
    qblocks::loadNames(options);
    forEveryFileInFolder("./data/*", visit, &options);
    etherlib_cleanup();
}
#endif

