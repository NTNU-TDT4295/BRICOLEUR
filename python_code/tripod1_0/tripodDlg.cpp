// FILE: tripodDlg.cpp : implementation file
// AUTH: P. Oh
// DATE: 04/24/02 04:00
// VERS: 11/21/01 : 0.9 posted on web
//       04/24/02 : 1.0 Added free to release memory malloced for m_destinationBmp
// DESC: TRIPOD template files for real-time image processing development
// STAT: 1.0 Working
// REFS: brinarize - Example application for binary images

#include "stdafx.h"
#include "tripod.h"
#include "tripodDlg.h"

#include "LVServerDefs.h"
#include <math.h>

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CAboutDlg dialog used for App About

class CAboutDlg : public CDialog
{
public:
	CAboutDlg();

// Dialog Data
	//{{AFX_DATA(CAboutDlg)
	enum { IDD = IDD_ABOUTBOX };
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CAboutDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	//{{AFX_MSG(CAboutDlg)
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialog(CAboutDlg::IDD)
{
	//{{AFX_DATA_INIT(CAboutDlg)
	//}}AFX_DATA_INIT
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CAboutDlg)
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
	//{{AFX_MSG_MAP(CAboutDlg)
		// No message handlers
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CTripodDlg dialog

CTripodDlg::CTripodDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CTripodDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CTripodDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
	// Note that LoadIcon does not require a subsequent DestroyIcon in Win32
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);

	//////////////// Set destination BMP to NULL first 
	m_destinationBitmapInfoHeader = NULL;

}

////////////////////// Additional generic functions

static unsigned PixelBytes(int w, int bpp)
{
    return (w * bpp + 7) / 8;
}

static unsigned DibRowSize(int w, int bpp)
{
    return (w * bpp + 31) / 32 * 4;
}

static unsigned DibRowSize(LPBITMAPINFOHEADER pbi)
{
    return DibRowSize(pbi->biWidth, pbi->biBitCount);
}

static unsigned DibRowPadding(int w, int bpp)
{
    return DibRowSize(w, bpp) - PixelBytes(w, bpp);
}

static unsigned DibRowPadding(LPBITMAPINFOHEADER pbi)
{
    return DibRowPadding(pbi->biWidth, pbi->biBitCount);
}

static unsigned DibImageSize(int w, int h, int bpp)
{
    return h * DibRowSize(w, bpp);
}

static size_t DibSize(int w, int h, int bpp)
{
    return sizeof (BITMAPINFOHEADER) + DibImageSize(w, h, bpp);
}

/////////////////////// end of generic functions


void CTripodDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CTripodDlg)
	DDX_Control(pDX, IDC_PROCESSEDVIEW, m_cVideoProcessedView);
	DDX_Control(pDX, IDC_UNPROCESSEDVIEW, m_cVideoUnprocessedView);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CTripodDlg, CDialog)
	//{{AFX_MSG_MAP(CTripodDlg)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDEXIT, OnExit)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CTripodDlg message handlers

