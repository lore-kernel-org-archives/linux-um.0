Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DkRRl-0000kD-BZ	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Jun 2005 11:56:37 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DkRRi-0000Ic-Lf	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Jun 2005 11:56:37 -0700
Message-Id: <200506201851.j5KIpKPr008499@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 6/8] UML - Kill some useless vmalloc tlb flushing
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
Date: Mon, 20 Jun 2005 14:51:20 -0400
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

There is absolutely no reason to flush the kernel's VM area during a
tlb_flush_mm.

This results in a noticable performance increase in the kernel build 
benchmark.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12/arch/um/kernel/skas/tlb.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/skas/tlb.c	2005-06-20 11:54:56.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/skas/tlb.c	2005-06-20 12:11:00.000000000 -0400
@@ -76,7 +76,6 @@ void flush_tlb_mm_skas(struct mm_struct 
                 return;
 
         fix_range(mm, 0, host_task_size, 0);
-        flush_tlb_kernel_range_common(start_vm, end_vm);
 }
 
 void force_flush_all_skas(void)



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
