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
#include "utillib.h"
#include "classes/grant.h"

class COptions : public COptionsBase {
public:
    COptions(void) : COptionsBase() {
        CAccountName name;
        getNamedAccount(name, "0x0000000000000000000000000000000010101010");
    }
    bool parseArguments(string_q& command) override;
    void Init(void) override;
};

bool COptions::parseArguments(string_q& command) { return true; }
void COptions::Init(void) {}

string_q getURL(const address_t& addr) {
    static map<address_t, string_q> theMap;
    if (theMap.empty()) {
        CStringArray lines;
        asciiFileToLines("./url.txt", lines);
        for (auto line : lines) {
            CStringArray parts;
            explode(parts, line, '\t');
            theMap[parts[0]] = parts[1];
        }
    }
    return theMap[addr];
}
//----------------------------------------------------------------
extern string_q cleanName(CAccountName& name, const CGrant& grant);
extern string_q postpareString(const string_q &str);
extern string_q prepareString(const string_q &str);
extern bool loadGrants(CGrantArray& grants);
int main(int argc, char *argv[])
{
    string_q commands;
    COptions options;
    options.parseArguments(commands);
    
    CAccountName::registerClass();
    CGrant::registerClass();
    CMetaData::registerClass();
    CCounter::registerClass();
    CProfile::registerClass();
    COrganization::registerClass();
    CPoint2d::registerClass();
    CPoint3d::registerClass();
    
    manageFields("CAccountName:tags,address,name,symbol,source,decimals,description,is_custom,is_prefund,is_contract,is_erc20,is_erc721", true);

    CGrantArray grants;
    loadGrants(grants);
    // uint32_t cnt = 0;
    // for (auto a : options.namedAccounts)
    // {
    //     if (a.tags == "31-Gitcoin Grants:Grant") {
    //         for (auto g : grants) {
    //             if (g.admin_address == a.address) {
    //                 ostringstream n;
    //                 n << "\t" << "Grant " << padNum4(g.grant_id) << " " << g.title;
    //                 ostringstream o;
    //                 o << "\t" << a.name;
    //                 if (toLower(n.str()) != toLower(o.str())) {
    //                     cout << (cnt++) << ". " << a.address << endl;
    //                     cout << n.str() << endl;
    //                     cout << o.str() << endl;
    //                     cout << endl;
    //                 }
    //             }
    //         }
    //         cout << string_q(120, '-') << endl;
    //     }
    // }

#if 0
    sort(grants.begin(), grants.end());
    cout << "#!/usr/bin/env bash" << endl << endl;
    for (auto g : grants) {
        if (!g.slug.empty() && !isZeroAddr(g.admin_address)) {
            cout << "./file.1 " << g.admin_address << " " << "\"Grant " << g.grant_id << " " << g.title << "\"";
            cout << " \"31-Gitcoin Grants:Grant\" \"http://gitcoin.co/grants/" << g.grant_id;
            cout << "/" << g.slug << "\"" << endl;
        }
//            cout << "./file.1 " << g.grant_id << " " << g.slug << endl;
    }
#else
#if 0
    sort(grants.begin(), grants.end(), sortGrantsByAddress);
    CAddressArray addrs;
    ostringstream os;
    os << "chifra list ";
    size_t cnt = 0;
    for (auto grant : grants) {
        if (isAddress(grant.admin_address)) {
            if (++cnt > max)
                break;
            addrs.push_back(grant.admin_address);
            os << grant.admin_address << " ";
            if (addrs.size() == 13) {
                cout << os.str() << endl;
                addrs.clear();
                os.clear();
                os.str("");
                os << "chifra list ";
            }
        }
    }
    if (os.str() != "chifra list ")
        cout << os.str() << endl;
#else
#if 1
    for (auto grant : grants) {
        if (!grant.slug.empty() && !isZeroAddr(grant.admin_address)) {
            CAccountName acct;
            if (!options.getNamedAccount(acct, grant.admin_address)) {
                if (true) { //grant.grant_id != 184) {
                    string_q name = cleanName(acct, grant);
                    string_q slug = "https://gitcoin.co/grants/" + uint_2_Str(grant.grant_id) + "/" + grant.slug;
                    if (true) { // name != acct.name) {
                        cout << "addName ";
                        cout << "\"" << grant.admin_address << "\" ";
                        cout << "\"" << name << "\" ";
                        cout << "\"" << "31-Gitcoin Grants:Grant" << "\" ";
                        cout << "\"" << slug << "\" ";
                        cout << "\"\" ";
                        cout << "\"\" ";
                        cout << "\"" << getURL(grant.admin_address) << "\"";
                        cout << endl;
                    }
                }
            }
        }
    }
#else
    string_q contents = prepareString(asciiFileToString(file));
    CGrant grant;
    if (contents == "[]\n") {
        stringToAsciiFile("xx", contents);
    } else {
        grant.parseJson3(contents);
        grant.description = postpareString(grant.description);
        grant.title = postpareString(grant.title);
        grant.reference_url = postpareString(grant.reference_url);
        replaceAll(grant.title, "\\", "");
        ostringstream os;
        os << "[" << grant << "]";
        stringToAsciiFile("xx", os.str());
    }
    ostringstream s;
    s << "cat xx | jq . >" << substitute(file, "data/", "data/") << endl;
    system(s.str().c_str());
    cerr << s.str();
    usleep(5000);
    // if (file > "./data/1500.json")
    //     break;
#endif
#endif
#endif
    //    for (uint32_t pk = 2196 ; pk <= 2200 ; pk++) {
    //        ostringstream os;
    //        os << "curl -s \"https://gitcoin.co/api/v0.1/grants/?pk=" << pk << "\" | jq . >data/" << pk << ".json";
    //        system(os.str().c_str());
    //        usleep(500000);
    //        cerr << pk << endl;
    //    }

    return 0;
}

