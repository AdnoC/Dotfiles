function! s:set_size(...)
  " https://github.com/equalsraf/neovim-qt/issues/251
  py3 << EOF
import vim
from ctypes import *
u32 = WinDLL('user32.dll')

# Parent PID code gotten from
# http://code.activestate.com/recipes/578133-get-parent-process-pid-win32/
def get_parent_pid(pid):
    # Constants
    TH32CS_SNAPPROCESS = 2

    # Struct for PROCESSENTRY32
    class PROCESSENTRY32(Structure):
        _fields_ = [ ('dwSize', c_ulong ),
                    ('cntUsage', c_ulong),
                    ('th32ProcessID', c_ulong),
                    ('th32DefaultHeapID', POINTER(c_ulong)),
                    ('th32ModuleID', c_ulong),
                    ('cntThreads', c_ulong),
                    ('th32ParentProcessID', c_ulong),
                    ('pcPriClassBase', c_long),
                    ('dwFlags', c_ulong),
                    ('szExeFile', c_char * 260 ) ]

    # Foreign functions
    ## CreateToolhelp32Snapshot
    CreateToolhelp32Snapshot= windll.kernel32.CreateToolhelp32Snapshot
    CreateToolhelp32Snapshot.reltype = c_long
    CreateToolhelp32Snapshot.argtypes = [ c_int , c_int ]
    ## Process32First
    Process32First = windll.kernel32.Process32First
    Process32First.argtypes = [ c_void_p , POINTER( PROCESSENTRY32 ) ]
    Process32First.rettype = c_int
    ## Process32Next
    Process32Next = windll.kernel32.Process32Next
    Process32Next.argtypes = [ c_void_p , POINTER(PROCESSENTRY32) ]
    Process32Next.rettype = c_int
    ## CloseHandle
    CloseHandle = windll.kernel32.CloseHandle
    CloseHandle.argtypes = [ c_void_p ]
    CloseHandle.rettype = c_int

    ppid = None
    hProcessSnap = c_void_p(0)
    hProcessSnap = CreateToolhelp32Snapshot( TH32CS_SNAPPROCESS , 0 )

    pe32 = PROCESSENTRY32()
    pe32.dwSize = sizeof( PROCESSENTRY32 )
    ret = Process32First( hProcessSnap , pointer( pe32 ) )

    while ret:
        if pe32.th32ProcessID == pid:
            ppid = pe32.th32ParentProcessID
            break
        ret = Process32Next( hProcessSnap, pointer(pe32) )
    CloseHandle(hProcessSnap)
    return ppid


def get_window_handle(target_pid):
    EnumWindows = windll.user32.EnumWindows
    EnumWindowsProc = WINFUNCTYPE(c_bool, POINTER(c_int), POINTER(c_int))
    GetWindowText = windll.user32.GetWindowTextW
    GetWindowTextLength = windll.user32.GetWindowTextLengthW
    IsWindowVisible = windll.user32.IsWindowVisible

    win_handle = { 'handle': None }

    def foreach_window(hwnd, lParam):
        if IsWindowVisible(hwnd):
            length = GetWindowTextLength(hwnd)
            buff = create_unicode_buffer(length + 1)
            GetWindowText(hwnd, buff, length + 1)

            win_proc = c_ulong()
            u32.GetWindowThreadProcessId(hwnd, byref(win_proc))
            # print("title is", buff.value, "search", target_pid, " proc is", win_proc)
            if target_pid == win_proc.value:
                win_handle['handle'] = hwnd
                return False

        return True

    EnumWindows(EnumWindowsProc(foreach_window), target_pid)
    return win_handle['handle']


def center_window(hwnd):
    GetForegroundWindow = u32.GetForegroundWindow
    MonitorFromWindow = u32.MonitorFromWindow
    GetMonitorInfoA = u32.GetMonitorInfoA
    SetWindowPos = u32.SetWindowPos
    SetForegroundWindow = u32.SetForegroundWindow

    class _rect_t(Structure):
        _fields_ = [
            ('left',    c_long),
            ('top',     c_long),
            ('right',   c_long),
            ('bottom',  c_long)
        ]

    class _monitor_info_t(Structure):
        _fields_ = [
            ('cbSize',     c_ulong),
            ('rcMonitor',  _rect_t),
            ('rcWork',     _rect_t),
            ('dwFlags',    c_ulong)
        ]

    MONITOR_DEFAULTTONEAREST = 0 # Probably

    mon = MonitorFromWindow(hwnd, MONITOR_DEFAULTTONEAREST)

    # Monitor info code gotten from:
    # http://nullege.com/codes/show/src%40s%40u%40SublimeSpeech-HEAD%40lib%40dragonfly%40windows%40monitor.py/118/windll.user32.GetMonitorInfoA/python

    info = _monitor_info_t()
    info.cbSize     = sizeof(_monitor_info_t)
    info.rcMonitor  = _rect_t()
    info.rcWork     = _rect_t()

    GetMonitorInfoA(mon, byref(info))

    mon_width = info.rcMonitor.right - info.rcMonitor.left
    mon_height = info.rcMonitor.bottom - info.rcMonitor.top

    mid_w = mon_width / 2
    mid_h = mon_height / 2

    width = int(mon_width * 45.0/100.0)
    height = int(mon_height * 9.0/10.0)

    left = info.rcMonitor.left + int(mid_w - (width / 2))
    top = info.rcMonitor.top + int(mid_h - (height / 2))

    SetWindowPos(hwnd, 0, left, top, width, height, 0)
    SetForegroundWindow(hwnd)


def setup_window():
  vim_pid = vim.eval('getpid()')
  vim_pid = int(vim_pid)
  qt_pid = get_parent_pid(vim_pid)
  if not qt_pid:
    print("Was unable to get PID of Qt")
    return
  vim_win = get_window_handle(qt_pid)
  center_window(vim_win)


setup_window()
EOF
endfunction


if exists('g:GuiLoaded')
  let g:solarized_termtrans=0
  set termguicolors
  set clipboard=unnamed
  colorscheme solarized8
  Guifont! DejaVu Sans Mono for Powerline:h10
  let SetSize = function('s:set_size')
  call timer_start(500, SetSize)
endif

