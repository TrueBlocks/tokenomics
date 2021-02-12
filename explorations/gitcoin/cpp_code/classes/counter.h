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
class CCounter : public CBaseNode {
  public:
    string_q string;
    uint64_t count;

  public:
    CCounter(void);
    CCounter(const CCounter& co);
    virtual ~CCounter(void);
    CCounter& operator=(const CCounter& co);

    DECLARE_NODE(CCounter);

    // EXISTING_CODE
    // EXISTING_CODE
    bool operator==(const CCounter& it) const;
    bool operator!=(const CCounter& it) const {
        return !operator==(it);
    }
    friend bool operator<(const CCounter& v1, const CCounter& v2);
    friend ostream& operator<<(ostream& os, const CCounter& it);

  protected:
    void clear(void);
    void initialize(void);
    void duplicate(const CCounter& co);
    bool readBackLevel(CArchive& archive) override;

    // EXISTING_CODE
    // EXISTING_CODE
};

//--------------------------------------------------------------------------
inline CCounter::CCounter(void) {
    initialize();
    // EXISTING_CODE
    // EXISTING_CODE
}

//--------------------------------------------------------------------------
inline CCounter::CCounter(const CCounter& co) {
    // EXISTING_CODE
    // EXISTING_CODE
    duplicate(co);
}

// EXISTING_CODE
// EXISTING_CODE

//--------------------------------------------------------------------------
inline CCounter::~CCounter(void) {
    clear();
    // EXISTING_CODE
    // EXISTING_CODE
}

//--------------------------------------------------------------------------
inline void CCounter::clear(void) {
    // EXISTING_CODE
    // EXISTING_CODE
}

//--------------------------------------------------------------------------
inline void CCounter::initialize(void) {
    CBaseNode::initialize();

    string = "";
    count = 0;

    // EXISTING_CODE
    // EXISTING_CODE
}

//--------------------------------------------------------------------------
inline void CCounter::duplicate(const CCounter& co) {
    clear();
    CBaseNode::duplicate(co);

    string = co.string;
    count = co.count;

    // EXISTING_CODE
    // EXISTING_CODE
}

//--------------------------------------------------------------------------
inline CCounter& CCounter::operator=(const CCounter& co) {
    duplicate(co);
    // EXISTING_CODE
    // EXISTING_CODE
    return *this;
}

//-------------------------------------------------------------------------
inline bool CCounter::operator==(const CCounter& it) const {
    // EXISTING_CODE
    // EXISTING_CODE
    // No default equal operator in class definition, assume none are equal (so find fails)
    return false;
}

//-------------------------------------------------------------------------
inline bool operator<(const CCounter& v1, const CCounter& v2) {
    // EXISTING_CODE
    // EXISTING_CODE
    // No default sort defined in class definition, assume already sorted, preserve ordering
    return true;
}

//---------------------------------------------------------------------------
typedef vector<CCounter> CCounterArray;
extern CArchive& operator>>(CArchive& archive, CCounterArray& array);
extern CArchive& operator<<(CArchive& archive, const CCounterArray& array);

//---------------------------------------------------------------------------
extern CArchive& operator<<(CArchive& archive, const CCounter& cou);
extern CArchive& operator>>(CArchive& archive, CCounter& cou);

//---------------------------------------------------------------------------
extern const char* STR_DISPLAY_COUNTER;

//---------------------------------------------------------------------------
// EXISTING_CODE
// EXISTING_CODE
}  // namespace qblocks
