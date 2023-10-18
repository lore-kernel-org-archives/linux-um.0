Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FEB4CDB483
	for <linux-um@archiver.kernel.org>; Wed, 18 Oct 2023 12:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=rJbkCNTdchiGXpafYMOrcSDRda3QUw7DEUDJHe3nhmE=; b=L8S46SfwBROFqf
	HjKQJsf4vNjxUIoTU8YvRgIfy33+rEYweOy6801dgtvH9Ub5NieEksWBIGfANhqWIV5z4XwAfGD2A
	CSYqhD2C1uhrsp8lC1d3oLXqyXaIDE93J7lTfH6MZ68+cKK77kAiYrrGDrafF9dBPzek5SzjkDOsJ
	pxEpzKp4ppXe1jQRIEw046wxxkm5/lVBXwhPOZFh3y9IpT7pDAE2I9ZCyokQmd3XSxzU7bETyNiHZ
	NbTmFkWibdabhOt80tvT8H1bMHKz7L7tksw4O7xL86BwCKQir3y2Fuk7NKd3aP1EazfOUHnL9W1kC
	Utew08xpjWwu50VGJLBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qt5nI-00Eg32-01;
	Wed, 18 Oct 2023 12:37:00 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qt5nF-00Eg0s-0x
	for linux-um@lists.infradead.org;
	Wed, 18 Oct 2023 12:36:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=l+4XCYlxG+ZjWiDQZ6t8MIqcICs56Kc1BL6Dptilf1g=; t=1697632615; x=1698842215; 
	b=s44WFZNNrHVeDCU6rLdjpHb3PyOLHMJ+yocJfsFwgHX7VPFHdX1TM04P3pvjNK0F0JNZ/vvtrfY
	WECLXlMcCVjlMGza1RhmsCvPcEEnqNnUdaPjnirbqCz7CYiCanR0cOFsjrEPm6s5p7Y7yA4Ss8PhA
	FImAmjdBWY8gSVPMbYqGzeaSul/8CdoGWOnu4WgwwnnNmYpqHbi1jdBPAsAAbSAsv/rHsrqVhzJ30
	3Y8Dp59HVu/xgcneLVniH3AphG5Fu30uCAkLfPijimrNAYTGnFqrLtPJbPPbjq5qvMyZovsYP1Sbm
	uOpUmExUJ5DZMpg9SUck6m6nfgrABSErTO/g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC1)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1qt5nB-0000000Bo1V-0xMi;
	Wed, 18 Oct 2023 14:36:53 +0200
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 1/4] um: irqs: process outstanding IRQs when unblocking signals
Date: Wed, 18 Oct 2023 14:36:40 +0200
Message-ID: <20231018123643.1255813-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231018_053657_336783_D193B3EF 
X-CRM114-Status: GOOD (  21.57  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Benjamin Berg <benjamin.berg@intel.com>

When in time-travel mode, the eventfd events are read even when signals
are blocked as SIGIO still needs to be processed. In this case, the
event is cleared on the eventfd but the IRQ still needs to be fired
later.

We did already ensure that the SIGIO handler is run again. However, the
FDs are configured to be level triggered, so that eventfd will not
notify again. As such, add some logic to mark the IRQ as pending and
process it at the next opportunity.

To avoid duplication, reuse the logic used for the suspend/resume case.
This does not really change anything except for delaying running the
IRQs with timetravel_handler at a slightly later point in time (and
possibly running non-timetravel IRQs that shouldn't happen earlier).
While at it, move marking as pending into irq_event_handler as that is
the more logical place for it to happen.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/kernel/irq.c | 78 ++++++++++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 29 deletions(-)

diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index 635d44606bfe..ceda4bd2e5ed 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -37,7 +37,7 @@ struct irq_reg {
 	bool pending;
 	bool wakeup;
 #ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
-	bool pending_on_resume;
+	bool pending_event;
 	void (*timetravel_handler)(int, int, void *,
 				   struct time_travel_event *);
 	struct time_travel_event event;
@@ -56,6 +56,9 @@ static DEFINE_SPINLOCK(irq_lock);
 static LIST_HEAD(active_fds);
 static DECLARE_BITMAP(irqs_allocated, UM_LAST_SIGNAL_IRQ);
 static bool irqs_suspended;
+#ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
+static bool irqs_pending;
+#endif
 
 static void irq_io_loop(struct irq_reg *irq, struct uml_pt_regs *regs)
 {
@@ -84,9 +87,12 @@ static void irq_event_handler(struct time_travel_event *ev)
 {
 	struct irq_reg *reg = container_of(ev, struct irq_reg, event);
 
-	/* do nothing if suspended - just to cause a wakeup */
-	if (irqs_suspended)
+	/* do nothing if suspended; just cause a wakeup and mark as pending */
+	if (irqs_suspended) {
+		irqs_pending = true;
+		reg->pending_event = true;
 		return;
+	}
 
 	generic_handle_irq(reg->irq);
 }
@@ -110,16 +116,47 @@ static bool irq_do_timetravel_handler(struct irq_entry *entry,
 	if (!reg->event.pending)
 		return false;
 
-	if (irqs_suspended)
-		reg->pending_on_resume = true;
 	return true;
 }
+
+static void irq_do_pending_events(bool timetravel_handlers_only)
+{
+	struct irq_entry *entry;
+
+	if (!irqs_pending || timetravel_handlers_only)
+		return;
+
+	irqs_pending = false;
+
+	list_for_each_entry(entry, &active_fds, list) {
+		enum um_irq_type t;
+
+		for (t = 0; t < NUM_IRQ_TYPES; t++) {
+			struct irq_reg *reg = &entry->reg[t];
+
+			/*
+			 * Any timetravel_handler was invoked already, just
+			 * directly run the IRQ.
+			 */
+			if (reg->pending_event) {
+				irq_enter();
+				generic_handle_irq(reg->irq);
+				irq_exit();
+				reg->pending_event = false;
+			}
+		}
+	}
+}
 #else
 static bool irq_do_timetravel_handler(struct irq_entry *entry,
 				      enum um_irq_type t)
 {
 	return false;
 }
+
+static void irq_do_pending_events(bool timetravel_handlers_only)
+{
+}
 #endif
 
 static void sigio_reg_handler(int idx, struct irq_entry *entry, enum um_irq_type t,
@@ -145,6 +182,8 @@ static void sigio_reg_handler(int idx, struct irq_entry *entry, enum um_irq_type
 	 */
 	if (timetravel_handlers_only) {
 #ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
+		reg->pending_event = true;
+		irqs_pending = true;
 		mark_sigio_pending();
 #endif
 		return;
@@ -162,6 +201,10 @@ static void _sigio_handler(struct uml_pt_regs *regs,
 	if (timetravel_handlers_only && !um_irq_timetravel_handler_used())
 		return;
 
+	/* Flush out pending events that were ignored due to time-travel. */
+	if (!irqs_suspended)
+		irq_do_pending_events(timetravel_handlers_only);
+
 	while (1) {
 		/* This is now lockless - epoll keeps back-referencesto the irqs
 		 * which have trigger it so there is no need to walk the irq
@@ -543,30 +586,7 @@ void um_irqs_resume(void)
 	unsigned long flags;
 
 
-	local_irq_save(flags);
-#ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
-	/*
-	 * We don't need to lock anything here since we're in resume
-	 * and nothing else is running, but have disabled IRQs so we
-	 * don't try anything else with the interrupt list from there.
-	 */
-	list_for_each_entry(entry, &active_fds, list) {
-		enum um_irq_type t;
-
-		for (t = 0; t < NUM_IRQ_TYPES; t++) {
-			struct irq_reg *reg = &entry->reg[t];
-
-			if (reg->pending_on_resume) {
-				irq_enter();
-				generic_handle_irq(reg->irq);
-				irq_exit();
-				reg->pending_on_resume = false;
-			}
-		}
-	}
-#endif
-
-	spin_lock(&irq_lock);
+	spin_lock_irqsave(&irq_lock, flags);
 	list_for_each_entry(entry, &active_fds, list) {
 		if (entry->suspended) {
 			int err = os_set_fd_async(entry->fd);
-- 
2.41.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
