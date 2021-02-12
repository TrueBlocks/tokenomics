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
#include "point2d.h"
#include "counter.h"

namespace qblocks {

// EXISTING_CODE
// EXISTING_CODE

//--------------------------------------------------------------------------
class CMetaData : public CBaseNode {
  public:
    CPoint2dArray related;
    CCounterArray wall_of_love;
    double last_calc_time_related;
    double last_calc_time_contributor_counts;
    double last_calc_time_sybil_and_contrib_amounts;

  public:
    CMetaData(void);
    CMetaData(const CMetaData& me);
    virtual ~CMetaData(void);
    CMetaData& operator=(const CMetaData& me);

    DECLARE_NODE(CMetaData);

    const CBaseNode* getObjectAt(const string_q& fieldName, size_t index) const override;

    // EXISTING_CODE
    // EXISTING_CODE
    bool operator==(const CMetaData& it) const;
    bool operator!=(const CMetaData& it) const {
        return !operator==(it);
    }
    friend bool operator<(const CMetaData& v1, const CMetaData& v2);
    friend ostream& operator<<(ostream& os, const CMetaData& it);

  protected:
    void clear(void);
    void initialize(void);
    void duplicate(const CMetaData& me);
    bool readBackLevel(CArchive& archive) override;

    // EXISTING_CODE
    // EXISTING_CODE
};

//--------------------------------------------------------------------------
inline CMetaData::CMetaData(void) {
    initialize();
    // EXISTING_CODE
    // EXISTING_CODE
}

//--------------------------------------------------------------------------
inline CMetaData::CMetaData(const CMetaData& me) {
    // EXISTING_CODE
    // EXISTING_CODE
    duplicate(me);
}

// EXISTING_CODE
// EXISTING_CODE

//--------------------------------------------------------------------------
inline CMetaData::~CMetaData(void) {
    clear();
    // EXISTING_CODE
    // EXISTING_CODE
}

//--------------------------------------------------------------------------
inline void CMetaData::clear(void) {
    // EXISTING_CODE
    // EXISTING_CODE
}

//--------------------------------------------------------------------------
inline void CMetaData::initialize(void) {
    CBaseNode::initialize();

    related.clear();
    wall_of_love.clear();
    last_calc_time_related = 0.0;
    last_calc_time_contributor_counts = 0.0;
    last_calc_time_sybil_and_contrib_amounts = 0.0;

    // EXISTING_CODE
    // EXISTING_CODE
}

//--------------------------------------------------------------------------
inline void CMetaData::duplicate(const CMetaData& me) {
    clear();
    CBaseNode::duplicate(me);

    related = me.related;
    wall_of_love = me.wall_of_love;
    last_calc_time_related = me.last_calc_time_related;
    last_calc_time_contributor_counts = me.last_calc_time_contributor_counts;
    last_calc_time_sybil_and_contrib_amounts = me.last_calc_time_sybil_and_contrib_amounts;

    // EXISTING_CODE
    // EXISTING_CODE
}

//--------------------------------------------------------------------------
inline CMetaData& CMetaData::operator=(const CMetaData& me) {
    duplicate(me);
    // EXISTING_CODE
    // EXISTING_CODE
    return *this;
}

//-------------------------------------------------------------------------
inline bool CMetaData::operator==(const CMetaData& it) const {
    // EXISTING_CODE
    // EXISTING_CODE
    // No default equal operator in class definition, assume none are equal (so find fails)
    return false;
}

//-------------------------------------------------------------------------
inline bool operator<(const CMetaData& v1, const CMetaData& v2) {
    // EXISTING_CODE
    // EXISTING_CODE
    // No default sort defined in class definition, assume already sorted, preserve ordering
    return true;
}

//---------------------------------------------------------------------------
typedef vector<CMetaData> CMetaDataArray;
extern CArchive& operator>>(CArchive& archive, CMetaDataArray& array);
extern CArchive& operator<<(CArchive& archive, const CMetaDataArray& array);

//---------------------------------------------------------------------------
extern CArchive& operator<<(CArchive& archive, const CMetaData& met);
extern CArchive& operator>>(CArchive& archive, CMetaData& met);

//---------------------------------------------------------------------------
extern const char* STR_DISPLAY_METADATA;

//---------------------------------------------------------------------------
// EXISTING_CODE
// EXISTING_CODE
}  // namespace qblocks
