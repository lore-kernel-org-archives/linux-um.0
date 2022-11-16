Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9614C4332F
	for <linux-um@archiver.kernel.org>; Wed, 16 Nov 2022 17:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BhhrT3gVU/zBkvJt/92wQsBYCCUwenCodUKPJO/mLjs=; b=BgkGCnQ+925RFV
	4b1TUyk0HVjhnGV8gu6j1HJZ0eI2gQ7MLMWpas0jXPnkHFIIpyW8zmqP7Jf0o4JgbS5UOPbM5EsGx
	1rdHXDzrfYYkh4Sjv6Uoim4J0pEluDjnC3j34UFuwIjHZrxAVvFLQumhXt1eIQa2PVJMWj67fxHLj
	JQ9k0z7QbBtpggleTtfnR3cgrTXBbtdcutv99ie9id1XYgGd5kFMrdLTXnbZ9Ya+Wvn/KWwfdf3IJ
	t5gBaeO46HAuo6R7FhrPimP6fPwLwbJr9WHZbRUhFaH1xlXj6D2ya+KINGZPGTAroEDTzdWmscgUU
	ahCLwqdYpJ96wJLQFYIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovMFc-006RFy-Gk; Wed, 16 Nov 2022 17:31:04 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovLAr-005oO9-IX
	for linux-um@lists.infradead.org; Wed, 16 Nov 2022 16:22:07 +0000
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1668615720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eUV7NYFJOYRPWEVh0G/EU6zT1t7HGJ6qLPZoOxwFJX0=;
	b=i6rR4UWrVsi6o7VcT0dSMzT5OauKeph8Ma1KOTE1b3BM6zKYwJAEGVd6iEJRPcFdOzFCsV
	HFHmgCNxA9Fub/V2HRwn5xTn33moUGNvgJO1eRSW7ZjzDCd6FDzinZgDymoEquukHZHHq8
	s0CfN3++aC4Wd7OuFwJFvCQsDYHtBi7rsrcCbu9lZoG91wvkVze/0dhNIfwRkt0O7vFlHa
	rE7O6ZmuYj60l/uRvg4R+LV7hz+mhxPJqdVMQJcBtOHc7Hs81xukaMun6CQZh40u/UZ7RM
	NeBEbscz4y231v4m1OKF/5nSrs2B2K8EMQ5CSNYZsDingtF4zCMr28jZldooGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1668615720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eUV7NYFJOYRPWEVh0G/EU6zT1t7HGJ6qLPZoOxwFJX0=;
	b=DKb9EMCX8Wi5FM8m4Bsdn/mxAv1cbCLE/1Q/F6hUtEvssXkb+GtLbarPzOkGGdX5WYOnik
	tlusV+pfZJZlBrAA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: [PATCH printk v5 07/40] um: kmsg_dump: only dump when no output console available
Date: Wed, 16 Nov 2022 17:27:19 +0106
Message-Id: <20221116162152.193147-8-john.ogness@linutronix.de>
In-Reply-To: <20221116162152.193147-1-john.ogness@linutronix.de>
References: <20221116162152.193147-1-john.ogness@linutronix.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221116_082205_792471_2051F7F5 
X-CRM114-Status: GOOD (  13.53  )
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

The initial intention of the UML kmsg_dumper is to dump the kernel
buffers to stdout if there is no console available to perform the
regular crash output.

However, if ttynull was registered as a console, no crash output was
seen. Commit e23fe90dec28 ("um: kmsg_dumper: always dump when not tty
console") tried to fix this by performing the kmsg_dump unless the
stdio console was behind /dev/console or enabled. But this allowed
kmsg dumping to occur even if other non-stdio consoles will output
the crash output. Also, a console being the driver behind
/dev/console has nothing to do with a crash scenario.

Restore the initial intention by dumping the kernel buffers to stdout
only if a non-ttynull console is registered and enabled. Also add
detailed comments so that it is clear why these rules are applied.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 arch/um/kernel/kmsg_dump.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
index 0224fcb36e22..40abf1e9ccb1 100644
--- a/arch/um/kernel/kmsg_dump.c
+++ b/arch/um/kernel/kmsg_dump.c
@@ -17,13 +17,22 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
 	unsigned long flags;
 	size_t len = 0;
 
-	/* only dump kmsg when no console is available */
+	/*
+	 * If no consoles are available to output crash information, dump
+	 * the kmsg buffer to stdout.
+	 */
+
 	if (!console_trylock())
 		return;
 
 	for_each_console(con) {
-		if(strcmp(con->name, "tty") == 0 &&
-		   (con->flags & (CON_ENABLED | CON_CONSDEV)) != 0) {
+		/*
+		 * The ttynull console and disabled consoles are ignored
+		 * since they cannot output. All other consoles are
+		 * expected to output the crash information.
+		 */
+		if (strcmp(con->name, "ttynull") != 0 &&
+		    (con->flags & CON_ENABLED)) {
 			break;
 		}
 	}
-- 
2.30.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
