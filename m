Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Izx97-0001MV-RT for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Dec 2007 08:30:51 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Izx94-0001Sq-Ho
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Dec 2007 08:30:49 -0800
Date: Wed, 5 Dec 2007 11:30:24 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071205163024.GA7241@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH] UML - change sigcontext fields to match x86
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, "H. Peter Anvin" <hpa@zytor.com>

git-x86, in commit 70aa1bd3839e3ec74ce65316528a82570e8de666, changed
a lot of the sigcontext field names.  This patch changes UML usage to
match.

I also changed includes of generic headers from "" to <>.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/sys-i386/signal.c   |   50 +++++++++++++++----------------
 arch/um/sys-x86_64/signal.c |   70 ++++++++++++++++++++++----------------------
 2 files changed, 60 insertions(+), 60 deletions(-)

Index: linux-2.6.22/arch/um/sys-i386/signal.c
===================================================================
--- linux-2.6.22.orig/arch/um/sys-i386/signal.c	2007-12-05 10:30:15.000000000 -0500
+++ linux-2.6.22/arch/um/sys-i386/signal.c	2007-12-05 10:55:17.000000000 -0500
@@ -3,10 +3,10 @@
  * Licensed under the GPL
  */
 
-#include "linux/ptrace.h"
-#include "asm/unistd.h"
-#include "asm/uaccess.h"
-#include "asm/ucontext.h"
+#include <linux/ptrace.h>
+#include <asm/unistd.h>
+#include <asm/uaccess.h>
+#include <asm/ucontext.h>
 #include "frame_kern.h"
 #include "skas.h"
 
@@ -18,17 +18,17 @@ void copy_sc(struct uml_pt_regs *regs, v
 	REGS_FS(regs->gp) = sc->fs;
 	REGS_ES(regs->gp) = sc->es;
 	REGS_DS(regs->gp) = sc->ds;
-	REGS_EDI(regs->gp) = sc->edi;
-	REGS_ESI(regs->gp) = sc->esi;
-	REGS_EBP(regs->gp) = sc->ebp;
-	REGS_SP(regs->gp) = sc->esp;
-	REGS_EBX(regs->gp) = sc->ebx;
-	REGS_EDX(regs->gp) = sc->edx;
-	REGS_ECX(regs->gp) = sc->ecx;
-	REGS_EAX(regs->gp) = sc->eax;
-	REGS_IP(regs->gp) = sc->eip;
+	REGS_EDI(regs->gp) = sc->di;
+	REGS_ESI(regs->gp) = sc->si;
+	REGS_EBP(regs->gp) = sc->bp;
+	REGS_SP(regs->gp) = sc->sp;
+	REGS_EBX(regs->gp) = sc->bx;
+	REGS_EDX(regs->gp) = sc->dx;
+	REGS_ECX(regs->gp) = sc->cx;
+	REGS_EAX(regs->gp) = sc->ax;
+	REGS_IP(regs->gp) = sc->ip;
 	REGS_CS(regs->gp) = sc->cs;
-	REGS_EFLAGS(regs->gp) = sc->eflags;
+	REGS_EFLAGS(regs->gp) = sc->flags;
 	REGS_SS(regs->gp) = sc->ss;
 }
 
