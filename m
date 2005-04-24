Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DPmLV-0006kE-0o for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 24 Apr 2005 12:00:45 -0700
Received: from mail-relay-2.tiscali.it ([213.205.33.42])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DPmLT-0001Yl-AF for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 24 Apr 2005 12:00:44 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050424181922.631D255D03@zion>
Subject: [uml-devel] [patch 6/7] uml: commentary about forking flag
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
Date: Sun, 24 Apr 2005 20:19:22 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, bstroesser@fujitsu-siemens.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


Add some commentary about UML internals, for a strange trick.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.12-paolo/include/asm-um/processor-generic.h |    4 ++++
 1 files changed, 4 insertions(+)

diff -puN include/asm-um/processor-generic.h~uml-commentary-about-forking-flag include/asm-um/processor-generic.h
--- linux-2.6.12/include/asm-um/processor-generic.h~uml-commentary-about-forking-flag	2005-04-24 20:17:06.000000000 +0200
+++ linux-2.6.12-paolo/include/asm-um/processor-generic.h	2005-04-24 20:17:06.000000000 +0200
@@ -17,6 +17,10 @@ struct task_struct;
 struct mm_struct;
 
 struct thread_struct {
+	/* This flag is set to 1 before calling do_fork (and analyzed in
+	 * copy_thread) to mark that we are begin called from userspace (fork /
+	 * vfork / clone), and reset to 0 after. It is left to 0 when called
+	 * from kernelspace (i.e. kernel_thread() or fork_idle(), as of 2.6.11). */
 	int forking;
 	int nsyscalls;
 	struct pt_regs regs;
_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
