Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bplhd-000447-GC for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Jul 2004 03:30:29 -0700
Received: from everest.2mbit.com
	([24.123.221.2] helo=mail.sosdg.org ident=mail)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1Bplhb-0003Jy-D3
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Jul 2004 03:30:29 -0700
Message-ID: <41078007.5000802@greatcn.org>
From: Coywolf Qi Hunt <coywolf@greatcn.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] [PATCH] [UM] remove a group of unused bh functions
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
Date: Wed, 28 Jul 2004 18:29:27 +0800
To: jdike@karaya.com, akpm@osdl.org
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

hi jdike, akpm,

This patch removes a group of unused bh functions in um.
This 2.2 legacy code should be cleaned up.

    -- coywolf

Signed-off-by: Coywolf Qi Hunt <coywolf@greatcn.org>

 smp.c |   35 -----------------------------------
 1 files changed, 35 deletions(-)

diff -Nrup linux-2.6.8-rc2/arch/um/kernel/smp.c linux-2.6.8-rc2-cy/arch/um/kernel/smp.c
--- linux-2.6.8-rc2/arch/um/kernel/smp.c	2004-06-29 23:03:33.000000000 -0500
+++ linux-2.6.8-rc2-cy/arch/um/kernel/smp.c	2004-07-28 05:26:32.554146767 -0500
@@ -59,41 +59,6 @@ void smp_send_reschedule(int cpu)
 	num_reschedules_sent++;
 }
 
-static void show(char * str)
-{
-	int cpu = smp_processor_id();
-
-	printk(KERN_INFO "\n%s, CPU %d:\n", str, cpu);
-}
-	
-#define MAXCOUNT 100000000
-
-static inline void wait_on_bh(void)
-{
-	int count = MAXCOUNT;
-	do {
-		if (!--count) {
-			show("wait_on_bh");
-			count = ~0;
-		}
-		/* nothing .. wait for the other bh's to go away */
-	} while (atomic_read(&global_bh_count) != 0);
-}
-
-/*
- * This is called when we want to synchronize with
- * bottom half handlers. We need to wait until
- * no other CPU is executing any bottom half handler.
- *
- * Don't wait if we're already running in an interrupt
- * context or are inside a bh handler. 
- */
-void synchronize_bh(void)
-{
-	if (atomic_read(&global_bh_count) && !in_interrupt())
-		wait_on_bh();
-}
-
 void smp_send_stop(void)
 {
 	int i;



-- 
Coywolf Qi Hunt
Homepage http://greatcn.org/~coywolf/
Admin of http://GreatCN.org and http://LoveCN.org



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
