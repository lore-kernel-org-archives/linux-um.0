Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DzIDR-0001et-24	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 31 Jul 2005 11:07:13 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1DzICt-00061e-V1
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 31 Jul 2005 11:07:13 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050731181134.4D98721D458@zion.home.lan>
Subject: [uml-devel] [patch 1/1] UML Support - SYSEMU: slight cleanup and
	speedup
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
Date: Sun, 31 Jul 2005 20:11:31 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it, cwright@cs.sunysb.edu


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
CC: Charles P. Wright <cwright@cs.sunysb.edu>

As a follow-up to "UML Support - Ptrace: adds the host SYSEMU support, for UML
and general usage" (i.e. uml-support-* in current mm).

Avoid unconditionally jumping to work_pending and code copying, just reuse the
already existing resume_userspace path.

About those patches, they should stay in -mm only for now - I expect to get
them reviewed.

One interesting note, from Charles P. Wright, suggested that the API is
improvable with no downsides for UML (except that it will have to support yet
another host API, since dropping support for the current API, for UML, is not
reasonable from users' point of view).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/i386/kernel/entry.S |    8 +-------
 1 files changed, 1 insertion(+), 7 deletions(-)

diff -puN arch/i386/kernel/entry.S~sysemu-cleanup-speedup arch/i386/kernel/entry.S
--- linux-2.6.git/arch/i386/kernel/entry.S~sysemu-cleanup-speedup	2005-07-31 20:03:19.000000000 +0200
+++ linux-2.6.git-paolo/arch/i386/kernel/entry.S	2005-07-31 20:03:19.000000000 +0200
@@ -339,18 +339,12 @@ syscall_trace_entry:
 	xorl %edx,%edx
 	call do_syscall_trace
 	cmpl $0, %eax
-	jne syscall_skip		# ret != 0 -> running under PTRACE_SYSEMU,
+	jne resume_userspace		# ret != 0 -> running under PTRACE_SYSEMU,
 					# so must skip actual syscall
 	movl ORIG_EAX(%esp), %eax
 	cmpl $(nr_syscalls), %eax
 	jnae syscall_call
 	jmp syscall_exit
-syscall_skip:
-	cli				# make sure we don't miss an interrupt
-					# setting need_resched or sigpending
-					# between sampling and the iret
-	movl TI_flags(%ebp), %ecx
-	jmp work_pending
 
 	# perform syscall exit tracing
 	ALIGN
_


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
