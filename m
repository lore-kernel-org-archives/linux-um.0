Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CwRds-0006iR-02 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Feb 2005 13:02:28 -0800
Received: from ktown.kde.org ([131.246.103.200])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CwRdo-0005lv-UK for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Feb 2005 13:02:27 -0800
From: das deniz <das_deniz@yahoo.com>
Reply-To: 98444@bugs.kde.org
Content-Type: text/plain; charset="utf-8"   
Message-ID: <20050202220205.98444.das_deniz@yahoo.com>  
Subject: [uml-devel] [Bug 98444] New: valgrind fails to run against
	user-mode-linux (UML) process - clone
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: 2 Feb 2005 21:02:15 -0000
To: user-mode-linux-devel@lists.sourceforge.net

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.
         
http://bugs.kde.org/show_bug.cgi?id=98444         
           Summary: valgrind fails to run against user-mode-linux (UML)
                    process - clone
           Product: valgrind
           Version: 2.3 CVS
          Platform: RedHat RPMs
        OS/Version: Linux
            Status: UNCONFIRMED
          Severity: crash
          Priority: NOR
         Component: general
        AssignedTo: jseward acm org
        ReportedBy: das_deniz yahoo com
                CC: user-mode-linux-devel lists sourceforge net


picking up this thread again:  

  http://marc.theaimsgroup.com/?l=user-mode-linux-devel&m=109152647819605&w=2

in valgrind 2.2.0 we had at best -- "clone(): not supported by Valgrind." and it
never went any further despite talk of old patches that would allow the clone
out from under valgrind to get to the next stopper.

but now in CVS HEAD, we no longer get this message, but instead we see:

SYSCALL[27839,1](120) special:sys_clone ( 11, 0x1BB4AFEC, 0x1BA40DA0, 0x8113360,
0x52BFE4F4 )==27839== Syscall param clone(parent_tidptr) contains uninitialised
byte(s)
==27839==    at 0x1B9EE4C9: clone (in /lib/libc-2.3.2.so)
==27839==    by 0x80BEBC8: can_do_skas (process.c:243)
==27839==    by 0x80C2DB3: linux_main (um_arch.c:332)
==27839==    by 0x80512BF: main (main.c:148)
==27839== 
==27839== Syscall param clone(tlsinfo) contains uninitialised byte(s)
==27839==    at 0x1B9EE4C9: clone (in /lib/libc-2.3.2.so)
==27839==    by 0x80BEBC8: can_do_skas (process.c:243)
==27839==    by 0x80C2DB3: linux_main (um_arch.c:332)
==27839==    by 0x80512BF: main (main.c:148)
==27839== 
==27839== Syscall param clone(child_tidptr) contains uninitialised byte(s)
==27839==    at 0x1B9EE4C9: clone (in /lib/libc-2.3.2.so)
==27839==    by 0x80BEBC8: can_do_skas (process.c:243)
==27839==    by 0x80C2DB3: linux_main (um_arch.c:332)
==27839==    by 0x80512BF: main (main.c:148)
   clone(fork): process 27839 created child 27840
 --> 0 (0x0)
==27840== 
==27840== Jump to the invalid address stated on the next line
==27840==    at 0x7: ???
==27840==  Address 0x7 is not stack'd, malloc'd or (recently) free'd
==27840== 
==27840== Process terminating with default action of signal 11 (SIGSEGV)
==27840==  Access not within mapped region at address 0x7
==27840==    at 0x7: ???


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
