// tripodDlg.h : header file
//
//{{AFX_INCLUDES()
#include "videoportal.h"
//}}AFX_INCLUDES

#if !defined(AFX_TRIPODDLG_H__81028C44_DE77_11D5_B703_00C04F04A1F3__INCLUDED_)
#define AFX_TRIPODDLG_H__81028C44_DE77_11D5_B703_00C04F04A1F3__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

/////////////////////////////////////////////////////////////////////////////
// CTripodDlg dialog

class CTripodDlg : public CDialog
{
// Construction
public:
	CTripodDlg(CWnd* pParent = NULL);	// standard constructor

// Dialog Data
	//{{AFX_DATA(CTripodDlg)
	enum { IDD = IDD_TRIPOD_DIALOG };
	CVideoPortal	m_cVideoProcessedView;
	CVideoPortal	m_cVideoUnprocessedView;
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CTripodDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	HICON m_hIcon;
	CRect				m_rectForProcessedView;			// Videoportal frame characteristics (width, screen location etc)
	LPBITMAPINFOHEADER	m_destinationBitmapInfoHeader;
	BYTE				*m_destinationBmp;

	void grayScaleTheFrameData(LPBITMAPINFOHEADER lpThisBitmapHeaderInfo, LPBYTE lpThisBitmapPixelData);
	void allocateDib(CSize sz);
	void doMyImageProcessing(LPBITMAPINFOHEADER lpThisBitmapInfoHeader);
	void displayMyResults(LPBITMAPINFOHEADER lpThisBitmapInfoHeader);

	// Generated message map functions
	//{{AFX_MSG(CTripodDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	afx_msg void OnExit();
	afx_msg void OnPortalNotificationProcessedview(long lMsg, long lParam1, long lParam2, long lParam3);
	DECLARE_EVENTSINK_MAP()
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_TRIPODDLG_H__81028C44_DE77_11D5_B703_00C04F04A1F3__INCLUDED_)
