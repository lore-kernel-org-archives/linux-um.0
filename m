Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CNRgS-0007yA-MN for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Oct 2004 01:00:28 -0700
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CNRgR-0007Tf-Jz
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Oct 2004 01:00:28 -0700
From: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [uml-devel] Re: [patch 1/1] SYSEMU: avoid intercepting syscall on
	return when using SYSCALL again.
Message-ID: <20041029075124.GA14311@bytesex>
References: <20041021231834.9D3833F37@zion.localdomain>
	<200410290104.22725.blaisorblade_spam@yahoo.it>
	<41818295.5000209@fujitsu-siemens.com>
	<200410290200.46907.blaisorblade_spam@yahoo.it>
	<41819A8A.20403@fujitsu-siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41819A8A.20403@fujitsu-siemens.com>
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
Date: Fri, 29 Oct 2004 09:51:25 +0200
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: Blaisorblade <blaisorblade_spam@yahoo.it>, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net

> Here's the patch:

Hmm, your mailer seems to mangle whitespaces, I often can apply your
patches mailed inline with "patch -l" only (the mime attached ones are
fine).

Two small fixes I need in the big stack of patches i have now to
build kernels successfully.  The first is a simple missing include:

==============================[ cut here ]==============================
--- linux-uml-2.6.9.orig/arch/um/os-Linux/signal.c	2004-10-28 20:11:02.757586671 +0200
+++ linux-uml-2.6.9/arch/um/os-Linux/signal.c	2004-10-28 20:23:32.730183963 +0200
@@ -6,6 +6,7 @@
 #include <signal.h>
 #include "time_user.h"
 #include "mode.h"
+#include "choose-mode.h"
 #include "sysdep/signal.h"
 
 void sig_handler(int sig)
==============================[ cut here ]==============================

The second one is a fixup for the host-skas3 patch.  That one is needed
if you use one source tree for both host and uml builds.  Without that
fixup the host-skas3 patch breaks uml kernel builds (and also all other
architectures as only i386 has sysemu right now ...).

==============================[ cut here ]==============================
--- uml-2.6.9-rc2.orig/arch/um/include/skas_ptrace.h	2004-09-16 16:10:16.000000000 +0200
+++ uml-2.6.9-rc2/arch/um/include/skas_ptrace.h	2004-09-16 16:10:24.000000000 +0200
@@ -6,6 +6,7 @@
 #ifndef __SKAS_PTRACE_H
 #define __SKAS_PTRACE_H
 
+#ifndef PTRACE_FAULTINFO
 struct ptrace_faultinfo {
 	int is_write;
 	unsigned long addr;
@@ -21,6 +22,7 @@ struct ptrace_ldt {
 #define PTRACE_SIGPENDING 53
 #define PTRACE_LDT 54
 #define PTRACE_SWITCH_MM 55
+#endif
 
 #endif
 
--- uml-2.6.9-rc2.orig/kernel/fork.c	2004-09-16 16:10:21.000000000 +0200
+++ uml-2.6.9-rc2/kernel/fork.c	2004-09-16 16:12:40.000000000 +0200
@@ -1038,7 +1038,9 @@ static task_t *copy_process(unsigned lon
 	 * of CLONE_PTRACE.
 	 */
 	clear_tsk_thread_flag(p, TIF_SYSCALL_TRACE);
+#ifdef TIF_SYSCALL_EMU
 	clear_tsk_thread_flag(p, TIF_SYSCALL_EMU);
+#endif
 
 	/* Our parent execution domain becomes current domain
 	   These must match for thread signalling to apply */
==============================[ cut here ]==============================

It's kida quick&dirty, the real fix probably would be to have the skas
ptrace stuff in *one* place, guess that isn't going to happen before
skas is merged mainline through.  Whats the status on skas4 btw.?

  Gerd



-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
