Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DQt2s-0004yZ-7h for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Apr 2005 13:22:06 -0700
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DQt2p-0002DT-N4 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Apr 2005 13:22:06 -0700
Message-ID: <426FF466.10501@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Again: UML on s390 (31Bit)
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
Date: Wed, 27 Apr 2005 22:21:58 +0200
To: linux-kernel@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Jeff Dike <jdike@addtoit.com>, user-mode-linux devel <user-mode-linux-devel@lists.sourceforge.net>

I'm sending this mail again, because unfortunately I didn't receive
any reply. It was sent the first time at April, 5th.

Regards, Bodo


Hi,

currently I'm porting UML to s390 31-bit.
A first 2.6.11 UML system already is running in UML-SKAS0 mode,
which normally should run on an unpatched host (no skas3-patch).

To make UML build and run on s390, I needed to do these two little
changes (the patches are copy and paste. I hope that doesn't hurt,
since they are very small):

1) UML includes some of the subarch's (s390) headers. I had to
    change one of them with the following one-liner, to make this
    compile. AFAICS, this change doesn't break compilation of s390
    itself.

==============================================================================
--- linux-2.6.11.orig/include/asm-s390/user.h	2004-12-09 18:45:02.000000000 +0100
+++ linux-2.6.11/include/asm-s390/user.h	2004-12-09 18:48:11.000000000 +0100
@@ -10,7 +10,7 @@
  #define _S390_USER_H

  #include <asm/page.h>
-#include <linux/ptrace.h>
+#include <asm/ptrace.h>
  /* Core file format: The core file is written in such a way that gdb
     can understand it and provide useful information to the user (under
     linux we use the 'trad-core' bfd).  There are quite a number of
==============================================================================

2) UML needs to intercept syscalls via ptrace to invalidate the syscall,
    read syscall's parameters and write the result with the result of
    UML's syscall processing. Also, UML needs to make sure, that the host
    does no syscall restart processing. On i386 for example, this can be
    done by writing -1 to orig_eax on the 2nd syscall interception
    (orig_eax is the syscall number, which after the interception is used
    as a "interrupt was a syscall" flag only.
    Unfortunately, s390 holds syscall number and syscall result in gpr2 and
    its "interrupt was a syscall" flag (trap) is unreachable via ptrace.
    So I changed the host to set trap to -1, if the syscall number is written
    to a negative value on the first syscall interception.
    I hope, this adds what UML needs without changing ptrace visibly to other
    ptrace users.
    (This isn't tested on a 2.6 host yet, because my host still is a 2.4.21 SuSE.
    But I've adapted this change to 2.4 and tested, it works.)


==============================================================================
--- linux-2.6.11.orig/arch/s390/kernel/ptrace.c	2005-04-04 18:57:38.000000000 +0200
+++ linux-2.6.11/arch/s390/kernel/ptrace.c	2005-04-04 19:01:51.000000000 +0200
@@ -726,6 +726,13 @@
				  ? 0x80 : 0));

  	/*
+	 * If debugger has set an invalid syscall number,
+	 * we prepare to skip syscall restart handling
+	 */
+	if (!entryexit && (long )regs->gprs[2] < 0 )
+		regs->trap = -1;
+
+	/*
  	 * this isn't the same as continuing with a signal, but it will do
  	 * for normal use.  strace only continues with a signal if the
  	 * stopping signal is not SIGTRAP.  -brl
==============================================================================


It would be very helpful for me, if these changes could go into s390 mainline.
If there is something wrong with them, please help me find a better solution.


Regards, Bodo


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
