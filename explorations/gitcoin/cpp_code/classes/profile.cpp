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
/*
 * This file was generated with makeClass. Edit only those parts of the code inside
 * of 'EXISTING_CODE' tags.
 */
#include "profile.h"

namespace qblocks {

//---------------------------------------------------------------------------
IMPLEMENT_NODE(CProfile, CBaseNode);

//---------------------------------------------------------------------------
static string_q nextProfileChunk(const string_q& fieldIn, const void* dataPtr);
static string_q nextProfileChunk_custom(const string_q& fieldIn, const void* dataPtr);

//---------------------------------------------------------------------------
void CProfile::Format(ostream& ctx, const string_q& fmtIn, void* dataPtr) const {
    if (!m_showing)
        return;

    // EXISTING_CODE
    // EXISTING_CODE

    string_q fmt = (fmtIn.empty() ? expContext().fmtMap["profile_fmt"] : fmtIn);
    if (fmt.empty()) {
        if (expContext().exportFmt == YAML1) {
            toYaml(ctx);
        } else {
            toJson(ctx);
        }
        return;
    }

    // EXISTING_CODE
    // EXISTING_CODE

    while (!fmt.empty())
        ctx << getNextChunk(fmt, nextProfileChunk, this);
}

//---------------------------------------------------------------------------
string_q nextProfileChunk(const string_q& fieldIn, const void* dataPtr) {
    if (dataPtr)
        return reinterpret_cast<const CProfile*>(dataPtr)->getValueByName(fieldIn);

    // EXISTING_CODE
    // EXISTING_CODE

    return fldNotFound(fieldIn);
}

//---------------------------------------------------------------------------
string_q CProfile::getValueByName(const string_q& fieldName) const {
    // Give customized code a chance to override first
    string_q ret = nextProfileChunk_custom(fieldName, this);
    if (!ret.empty())
        return ret;

    // EXISTING_CODE
    // EXISTING_CODE

    // Return field values
    switch (tolower(fieldName[0])) {
        case 'a':
            if (fieldName % "avatar_url") {
                return avatar_url;
            }
            break;
        case 'g':
            if (fieldName % "github_url") {
                return github_url;
            }
            break;
        case 'h':
            if (fieldName % "handle") {
                return handle;
            }
            break;
        case 'i':
            if (fieldName % "id") {
                return uint_2_Str(id);
            }
            break;
        case 'k':
            if (fieldName % "keywords" || fieldName % "keywordsCnt") {
                size_t cnt = keywords.size();
                if (endsWith(toLower(fieldName), "cnt"))
                    return uint_2_Str(cnt);
                if (!cnt)
                    return "";
                string_q retS;
                for (size_t i = 0; i < cnt; i++) {
                    retS += ("\"" + keywords[i] + "\"");
                    retS += ((i < cnt - 1) ? ",\n" + indentStr() : "\n");
                }
                return retS;
            }
            break;
        case 'o':
            if (fieldName % "organizations") {
                if (organizations == COrganization())
                    return "{}";
                return organizations.Format();
            }
            break;
        case 'p':
            if (fieldName % "position") {
                return uint_2_Str(position);
            }
            break;
        case 't':
            if (fieldName % "total_earned") {
                return double_2_Str(total_earned, 18);
            }
            break;
        case 'u':
            if (fieldName % "url") {
                return url;
            }
            break;
        default:
            break;
    }

    // EXISTING_CODE
    // EXISTING_CODE

    string_q s;
    s = toUpper(string_q("organizations")) + "::";
    if (contains(fieldName, s)) {
        string_q f = fieldName;
        replaceAll(f, s, "");
        f = organizations.getValueByName(f);
        return f;
    }

    // Finally, give the parent class a chance
    return CBaseNode::getValueByName(fieldName);
}

//---------------------------------------------------------------------------------------------------
bool CProfile::setValueByName(const string_q& fieldNameIn, const string_q& fieldValueIn) {
    string_q fieldName = fieldNameIn;
    string_q fieldValue = fieldValueIn;

    // EXISTING_CODE
    // EXISTING_CODE

    switch (tolower(fieldName[0])) {
        case 'a':
            if (fieldName % "avatar_url") {
                avatar_url = fieldValue;
                return true;
            }
            break;
        case 'g':
            if (fieldName % "github_url") {
                github_url = fieldValue;
                return true;
            }
            break;
        case 'h':
            if (fieldName % "handle") {
                handle = fieldValue;
                return true;
            }
            break;
        case 'i':
            if (fieldName % "id") {
                id = (uint32_t)str_2_Uint(fieldValue);
                return true;
            }
            break;
        case 'k':
            if (fieldName % "keywords") {
                string_q str = fieldValue;
                while (!str.empty()) {
                    keywords.push_back(nextTokenClear(str, ','));
                }
                return true;
            }
            break;
        case 'o':
            if (fieldName % "organizations") {
                return organizations.parseJson3(fieldValue);
            }
            break;
        case 'p':
            if (fieldName % "position") {
                position = (uint32_t)str_2_Uint(fieldValue);
                return true;
            }
            break;
        case 't':
            if (fieldName % "total_earned") {
                total_earned = str_2_Double(fieldValue);
                return true;
            }
            break;
        case 'u':
            if (fieldName % "url") {
                url = fieldValue;
                return true;
            }
            break;
        default:
            break;
    }
    return false;
}

//---------------------------------------------------------------------------------------------------
void CProfile::finishParse() {
    // EXISTING_CODE
    // EXISTING_CODE
}

//---------------------------------------------------------------------------------------------------
bool CProfile::Serialize(CArchive& archive) {
    if (archive.isWriting())
        return SerializeC(archive);

    // Always read the base class (it will handle its own backLevels if any, then
    // read this object's back level (if any) or the current version.
    CBaseNode::Serialize(archive);
    if (readBackLevel(archive))
        return true;

    // EXISTING_CODE
    // EXISTING_CODE
    archive >> id;
    archive >> url;
    archive >> handle;
    archive >> keywords;
    archive >> position;
    archive >> avatar_url;
    archive >> github_url;
    archive >> total_earned;
    archive >> organizations;
    finishParse();
    return true;
}

//---------------------------------------------------------------------------------------------------
bool CProfile::SerializeC(CArchive& archive) const {
    // Writing always write the latest version of the data
    CBaseNode::SerializeC(archive);

    // EXISTING_CODE
    // EXISTING_CODE
    archive << id;
    archive << url;
    archive << handle;
    archive << keywords;
    archive << position;
    archive << avatar_url;
    archive << github_url;
    archive << total_earned;
    archive << organizations;

    return true;
}

//---------------------------------------------------------------------------
CArchive& operator>>(CArchive& archive, CProfileArray& array) {
    uint64_t count;
    archive >> count;
    array.resize(count);
    for (size_t i = 0; i < count; i++) {
        ASSERT(i < array.capacity());
        array.at(i).Serialize(archive);
    }
    return archive;
}

//---------------------------------------------------------------------------
CArchive& operator<<(CArchive& archive, const CProfileArray& array) {
    uint64_t count = array.size();
    archive << count;
    for (size_t i = 0; i < array.size(); i++)
        array[i].SerializeC(archive);
    return archive;
}

//---------------------------------------------------------------------------
void CProfile::registerClass(void) {
    // only do this once
    if (HAS_FIELD(CProfile, "schema"))
        return;

    size_t fieldNum = 1000;
    ADD_FIELD(CProfile, "schema", T_NUMBER, ++fieldNum);
    ADD_FIELD(CProfile, "deleted", T_BOOL, ++fieldNum);
    ADD_FIELD(CProfile, "showing", T_BOOL, ++fieldNum);
    ADD_FIELD(CProfile, "cname", T_TEXT, ++fieldNum);
    ADD_FIELD(CProfile, "id", T_UNUMBER, ++fieldNum);
    ADD_FIELD(CProfile, "url", T_TEXT | TS_OMITEMPTY, ++fieldNum);
    ADD_FIELD(CProfile, "handle", T_TEXT | TS_OMITEMPTY, ++fieldNum);
    ADD_FIELD(CProfile, "keywords", T_TEXT | TS_ARRAY | TS_OMITEMPTY, ++fieldNum);
    ADD_FIELD(CProfile, "position", T_UNUMBER, ++fieldNum);
    ADD_FIELD(CProfile, "avatar_url", T_TEXT | TS_OMITEMPTY, ++fieldNum);
    ADD_FIELD(CProfile, "github_url", T_TEXT | TS_OMITEMPTY, ++fieldNum);
    ADD_FIELD(CProfile, "total_earned", T_DOUBLE, ++fieldNum);
    ADD_OBJECT(CProfile, "organizations", T_OBJECT | TS_OMITEMPTY, ++fieldNum, GETRUNTIME_CLASS(COrganization));

    // Hide our internal fields, user can turn them on if they like
    HIDE_FIELD(CProfile, "schema");
    HIDE_FIELD(CProfile, "deleted");
    HIDE_FIELD(CProfile, "showing");
    HIDE_FIELD(CProfile, "cname");

    builtIns.push_back(_biCProfile);

    // EXISTING_CODE
    // EXISTING_CODE
}

//---------------------------------------------------------------------------
string_q nextProfileChunk_custom(const string_q& fieldIn, const void* dataPtr) {
    const CProfile* pro = reinterpret_cast<const CProfile*>(dataPtr);
    if (pro) {
        switch (tolower(fieldIn[0])) {
            // EXISTING_CODE
            // EXISTING_CODE
            case 'p':
                // Display only the fields of this node, not it's parent type
                if (fieldIn % "parsed")
                    return nextBasenodeChunk(fieldIn, pro);
                // EXISTING_CODE
                // EXISTING_CODE
                break;

            default:
                break;
        }
    }

    return "";
}

//---------------------------------------------------------------------------
bool CProfile::readBackLevel(CArchive& archive) {
    bool done = false;
    // EXISTING_CODE
    // EXISTING_CODE
    return done;
}

//---------------------------------------------------------------------------
CArchive& operator<<(CArchive& archive, const CProfile& pro) {
    pro.SerializeC(archive);
    return archive;
}

//---------------------------------------------------------------------------
CArchive& operator>>(CArchive& archive, CProfile& pro) {
    pro.Serialize(archive);
    return archive;
}

//-------------------------------------------------------------------------
ostream& operator<<(ostream& os, const CProfile& it) {
    // EXISTING_CODE
    // EXISTING_CODE

    it.Format(os, "", nullptr);
    os << "\n";
    return os;
}

//---------------------------------------------------------------------------
const CBaseNode* CProfile::getObjectAt(const string_q& fieldName, size_t index) const {
    if (fieldName % "organizations")
        return &organizations;

    return NULL;
}

//---------------------------------------------------------------------------
const string_q CProfile::getStringAt(const string_q& fieldName, size_t i) const {
    if (fieldName % "keywords" && i < keywords.size())
        return (keywords[i]);
    return "";
}

//---------------------------------------------------------------------------
const char* STR_DISPLAY_PROFILE =
    "[{ID}]\t"
    "[{URL}]\t"
    "[{HANDLE}]\t"
    "[{KEYWORDS}]\t"
    "[{POSITION}]\t"
    "[{AVATAR_URL}]\t"
    "[{GITHUB_URL}]\t"
    "[{TOTAL_EARNED}]\t"
    "[{ORGANIZATIONS}]";

//---------------------------------------------------------------------------
// EXISTING_CODE
// EXISTING_CODE
}  // namespace qblocks
