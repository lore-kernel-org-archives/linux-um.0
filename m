Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63587C4332F
	for <linux-um@archiver.kernel.org>; Mon,  7 Nov 2022 14:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UVxKaQDv/r3nmo5UXs25ypZH0qxSDvr49NO25EHNfhU=; b=4JJLPAYM0HQmEb
	hx6iAWY7yuHYLx/HcBdu+Nj0cF642BHtJ+be9zRSStYQDhTiWd4WIEwGbaXZZdIUVcHU7JLfVWxYT
	nMxb+PCdsfxo1EHb6nd8hN1MxAAWla0dJyWg9ylkebEFBWy/s118211R18Wn8+HNd4CkcpAqWAK5k
	mMYRrT00YUmuSBhbhdtiT2VV2ZBf0sRDIHNggfMrbf74xKgZwWDC8rmPyPZIA1rMSvfflw3mi1Sbn
	uKgyUhPha5eubhGcm4jMxes+l7GjPwBvD4rVwKdb21boPBSW4zwRLIG1HeX6bao+ZZQOWbKiudBxn
	HMZfM92tksUPIKVLmaoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1os2w0-00F9mX-3m; Mon, 07 Nov 2022 14:17:08 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1os2vg-00F9ao-Lc
	for linux-um@lists.infradead.org; Mon, 07 Nov 2022 14:16:52 +0000
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1667830603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6/paKzOHPdL7LtYxjVc5vEnqdv9ZQ5lgTtMtTQHWNnQ=;
	b=kgfOV8TY/LzEY5UzgRdT3BlvUS4J1DgI43rtqiBP9Hat6fe0tbknUSa2d0RAAIOO+gTscI
	9gmZ/Oe5VTwP6nr6aI5cirDD8ru3D4TaVVzQzcKFr/nXfUWAbIm76g0tG7oACi1zAypM21
	wSACcAaMqT+08PtymJMHqyyKDvN6rE0eGaya9a2kYmWdI+WL8S/v3bS5NYBqugmdS4eUgw
	2PBFr7mml7AoQQIqx6L9iXf/WfFvtkQbEyOJtpgmt4m1tvzCh+5Ks6dDOcremWNzfpqzKp
	9uTWvROhtIUwlxLIz7tHhRdcrNZtybOB6R8xqouGyYP+HcGLH3dnVTezBOcTHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1667830603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6/paKzOHPdL7LtYxjVc5vEnqdv9ZQ5lgTtMtTQHWNnQ=;
	b=vWS9R1RBOLVJYj2nIE+UOu47k28bDRXb6conZQphvOjHz1Y9ErtSJTCEnA7Fn3BAEIUYkJ
	oQTGziecwCDdfmAQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: [PATCH printk v3 06/40] um: kmsg_dump: only dump when no output console available
Date: Mon,  7 Nov 2022 15:22:04 +0106
Message-Id: <20221107141638.3790965-7-john.ogness@linutronix.de>
In-Reply-To: <20221107141638.3790965-1-john.ogness@linutronix.de>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221107_061648_937456_61178981 
X-CRM114-Status: GOOD (  13.55  )
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
