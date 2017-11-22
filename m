Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1eHVPn-0002g8-1K
 for user-mode-linux-devel@lists.sourceforge.net;
 Wed, 22 Nov 2017 13:50:11 +0000
Received: from ivanoab5.miniserver.com ([78.31.111.25]
 helo=www.kot-begemot.co.uk)
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.89)
 id 1eHVPm-0000xt-60 for user-mode-linux-devel@lists.sourceforge.net;
 Wed, 22 Nov 2017 13:50:10 +0000
From: anton.ivanov@kot-begemot.co.uk
Date: Wed, 22 Nov 2017 13:49:55 +0000
Message-Id: <20171122134955.27539-2-anton.ivanov@kot-begemot.co.uk>
In-Reply-To: <20171122134955.27539-1-anton.ivanov@kot-begemot.co.uk>
References: <20171122134955.27539-1-anton.ivanov@kot-begemot.co.uk>
Subject: [uml-devel] [Errata for PATCH v11] UML EPOLL IRQ Controller errata
List-Id: The user-mode Linux development list
 <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: richard.weinberger@gmail.com, Anton Ivanov <anton.ivanov@cambridgegreys.com>

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

Add missing EXPORT for free_irq_by_fd()

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/kernel/irq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index 980148d56537..6b7f3827d6e4 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -328,6 +328,7 @@ void free_irq_by_fd(int fd)
 	garbage_collect_irq_entries();
 	spin_unlock_irqrestore(&irq_lock, flags);
 }
+EXPORT_SYMBOL(free_irq_by_fd);
 
 static void free_irq_by_irq_and_dev(unsigned int irq, void *dev)
 {
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

