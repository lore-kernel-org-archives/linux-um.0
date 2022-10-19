Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB35FC4332F
	for <linux-um@archiver.kernel.org>; Wed, 19 Oct 2022 15:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=e24APktF5KaoM+SW3308/XRqLdr+eBbVqgmqZEN3tCU=; b=dVvqqN5azZLJ2F
	hNcdlsge8TsZ0rxwpnfY4th18SR2hipkjGPUYjelnvVnqPO6KvusEksHddx+O769kh+c22QvjnMbm
	5KBoxfdBwE2vX0a1Mer1AWn/vFVayYlxecbzBCrkbH6vWq+X1Avkt4EmY9DY0hhs5r/D/WmGHt+IB
	7KkaIPPzmGKeqF1JTU1731eAFsrL2DyzoX5Ts+bhN79oPitspiEjIoIfT5w+yHKHiYHmSds+J0PLO
	zAoE9PfQmd9e/TWV7Ji8++8mKyJC0YuPOQwr2E3yFUnJt9fY7LlMVeuyl3rdSh3pqkwgQWobUCt5H
	w9bG3l4ulOmpro9o/8zQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olAja-0036Uy-41; Wed, 19 Oct 2022 15:11:54 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olAUQ-002wcx-Ir
	for linux-um@lists.infradead.org; Wed, 19 Oct 2022 14:56:16 +0000
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1666191373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2RcyNuvhxtc3XAp6KUXXBEZGfBTKoyRNmah0KdJRqUM=;
	b=s+uK2CVyfeRWS2SM8ONtEm3ezF4TKCfBKPBHIwbQeW7/3EKdt2DXK8Se8xiredxeNeCSkY
	ZKidWJ9kOFMnJ+GDRhqzajlfU0p4AFkX17OY/4V8RDFxWqEJS/1ZvxtBmCOcbU/4l2IV5+
	uARnYyoVv6Nyvh9wOtzsxW1T3vJw5LOkY1LuXAHyxPLMVW6YaxF14EZEX4gyzIy+5CXUjS
	vS1F3O108Xc1xgSipOJuPxZcLQ/qV1jeZloh/cC1xGCqj2wAIwT9zN8nuby6knA2dC3umy
	BQvb2BMGIRylFs6NDquzoIBMVcnZI7H6sM7m8P0T/FddSctNfiRBDKDOqpiRPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1666191373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2RcyNuvhxtc3XAp6KUXXBEZGfBTKoyRNmah0KdJRqUM=;
	b=o+Tf43pKW3jb3K3SYt/Uyhx64JMO0G2cG8/ulnFuahJncjT6ev9pQxCcwgJEpI8Oeo5SuX
	YSUluQ/obMklGtAg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: [PATCH printk v2 20/38] um: kmsg_dumper: use srcu console list iterator
Date: Wed, 19 Oct 2022 17:01:42 +0206
Message-Id: <20221019145600.1282823-21-john.ogness@linutronix.de>
In-Reply-To: <20221019145600.1282823-1-john.ogness@linutronix.de>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221019_075614_810331_E53864DB 
X-CRM114-Status: UNSURE (   9.06  )
X-CRM114-Notice: Please train this message.
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

Rather than using the console_lock to guarantee safe console list
traversal, use srcu console list iteration.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 arch/um/kernel/kmsg_dump.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
index 3a3bbbb22090..44a418dec919 100644
--- a/arch/um/kernel/kmsg_dump.c
+++ b/arch/um/kernel/kmsg_dump.c
@@ -16,20 +16,17 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
 	struct console *con;
 	unsigned long flags;
 	size_t len = 0;
+	int cookie;
 
 	/* only dump kmsg when no console is available */
-	if (!console_trylock())
-		return;
-
-	for_each_console(con) {
+	cookie = console_srcu_read_lock();
+	for_each_console_srcu(con) {
 		if (strcmp(con->name, "tty") == 0 &&
 		    (console_is_enabled(con) || (con->flags & CON_CONSDEV))) {
 			break;
 		}
 	}
-
-	console_unlock();
-
+	console_srcu_read_unlock(cookie);
 	if (con)
 		return;
 
-- 
2.30.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
