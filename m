Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CpCzA-0001b7-R0 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 13:58:32 -0800
Received: from www.ssc.unict.it ([151.97.230.9] helo=ssc.unict.it)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CpCz9-0001Oi-OO for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 13:58:32 -0800
From: blaisorblade_spam@yahoo.it
Message-Id: <20050113210111.86DE01FEFB@zion>
Subject: [uml-devel] [patch 10/11] uml: add stack addresses to dumps
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
Date: Thu, 13 Jan 2005 22:01:11 +0100
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it, bstroesser@fujitsu-siemens.com


From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

Add stack addresses to print of symbols from stack trace.
For stack analysis it's important to have this information.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

For UML, we should also copy the CONFIG_FRAME_POINTER stack walking from i386,
and move the result to sys-i386.

Another note: this should be done for i386 also, if ksymoops does not have
problems.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/kernel/sysrq.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff -puN arch/um/kernel/sysrq.c~uml-add-stack-addresses-to-dumps arch/um/kernel/sysrq.c
--- linux-2.6.11/arch/um/kernel/sysrq.c~uml-add-stack-addresses-to-dumps	2005-01-13 21:54:57.450269544 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/sysrq.c	2005-01-13 21:56:09.250354272 +0100
@@ -25,12 +25,13 @@ void show_trace(unsigned long * stack)
 
         printk("Call Trace: \n");
         while (((long) stack & (THREAD_SIZE-1)) != 0) {
-                addr = *stack++;
+                addr = *stack;
 		if (__kernel_text_address(addr)) {
-			printk(" [<%08lx>]", addr);
+			printk("%08lx:  [<%08lx>]", (unsigned long) stack, addr);
 			print_symbol(" %s", addr);
 			printk("\n");
                 }
+                stack++;
         }
         printk("\n");
 }
_


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
