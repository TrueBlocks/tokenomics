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
#include "organization.h"

namespace qblocks {

// EXISTING_CODE
// EXISTING_CODE

//--------------------------------------------------------------------------
class CProfile : public CBaseNode {
  public:
    uint32_t id;
    string_q url;
    string_q handle;
    CStringArray keywords;
    uint32_t position;
    string_q avatar_url;
    string_q github_url;
    double total_earned;
    COrganization organizations;

  public:
    CProfile(void);
    CProfile(const CProfile& pr);
    virtual ~CProfile(void);
    CProfile& operator=(const CProfile& pr);

    DECLARE_NODE(CProfile);

    const CBaseNode* getObjectAt(const string_q& fieldName, size_t index) const override;
    const string_q getStringAt(const string_q& fieldName, size_t i) const override;

    // EXISTING_CODE
    // EXISTING_CODE
    bool operator==(const CProfile& it) const;
    bool operator!=(const CProfile& it) const {
        return !operator==(it);
    }
    friend bool operator<(const CProfile& v1, const CProfile& v2);
    friend ostream& operator<<(ostream& os, const CProfile& it);

  protected:
    void clear(void);
    void initialize(void);
    void duplicate(const CProfile& pr);
    bool readBackLevel(CArchive& archive) override;

    // EXISTING_CODE
    // EXISTING_CODE
};

//--------------------------------------------------------------------------
inline CProfile::CProfile(void) {
    initialize();
    // EXISTING_CODE
    // EXISTING_CODE
}

//--------------------------------------------------------------------------
inline CProfile::CProfile(const CProfile& pr) {
    // EXISTING_CODE
    // EXISTING_CODE
    duplicate(pr);
}

// EXISTING_CODE
// EXISTING_CODE

//--------------------------------------------------------------------------
inline CProfile::~CProfile(void) {
    clear();
    // EXISTING_CODE
    // EXISTING_CODE
}

//--------------------------------------------------------------------------
inline void CProfile::clear(void) {
    // EXISTING_CODE
    // EXISTING_CODE
}

//--------------------------------------------------------------------------
inline void CProfile::initialize(void) {
    CBaseNode::initialize();

    id = 0;
    url = "";
    handle = "";
    keywords.clear();
    position = 0;
    avatar_url = "";
    github_url = "";
    total_earned = 0.0;
    organizations = COrganization();

    // EXISTING_CODE
    // EXISTING_CODE
}

//--------------------------------------------------------------------------
inline void CProfile::duplicate(const CProfile& pr) {
    clear();
    CBaseNode::duplicate(pr);

    id = pr.id;
    url = pr.url;
    handle = pr.handle;
    keywords = pr.keywords;
    position = pr.position;
    avatar_url = pr.avatar_url;
    github_url = pr.github_url;
    total_earned = pr.total_earned;
    organizations = pr.organizations;

    // EXISTING_CODE
    // EXISTING_CODE
}

//--------------------------------------------------------------------------
inline CProfile& CProfile::operator=(const CProfile& pr) {
    duplicate(pr);
    // EXISTING_CODE
    // EXISTING_CODE
    return *this;
}

//-------------------------------------------------------------------------
inline bool CProfile::operator==(const CProfile& it) const {
    // EXISTING_CODE
    // EXISTING_CODE
    // No default equal operator in class definition, assume none are equal (so find fails)
    return false;
}

//-------------------------------------------------------------------------
inline bool operator<(const CProfile& v1, const CProfile& v2) {
    // EXISTING_CODE
    // EXISTING_CODE
    // No default sort defined in class definition, assume already sorted, preserve ordering
    return true;
}

//---------------------------------------------------------------------------
typedef vector<CProfile> CProfileArray;
extern CArchive& operator>>(CArchive& archive, CProfileArray& array);
extern CArchive& operator<<(CArchive& archive, const CProfileArray& array);

//---------------------------------------------------------------------------
extern CArchive& operator<<(CArchive& archive, const CProfile& pro);
extern CArchive& operator>>(CArchive& archive, CProfile& pro);

//---------------------------------------------------------------------------
extern const char* STR_DISPLAY_PROFILE;

//---------------------------------------------------------------------------
// EXISTING_CODE
// EXISTING_CODE
}  // namespace qblocks