#if 0
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

#endif

//----------------------------------------------------------------
string_q postpareString(const string_q &str)
{
    string_q ret = substitute(str, "+XX+", ",");
//    ret = substitute(ret, "[EMPTY]", "");
//    ret = substitute(ret, "screama", "schema");
//    ret = substitute(ret, " true ", " ``true`` ");
//    ret = substitute(ret, " false ", " ``false`` ");
//    ret = substitute(ret, " or null", " or ``null``");
    return ret;
}

//----------------------------------------------------------------
string_q prepareString(const string_q &str)
{
    string_q copy = str;
    copy = substitute(copy, "“", "'");
    copy = substitute(copy, "”", "'");
    copy = substitute(copy, "\\\"", "'");
//    copy = substitute(copy, "\"\",\n", "\"[EMPTY]\",\n");
//    copy = substitute(copy, "\"\"\n", "\"[EMPTY]\"\n");
//    copy = substitute(copy, "schema", "screama");
//    copy = substitute(copy, "**TODO**", "**TODO**\r\n");

    ostringstream os;

    typedef enum
    {
        OUT_NAME = 0,
        IN_NAME = 1,
        OUT_VALUE = 2,
        IN_VALUE = 3
    } pState;
    pState state = OUT_NAME;
    char *s = (char *)copy.c_str();
    char prev = 0;
    while (*s)
    {
        if (prev != '\\' && *s == '\"')
        {
            if (state == OUT_NAME)
            {
                state = IN_NAME;
                os << *s;
            }
            else if (state == IN_NAME)
            {
                state = OUT_VALUE;
                os << *s;
            }
            else if (state == OUT_VALUE)
            {
                state = IN_VALUE;
                os << *s;
            }
            else
            {
                ASSERT(state == OUT_VALUE);
                state = OUT_NAME;
                os << *s;
            }
        }
        else
        {
            if (state == IN_NAME)
            {
                if (*s == ',')
                {
                    os << "+XX+";
                } else
                {
                    os << *s;
                }
            }
            else if (state == IN_VALUE)
            {
                if (*s == ',')
                {
                    os << "+XX+";
                } else
                {
                    os << *s;
                }
            }
            else
            {
                os << *s;
            }
        }
        prev = *s;
        s++;
    }

    return os.str();
}

//----------------------------------------------------------------
bool loadGrant(CGrant& grant, const string_q& filename) {
    time_q jsonTime = fileLastModifyDate(filename);

    string_q binFile = substitute(filename, ".json", ".bin");
    if (fileExists(binFile) && fileLastModifyDate(binFile) > jsonTime) {
        CArchive archive(READING_ARCHIVE);
        if (archive.Lock(binFile, modeReadOnly, LOCK_NOWAIT)) {
            archive >> grant;
            archive.Release();
            return true;
        }
    } else {
        string_q contents = trim(trim(asciiFileToString(filename), '['), ']');
        if (grant.parseJson3(contents)) {
            CArchive archive(WRITING_ARCHIVE);
            if (archive.Lock(binFile, modeWriteCreate, LOCK_NOWAIT)) {
                grant.grant_id = str_2_Uint(substitute(substitute(filename, "./data/", ""), ".json", ""));
                archive << grant;
                archive.Release();
                return true;
            }
        }
    }
    return false;
}

//----------------------------------------------------------------
bool loadGrants(CGrantArray& grants) {
    grants.clear();

    CStringArray files;
    listFilesInFolder(files, "./data/", false);
    for (auto file : files) {
        if (contains(file, ".json")) {
            CGrant grant;
            if (loadGrant(grant, file)) {
                if (grant.active)
                    grants.push_back(grant);
            }
        }
    }
    sort(grants.begin(), grants.end());

    return true;
}

string_q cleanName(CAccountName& acct, const CGrant& grant) {
    CStringArray corrections = {"for", "the", "on", "in", "with", "as", "at", "and", "by", "in", "to", "of", "a", "is", "it", "or"};

    uint64_t id = grant.grant_id;
    string_q ret = toProper(grant.title); // countOf(acct.name, ' ') == 0 ? acct.name : toProper(acct.name);
    if (startsWith(ret, "Grant ")) {
        replace(ret, "Grant ", "");
        // id = str_2_Uint(nextTokenClear(ret, ' '));
        nextTokenClear(ret, ' ');
    }
    ret = "Grant " + padNum4(id) + " " + ret;
    for (auto c : corrections) {
        replaceAll(ret, " " + toProper(c) + " ", " " + toLower(c) + " ");
        replaceAll(ret, "\t" + toProper(c) + " ", "\t" + toLower(c) + " ");
        replaceAll(ret, " " + toProper(c) + "\t", " " + toLower(c) + "\t");
    }
    CStringArray caps = {"Dao", "Dai", "Q.e.d.", "Iot", "Kernel"};
    for (auto c : caps) {
        replaceAll(ret, c, toUpper(c));
    }
    CStringArray changes = {"Defi|DeFi", "Rdai|rDAI"};
    for (auto c : changes) {
        string_q f = nextTokenClear(c, '|');
        replaceAll(ret, f, c);
    }
    return ret;
}
