Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE03C4332F
	for <linux-um@archiver.kernel.org>; Mon,  7 Nov 2022 14:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fmLg0NNuAPxmW3lBz1Yz25O1DvZpRS+HxpSQ8Im7AHU=; b=Mt6oUjoirtcgV8
	s+oF2wel1hQyzzbQD8fAovAHhy14iUB289/B5g8Zwf1/B0p1wX1g9fAePAquh+sezzWChkecTMa4e
	ZJx7RxK+yLumpqdpLt8MEFOlGJz3I4IME6b5yNSFpfs5DxU8RGMTVbs/zszlo3/QHoLK297+vZdRX
	Lgzr8gs9oeLQ+W5lV1UoUOEprfOfTpFCxrvA27esgHqrZb9qegdJXfE5JOJ9qRg7Ts1mZ3KtQSV0h
	lSkGpI2/av4513PfTf4cJD/J6TwkX5M03PQBctTWBKrCFM+8z6wPZxNFsQGt5Jh3rLNH/G0tCxpkJ
	MJdhkuPwfn7XJi8291Jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1os2vz-00F9m0-IR; Mon, 07 Nov 2022 14:17:07 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1os2vg-00F9bD-LZ
	for linux-um@lists.infradead.org; Mon, 07 Nov 2022 14:16:50 +0000
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1667830605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jHu0DmQ8f1rgQbiyd2Suu9x07qh6zOdBEqqZ/26ftRk=;
	b=hGwj6gizl96NQKwR498k6uAl6XSNfXs5DgtmC5L8WU7gQWVMnV7NlRaPDbm+f6yjkhmslu
	QucFR7Y2mtVq5FQDr4sTthdt7CY0EmINf9SVUOxmemZNSxstqrHpUbc6G88hCPT21Yegbw
	eqg3pL91M6+PPtd1gM+QJUhLzSCTMEpbM2aJhVq6e1aoD+8XkEN/nxIGyiR1B32A6BlAV6
	m19ypo58YK7PSvx6wjWoCQiTVJgwBKEG3xfqcKheTXfurqjSDhZxeg3XVqGOZTLfPijIy1
	IOG5h4UQmGKMeBTZ1D2406gA5WuWTokF1Wsn3rGlck+/9hA/SyrLA4qUBFxMzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1667830605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jHu0DmQ8f1rgQbiyd2Suu9x07qh6zOdBEqqZ/26ftRk=;
	b=P9Gxvfan7DCC1ih4Knt2kaKzs4QeQhU+whuk/d07z5yqj/O+rOCCGJvNj0Wj3ZUD3GFgTP
	nGuJe2YaCbe55ACw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: [PATCH printk v3 11/40] um: kmsg_dumper: use srcu console list iterator
Date: Mon,  7 Nov 2022 15:22:09 +0106
Message-Id: <20221107141638.3790965-12-john.ogness@linutronix.de>
In-Reply-To: <20221107141638.3790965-1-john.ogness@linutronix.de>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221107_061648_913674_72531DB6 
X-CRM114-Status: UNSURE (   9.23  )
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
index f0233e2f8de0..b6acb3837f1d 100644
--- a/arch/um/kernel/kmsg_dump.c
+++ b/arch/um/kernel/kmsg_dump.c
@@ -16,16 +16,15 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
 	struct console *con;
 	unsigned long flags;
 	size_t len = 0;
+	int cookie;
 
 	/*
 	 * If no consoles are available to output crash information, dump
 	 * the kmsg buffer to stdout.
 	 */
 
-	if (!console_trylock())
-		return;
-
-	for_each_console(con) {
+	cookie = console_srcu_read_lock();
+	for_each_console_srcu(con) {
 		/*
 		 * The ttynull console and disabled consoles are ignored
 		 * since they cannot output. All other consoles are
@@ -36,9 +35,7 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
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