BOOL CTripodDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// Add "About..." menu item to system menu.

	// IDM_ABOUTBOX must be in the system command range.
	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);

	CMenu* pSysMenu = GetSystemMenu(FALSE);
	if (pSysMenu != NULL)
	{
		CString strAboutMenu;
		strAboutMenu.LoadString(IDS_ABOUTBOX);
		if (!strAboutMenu.IsEmpty())
		{
			pSysMenu->AppendMenu(MF_SEPARATOR);
			pSysMenu->AppendMenu(MF_STRING, IDM_ABOUTBOX, strAboutMenu);
		}
	}

	// Set the icon for this dialog.  The framework does this automatically
	//  when the application's main window is not a dialog
	SetIcon(m_hIcon, TRUE);			// Set big icon
	SetIcon(m_hIcon, FALSE);		// Set small icon
	
	// TODO: Add extra initialization here

	// For Unprocessed view videoportal (top one)
	char sRegUnprocessedView[] = "HKEY_LOCAL_MACHINE\\Software\\UnprocessedView";
	m_cVideoUnprocessedView.PrepareControl("UnprocessedView", sRegUnprocessedView, 0 );	
	m_cVideoUnprocessedView.EnableUIElements(UIELEMENT_STATUSBAR,0,TRUE);
	m_cVideoUnprocessedView.ConnectCamera2();
	m_cVideoUnprocessedView.SetEnablePreview(TRUE);

	// For binary view videoportal (bottom one)
	char sRegProcessedView[] = "HKEY_LOCAL_MACHINE\\Software\\ProcessedView";
	m_cVideoProcessedView.PrepareControl("ProcessedView", sRegProcessedView, 0 );	
	m_cVideoProcessedView.EnableUIElements(UIELEMENT_STATUSBAR,0,TRUE);
	m_cVideoProcessedView.ConnectCamera2();
	m_cVideoProcessedView.SetEnablePreview(TRUE);

	// Initialize the size of binary videoportal
	m_cVideoProcessedView.SetPreviewMaxHeight(240);
	m_cVideoProcessedView.SetPreviewMaxWidth(320);

	// Uncomment if you wish to fix the live videoportal's size
	// m_cVideoUnprocessedView.SetPreviewMaxHeight(240);
	// m_cVideoUnprocessedView.SetPreviewMaxWidth(320);

	// Find the screen coodinates of the binary videoportal
	m_cVideoProcessedView.GetWindowRect(m_rectForProcessedView);
	ScreenToClient(m_rectForProcessedView);
	allocateDib(CSize(320, 240));

	// Start grabbing frame data for Procssed videoportal (bottom one)
	m_cVideoProcessedView.StartVideoHook(0);

	return TRUE;  // return TRUE  unless you set the focus to a control
}

void CTripodDlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	if ((nID & 0xFFF0) == IDM_ABOUTBOX)
	{
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	}
	else
	{
		CDialog::OnSysCommand(nID, lParam);
	}
}

// If you add a minimize button to your dialog, you will need the code below
//  to draw the icon.  For MFC applications using the document/view model,
//  this is automatically done for you by the framework.

void CTripodDlg::OnPaint() 
{
	if (IsIconic())
	{
		CPaintDC dc(this); // device context for painting

		SendMessage(WM_ICONERASEBKGND, (WPARAM) dc.GetSafeHdc(), 0);

		// Center icon in client rectangle
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// Draw the icon
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialog::OnPaint();
	}
}

// The system calls this to obtain the cursor to display while the user drags
//  the minimized window.
HCURSOR CTripodDlg::OnQueryDragIcon()
{
	return (HCURSOR) m_hIcon;
}

void CTripodDlg::OnExit() 
{
	// TODO: Add your control notification handler code here

	// Kill live view videoportal (top one)
	m_cVideoUnprocessedView.StopVideoHook(0);
    m_cVideoUnprocessedView.DisconnectCamera();	
	
	// Kill binary view videoportal (bottom one)
	m_cVideoProcessedView.StopVideoHook(0);
    m_cVideoProcessedView.DisconnectCamera();	

	// Kill program
	DestroyWindow();	

}

BEGIN_EVENTSINK_MAP(CTripodDlg, CDialog)
    //{{AFX_EVENTSINK_MAP(CTripodDlg)
	ON_EVENT(CTripodDlg, IDC_PROCESSEDVIEW, 1 /* PortalNotification */, OnPortalNotificationProcessedview, VTS_I4 VTS_I4 VTS_I4 VTS_I4)
	//}}AFX_EVENTSINK_MAP
END_EVENTSINK_MAP()

