Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1VGb49-0003Xt-Hk
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Sep 2013 20:49:41 +0000
Received: from mail.sigma-star.at ([95.130.255.111])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VGb47-0006t6-KA for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Sep 2013 20:49:41 +0000
From: Richard Weinberger <richard@nod.at>
Date: Mon,  2 Sep 2013 22:49:22 +0200
Message-Id: <1378154962-29057-1-git-send-email-richard@nod.at>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
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
Subject: [uml-devel] [PATCH] um: Add irq chip um/mask handlers
To: richard@nod.at
Cc: user-mode-linux-devel@lists.sourceforge.net

These handlers are not optional and need in our case
dummy implementions to avoid NULL pointer bugs within
the irq core code.

Reported-and-tested-by: Toralf Foester <toralf.foerster@gmx.de>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/kernel/irq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index 36e12f0..1d8505b 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -337,6 +337,8 @@ static struct irq_chip normal_irq_type = {
 	.irq_disable = dummy,
 	.irq_enable = dummy,
 	.irq_ack = dummy,
+	.irq_mask = dummy,
+	.irq_unmask = dummy,
 };
 
 static struct irq_chip SIGVTALRM_irq_type = {
@@ -344,6 +346,8 @@ static struct irq_chip SIGVTALRM_irq_type = {
 	.irq_disable = dummy,
 	.irq_enable = dummy,
 	.irq_ack = dummy,
+	.irq_mask = dummy,
+	.irq_unmask = dummy,
 };
 
 void __init init_IRQ(void)
-- 
1.8.3.1


------------------------------------------------------------------------------
Learn the latest--Visual Studio 2012, SharePoint 2013, SQL 2012, more!
Discover the easy way to master current and previous Microsoft technologies
and advance your career. Get an incredible 1,500+ hours of step-by-step
tutorial videos with LearnDevNow. Subscribe today and save!
http://pubads.g.doubleclick.net/gampad/clk?id=58040911&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

