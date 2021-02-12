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
#include "point3d.h"

namespace qblocks {

//---------------------------------------------------------------------------
IMPLEMENT_NODE(CPoint3d, CBaseNode);

//---------------------------------------------------------------------------
static string_q nextPoint3dChunk(const string_q& fieldIn, const void* dataPtr);
static string_q nextPoint3dChunk_custom(const string_q& fieldIn, const void* dataPtr);

//---------------------------------------------------------------------------
void CPoint3d::Format(ostream& ctx, const string_q& fmtIn, void* dataPtr) const {
    if (!m_showing)
        return;

    // EXISTING_CODE
    // EXISTING_CODE

    string_q fmt = (fmtIn.empty() ? expContext().fmtMap["point3d_fmt"] : fmtIn);
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
        ctx << getNextChunk(fmt, nextPoint3dChunk, this);
}

//---------------------------------------------------------------------------
string_q nextPoint3dChunk(const string_q& fieldIn, const void* dataPtr) {
    if (dataPtr)
        return reinterpret_cast<const CPoint3d*>(dataPtr)->getValueByName(fieldIn);

    // EXISTING_CODE
    // EXISTING_CODE

    return fldNotFound(fieldIn);
}

//---------------------------------------------------------------------------
string_q CPoint3d::getValueByName(const string_q& fieldName) const {
    // Give customized code a chance to override first
    string_q ret = nextPoint3dChunk_custom(fieldName, this);
    if (!ret.empty())
        return ret;

    // EXISTING_CODE
    // EXISTING_CODE

    // Return field values
    switch (tolower(fieldName[0])) {
        case 'x':
            if (fieldName % "x") {
                return double_2_Str(x, 16);
            }
            break;
        case 'y':
            if (fieldName % "y") {
                return double_2_Str(y, 16);
            }
            break;
        case 'z':
            if (fieldName % "z") {
                return double_2_Str(z, 16);
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
bool CPoint3d::setValueByName(const string_q& fieldNameIn, const string_q& fieldValueIn) {
    string_q fieldName = fieldNameIn;
    string_q fieldValue = fieldValueIn;

    // EXISTING_CODE
    // EXISTING_CODE

    switch (tolower(fieldName[0])) {
        case 'x':
            if (fieldName % "x") {
                x = str_2_Double(fieldValue);
                return true;
            }
            break;
        case 'y':
            if (fieldName % "y") {
                y = str_2_Double(fieldValue);
                return true;
            }
            break;
        case 'z':
            if (fieldName % "z") {
                z = str_2_Double(fieldValue);
                return true;
            }
            break;
        default:
            break;
    }
    return false;
}

//---------------------------------------------------------------------------------------------------
void CPoint3d::finishParse() {
    // EXISTING_CODE
    // EXISTING_CODE
}

//---------------------------------------------------------------------------------------------------
bool CPoint3d::Serialize(CArchive& archive) {
    if (archive.isWriting())
        return SerializeC(archive);

    // Always read the base class (it will handle its own backLevels if any, then
    // read this object's back level (if any) or the current version.
    CBaseNode::Serialize(archive);
    if (readBackLevel(archive))
        return true;

    // EXISTING_CODE
    // EXISTING_CODE
    archive >> x;
    archive >> y;
    archive >> z;
    finishParse();
    return true;
}

//---------------------------------------------------------------------------------------------------
bool CPoint3d::SerializeC(CArchive& archive) const {
    // Writing always write the latest version of the data
    CBaseNode::SerializeC(archive);

    // EXISTING_CODE
    // EXISTING_CODE
    archive << x;
    archive << y;
    archive << z;

    return true;
}

//---------------------------------------------------------------------------
CArchive& operator>>(CArchive& archive, CPoint3dArray& array) {
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
CArchive& operator<<(CArchive& archive, const CPoint3dArray& array) {
    uint64_t count = array.size();
    archive << count;
    for (size_t i = 0; i < array.size(); i++)
        array[i].SerializeC(archive);
    return archive;
}

//---------------------------------------------------------------------------
void CPoint3d::registerClass(void) {
    // only do this once
    if (HAS_FIELD(CPoint3d, "schema"))
        return;

    size_t fieldNum = 1000;
    ADD_FIELD(CPoint3d, "schema", T_NUMBER, ++fieldNum);
    ADD_FIELD(CPoint3d, "deleted", T_BOOL, ++fieldNum);
    ADD_FIELD(CPoint3d, "showing", T_BOOL, ++fieldNum);
    ADD_FIELD(CPoint3d, "cname", T_TEXT, ++fieldNum);
    ADD_FIELD(CPoint3d, "x", T_DOUBLE, ++fieldNum);
    ADD_FIELD(CPoint3d, "y", T_DOUBLE, ++fieldNum);
    ADD_FIELD(CPoint3d, "z", T_DOUBLE, ++fieldNum);

    // Hide our internal fields, user can turn them on if they like
    HIDE_FIELD(CPoint3d, "schema");
    HIDE_FIELD(CPoint3d, "deleted");
    HIDE_FIELD(CPoint3d, "showing");
    HIDE_FIELD(CPoint3d, "cname");

    builtIns.push_back(_biCPoint3d);

    // EXISTING_CODE
    // EXISTING_CODE
}

//---------------------------------------------------------------------------
string_q nextPoint3dChunk_custom(const string_q& fieldIn, const void* dataPtr) {
    const CPoint3d* poi = reinterpret_cast<const CPoint3d*>(dataPtr);
    if (poi) {
        switch (tolower(fieldIn[0])) {
            // EXISTING_CODE
            // EXISTING_CODE
            case 'p':
                // Display only the fields of this node, not it's parent type
                if (fieldIn % "parsed")
                    return nextBasenodeChunk(fieldIn, poi);
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
bool CPoint3d::readBackLevel(CArchive& archive) {
    bool done = false;
    // EXISTING_CODE
    // EXISTING_CODE
    return done;
}

//---------------------------------------------------------------------------
CArchive& operator<<(CArchive& archive, const CPoint3d& poi) {
    poi.SerializeC(archive);
    return archive;
}

//---------------------------------------------------------------------------
CArchive& operator>>(CArchive& archive, CPoint3d& poi) {
    poi.Serialize(archive);
    return archive;
}

//-------------------------------------------------------------------------
ostream& operator<<(ostream& os, const CPoint3d& it) {
    // EXISTING_CODE
    // EXISTING_CODE

    it.Format(os, "", nullptr);
    os << "\n";
    return os;
}

//---------------------------------------------------------------------------
const char* STR_DISPLAY_POINT3D =
    "[{X}]\t"
    "[{Y}]\t"
    "[{Z}]";

//---------------------------------------------------------------------------
// EXISTING_CODE
// EXISTING_CODE
}  // namespace qblocks
