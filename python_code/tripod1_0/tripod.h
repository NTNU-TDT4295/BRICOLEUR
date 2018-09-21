// tripod.h : main header file for the TRIPOD application
//

#if !defined(AFX_TRIPOD_H__81028C42_DE77_11D5_B703_00C04F04A1F3__INCLUDED_)
#define AFX_TRIPOD_H__81028C42_DE77_11D5_B703_00C04F04A1F3__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"		// main symbols

/////////////////////////////////////////////////////////////////////////////
// CTripodApp:
// See tripod.cpp for the implementation of this class
//

class CTripodApp : public CWinApp
{
public:
	CTripodApp();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CTripodApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation

	//{{AFX_MSG(CTripodApp)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_TRIPOD_H__81028C42_DE77_11D5_B703_00C04F04A1F3__INCLUDED_)
