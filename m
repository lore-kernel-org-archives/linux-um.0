Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8377FC433FE
	for <linux-um@archiver.kernel.org>; Wed, 16 Nov 2022 16:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PbzOeR05n7bK5pGy92cpTm4DdrKBy8u/a0nGUCiwZDQ=; b=f7uUCHYxvi/iuo
	PfNaajz3Y8voU3J81p0rilz/PB5qYCeTdAGGqdHabikMb4RVZZ1Wu0Ig1utQtHUHaGzsgfRgQymtc
	nyxCjFJ+42CNjwKzqx7dN50eAy5dDkB+v4dx/xnFfCgOJsPYHkow7U/fi6/zwlEyLjiCdTakfkWxZ
	xCUlIqFUCoNu6ujxaeOB+0KP2maspCMKN+mUcT5FDzela5cFRLdno96XgfGxghL4CdELxIMCrx+O8
	GftlgRp/5N4JDwACk0H0enkZBH+RYBjmxCY49WKHooQTyJfAfCVVibU1c4eGt4aBP394mXmxzz593
	54+UqiWmPEAvHm343qsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovLBR-005oiB-Ds; Wed, 16 Nov 2022 16:22:41 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovLB4-005oU6-3D
	for linux-um@bombadil.infradead.org; Wed, 16 Nov 2022 16:22:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=GEhKO0dJc2f16pdA5isP3tyKiWxAMb8gJwHLg9bJtvU=; b=cJnjooiTe/EFAWRr4QwEKoCaWn
	j8E8qkpVIAgz229qnD7nkvIkoi/MwpRYW1H5tBSoXxnCVXujUtYw01wiiydv26F1slC/tinphTEKi
	txj7K3m9mKZui8DTb6CbL2DWjwcc/sjRKcga5bMmO/J2U5TQ6FktJvD3dKWChFUVuwosLEEYUS+QA
	xa3aETyRVH0aQDNGIiAL/9avgKaMFbaxi06HjGxMVqnnf2pezxp+ELrbAv7my6mq5DXEoeuGZMoV5
	IC93eAZAZ6Xv5bXUaCDvXPWYmod9gjMDe0VRbdTNktY+XNbm+A1mU1aEp/dxXGYcsgYpip0XAwz8z
	6TugauAQ==;
Received: from galois.linutronix.de ([193.142.43.55])
	by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovLAz-001O5M-Cf
	for linux-um@lists.infradead.org; Wed, 16 Nov 2022 16:22:16 +0000
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1668615723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GEhKO0dJc2f16pdA5isP3tyKiWxAMb8gJwHLg9bJtvU=;
	b=oIuBdriz4JcEynWjZAm586o5EvapOAFjcQM7Y2h/jaFjTqDiY6uPhp8aLR8nBjL3sNQ3Dd
	wHZzRlW7PVlMFZSrjuZBAdlaxGYKCPXOLT+eJt0Bx/Bf77XSVU/Sdj0fUXPID4f2JKMYWO
	xth7HR45tX4LCgAiYQR9UtjW3xY/OwKJbQ+MTsyvDkIBwVQsRDJgcmxvXQmLUsb4ji4IMo
	1l0xna2GGygbTY1KnRexudbFu2wA9TeXsj853JqPUmudt8ywLyxwW5Iiqh0Ree6FU5BaTz
	iM41PTKy8qkj5y2nB37PhrfFjKOUabUIaaJMqZLYTWFwtJKpjb3tdQms5EUKig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1668615723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GEhKO0dJc2f16pdA5isP3tyKiWxAMb8gJwHLg9bJtvU=;
	b=OZ7EGuhsAVFVp8NSWYxYiCIDMCwa1My5MhuROv6LAzBXyKI2zB/l2XJjq2B5TvLEf2EdaF
	XZjkrE4iliwyN5CQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: [PATCH printk v5 13/40] um: kmsg_dumper: use srcu console list iterator
Date: Wed, 16 Nov 2022 17:27:25 +0106
Message-Id: <20221116162152.193147-14-john.ogness@linutronix.de>
In-Reply-To: <20221116162152.193147-1-john.ogness@linutronix.de>
References: <20221116162152.193147-1-john.ogness@linutronix.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221116_162213_554560_DF8565DD 
X-CRM114-Status: GOOD (  10.29  )
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
