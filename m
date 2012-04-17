Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1SKF9f-0007Xs-V7
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Apr 2012 20:37:39 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SKF9b-0005Ql-Sb
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Apr 2012 20:37:39 +0000
From: Richard Weinberger <richard@nod.at>
Date: Tue, 17 Apr 2012 22:37:14 +0200
Message-Id: <1334695036-19977-2-git-send-email-richard@nod.at>
In-Reply-To: <1334695036-19977-1-git-send-email-richard@nod.at>
References: <1334695036-19977-1-git-send-email-richard@nod.at>
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
Subject: [uml-devel] [PATCH 2/4] um: Remove usage of irq_chip->release()
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Richard Weinberger <richard@nod.at>, tglx@linutronix.de, linux-kernel@vger.kernel.org

UML does no longer need irq_chip->release().

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/kernel/irq.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index 47a09ee..00506c3 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -334,7 +334,6 @@ static void dummy(struct irq_data *d)
 /* This is used for everything else than the timer. */
 static struct irq_chip normal_irq_type = {
 	.name = "SIGIO",
-	.release = free_irq_by_irq_and_dev,
 	.irq_disable = dummy,
 	.irq_enable = dummy,
 	.irq_ack = dummy,
@@ -342,7 +341,6 @@ static struct irq_chip normal_irq_type = {
 
 static struct irq_chip SIGVTALRM_irq_type = {
 	.name = "SIGVTALRM",
-	.release = free_irq_by_irq_and_dev,
 	.irq_disable = dummy,
 	.irq_enable = dummy,
 	.irq_ack = dummy,
-- 
1.7.7.3


------------------------------------------------------------------------------
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second 
resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

