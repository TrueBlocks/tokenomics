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
#include "organization.h"

namespace qblocks {

//---------------------------------------------------------------------------
IMPLEMENT_NODE(COrganization, CBaseNode);

//---------------------------------------------------------------------------
static string_q nextOrganizationChunk(const string_q& fieldIn, const void* dataPtr);
static string_q nextOrganizationChunk_custom(const string_q& fieldIn, const void* dataPtr);

//---------------------------------------------------------------------------
void COrganization::Format(ostream& ctx, const string_q& fmtIn, void* dataPtr) const {
    if (!m_showing)
        return;

    // EXISTING_CODE
    // EXISTING_CODE

    string_q fmt = (fmtIn.empty() ? expContext().fmtMap["organization_fmt"] : fmtIn);
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
        ctx << getNextChunk(fmt, nextOrganizationChunk, this);
}

//---------------------------------------------------------------------------
string_q nextOrganizationChunk(const string_q& fieldIn, const void* dataPtr) {
    if (dataPtr)
        return reinterpret_cast<const COrganization*>(dataPtr)->getValueByName(fieldIn);

    // EXISTING_CODE
    // EXISTING_CODE

    return fldNotFound(fieldIn);
}

//---------------------------------------------------------------------------
string_q COrganization::getValueByName(const string_q& fieldName) const {
    // Give customized code a chance to override first
    string_q ret = nextOrganizationChunk_custom(fieldName, this);
    if (!ret.empty())
        return ret;

    // EXISTING_CODE
    // EXISTING_CODE

    // Return field values
    switch (tolower(fieldName[0])) {
        case 'i':
            if (fieldName % "items" || fieldName % "itemsCnt") {
                size_t cnt = items.size();
                if (endsWith(toLower(fieldName), "cnt"))
                    return uint_2_Str(cnt);
                if (!cnt)
                    return "";
                string_q retS;
                for (size_t i = 0; i < cnt; i++) {
                    retS += ("\"" + items[i] + "\"");
                    retS += ((i < cnt - 1) ? ",\n" + indentStr() : "\n");
                }
                return retS;
            }
            break;
        case 'v':
            if (fieldName % "values") {
                return values;
            }
            break;
        default:
            break;
    }

    // EXISTING_CODE
    // EXISTING_CODE

    // Finally, give the parent class a chance
    return CBaseNode::getValueByName(fieldName);
}

//---------------------------------------------------------------------------------------------------
bool COrganization::setValueByName(const string_q& fieldNameIn, const string_q& fieldValueIn) {
    string_q fieldName = fieldNameIn;
    string_q fieldValue = fieldValueIn;

    // EXISTING_CODE
    if (fieldName != "items") {
        items.push_back(fieldName + ": " + fieldValue);
        return true;
    }
    // EXISTING_CODE

    switch (tolower(fieldName[0])) {
        case 'i':
            if (fieldName % "items") {
                string_q str = fieldValue;
                while (!str.empty()) {
                    items.push_back(nextTokenClear(str, ','));
                }
                return true;
            }
            break;
        case 'v':
            if (fieldName % "values") {
                values = fieldValue;
                return true;
            }
            break;
        default:
            break;
    }
    return false;
}

//---------------------------------------------------------------------------------------------------
void COrganization::finishParse() {
    // EXISTING_CODE
    // EXISTING_CODE
}

//---------------------------------------------------------------------------------------------------
bool COrganization::Serialize(CArchive& archive) {
    if (archive.isWriting())
        return SerializeC(archive);

    // Always read the base class (it will handle its own backLevels if any, then
    // read this object's back level (if any) or the current version.
    CBaseNode::Serialize(archive);
    if (readBackLevel(archive))
        return true;

    // EXISTING_CODE
    // EXISTING_CODE
    archive >> values;
    archive >> items;
    finishParse();
    return true;
}

//---------------------------------------------------------------------------------------------------
bool COrganization::SerializeC(CArchive& archive) const {
    // Writing always write the latest version of the data
    CBaseNode::SerializeC(archive);

    // EXISTING_CODE
    // EXISTING_CODE
    archive << values;
    archive << items;

    return true;
}

//---------------------------------------------------------------------------
CArchive& operator>>(CArchive& archive, COrganizationArray& array) {
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
CArchive& operator<<(CArchive& archive, const COrganizationArray& array) {
    uint64_t count = array.size();
    archive << count;
    for (size_t i = 0; i < array.size(); i++)
        array[i].SerializeC(archive);
    return archive;
}

//---------------------------------------------------------------------------
void COrganization::registerClass(void) {
    // only do this once
    if (HAS_FIELD(COrganization, "schema"))
        return;

    size_t fieldNum = 1000;
    ADD_FIELD(COrganization, "schema", T_NUMBER, ++fieldNum);
    ADD_FIELD(COrganization, "deleted", T_BOOL, ++fieldNum);
    ADD_FIELD(COrganization, "showing", T_BOOL, ++fieldNum);
    ADD_FIELD(COrganization, "cname", T_TEXT, ++fieldNum);
    ADD_FIELD(COrganization, "values", T_TEXT | TS_OMITEMPTY, ++fieldNum);
    ADD_FIELD(COrganization, "items", T_TEXT | TS_ARRAY | TS_OMITEMPTY, ++fieldNum);

    // Hide our internal fields, user can turn them on if they like
    HIDE_FIELD(COrganization, "schema");
    HIDE_FIELD(COrganization, "deleted");
    HIDE_FIELD(COrganization, "showing");
    HIDE_FIELD(COrganization, "cname");

    builtIns.push_back(_biCOrganization);

    // EXISTING_CODE
    // EXISTING_CODE
}

//---------------------------------------------------------------------------
string_q nextOrganizationChunk_custom(const string_q& fieldIn, const void* dataPtr) {
    const COrganization* orga = reinterpret_cast<const COrganization*>(dataPtr);
    if (orga) {
        switch (tolower(fieldIn[0])) {
            // EXISTING_CODE
            // EXISTING_CODE
            case 'p':
                // Display only the fields of this node, not it's parent type
                if (fieldIn % "parsed")
                    return nextBasenodeChunk(fieldIn, orga);
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
bool COrganization::readBackLevel(CArchive& archive) {
    bool done = false;
    // EXISTING_CODE
    // EXISTING_CODE
    return done;
}

//---------------------------------------------------------------------------
CArchive& operator<<(CArchive& archive, const COrganization& orga) {
    orga.SerializeC(archive);
    return archive;
}

//---------------------------------------------------------------------------
CArchive& operator>>(CArchive& archive, COrganization& orga) {
    orga.Serialize(archive);
    return archive;
}

//-------------------------------------------------------------------------
ostream& operator<<(ostream& os, const COrganization& it) {
    // EXISTING_CODE
    // EXISTING_CODE

    it.Format(os, "", nullptr);
    os << "\n";
    return os;
}

//---------------------------------------------------------------------------
const string_q COrganization::getStringAt(const string_q& fieldName, size_t i) const {
    if (fieldName % "items" && i < items.size())
        return (items[i]);
    return "";
}

//---------------------------------------------------------------------------
const char* STR_DISPLAY_ORGANIZATION =
    "[{VALUES}]\t"
    "[{ITEMS}]";

//---------------------------------------------------------------------------
// EXISTING_CODE
string_q COrganization::getKeyByName(const string_q& fieldName) const {
    return CBaseNode::getKeyByName(fieldName);
}
// EXISTING_CODE
}  // namespace qblocks
