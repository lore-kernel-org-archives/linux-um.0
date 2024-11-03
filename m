Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D2CD11182
	for <linux-um@archiver.kernel.org>; Sun,  3 Nov 2024 16:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SH/kltViIcnRE/xnw4HMaQpFc9VKY1b8ULnLKaKX2pc=; b=d1vbO/eYpKVUzURSX6Ua23t2vh
	WjhrKOAIIlU3zKOOwkpiWBFoBR5gsUp/WDJrFKjBUum8BE+f3kpjdOmXpK3vOXuaKF/VGt+ZnDDPk
	3/GxEXIHUJbDK9tjHfFX851yOxV4swm8x5HHf5WEjjxH0ExxJQPGMaBLt5K7ASqtqtasOUM/fi4cY
	oGcWUt1Xw5HLPwxBmUOiZbM99sDsMvdkg5psaP1ENU+bKpnUG7OnBlOOpzhUjRr8MJnH0uOU3AiyF
	kvzeZqs1E4zeYaB5tzxxyS2oGMpUMeRouOuz5Tpiv8/CuBe3i3eUyWRvuboXGX4f54df1Ta/wOUCz
	KGqfi/7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7dFz-0000000BgFK-0tSn;
	Sun, 03 Nov 2024 16:15:15 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7c7Y-0000000Batl-0f39
	for linux-um@bombadil.infradead.org;
	Sun, 03 Nov 2024 15:02:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=SH/kltViIcnRE/xnw4HMaQpFc9VKY1b8ULnLKaKX2pc=; b=idU/G+nkhEeNcq3l/CPSv6Tlq7
	uNQEkSr81+/bXn0PlDIg2ZiJ7jyaPlv5tpX0nX96opkp0n70HbmqT/5YV2+24dCyD/rbcL7C1MmLk
	/q8I/okT/SxezU7Ly0KgpkwYklvKiDsSAISSUAxE7yF9vlrBxd7UO8N607sqgLjqy25mcecyjU6G/
	Rh/8/de+X2pI2aCBJXmRAd91pS+mXh0N2lGrqIokTATGm7WAq5+w6w5S8Mndxf0zAQz3s5uQhq58F
	OSIUoJE8Mb/7a/Sx3+RRX1B8h4a8f3inZQlW8o05YQGtl6asgfgF6MKeTee4Pj7WxImGL8jvVyIlF
	3L+bbw3g==;
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7c7T-0000000B8Nz-1VLz
	for linux-um@lists.infradead.org;
	Sun, 03 Nov 2024 15:02:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=SH/kltViIcnRE/xnw4HMaQpFc9VKY1b8ULnLKaKX2pc=;
	t=1730646143; x=1731855743; b=eqnfxtHyyoBIdv/7E1EpWgr1Z+aNQ6wfXKHZYgR4XL8bKD0
	ODlrimjhZOo0BotHLBuKu+JanH3kikDrhcXAgpdSGvonnznXFZ1GpfdVxd4paw77pG+FOuTGiyRiw
	5TRrtoYig1V5GwypTGJ6hi5SS2n9jXX4xGjlPPZCGoqqJKsmhSXnwnPBs584Y0w8TZBX/bI3eZzw+
	aAoVXM3qd4Gy+Xos+ISMPhZT+lPp9OPXQQqmzw8iQQrrTfPy1BIZQi00dkqOAr9QOcUdBA70eixIj
	F59fxNiuBAXFvkZw+kEqXGXaOEeRrI5uXFTBCOYTk6HwdnSvklqE7EgM5vBlZbSQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1t7c7R-0000000D5Ia-2fHO;
	Sun, 03 Nov 2024 16:02:21 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 5/5] um: remove broken double fault detection
Date: Sun,  3 Nov 2024 16:02:11 +0100
Message-ID: <20241103150211.1366452-5-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103150211.1366452-1-benjamin@sipsolutions.net>
References: <20241103150211.1366452-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241103_150223_986821_CB4BFEFE 
X-CRM114-Status: GOOD (  11.88  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Benjamin Berg <benjamin.berg@intel.com>

The show_stack function had some code to detect double faults. However,
the logic is wrong and it would e.g. trigger if a WARNING happened
inside an IRQ.

Remove it without trying to add a new logic. The current behaviour,
which will just fault repeatedly until the IRQ stack is used up and the
host kills UML, seems to be good enough.
---
 arch/um/include/shared/os.h | 1 -
 arch/um/kernel/sysrq.c      | 6 ------
 arch/um/os-Linux/signal.c   | 8 --------
 3 files changed, 15 deletions(-)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 6c656ef096c9..5babad8c5f75 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -241,7 +241,6 @@ extern void block_signals(void);
 extern void unblock_signals(void);
 extern int um_set_signals(int enable);
 extern int um_set_signals_trace(int enable);
-extern int os_is_signal_stack(void);
 extern void deliver_alarm(void);
 extern void register_pm_wake_signal(void);
 extern void block_signals_hard(void);
diff --git a/arch/um/kernel/sysrq.c b/arch/um/kernel/sysrq.c
index 4bb8622dc512..a3bdab048617 100644
--- a/arch/um/kernel/sysrq.c
+++ b/arch/um/kernel/sysrq.c
@@ -32,12 +32,6 @@ void show_stack(struct task_struct *task, unsigned long *stack,
 	struct pt_regs *segv_regs = current->thread.segv_regs;
 	int i;
 
-	if (!segv_regs && os_is_signal_stack()) {
-		pr_err("Received SIGSEGV in SIGSEGV handler,"
-				" aborting stack trace!\n");
-		return;
-	}
-
 	if (!stack)
 		stack = get_stack_pointer(task, segv_regs);
 
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 1c6caa9dbd6c..52852018a3ad 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -487,11 +487,3 @@ void unblock_signals_hard(void)
 	unblocking = false;
 }
 #endif
-
-int os_is_signal_stack(void)
-{
-	stack_t ss;
-	sigaltstack(NULL, &ss);
-
-	return ss.ss_flags & SS_ONSTACK;
-}
-- 
2.47.0


