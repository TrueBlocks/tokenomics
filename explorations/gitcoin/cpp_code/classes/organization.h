#pragma once
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
#include "utillib.h"

namespace qblocks {

// EXISTING_CODE
// EXISTING_CODE

//--------------------------------------------------------------------------
class COrganization : public CBaseNode {
  public:
    string_q values;
    CStringArray items;

  public:
    COrganization(void);
    COrganization(const COrganization& orga);
    virtual ~COrganization(void);
    COrganization& operator=(const COrganization& orga);

    DECLARE_NODE(COrganization);

    const string_q getStringAt(const string_q& fieldName, size_t i) const override;

    // EXISTING_CODE
    string_q getKeyByName(const string_q& fieldName) const override;
    // EXISTING_CODE
    bool operator==(const COrganization& it) const;
    bool operator!=(const COrganization& it) const {
        return !operator==(it);
    }
    friend bool operator<(const COrganization& v1, const COrganization& v2);
    friend ostream& operator<<(ostream& os, const COrganization& it);

  protected:
    void clear(void);
    void initialize(void);
    void duplicate(const COrganization& orga);
    bool readBackLevel(CArchive& archive) override;

    // EXISTING_CODE
    // EXISTING_CODE
};

//--------------------------------------------------------------------------
inline COrganization::COrganization(void) {
    initialize();
    // EXISTING_CODE
    // EXISTING_CODE
}

//--------------------------------------------------------------------------
inline COrganization::COrganization(const COrganization& orga) {
    // EXISTING_CODE
    // EXISTING_CODE
    duplicate(orga);
}

// EXISTING_CODE
// EXISTING_CODE

//--------------------------------------------------------------------------
inline COrganization::~COrganization(void) {
    clear();
    // EXISTING_CODE
    // EXISTING_CODE
}

//--------------------------------------------------------------------------
inline void COrganization::clear(void) {
    // EXISTING_CODE
    // EXISTING_CODE
}

//--------------------------------------------------------------------------
inline void COrganization::initialize(void) {
    CBaseNode::initialize();

    values = "";
    items.clear();

    // EXISTING_CODE
    // EXISTING_CODE
}

//--------------------------------------------------------------------------
inline void COrganization::duplicate(const COrganization& orga) {
    clear();
    CBaseNode::duplicate(orga);

    values = orga.values;
    items = orga.items;

    // EXISTING_CODE
    // EXISTING_CODE
}

//--------------------------------------------------------------------------
inline COrganization& COrganization::operator=(const COrganization& orga) {
    duplicate(orga);
    // EXISTING_CODE
    // EXISTING_CODE
    return *this;
}

//-------------------------------------------------------------------------
inline bool COrganization::operator==(const COrganization& it) const {
    // EXISTING_CODE
    // EXISTING_CODE
    // No default equal operator in class definition, assume none are equal (so find fails)
    return false;
}

//-------------------------------------------------------------------------
inline bool operator<(const COrganization& v1, const COrganization& v2) {
    // EXISTING_CODE
    // EXISTING_CODE
    // No default sort defined in class definition, assume already sorted, preserve ordering
    return true;
}

//---------------------------------------------------------------------------
typedef vector<COrganization> COrganizationArray;
extern CArchive& operator>>(CArchive& archive, COrganizationArray& array);
extern CArchive& operator<<(CArchive& archive, const COrganizationArray& array);

//---------------------------------------------------------------------------
extern CArchive& operator<<(CArchive& archive, const COrganization& orga);
extern CArchive& operator>>(CArchive& archive, COrganization& orga);

//---------------------------------------------------------------------------
extern const char* STR_DISPLAY_ORGANIZATION;

//---------------------------------------------------------------------------
// EXISTING_CODE
// EXISTING_CODE
}  // namespace qblocks
