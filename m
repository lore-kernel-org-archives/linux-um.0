Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C6BCC4167B
	for <linux-um@archiver.kernel.org>; Fri,  3 Nov 2023 16:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:CC:To:In-Reply-To:References:Message-ID
	:MIME-Version:Subject:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5gQA32BHWdgiO8Nfe1WUrOoz+NWHzuTRNv0lBPRomaw=; b=gC0SNJkYBjN+zB
	jmqZI9yq4LDYI60hzYi270BO4JolsOrd6nHsmGm7adYjbzvk2sId5Md0YeU0x/OTfERuw0DJH9rvw
	L76lGiiygdNIMqAq2fntY4MCoOTShUsMEw+JXQsIcMA+huG/koT80p55/KSkn/67PWjRr5jcKXM9b
	KBx6+h0Nv9cz4xlR7WvoRqP8fyvffOwYjIHJc/Ov7eCrT/akmT2tUtB2jhZ+O6r57oFKVauHtI5JK
	K41wFn7/9gVqRRxL2+jX7hwWV9nCqGLZdHS0W/McYRN+PErE7yW8jXZf2+dkxxjDUCF6xMuD3YHWj
	S+wir2qv3GE+y2ExXJUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qyxFX-00Bnpq-2X;
	Fri, 03 Nov 2023 16:42:23 +0000
Received: from mx1.uni-rostock.de ([139.30.22.71])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qyxFT-00BnjX-0Y
	for linux-um@lists.infradead.org;
	Fri, 03 Nov 2023 16:42:21 +0000
Received: from 139.30.22.84 by mx1.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Fri, 03 Nov 2023 16:42:06 GMT
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmze; 
 t=1699029726; bh=x7wS4WGG6GPiuEEX7c7cCKioCWmfLx/hgOb+xsN5EIM=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=ed25519-sha256; b=
 UDAlGqjLf4dVdADqK9Btosqlpbkg7BI8aJch1A09TgjvqZF6HjO/BBa5mSG0zqMd3Nbyzqbxr6QXA5mu10+VCA==
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmz; 
 t=1699029726; bh=x7wS4WGG6GPiuEEX7c7cCKioCWmfLx/hgOb+xsN5EIM=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=rsa-sha256; b=
 DEjhIXJSm8VAVJ0fM+MfoGcAbLur3Pq8/y8EN2U4FEYY9hrOQgUJhvM+ohZEskICE+UyAkDl1x2eB9bWiZ+uQ9zDEe0uOsDpbh7328cNIt0XBz38/k+mQUQ+uATAxEcNBYb9B2jwn0Z4x7vBvwd0nShF0bRYKWYOKcPmEu1iS7o=
Received: from mininet-experimente.amd.e-technik.uni-rostock.de (139.30.201.3)
 by mail1.uni-rostock.de (139.30.22.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 3 Nov 2023 17:41:57 +0100
From: Benjamin Beichler <benjamin.beichler@uni-rostock.de>
Date: Fri, 3 Nov 2023 16:41:46 +0000
Subject: [PATCH RFC 08/11] um: Protect accesses to the timetravel event
 list
MIME-Version: 1.0
Message-ID: <20231103-bb-timetravel-patches-v1-8-e2c68efcf664@uni-rostock.de>
References: <20231103-bb-timetravel-patches-v1-0-e2c68efcf664@uni-rostock.de>
In-Reply-To: <20231103-bb-timetravel-patches-v1-0-e2c68efcf664@uni-rostock.de>
To: Richard Weinberger <richard@nod.at>, Anton Ivanov
	<anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>
CC: <linux-um@lists.infradead.org>, Benjamin Beichler
	<benjamin.beichler@uni-rostock.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699029716; l=2785;
 i=benjamin.beichler@uni-rostock.de; s=20231103; h=from:subject:message-id;
 bh=cScckTJnr4aeaowsPfVGYikHgA1H6YJtd9gFfj8TAoE=;
 b=UvRd7fTAfaq9jnYM/Ck2XwWe/wbs1YW0itXq8TXrGgVTIBIV7wTjEB/++ZnNrVAzvRBmWm693
 b1MejuPOAcJBBUkaOCVQxxorrq6qZLiFkk64OOX2fnpau6iQ5ugzv2p
X-Developer-Key: i=benjamin.beichler@uni-rostock.de; a=ed25519;
 pk=fla2/IRwqFWH5W+fACqQyDu/mTc6mEcSPQtqb/SoX8o=
X-Originating-IP: [139.30.201.3]
X-ClientProxiedBy: email3.uni-rostock.de (139.30.22.83) To
 mail1.uni-rostock.de (139.30.22.84)
X-TM-SNTS-SMTP: 2449E7744075D006F2AE9A48A91343E8332FC8283F924601CBECDFFAED1D59422000:8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231103_094219_506375_4677B64B 
X-CRM114-Status: GOOD (  13.03  )
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

When the timetravel ext modus is used, accessing the timetravel event
list can be interrupted by a message on the timetravel socket in the
SIGIO signal handler. This interruption can potentially modify the event
list, leading to race conditions that cause deadlocks in the timetravel
protocol or disrupt the ordered nature of the list, triggering bugs.

Previously, the normal irq-save function did not intentionally block the
timetravel handlers. However, the additional (un)block_signals_hard
functions do block them. Therefore, these functions have been added at
the appropriate places to address the issue.

It's worth noting that although the functions are named as blocking,
they primarily defer the actual execution of the SIGIO handlers until
the unblock call. If no signal was issued, this mainly results in a
variable assignment and a memory barrier.

Signed-off-by: Benjamin Beichler <benjamin.beichler@uni-rostock.de>
---
 arch/um/kernel/time.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index e513256eadfe..f1b2ca45994d 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -288,6 +288,7 @@ static void __time_travel_add_event(struct time_travel_event *e,
 	e->time = time;
 
 	local_irq_save(flags);
+	block_signals_hard();
 	list_for_each_entry(tmp, &time_travel_events, list) {
 		/*
 		 * Add the new entry before one with higher time,
@@ -310,6 +311,7 @@ static void __time_travel_add_event(struct time_travel_event *e,
 	tmp = time_travel_first_event();
 	time_travel_ext_update_request(tmp->time);
 	time_travel_next_event = tmp->time;
+	unblock_signals_hard();
 	local_irq_restore(flags);
 }
 
@@ -349,6 +351,7 @@ void deliver_time_travel_irqs(void)
 		return;
 
 	local_irq_save(flags);
+	block_signals_hard();
 	irq_enter();
 	while ((e = list_first_entry_or_null(&time_travel_irqs,
 					     struct time_travel_event,
@@ -358,6 +361,7 @@ void deliver_time_travel_irqs(void)
 		e->fn(e);
 	}
 	irq_exit();
+	unblock_signals_hard();
 	local_irq_restore(flags);
 }
 
@@ -370,7 +374,9 @@ static void time_travel_deliver_event(struct time_travel_event *e)
 		 */
 		e->fn(e);
 	} else if (irqs_disabled()) {
+		block_signals_hard();
 		list_add_tail(&e->list, &time_travel_irqs);
+		unblock_signals_hard();
 		/*
 		 * set pending again, it was set to false when the
 		 * event was deleted from the original list, but
@@ -395,8 +401,10 @@ bool time_travel_del_event(struct time_travel_event *e)
 	if (!e->pending)
 		return false;
 	local_irq_save(flags);
+	block_signals_hard();
 	list_del(&e->list);
 	e->pending = false;
+	unblock_signals_hard();
 	local_irq_restore(flags);
 	return true;
 }

-- 
2.34.1



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