@@ -228,18 +228,18 @@ static int copy_sc_to_user(struct sigcon
 	sc.fs = REGS_FS(regs->regs.gp);
 	sc.es = REGS_ES(regs->regs.gp);
 	sc.ds = REGS_DS(regs->regs.gp);
-	sc.edi = REGS_EDI(regs->regs.gp);
-	sc.esi = REGS_ESI(regs->regs.gp);
-	sc.ebp = REGS_EBP(regs->regs.gp);
-	sc.esp = sp;
-	sc.ebx = REGS_EBX(regs->regs.gp);
-	sc.edx = REGS_EDX(regs->regs.gp);
-	sc.ecx = REGS_ECX(regs->regs.gp);
-	sc.eax = REGS_EAX(regs->regs.gp);
-	sc.eip = REGS_IP(regs->regs.gp);
+	sc.di = REGS_EDI(regs->regs.gp);
+	sc.si = REGS_ESI(regs->regs.gp);
+	sc.bp = REGS_EBP(regs->regs.gp);
+	sc.sp = sp;
+	sc.bx = REGS_EBX(regs->regs.gp);
+	sc.dx = REGS_EDX(regs->regs.gp);
+	sc.cx = REGS_ECX(regs->regs.gp);
+	sc.ax = REGS_EAX(regs->regs.gp);
+	sc.ip = REGS_IP(regs->regs.gp);
 	sc.cs = REGS_CS(regs->regs.gp);
-	sc.eflags = REGS_EFLAGS(regs->regs.gp);
-	sc.esp_at_signal = regs->regs.gp[UESP];
+	sc.flags = REGS_EFLAGS(regs->regs.gp);
+	sc.sp_at_signal = regs->regs.gp[UESP];
 	sc.ss = regs->regs.gp[SS];
 	sc.cr2 = fi->cr2;
 	sc.err = fi->error_code;
Index: linux-2.6.22/arch/um/sys-x86_64/signal.c
===================================================================
--- linux-2.6.22.orig/arch/um/sys-x86_64/signal.c	2007-12-05 10:30:15.000000000 -0500
+++ linux-2.6.22/arch/um/sys-x86_64/signal.c	2007-12-05 11:23:48.000000000 -0500
@@ -4,11 +4,11 @@
  * Licensed under the GPL
  */
 
-#include "linux/personality.h"
-#include "linux/ptrace.h"
-#include "asm/unistd.h"
-#include "asm/uaccess.h"
-#include "asm/ucontext.h"
+#include <linux/personality.h>
+#include <linux/ptrace.h>
+#include <asm/unistd.h>
+#include <asm/uaccess.h>
+#include <asm/ucontext.h>
 #include "frame_kern.h"
 #include "skas.h"
 
@@ -27,16 +27,16 @@ void copy_sc(struct uml_pt_regs *regs, v
 	GETREG(regs, R13, sc, r13);
 	GETREG(regs, R14, sc, r14);
 	GETREG(regs, R15, sc, r15);
-	GETREG(regs, RDI, sc, rdi);
-	GETREG(regs, RSI, sc, rsi);
-	GETREG(regs, RBP, sc, rbp);
-	GETREG(regs, RBX, sc, rbx);
-	GETREG(regs, RDX, sc, rdx);
-	GETREG(regs, RAX, sc, rax);
-	GETREG(regs, RCX, sc, rcx);
-	GETREG(regs, RSP, sc, rsp);
-	GETREG(regs, RIP, sc, rip);
-	GETREG(regs, EFLAGS, sc, eflags);
+	GETREG(regs, RDI, sc, di);
+	GETREG(regs, RSI, sc, si);
+	GETREG(regs, RBP, sc, bp);
+	GETREG(regs, RBX, sc, bx);
+	GETREG(regs, RDX, sc, dx);
+	GETREG(regs, RAX, sc, ax);
+	GETREG(regs, RCX, sc, cx);
+	GETREG(regs, RSP, sc, sp);
+	GETREG(regs, RIP, sc, ip);
+	GETREG(regs, EFLAGS, sc, flags);
 	GETREG(regs, CS, sc, cs);
 
 #undef GETREG
@@ -61,16 +61,16 @@ static int copy_sc_from_user(struct pt_r
 	err |= GETREG(regs, R13, from, r13);
 	err |= GETREG(regs, R14, from, r14);
 	err |= GETREG(regs, R15, from, r15);
-	err |= GETREG(regs, RDI, from, rdi);
-	err |= GETREG(regs, RSI, from, rsi);
-	err |= GETREG(regs, RBP, from, rbp);
-	err |= GETREG(regs, RBX, from, rbx);
-	err |= GETREG(regs, RDX, from, rdx);
-	err |= GETREG(regs, RAX, from, rax);
-	err |= GETREG(regs, RCX, from, rcx);
-	err |= GETREG(regs, RSP, from, rsp);
-	err |= GETREG(regs, RIP, from, rip);
-	err |= GETREG(regs, EFLAGS, from, eflags);
+	err |= GETREG(regs, RDI, from, di);
+	err |= GETREG(regs, RSI, from, si);
+	err |= GETREG(regs, RBP, from, bp);
+	err |= GETREG(regs, RBX, from, bx);
+	err |= GETREG(regs, RDX, from, dx);
+	err |= GETREG(regs, RAX, from, ax);
+	err |= GETREG(regs, RCX, from, cx);
+	err |= GETREG(regs, RSP, from, sp);
+	err |= GETREG(regs, RIP, from, ip);
+	err |= GETREG(regs, EFLAGS, from, flags);
 	err |= GETREG(regs, CS, from, cs);
 	if (err)
 		return 1;
@@ -108,19 +108,19 @@ static int copy_sc_to_user(struct sigcon
 	__put_user((regs)->regs.gp[(regno) / sizeof(unsigned long)],	\
 		   &(sc)->regname)
 
-	err |= PUTREG(regs, RDI, to, rdi);
-	err |= PUTREG(regs, RSI, to, rsi);
-	err |= PUTREG(regs, RBP, to, rbp);
+	err |= PUTREG(regs, RDI, to, di);
+	err |= PUTREG(regs, RSI, to, si);
+	err |= PUTREG(regs, RBP, to, bp);
 	/*
 	 * Must use orignal RSP, which is passed in, rather than what's in
 	 * the pt_regs, because that's already been updated to point at the
 	 * signal frame.
 	 */
-	err |= __put_user(sp, &to->rsp);
-	err |= PUTREG(regs, RBX, to, rbx);
-	err |= PUTREG(regs, RDX, to, rdx);
-	err |= PUTREG(regs, RCX, to, rcx);
-	err |= PUTREG(regs, RAX, to, rax);
+	err |= __put_user(sp, &to->sp);
+	err |= PUTREG(regs, RBX, to, bx);
+	err |= PUTREG(regs, RDX, to, dx);
+	err |= PUTREG(regs, RCX, to, cx);
+	err |= PUTREG(regs, RAX, to, ax);
 	err |= PUTREG(regs, R8, to, r8);
 	err |= PUTREG(regs, R9, to, r9);
 	err |= PUTREG(regs, R10, to, r10);
@@ -135,8 +135,8 @@ static int copy_sc_to_user(struct sigcon
 	err |= __put_user(fi->error_code, &to->err);
 	err |= __put_user(fi->trap_no, &to->trapno);
 
-	err |= PUTREG(regs, RIP, to, rip);
-	err |= PUTREG(regs, EFLAGS, to, eflags);
+	err |= PUTREG(regs, RIP, to, ip);
+	err |= PUTREG(regs, EFLAGS, to, flags);
 #undef PUTREG
 
 	err |= __put_user(mask, &to->oldmask);

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
