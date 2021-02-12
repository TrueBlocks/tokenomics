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
#include "metadata.h"

namespace qblocks {

//---------------------------------------------------------------------------
IMPLEMENT_NODE(CMetaData, CBaseNode);

//---------------------------------------------------------------------------
static string_q nextMetadataChunk(const string_q& fieldIn, const void* dataPtr);
static string_q nextMetadataChunk_custom(const string_q& fieldIn, const void* dataPtr);

//---------------------------------------------------------------------------
void CMetaData::Format(ostream& ctx, const string_q& fmtIn, void* dataPtr) const {
    if (!m_showing)
        return;

    // EXISTING_CODE
    // EXISTING_CODE

    string_q fmt = (fmtIn.empty() ? expContext().fmtMap["metadata_fmt"] : fmtIn);
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
        ctx << getNextChunk(fmt, nextMetadataChunk, this);
}

//---------------------------------------------------------------------------
string_q nextMetadataChunk(const string_q& fieldIn, const void* dataPtr) {
    if (dataPtr)
        return reinterpret_cast<const CMetaData*>(dataPtr)->getValueByName(fieldIn);

    // EXISTING_CODE
    // EXISTING_CODE

    return fldNotFound(fieldIn);
}

//---------------------------------------------------------------------------
string_q CMetaData::getValueByName(const string_q& fieldName) const {
    // Give customized code a chance to override first
    string_q ret = nextMetadataChunk_custom(fieldName, this);
    if (!ret.empty())
        return ret;

    // EXISTING_CODE
    // EXISTING_CODE

    // Return field values
    switch (tolower(fieldName[0])) {
        case 'l':
            if (fieldName % "last_calc_time_related") {
                return double_2_Str(last_calc_time_related, 7);
            }
            if (fieldName % "last_calc_time_contributor_counts") {
                return double_2_Str(last_calc_time_contributor_counts, 7);
            }
            if (fieldName % "last_calc_time_sybil_and_contrib_amounts") {
                return double_2_Str(last_calc_time_sybil_and_contrib_amounts, 7);
            }
            break;
        case 'r':
            if (fieldName % "related" || fieldName % "relatedCnt") {
                size_t cnt = related.size();
                if (endsWith(toLower(fieldName), "cnt"))
                    return uint_2_Str(cnt);
                if (!cnt)
                    return "";
                string_q retS;
                for (size_t i = 0; i < cnt; i++) {
                    retS += related[i].Format();
                    retS += ((i < cnt - 1) ? ",\n" : "\n");
                }
                return retS;
            }
            break;
        case 'w':
            if (fieldName % "wall_of_love" || fieldName % "wall_of_loveCnt") {
                size_t cnt = wall_of_love.size();
                if (endsWith(toLower(fieldName), "cnt"))
                    return uint_2_Str(cnt);
                if (!cnt)
                    return "";
                string_q retS;
                for (size_t i = 0; i < cnt; i++) {
                    retS += wall_of_love[i].Format();
                    retS += ((i < cnt - 1) ? ",\n" : "\n");
                }
                return retS;
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
bool CMetaData::setValueByName(const string_q& fieldNameIn, const string_q& fieldValueIn) {
    string_q fieldName = fieldNameIn;
    string_q fieldValue = fieldValueIn;

    // EXISTING_CODE
    CStringArray array;
    if (fieldName % "related") {
        if (contains(fieldValue, "[")) {
            explode(array, substitute(substitute(fieldValue, "[", ""), "],", "]"), ']');
            for (auto p : array) {
                CPoint2d point;
                point.x = (uint32_t)str_2_Uint(nextTokenClear(p, ','));
                point.y = (uint32_t)str_2_Uint(nextTokenClear(p, ','));
                related.push_back(point);
            }
            return true;
        }
    } else if (fieldName % "wall_of_love") {
        if (contains(fieldValue, "[")) {
            explode(array, substitute(substitute(fieldValue, "[", ""), "],", "]"), ']');
            for (auto w : array) {
                CCounter counter;
                counter.string = nextTokenClear(w, ',');
                counter.count = str_2_Uint(w);
                wall_of_love.push_back(counter);
            }
            return true;
        }
    }
    // EXISTING_CODE

    switch (tolower(fieldName[0])) {
        case 'l':
            if (fieldName % "last_calc_time_related") {
                last_calc_time_related = str_2_Double(fieldValue);
                return true;
            }
            if (fieldName % "last_calc_time_contributor_counts") {
                last_calc_time_contributor_counts = str_2_Double(fieldValue);
                return true;
            }
            if (fieldName % "last_calc_time_sybil_and_contrib_amounts") {
                last_calc_time_sybil_and_contrib_amounts = str_2_Double(fieldValue);
                return true;
            }
            break;
        case 'r':
            if (fieldName % "related") {
                CPoint2d obj;
                string_q str = fieldValue;
                while (obj.parseJson3(str)) {
                    related.push_back(obj);
                    obj = CPoint2d();  // reset
                }
                return true;
            }
            break;
        case 'w':
            if (fieldName % "wall_of_love") {
                CCounter obj;
                string_q str = fieldValue;
                while (obj.parseJson3(str)) {
                    wall_of_love.push_back(obj);
                    obj = CCounter();  // reset
                }
                return true;
            }
            break;
        default:
            break;
    }
    return false;
}

//---------------------------------------------------------------------------------------------------
void CMetaData::finishParse() {
    // EXISTING_CODE
    // EXISTING_CODE
}

//---------------------------------------------------------------------------------------------------
bool CMetaData::Serialize(CArchive& archive) {
    if (archive.isWriting())
        return SerializeC(archive);

    // Always read the base class (it will handle its own backLevels if any, then
    // read this object's back level (if any) or the current version.
    CBaseNode::Serialize(archive);
    if (readBackLevel(archive))
        return true;

    // EXISTING_CODE
    // EXISTING_CODE
    archive >> related;
    archive >> wall_of_love;
    archive >> last_calc_time_related;
    archive >> last_calc_time_contributor_counts;
    archive >> last_calc_time_sybil_and_contrib_amounts;
    finishParse();
    return true;
}

//---------------------------------------------------------------------------------------------------
bool CMetaData::SerializeC(CArchive& archive) const {
    // Writing always write the latest version of the data
    CBaseNode::SerializeC(archive);

    // EXISTING_CODE
    // EXISTING_CODE
    archive << related;
    archive << wall_of_love;
    archive << last_calc_time_related;
    archive << last_calc_time_contributor_counts;
    archive << last_calc_time_sybil_and_contrib_amounts;

    return true;
}

//---------------------------------------------------------------------------
CArchive& operator>>(CArchive& archive, CMetaDataArray& array) {
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
CArchive& operator<<(CArchive& archive, const CMetaDataArray& array) {
    uint64_t count = array.size();
    archive << count;
    for (size_t i = 0; i < array.size(); i++)
        array[i].SerializeC(archive);
    return archive;
}

//---------------------------------------------------------------------------
void CMetaData::registerClass(void) {
    // only do this once
    if (HAS_FIELD(CMetaData, "schema"))
        return;

    size_t fieldNum = 1000;
    ADD_FIELD(CMetaData, "schema", T_NUMBER, ++fieldNum);
    ADD_FIELD(CMetaData, "deleted", T_BOOL, ++fieldNum);
    ADD_FIELD(CMetaData, "showing", T_BOOL, ++fieldNum);
    ADD_FIELD(CMetaData, "cname", T_TEXT, ++fieldNum);
    ADD_FIELD(CMetaData, "related", T_OBJECT | TS_ARRAY | TS_OMITEMPTY, ++fieldNum);
    ADD_FIELD(CMetaData, "wall_of_love", T_OBJECT | TS_ARRAY | TS_OMITEMPTY, ++fieldNum);
    ADD_FIELD(CMetaData, "last_calc_time_related", T_DOUBLE, ++fieldNum);
    ADD_FIELD(CMetaData, "last_calc_time_contributor_counts", T_DOUBLE, ++fieldNum);
    ADD_FIELD(CMetaData, "last_calc_time_sybil_and_contrib_amounts", T_DOUBLE, ++fieldNum);

    // Hide our internal fields, user can turn them on if they like
    HIDE_FIELD(CMetaData, "schema");
    HIDE_FIELD(CMetaData, "deleted");
    HIDE_FIELD(CMetaData, "showing");
    HIDE_FIELD(CMetaData, "cname");

    builtIns.push_back(_biCMetaData);

    // EXISTING_CODE
    // EXISTING_CODE
}

//---------------------------------------------------------------------------
string_q nextMetadataChunk_custom(const string_q& fieldIn, const void* dataPtr) {
    const CMetaData* met = reinterpret_cast<const CMetaData*>(dataPtr);
    if (met) {
        switch (tolower(fieldIn[0])) {
            // EXISTING_CODE
            // EXISTING_CODE
            case 'p':
                // Display only the fields of this node, not it's parent type
                if (fieldIn % "parsed")
                    return nextBasenodeChunk(fieldIn, met);
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
bool CMetaData::readBackLevel(CArchive& archive) {
    bool done = false;
    // EXISTING_CODE
    // EXISTING_CODE
    return done;
}

//---------------------------------------------------------------------------
CArchive& operator<<(CArchive& archive, const CMetaData& met) {
    met.SerializeC(archive);
    return archive;
}

//---------------------------------------------------------------------------
CArchive& operator>>(CArchive& archive, CMetaData& met) {
    met.Serialize(archive);
    return archive;
}

//-------------------------------------------------------------------------
ostream& operator<<(ostream& os, const CMetaData& it) {
    // EXISTING_CODE
    // EXISTING_CODE

    it.Format(os, "", nullptr);
    os << "\n";
    return os;
}

//---------------------------------------------------------------------------
const CBaseNode* CMetaData::getObjectAt(const string_q& fieldName, size_t index) const {
    if (fieldName % "related") {
        if (index == NOPOS) {
            CPoint2d empty;
            ((CMetaData*)this)->related.push_back(empty);
            index = related.size() - 1;
        }
        if (index < related.size())
            return &related[index];
    }

    if (fieldName % "wall_of_love") {
        if (index == NOPOS) {
            CCounter empty;
            ((CMetaData*)this)->wall_of_love.push_back(empty);
            index = wall_of_love.size() - 1;
        }
        if (index < wall_of_love.size())
            return &wall_of_love[index];
    }

    return NULL;
}

//---------------------------------------------------------------------------
const char* STR_DISPLAY_METADATA =
    "[{RELATED}]\t"
    "[{WALL_OF_LOVE}]\t"
    "[{LAST_CALC_TIME_RELATED}]\t"
    "[{LAST_CALC_TIME_CONTRIBUTOR_COUNTS}]\t"
    "[{LAST_CALC_TIME_SYBIL_AND_CONTRIB_AMOUNTS}]";

//---------------------------------------------------------------------------
// EXISTING_CODE
// EXISTING_CODE
}  // namespace qblocks
