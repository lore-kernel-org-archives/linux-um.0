Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPJwZ-0006Uv-Te for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 04:08:51 -0800
Received: from pimout3-ext.prodigy.net ([207.115.63.102])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CPJwZ-0003NK-Dj for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 04:08:51 -0800
From: Chris Wedgwood <cw@f00f.org>
Message-ID: <20041103120829.GA23182@taniwha.stupidest.org>
References: <20041103113736.GA23041@taniwha.stupidest.org>
	<1099482457.16445.1.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099482457.16445.1.camel@imp.csi.cam.ac.uk>
Subject: [uml-devel] [PATCH] UML: Use PTRACE_KILL instead of SIGKILL to kill
	host-OS processes (take #2)
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
Date: Wed, 3 Nov 2004 04:08:29 -0800
To: Jeff Dike <jdike@addtoit.com>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, Blaisorblade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>

On Wed, Nov 03, 2004 at 11:47:38AM +0000, Anton Altaparmakov wrote:

> You have two %d but only one argument.  You seem to have forgotten
> an "old_pid, " in there.

doh!  it's a warning if something iffy happens (which so far for me it
hasn't) which explains why i missed it...  not sure why i didn't get a
build warning though...  thanks!

---
kill(..., SIGKILL) doesn't work to kill host-OS processes created in
the exec path in TT mode --- for this we need PTRACE_KILL (it did work
in previous kernels, but not by design).  Without this process will
accumulate on the host-OS (although the won't be visible inside UML).

Signed-off-by: Chris Wedgwood <cw@f00f.org>
---

Index: cw-current/arch/um/kernel/tt/exec_user.c
===================================================================
--- cw-current.orig/arch/um/kernel/tt/exec_user.c	2004-11-03 02:10:18.064830204 -0800
+++ cw-current/arch/um/kernel/tt/exec_user.c	2004-11-03 04:05:00.435843464 -0800
@@ -35,7 +35,8 @@
 		tracer_panic("do_exec failed to get registers - errno = %d",
 			     errno);
 
-	kill(old_pid, SIGKILL);
+	if (ptrace(PTRACE_KILL, old_pid, NULL, NULL))
+		printk("Warning: ptrace(PTRACE_KILL, %d, ...) saw %d\n", old_pid, errno);
 
 	if(ptrace_setregs(new_pid, regs) < 0)
 		tracer_panic("do_exec failed to start new proc - errno = %d",


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
