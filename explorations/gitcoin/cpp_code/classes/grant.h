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
#include "point3d.h"
#include "profile.h"
#include "metadata.h"

namespace qblocks {

// EXISTING_CODE
// EXISTING_CODE

//--------------------------------------------------------------------------
class CGrant : public CBaseNode {
  public:
    bool active;
    uint64_t grant_id;
    string_q title;
    string_q slug;
    string_q description;
    string_q reference_url;
    string_q logo;
    address_t admin_address;
    string_q amount_received;
    address_t token_address;
    string_q token_symbol;
    address_t contract_address;
    CMetaData metadata;
    string_q network;
    string_q required_gas_price;
    CProfile admin_profile;
    CProfileArray team_members;
    CPoint3dArray clr_prediction_curve;

  public:
    CGrant(void);
    CGrant(const CGrant& gr);
    virtual ~CGrant(void);
    CGrant& operator=(const CGrant& gr);

    DECLARE_NODE(CGrant);

    const CBaseNode* getObjectAt(const string_q& fieldName, size_t index) const override;

    // EXISTING_CODE
    // EXISTING_CODE
    bool operator==(const CGrant& it) const;
    bool operator!=(const CGrant& it) const {
        return !operator==(it);
    }
    friend bool operator<(const CGrant& v1, const CGrant& v2);
    friend ostream& operator<<(ostream& os, const CGrant& it);

  protected:
    void clear(void);
    void initialize(void);
    void duplicate(const CGrant& gr);
    bool readBackLevel(CArchive& archive) override;

    // EXISTING_CODE
    // EXISTING_CODE
};

//--------------------------------------------------------------------------
inline CGrant::CGrant(void) {
    initialize();
    // EXISTING_CODE
    // EXISTING_CODE
}

//--------------------------------------------------------------------------
inline CGrant::CGrant(const CGrant& gr) {
    // EXISTING_CODE
    // EXISTING_CODE
    duplicate(gr);
}

// EXISTING_CODE
// EXISTING_CODE

//--------------------------------------------------------------------------
inline CGrant::~CGrant(void) {
    clear();
    // EXISTING_CODE
    // EXISTING_CODE
}

//--------------------------------------------------------------------------
inline void CGrant::clear(void) {
    // EXISTING_CODE
    // EXISTING_CODE
}

//--------------------------------------------------------------------------
inline void CGrant::initialize(void) {
    CBaseNode::initialize();

    active = false;
    grant_id = 0;
    title = "";
    slug = "";
    description = "";
    reference_url = "";
    logo = "";
    admin_address = "";
    amount_received = "";
    token_address = "";
    token_symbol = "";
    contract_address = "";
    metadata = CMetaData();
    network = "";
    required_gas_price = "";
    admin_profile = CProfile();
    team_members.clear();
    clr_prediction_curve.clear();

    // EXISTING_CODE
    // EXISTING_CODE
}

//--------------------------------------------------------------------------
inline void CGrant::duplicate(const CGrant& gr) {
    clear();
    CBaseNode::duplicate(gr);

    active = gr.active;
    grant_id = gr.grant_id;
    title = gr.title;
    slug = gr.slug;
    description = gr.description;
    reference_url = gr.reference_url;
    logo = gr.logo;
    admin_address = gr.admin_address;
    amount_received = gr.amount_received;
    token_address = gr.token_address;
    token_symbol = gr.token_symbol;
    contract_address = gr.contract_address;
    metadata = gr.metadata;
    network = gr.network;
    required_gas_price = gr.required_gas_price;
    admin_profile = gr.admin_profile;
    team_members = gr.team_members;
    clr_prediction_curve = gr.clr_prediction_curve;

    // EXISTING_CODE
    // EXISTING_CODE
}

//--------------------------------------------------------------------------
inline CGrant& CGrant::operator=(const CGrant& gr) {
    duplicate(gr);
    // EXISTING_CODE
    // EXISTING_CODE
    return *this;
}

//-------------------------------------------------------------------------
inline bool CGrant::operator==(const CGrant& it) const {
    // EXISTING_CODE
    // EXISTING_CODE
    // No default equal operator in class definition, assume none are equal (so find fails)
    return false;
}

//-------------------------------------------------------------------------
inline bool operator<(const CGrant& v1, const CGrant& v2) {
    // EXISTING_CODE
    // EXISTING_CODE
    // Default sort as defined in class definition
    return v1.grant_id < v2.grant_id;
}

//---------------------------------------------------------------------------
typedef vector<CGrant> CGrantArray;
extern CArchive& operator>>(CArchive& archive, CGrantArray& array);
extern CArchive& operator<<(CArchive& archive, const CGrantArray& array);

//---------------------------------------------------------------------------
extern CArchive& operator<<(CArchive& archive, const CGrant& gra);
extern CArchive& operator>>(CArchive& archive, CGrant& gra);

//---------------------------------------------------------------------------
extern const char* STR_DISPLAY_GRANT;

//---------------------------------------------------------------------------
// EXISTING_CODE
// EXISTING_CODE
}  // namespace qblocks
