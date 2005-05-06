Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DUC1m-0001KR-74	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 06 May 2005 16:14:38 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DUC1k-00088d-Lz	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 06 May 2005 16:14:38 -0700
Message-Id: <200505062249.j46MnXqg010480@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 9/12] UML - Use CONFIG variable for address space
	size
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
Date: Fri, 06 May 2005 18:49:33 -0400
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

tt/mem.c still uses hardcoded TOP for i386 instead of
CONFIG_TOP_ADDR provided by subarch's Kconfig_XXXX,
which would be right.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/kernel/tt/mem.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/tt/mem.c	2005-04-29 13:44:51.000000000 -0400
+++ linux-2.6.11/arch/um/kernel/tt/mem.c	2005-04-29 15:11:21.000000000 -0400
@@ -21,14 +21,8 @@
 	remap_data(UML_ROUND_DOWN(&__bss_start), UML_ROUND_UP(&_end), 1);
 }
 
-#ifdef CONFIG_HOST_2G_2G
-#define TOP 0x80000000
-#else
-#define TOP 0xc0000000
-#endif
-
 #define SIZE ((CONFIG_NEST_LEVEL + CONFIG_KERNEL_HALF_GIGS) * 0x20000000)
-#define START (TOP - SIZE)
+#define START (CONFIG_TOP_ADDR - SIZE)
 
 unsigned long set_task_sizes_tt(int arg, unsigned long *host_size_out, 
 				unsigned long *task_size_out)



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
