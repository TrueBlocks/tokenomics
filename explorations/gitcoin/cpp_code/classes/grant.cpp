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
#include "grant.h"

namespace qblocks {

//---------------------------------------------------------------------------
IMPLEMENT_NODE(CGrant, CBaseNode);

//---------------------------------------------------------------------------
static string_q nextGrantChunk(const string_q& fieldIn, const void* dataPtr);
static string_q nextGrantChunk_custom(const string_q& fieldIn, const void* dataPtr);

//---------------------------------------------------------------------------
void CGrant::Format(ostream& ctx, const string_q& fmtIn, void* dataPtr) const {
    if (!m_showing)
        return;

    // EXISTING_CODE
    // EXISTING_CODE

    string_q fmt = (fmtIn.empty() ? expContext().fmtMap["grant_fmt"] : fmtIn);
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
        ctx << getNextChunk(fmt, nextGrantChunk, this);
}

//---------------------------------------------------------------------------
string_q nextGrantChunk(const string_q& fieldIn, const void* dataPtr) {
    if (dataPtr)
        return reinterpret_cast<const CGrant*>(dataPtr)->getValueByName(fieldIn);

    // EXISTING_CODE
    // EXISTING_CODE

    return fldNotFound(fieldIn);
}

//---------------------------------------------------------------------------
string_q CGrant::getValueByName(const string_q& fieldName) const {
    // Give customized code a chance to override first
    string_q ret = nextGrantChunk_custom(fieldName, this);
    if (!ret.empty())
        return ret;

    // EXISTING_CODE
    // EXISTING_CODE

    // Return field values
    switch (tolower(fieldName[0])) {
        case 'a':
            if (fieldName % "active") {
                return bool_2_Str(active);
            }
            if (fieldName % "admin_address") {
                return addr_2_Str(admin_address);
            }
            if (fieldName % "amount_received") {
                return amount_received;
            }
            if (fieldName % "admin_profile") {
                if (admin_profile == CProfile())
                    return "{}";
                return admin_profile.Format();
            }
            break;
        case 'c':
            if (fieldName % "contract_address") {
                return addr_2_Str(contract_address);
            }
            if (fieldName % "clr_prediction_curve" || fieldName % "clr_prediction_curveCnt") {
                size_t cnt = clr_prediction_curve.size();
                if (endsWith(toLower(fieldName), "cnt"))
                    return uint_2_Str(cnt);
                if (!cnt)
                    return "";
                string_q retS;
                for (size_t i = 0; i < cnt; i++) {
                    retS += clr_prediction_curve[i].Format();
                    retS += ((i < cnt - 1) ? ",\n" : "\n");
                }
                return retS;
            }
            break;
        case 'd':
            if (fieldName % "description") {
                return description;
            }
            break;
        case 'g':
            if (fieldName % "grant_id") {
                return uint_2_Str(grant_id);
            }
            break;
        case 'l':
            if (fieldName % "logo") {
                return logo;
            }
            break;
        case 'm':
            if (fieldName % "metadata") {
                if (metadata == CMetaData())
                    return "{}";
                return metadata.Format();
            }
            break;
        case 'n':
            if (fieldName % "network") {
                return network;
            }
            break;
        case 'r':
            if (fieldName % "reference_url") {
                return reference_url;
            }
            if (fieldName % "required_gas_price") {
                return required_gas_price;
            }
            break;
        case 's':
            if (fieldName % "slug") {
                return slug;
            }
            break;
        case 't':
            if (fieldName % "title") {
                return title;
            }
            if (fieldName % "token_address") {
                return addr_2_Str(token_address);
            }
            if (fieldName % "token_symbol") {
                return token_symbol;
            }
            if (fieldName % "team_members" || fieldName % "team_membersCnt") {
                size_t cnt = team_members.size();
                if (endsWith(toLower(fieldName), "cnt"))
                    return uint_2_Str(cnt);
                if (!cnt)
                    return "";
                string_q retS;
                for (size_t i = 0; i < cnt; i++) {
                    retS += team_members[i].Format();
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

    string_q s;
    s = toUpper(string_q("metadata")) + "::";
    if (contains(fieldName, s)) {
        string_q f = fieldName;
        replaceAll(f, s, "");
        f = metadata.getValueByName(f);
        return f;
    }

    s = toUpper(string_q("admin_profile")) + "::";
    if (contains(fieldName, s)) {
        string_q f = fieldName;
        replaceAll(f, s, "");
        f = admin_profile.getValueByName(f);
        return f;
    }

    // Finally, give the parent class a chance
    return CBaseNode::getValueByName(fieldName);
}

//---------------------------------------------------------------------------------------------------
bool CGrant::setValueByName(const string_q& fieldNameIn, const string_q& fieldValueIn) {
    string_q fieldName = fieldNameIn;
    string_q fieldValue = fieldValueIn;

    // EXISTING_CODE
    if (fieldName % "clr_prediction_curve") {
        CStringArray points;
        if (contains(fieldValue, "[")) {
            explode(points, substitute(substitute(fieldValue, "[", ""), "],", "]"), ']');
            for (auto p : points) {
                CPoint3d point;
                point.x = str_2_Double(nextTokenClear(p, ','));
                point.y = str_2_Double(nextTokenClear(p, ','));
                point.z = str_2_Double(p);
                clr_prediction_curve.push_back(point);
            }
        } else {
            explode(points, substitute(substitute(fieldValue, "{", ""), "},", "}"), '}');
            for (auto p : points) {
                p = substitute(substitute(substitute(p, "x:", ""), "y:", ""), "z:", "");
                CPoint3d point;
                point.x = str_2_Double(nextTokenClear(p, ','));
                point.y = str_2_Double(nextTokenClear(p, ','));
                point.z = str_2_Double(p);
                clr_prediction_curve.push_back(point);
            }
        }
        return true;
    } else if (fieldName == "description") {
        replaceAny(fieldValue, "{}[]", "");
    }
    // EXISTING_CODE

    switch (tolower(fieldName[0])) {
        case 'a':
            if (fieldName % "active") {
                active = str_2_Bool(fieldValue);
                return true;
            }
            if (fieldName % "admin_address") {
                admin_address = str_2_Addr(fieldValue);
                return true;
            }
            if (fieldName % "amount_received") {
                amount_received = fieldValue;
                return true;
            }
            if (fieldName % "admin_profile") {
                return admin_profile.parseJson3(fieldValue);
            }
            break;
        case 'c':
            if (fieldName % "contract_address") {
                contract_address = str_2_Addr(fieldValue);
                return true;
            }
            if (fieldName % "clr_prediction_curve") {
                CPoint3d obj;
                string_q str = fieldValue;
                while (obj.parseJson3(str)) {
                    clr_prediction_curve.push_back(obj);
                    obj = CPoint3d();  // reset
                }
                return true;
            }
            break;
        case 'd':
            if (fieldName % "description") {
                description = fieldValue;
                return true;
            }
            break;
        case 'g':
            if (fieldName % "grant_id") {
                grant_id = str_2_Uint(fieldValue);
                return true;
            }
            break;
        case 'l':
            if (fieldName % "logo") {
                logo = fieldValue;
                return true;
            }
            break;
        case 'm':
            if (fieldName % "metadata") {
                return metadata.parseJson3(fieldValue);
            }
            break;
        case 'n':
            if (fieldName % "network") {
                network = fieldValue;
                return true;
            }
            break;
        case 'r':
            if (fieldName % "reference_url") {
                reference_url = fieldValue;
                return true;
            }
            if (fieldName % "required_gas_price") {
                required_gas_price = fieldValue;
                return true;
            }
            break;
        case 's':
            if (fieldName % "slug") {
                slug = fieldValue;
                return true;
            }
            break;
        case 't':
            if (fieldName % "title") {
                title = fieldValue;
                return true;
            }
            if (fieldName % "token_address") {
                token_address = str_2_Addr(fieldValue);
                return true;
            }
            if (fieldName % "token_symbol") {
                token_symbol = fieldValue;
                return true;
            }
            if (fieldName % "team_members") {
                CProfile obj;
                string_q str = fieldValue;
                while (obj.parseJson3(str)) {
                    team_members.push_back(obj);
                    obj = CProfile();  // reset
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
void CGrant::finishParse() {
    // EXISTING_CODE
    // EXISTING_CODE
}

//---------------------------------------------------------------------------------------------------
bool CGrant::Serialize(CArchive& archive) {
    if (archive.isWriting())
        return SerializeC(archive);

    // Always read the base class (it will handle its own backLevels if any, then
    // read this object's back level (if any) or the current version.
    CBaseNode::Serialize(archive);
    if (readBackLevel(archive))
        return true;

    // EXISTING_CODE
    // EXISTING_CODE
    archive >> active;
    archive >> grant_id;
    archive >> title;
    archive >> slug;
    archive >> description;
    archive >> reference_url;
    archive >> logo;
    archive >> admin_address;
    archive >> amount_received;
    archive >> token_address;
    archive >> token_symbol;
    archive >> contract_address;
    archive >> metadata;
    archive >> network;
    archive >> required_gas_price;
    archive >> admin_profile;
    archive >> team_members;
    archive >> clr_prediction_curve;
    finishParse();
    return true;
}

//---------------------------------------------------------------------------------------------------
bool CGrant::SerializeC(CArchive& archive) const {
    // Writing always write the latest version of the data
    CBaseNode::SerializeC(archive);

    // EXISTING_CODE
    // EXISTING_CODE
    archive << active;
    archive << grant_id;
    archive << title;
    archive << slug;
    archive << description;
    archive << reference_url;
    archive << logo;
    archive << admin_address;
    archive << amount_received;
    archive << token_address;
    archive << token_symbol;
    archive << contract_address;
    archive << metadata;
    archive << network;
    archive << required_gas_price;
    archive << admin_profile;
    archive << team_members;
    archive << clr_prediction_curve;

    return true;
}

//---------------------------------------------------------------------------
CArchive& operator>>(CArchive& archive, CGrantArray& array) {
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
CArchive& operator<<(CArchive& archive, const CGrantArray& array) {
    uint64_t count = array.size();
    archive << count;
    for (size_t i = 0; i < array.size(); i++)
        array[i].SerializeC(archive);
    return archive;
}

//---------------------------------------------------------------------------
void CGrant::registerClass(void) {
    // only do this once
    if (HAS_FIELD(CGrant, "schema"))
        return;

    size_t fieldNum = 1000;
    ADD_FIELD(CGrant, "schema", T_NUMBER, ++fieldNum);
    ADD_FIELD(CGrant, "deleted", T_BOOL, ++fieldNum);
    ADD_FIELD(CGrant, "showing", T_BOOL, ++fieldNum);
    ADD_FIELD(CGrant, "cname", T_TEXT, ++fieldNum);
    ADD_FIELD(CGrant, "active", T_BOOL | TS_OMITEMPTY, ++fieldNum);
    ADD_FIELD(CGrant, "grant_id", T_UNUMBER, ++fieldNum);
    ADD_FIELD(CGrant, "title", T_TEXT | TS_OMITEMPTY, ++fieldNum);
    ADD_FIELD(CGrant, "slug", T_TEXT | TS_OMITEMPTY, ++fieldNum);
    ADD_FIELD(CGrant, "description", T_TEXT | TS_OMITEMPTY, ++fieldNum);
    ADD_FIELD(CGrant, "reference_url", T_TEXT | TS_OMITEMPTY, ++fieldNum);
    ADD_FIELD(CGrant, "logo", T_TEXT | TS_OMITEMPTY, ++fieldNum);
    ADD_FIELD(CGrant, "admin_address", T_ADDRESS | TS_OMITEMPTY, ++fieldNum);
    ADD_FIELD(CGrant, "amount_received", T_TEXT | TS_OMITEMPTY, ++fieldNum);
    ADD_FIELD(CGrant, "token_address", T_ADDRESS | TS_OMITEMPTY, ++fieldNum);
    ADD_FIELD(CGrant, "token_symbol", T_TEXT | TS_OMITEMPTY, ++fieldNum);
    ADD_FIELD(CGrant, "contract_address", T_ADDRESS | TS_OMITEMPTY, ++fieldNum);
    ADD_OBJECT(CGrant, "metadata", T_OBJECT | TS_OMITEMPTY, ++fieldNum, GETRUNTIME_CLASS(CMetaData));
    ADD_FIELD(CGrant, "network", T_TEXT | TS_OMITEMPTY, ++fieldNum);
    ADD_FIELD(CGrant, "required_gas_price", T_TEXT | TS_OMITEMPTY, ++fieldNum);
    ADD_OBJECT(CGrant, "admin_profile", T_OBJECT | TS_OMITEMPTY, ++fieldNum, GETRUNTIME_CLASS(CProfile));
    ADD_FIELD(CGrant, "team_members", T_OBJECT | TS_ARRAY | TS_OMITEMPTY, ++fieldNum);
    ADD_FIELD(CGrant, "clr_prediction_curve", T_OBJECT | TS_ARRAY | TS_OMITEMPTY, ++fieldNum);

    // Hide our internal fields, user can turn them on if they like
    HIDE_FIELD(CGrant, "schema");
    HIDE_FIELD(CGrant, "deleted");
    HIDE_FIELD(CGrant, "showing");
    HIDE_FIELD(CGrant, "cname");

    builtIns.push_back(_biCGrant);

    // EXISTING_CODE
    // EXISTING_CODE
}

//---------------------------------------------------------------------------
string_q nextGrantChunk_custom(const string_q& fieldIn, const void* dataPtr) {
    const CGrant* gra = reinterpret_cast<const CGrant*>(dataPtr);
    if (gra) {
        switch (tolower(fieldIn[0])) {
            // EXISTING_CODE
            // EXISTING_CODE
            case 'p':
                // Display only the fields of this node, not it's parent type
                if (fieldIn % "parsed")
                    return nextBasenodeChunk(fieldIn, gra);
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
bool CGrant::readBackLevel(CArchive& archive) {
    bool done = false;
    // EXISTING_CODE
    // EXISTING_CODE
    return done;
}

//---------------------------------------------------------------------------
CArchive& operator<<(CArchive& archive, const CGrant& gra) {
    gra.SerializeC(archive);
    return archive;
}

//---------------------------------------------------------------------------
CArchive& operator>>(CArchive& archive, CGrant& gra) {
    gra.Serialize(archive);
    return archive;
}

//-------------------------------------------------------------------------
ostream& operator<<(ostream& os, const CGrant& it) {
    // EXISTING_CODE
    // EXISTING_CODE

    it.Format(os, "", nullptr);
    os << "\n";
    return os;
}

//---------------------------------------------------------------------------
const CBaseNode* CGrant::getObjectAt(const string_q& fieldName, size_t index) const {
    if (fieldName % "metadata")
        return &metadata;

    if (fieldName % "admin_profile")
        return &admin_profile;

    if (fieldName % "team_members") {
        if (index == NOPOS) {
            CProfile empty;
            ((CGrant*)this)->team_members.push_back(empty);
            index = team_members.size() - 1;
        }
        if (index < team_members.size())
            return &team_members[index];
    }

    if (fieldName % "clr_prediction_curve") {
        if (index == NOPOS) {
            CPoint3d empty;
            ((CGrant*)this)->clr_prediction_curve.push_back(empty);
            index = clr_prediction_curve.size() - 1;
        }
        if (index < clr_prediction_curve.size())
            return &clr_prediction_curve[index];
    }

    return NULL;
}

//---------------------------------------------------------------------------
const char* STR_DISPLAY_GRANT =
    "[{ACTIVE}]\t"
    "[{TITLE}]\t"
    "[{SLUG}]\t"
    "[{DESCRIPTION}]\t"
    "[{REFERENCE_URL}]\t"
    "[{LOGO}]\t"
    "[{ADMIN_ADDRESS}]\t"
    "[{AMOUNT_RECEIVED}]\t"
    "[{TOKEN_ADDRESS}]\t"
    "[{TOKEN_SYMBOL}]\t"
    "[{CONTRACT_ADDRESS}]\t"
    "[{METADATA}]\t"
    "[{NETWORK}]\t"
    "[{REQUIRED_GAS_PRICE}]\t"
    "[{ADMIN_PROFILE}]\t"
    "[{TEAM_MEMBERS}]\t"
    "[{CLR_PREDICTION_CURVE}]";

//---------------------------------------------------------------------------
// EXISTING_CODE
// EXISTING_CODE
}  // namespace qblocks
