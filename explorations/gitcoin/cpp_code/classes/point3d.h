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
class CPoint3d : public CBaseNode {
  public:
    double x;
    double y;
    double z;

  public:
    CPoint3d(void);
    CPoint3d(const CPoint3d& po);
    virtual ~CPoint3d(void);
    CPoint3d& operator=(const CPoint3d& po);

    DECLARE_NODE(CPoint3d);

    // EXISTING_CODE
    // EXISTING_CODE
    bool operator==(const CPoint3d& it) const;
    bool operator!=(const CPoint3d& it) const {
        return !operator==(it);
    }
    friend bool operator<(const CPoint3d& v1, const CPoint3d& v2);
    friend ostream& operator<<(ostream& os, const CPoint3d& it);

  protected:
    void clear(void);
    void initialize(void);
    void duplicate(const CPoint3d& po);
    bool readBackLevel(CArchive& archive) override;

    // EXISTING_CODE
    // EXISTING_CODE
};

//--------------------------------------------------------------------------
inline CPoint3d::CPoint3d(void) {
    initialize();
    // EXISTING_CODE
    // EXISTING_CODE
}

//--------------------------------------------------------------------------
inline CPoint3d::CPoint3d(const CPoint3d& po) {
    // EXISTING_CODE
    // EXISTING_CODE
    duplicate(po);
}

// EXISTING_CODE
// EXISTING_CODE

//--------------------------------------------------------------------------
inline CPoint3d::~CPoint3d(void) {
    clear();
    // EXISTING_CODE
    // EXISTING_CODE
}

//--------------------------------------------------------------------------
inline void CPoint3d::clear(void) {
    // EXISTING_CODE
    // EXISTING_CODE
}

//--------------------------------------------------------------------------
inline void CPoint3d::initialize(void) {
    CBaseNode::initialize();

    x = 0.0;
    y = 0.0;
    z = 0.0;

    // EXISTING_CODE
    // EXISTING_CODE
}

//--------------------------------------------------------------------------
inline void CPoint3d::duplicate(const CPoint3d& po) {
    clear();
    CBaseNode::duplicate(po);

    x = po.x;
    y = po.y;
    z = po.z;

    // EXISTING_CODE
    // EXISTING_CODE
}

//--------------------------------------------------------------------------
inline CPoint3d& CPoint3d::operator=(const CPoint3d& po) {
    duplicate(po);
    // EXISTING_CODE
    // EXISTING_CODE
    return *this;
}

//-------------------------------------------------------------------------
inline bool CPoint3d::operator==(const CPoint3d& it) const {
    // EXISTING_CODE
    // EXISTING_CODE
    // No default equal operator in class definition, assume none are equal (so find fails)
    return false;
}

//-------------------------------------------------------------------------
inline bool operator<(const CPoint3d& v1, const CPoint3d& v2) {
    // EXISTING_CODE
    // EXISTING_CODE
    // No default sort defined in class definition, assume already sorted, preserve ordering
    return true;
}

//---------------------------------------------------------------------------
typedef vector<CPoint3d> CPoint3dArray;
extern CArchive& operator>>(CArchive& archive, CPoint3dArray& array);
extern CArchive& operator<<(CArchive& archive, const CPoint3dArray& array);

//---------------------------------------------------------------------------
extern CArchive& operator<<(CArchive& archive, const CPoint3d& poi);
extern CArchive& operator>>(CArchive& archive, CPoint3d& poi);

//---------------------------------------------------------------------------
extern const char* STR_DISPLAY_POINT3D;

//---------------------------------------------------------------------------
// EXISTING_CODE
// EXISTING_CODE
}  // namespace qblocks