void CTripodDlg::OnPortalNotificationProcessedview(long lMsg, long lParam1, long lParam2, long lParam3) 
{
	// TODO: Add your control notification handler code here
	
	// This function is called at the camera's frame rate
    
#define NOTIFICATIONMSG_VIDEOHOOK	10

	// Declare some useful variables
	// QCSDKMFC.pdf (Quickcam MFC documentation) p. 103 explains the variables lParam1, lParam2, lParam3 too 
	
	LPBITMAPINFOHEADER lpBitmapInfoHeader; // Frame's info header contains info like width and height
	LPBYTE lpBitmapPixelData; // This pointer-to-long will point to the start of the frame's pixel data
    unsigned long lTimeStamp; // Time when frame was grabbed

	switch(lMsg) {
		case NOTIFICATIONMSG_VIDEOHOOK:
			{
				lpBitmapInfoHeader = (LPBITMAPINFOHEADER) lParam1; 
				lpBitmapPixelData = (LPBYTE) lParam2;
				lTimeStamp = (unsigned long) lParam3;

				grayScaleTheFrameData(lpBitmapInfoHeader, lpBitmapPixelData);
				doMyImageProcessing(lpBitmapInfoHeader); // Place where you'd add your image processing code
				displayMyResults(lpBitmapInfoHeader);

			}
			break;

		default:
			break;
	}	
}

void CTripodDlg::allocateDib(CSize sz)
{
	// Purpose: allocate information for a device independent bitmap (DIB)
	// Called from OnInitVideo

	if(m_destinationBitmapInfoHeader) {
		free(m_destinationBitmapInfoHeader);
		m_destinationBitmapInfoHeader = NULL;
	}

	if(sz.cx | sz.cy) {
		m_destinationBitmapInfoHeader = (LPBITMAPINFOHEADER)malloc(DibSize(sz.cx, sz.cy, 24));
		ASSERT(m_destinationBitmapInfoHeader);
		m_destinationBitmapInfoHeader->biSize = sizeof(BITMAPINFOHEADER);
		m_destinationBitmapInfoHeader->biWidth = sz.cx;
		m_destinationBitmapInfoHeader->biHeight = sz.cy;
		m_destinationBitmapInfoHeader->biPlanes = 1;
		m_destinationBitmapInfoHeader->biBitCount = 24;
		m_destinationBitmapInfoHeader->biCompression = 0;
		m_destinationBitmapInfoHeader->biSizeImage = DibImageSize(sz.cx, sz.cy, 24);
		m_destinationBitmapInfoHeader->biXPelsPerMeter = 0;
		m_destinationBitmapInfoHeader->biYPelsPerMeter = 0;
		m_destinationBitmapInfoHeader->biClrImportant = 0;
		m_destinationBitmapInfoHeader->biClrUsed = 0;
	}
}

void CTripodDlg::displayMyResults(LPBITMAPINFOHEADER lpThisBitmapInfoHeader)
{
	// displayMyResults: Displays results of doMyImageProcessing() in the videoport
	// Notes: StretchDIBits stretches a device-independent bitmap to the appropriate size

	CDC				*pDC;	// Device context to display bitmap data
	
	pDC = GetDC();	
	int nOldMode = SetStretchBltMode(pDC->GetSafeHdc(),COLORONCOLOR);

	StretchDIBits( 
		pDC->GetSafeHdc(),
		m_rectForProcessedView.left,				// videoportal left-most coordinate
		m_rectForProcessedView.top,					// videoportal top-most coordinate
		m_rectForProcessedView.Width(),				// videoportal width
		m_rectForProcessedView.Height(),			// videoportal height
		0,											// Row position to display bitmap in videoportal
		0,											// Col position to display bitmap in videoportal
		lpThisBitmapInfoHeader->biWidth,			// m_destinationBmp's number of columns
		lpThisBitmapInfoHeader->biHeight,			// m_destinationBmp's number of rows
		m_destinationBmp,							// The bitmap to display; use the one resulting from doMyImageProcessing
		(BITMAPINFO*)m_destinationBitmapInfoHeader, // The bitmap's header info e.g. width, height, number of bits etc
		DIB_RGB_COLORS,								// Use default 24-bit color table
		SRCCOPY										// Just display
	);
 
	SetStretchBltMode(pDC->GetSafeHdc(),nOldMode);

	ReleaseDC(pDC);

	// Note: 04/24/02 - Added the following:
	// Christopher Wagner cwagner@fas.harvard.edu noticed that memory wasn't being freed

	// Recall OnPortalNotificationProcessedview, which gets called everytime
	// a frame of data arrives, performs 3 steps:
	// (1) grayScaleTheFrameData - which mallocs m_destinationBmp
	// (2) doMyImageProcesing
	// (3) displayMyResults - which we're in now
	// Since we're finished with the memory we malloc'ed for m_destinationBmp
	// we should free it: 
	
	free(m_destinationBmp);

	// End of adds
}

