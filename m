Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BL7Gf-0000HS-GU for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 May 2004 14:15:57 -0700
Received: from ns1.auto.ucl.ac.be ([130.104.239.135] helo=zlop.auto.ucl.ac.be)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BL7GA-0003b4-Vo for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 May 2004 14:15:27 -0700
Received: from auto.ucl.ac.be (unknown [213.213.240.140])
	by zlop.auto.ucl.ac.be (Postfix) with ESMTP id D0029A495B
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue,  4 May 2004 23:15:11 +0200 (CEST)
Message-ID: <40981F7F.4070007@auto.ucl.ac.be>
From: Vincent Guffens <guffens@auto.ucl.ac.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] missing symbols in ksyms
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
Date: Wed, 05 May 2004 00:55:59 +0200
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

I think these 2 symbols are missing in ksyms.c : enable_irq, disable_irq

Following diff fixes the problem for 2.4.24-um1 :



--- linux-2.4.24-um1-orig/arch/um/kernel/ksyms.c        Tue May  4 
22:10:01 2004
+++ linux-2.4.24-um1/arch/um/kernel/ksyms.c     Tue May  4 17:13:34 2004
@@ -8,6 +8,7 @@
  #include "linux/string.h"
  #include "linux/smp_lock.h"
  #include "linux/spinlock.h"
+#include "asm/irq.h"
  #include "asm/current.h"
  #include "asm/delay.h"
  #include "asm/processor.h"
@@ -44,6 +45,9 @@
  EXPORT_SYMBOL(mode_tt);
  EXPORT_SYMBOL(handle_page_fault);

+EXPORT_SYMBOL(enable_irq);
+EXPORT_SYMBOL(disable_irq);
+
  #ifdef CONFIG_MODE_TT
  EXPORT_SYMBOL(copy_from_user_tt);
  EXPORT_SYMBOL(copy_to_user_tt);



--- linux-2.4.24-um1-orig/include/asm-um/irq.h  Tue May  4 22:10:01 2004
+++ linux-2.4.24-um1/include/asm-um/irq.h       Tue May  4 17:19:20 2004
@@ -19,4 +19,7 @@
  #define LAST_IRQ XTERM_IRQ
  #define NR_IRQS (LAST_IRQ + 1)

+extern void enable_irq (unsigned int);
+extern void disable_irq (unsigned int);
+
  #endif


-- 
				Vincent Guffens
				PhD Student UCL/CESAME
				tel:   +32 10 47 80 30
Value your freedom, or you will lose it, teaches history.
"Don't bother us with politics," respond those who don't want to learn.
	      	-- Richard M. Stallman



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
