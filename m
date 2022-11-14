Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A49C43217
	for <linux-um@archiver.kernel.org>; Mon, 14 Nov 2022 16:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PbzOeR05n7bK5pGy92cpTm4DdrKBy8u/a0nGUCiwZDQ=; b=j0c0HqnVsCh3Dt
	DLG5pWLple3rqGPEykEbTQ1+honHfzx3YHBa3KZmqNH7Zfl2wFr0ReruQ8Xw4e7MZTa+Git2Y3v46
	nR4zUNLimx68LLqUN5DlIpCJcRuXEuH7AReHWZejemRQXJCb4C4YGl9ykT4PUZiODOCjFImlaJNTW
	/4BZc31QL6WaFJXt+9regU82csdbqAKt6oAVaPSwc/AmxAdnJpg9cOz/LfRm1qHfGWcz7AheNv9N1
	6cevnF2tB1uEHdwzNBIq5+M7hEfH7FwF9V3FDN8/vT8SuC9OScVPoU6XJV8/WN0ClG+iWvxSFSUVB
	+azfIdwCpVoDKr6Qt4Ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oucLH-002ig0-8i; Mon, 14 Nov 2022 16:29:51 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oucLC-002ibF-MN
	for linux-um@lists.infradead.org; Mon, 14 Nov 2022 16:29:49 +0000
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1668443379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GEhKO0dJc2f16pdA5isP3tyKiWxAMb8gJwHLg9bJtvU=;
	b=fED6VtmDED6MuLvYHCpr7jg0s8uQ4ubFuV+VJrDBURlb+sRmrPLVdZhbCg7C9vkvldCcZC
	O3jnP3sS40Xc/9Nl61qOPe4tQo5M701OfeqSfviyYjbM9aVF5lpkSd4rH9cAes5ZiqmRXV
	qSC0fmcpzoHohSsnvCqpR2jm74hLpeXfas4Urmb+nz47yUrVVMWUckuYe0K6QhSQ0thxYe
	Do4tLzYO/CeZJ4lQo1ewHWpTh8mj47O/uroIOAzyntCZsQtDNfsDD/JIDWJTssmb6VX7O6
	7zwiYUW4aXXfoFUuEEQfPo3tGoBVRNEWeL66ULaqMgc89bm5V3SqUuiZVWBb3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1668443379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GEhKO0dJc2f16pdA5isP3tyKiWxAMb8gJwHLg9bJtvU=;
	b=X+VenatF4kHSWTowXfqC0zSVEJludzZYKhc6X1KeZyez9dy82GgAGpy+a7Avhfw9vUOvoe
	nAz42aPySqUAAZDA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: [PATCH printk v4 12/39] um: kmsg_dumper: use srcu console list iterator
Date: Mon, 14 Nov 2022 17:35:05 +0106
Message-Id: <20221114162932.141883-13-john.ogness@linutronix.de>
In-Reply-To: <20221114162932.141883-1-john.ogness@linutronix.de>
References: <20221114162932.141883-1-john.ogness@linutronix.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221114_082946_925621_5000CEB5 
X-CRM114-Status: GOOD (  10.37  )
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
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 arch/um/kernel/kmsg_dump.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
index 40abf1e9ccb1..427dd5a61a38 100644
--- a/arch/um/kernel/kmsg_dump.c
+++ b/arch/um/kernel/kmsg_dump.c
@@ -16,29 +16,26 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
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
 		 * expected to output the crash information.
 		 */
 		if (strcmp(con->name, "ttynull") != 0 &&
-		    (con->flags & CON_ENABLED)) {
+		    (console_srcu_read_flags(con) & CON_ENABLED)) {
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
