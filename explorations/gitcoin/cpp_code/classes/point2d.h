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
class CPoint2d : public CBaseNode {
  public:
    uint64_t x;
    uint64_t y;

  public:
    CPoint2d(void);
    CPoint2d(const CPoint2d& po);
    virtual ~CPoint2d(void);
    CPoint2d& operator=(const CPoint2d& po);

    DECLARE_NODE(CPoint2d);

    // EXISTING_CODE
    // EXISTING_CODE
    bool operator==(const CPoint2d& it) const;
    bool operator!=(const CPoint2d& it) const {
        return !operator==(it);
    }
    friend bool operator<(const CPoint2d& v1, const CPoint2d& v2);
    friend ostream& operator<<(ostream& os, const CPoint2d& it);

  protected:
    void clear(void);
    void initialize(void);
    void duplicate(const CPoint2d& po);
    bool readBackLevel(CArchive& archive) override;

    // EXISTING_CODE
    // EXISTING_CODE
};

//--------------------------------------------------------------------------
inline CPoint2d::CPoint2d(void) {
    initialize();
    // EXISTING_CODE
    // EXISTING_CODE
}

//--------------------------------------------------------------------------
inline CPoint2d::CPoint2d(const CPoint2d& po) {
    // EXISTING_CODE
    // EXISTING_CODE
    duplicate(po);
}

// EXISTING_CODE
// EXISTING_CODE

//--------------------------------------------------------------------------
inline CPoint2d::~CPoint2d(void) {
    clear();
    // EXISTING_CODE
    // EXISTING_CODE
}

//--------------------------------------------------------------------------
inline void CPoint2d::clear(void) {
    // EXISTING_CODE
    // EXISTING_CODE
}

//--------------------------------------------------------------------------
inline void CPoint2d::initialize(void) {
    CBaseNode::initialize();

    x = 0;
    y = 0;

    // EXISTING_CODE
    // EXISTING_CODE
}

//--------------------------------------------------------------------------
inline void CPoint2d::duplicate(const CPoint2d& po) {
    clear();
    CBaseNode::duplicate(po);

    x = po.x;
    y = po.y;

    // EXISTING_CODE
    // EXISTING_CODE
}

//--------------------------------------------------------------------------
inline CPoint2d& CPoint2d::operator=(const CPoint2d& po) {
    duplicate(po);
    // EXISTING_CODE
    // EXISTING_CODE
    return *this;
}

//-------------------------------------------------------------------------
inline bool CPoint2d::operator==(const CPoint2d& it) const {
    // EXISTING_CODE
    // EXISTING_CODE
    // No default equal operator in class definition, assume none are equal (so find fails)
    return false;
}

//-------------------------------------------------------------------------
inline bool operator<(const CPoint2d& v1, const CPoint2d& v2) {
    // EXISTING_CODE
    // EXISTING_CODE
    // No default sort defined in class definition, assume already sorted, preserve ordering
    return true;
}

//---------------------------------------------------------------------------
typedef vector<CPoint2d> CPoint2dArray;
extern CArchive& operator>>(CArchive& archive, CPoint2dArray& array);
extern CArchive& operator<<(CArchive& archive, const CPoint2dArray& array);

//---------------------------------------------------------------------------
extern CArchive& operator<<(CArchive& archive, const CPoint2d& poi);
extern CArchive& operator>>(CArchive& archive, CPoint2d& poi);

//---------------------------------------------------------------------------
extern const char* STR_DISPLAY_POINT2D;

//---------------------------------------------------------------------------
// EXISTING_CODE
// EXISTING_CODE
}  // namespace qblocks