void CTripodDlg::grayScaleTheFrameData(LPBITMAPINFOHEADER lpThisBitmapInfoHeader, LPBYTE lpThisBitmapPixelData)
{

	// grayScaleTheFrameData: Called by CTripodDlg::OnPortalNotificationBinaryview
	// Task: Read current frame pixel data and computes a grayscale version

	unsigned int	W, H;			  // Width and Height of current frame [pixels]
	BYTE            *sourceBmp;		  // Pointer to current frame of data
	unsigned int    row, col;
	unsigned long   i;
	BYTE			grayValue;

	BYTE			redValue;
	BYTE			greenValue;
	BYTE			blueValue;

    W = lpThisBitmapInfoHeader->biWidth;  // biWidth: number of columns
    H = lpThisBitmapInfoHeader->biHeight; // biHeight: number of rows

	// Store pixel data in row-column vector format
	// Recall that each pixel requires 3 bytes (red, blue and green bytes)
	// m_destinationBmp is a protected member and declared in binarizeDlg.h

	m_destinationBmp = (BYTE*)malloc(H*3*W*sizeof(BYTE));

	// Point to the current frame's pixel data
	sourceBmp = lpThisBitmapPixelData;

	for (row = 0; row < H; row++) {
		for (col = 0; col < W; col++) {

			// Recall each pixel is composed of 3 bytes
			i = (unsigned long)(row*3*W + 3*col);
        
			// The source pixel has a blue, green andred value:
			blueValue  = *(sourceBmp + i);
			greenValue = *(sourceBmp + i + 1);
			redValue   = *(sourceBmp + i + 2);

			// A standard equation for computing a grayscale value based on RGB values
			grayValue = (BYTE)(0.299*redValue + 0.587*greenValue + 0.114*blueValue);

			// The destination BMP will be a grayscale version of the source BMP
			*(m_destinationBmp + i)     = grayValue;
			*(m_destinationBmp + i + 1) = grayValue;
			*(m_destinationBmp + i + 2) = grayValue;
			
		}
	}
}

void CTripodDlg::doMyImageProcessing(LPBITMAPINFOHEADER lpThisBitmapInfoHeader)
{
	// doMyImageProcessing:  This is where you'd write your own image processing code
	// Task: Read a pixel's grayscale value and process accordingly

	unsigned int	W, H;			  // Width and Height of current frame [pixels]
	unsigned int    row, col;		  // Pixel's row and col positions
	unsigned long   i;				  // Dummy variable for row-column vector

	char			str[80];		  // To print message 
	CDC				*pDC;			  // Device context need to print message

    W = lpThisBitmapInfoHeader->biWidth;  // biWidth: number of columns
    H = lpThisBitmapInfoHeader->biHeight; // biHeight: number of rows

	// In this example, the grayscale image (stored in m_destinationBmp) is
	// thresholded to create a binary image.  A threshold value close to 255 
	// means that only colors close to white will remain white in binarized 
	// BMP and all other colors will be black
	
	for (row = 0; row < H; row++) {
		for (col = 0; col < W; col++) {

			// Recall each pixel is composed of 3 bytes
			i = (unsigned long)(row*3*W + 3*col);

			// Add your code to operate on each pixel. For example 
			// *(m_destinationBmp + i) refers to the ith pixel in the destinationBmp
			// Since destinationBmp is a 24-bit grayscale image, you must also apply
			// the same operation to *((m_destinationBmp + i + 1) and *((m_destinationBmp + i + 2)

		}
	}

	// To print message at (row, column) = (75, 580). Comment if not needed
	pDC = GetDC();	
	sprintf(str, "Processed Viewport");
	pDC->TextOut(75, 580, str);
	ReleaseDC(pDC);
}
