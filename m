Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DUBi5-0008AT-Na	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 06 May 2005 15:54:17 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DUBi5-0005Nt-75	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 06 May 2005 15:54:17 -0700
Message-Id: <200505062249.j46MnZqk010485@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 10/12] UML - S390 preparation, arch_align_stack
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
Date: Fri, 06 May 2005 18:49:35 -0400
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

Only x86 and x86_64 use arch_align_stack(), all other subarches
have:
 #define arch_align_stack(x) (x)
So, if this definition is found, UML's own arch_align_stack()
should be skipped.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Index: linux-2.6.11-mm/arch/um/kernel/process_kern.c
===================================================================
--- linux-2.6.11-mm.orig/arch/um/kernel/process_kern.c	2005-04-30 13:13:04.000000000 -0400
+++ linux-2.6.11-mm/arch/um/kernel/process_kern.c	2005-04-30 13:20:41.000000000 -0400
@@ -462,12 +462,21 @@
 	return 2;
 }
 
+/*
+ * Only x86 and x86_64 have an arch_align_stack().
+ * All other arches have "#define arch_align_stack(x) (x)"
+ * in their asm/system.h
+ * As this is included in UML from asm-um/system-generic.h,
+ * we can use it to behave as the subarch does.
+ */
+#ifndef arch_align_stack
 unsigned long arch_align_stack(unsigned long sp)
 {
 	if (randomize_va_space)
 		sp -= get_random_int() % 8192;
 	return sp & ~0xf;
 }
+#endif
 
 
 /*



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
