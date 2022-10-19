Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B88FC4332F
	for <linux-um@archiver.kernel.org>; Wed, 19 Oct 2022 15:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8Vegk1kB3lRsYYFun7tnLd1YWqS28WXgxmSulEQOfAs=; b=1gCueCRBFUZlc6
	sC9XMVJExmq0rN3N3BKoInc94FtotDhFOBQSdeep4n5KqRsOfLaxBrTNiZqgaKqHgfa3G2FpdtY8Z
	JhhUnYWfuIDfGs0hEGdDf7HoJzXUTqje9nfxUzNKWDvH9D/4gTbfbfHck2/EF6CTVuW963sZcB4jk
	2xXi4ChXEfof2yXRVTv0nULfHkWgwmON/t6RsMASN0elhCkBirs2SpkWt4W0qlnRxOwAHnNzkiZxO
	7rFOniiQ8Bn5anGEkIkNNAGFLS8O3wLlXSL1Ht5L3oOvyHdsQZor6LytDT1qamZYt8IrCakyfDRNd
	FsDMlSCUmpXJrUomhatQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olAj1-00366u-P4; Wed, 19 Oct 2022 15:11:19 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olAUL-002wY2-8v
	for linux-um@lists.infradead.org; Wed, 19 Oct 2022 14:56:13 +0000
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1666191366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zWMphmFfDq8OlVxrrPCchY88v/O4bwRw57cpKirymSQ=;
	b=v9YrdXBBO/q6meOVsORl10DT9g8/uzZ23xImHaforLllPZJe1CnX//gDt3Ecm5guuqQ/so
	MACoct9zfApolTJ+v1FVD1h0RLDBoFkoLZNYKGiJ0DsuUqHcw+0rDpb9ZIPgagNu7Zgs+O
	gkRSYUFmeL4JqdZ1XKjm0OXKoaL+fnuYiiqcJ5sO4+rKUKDp2WLocmXDuVBuX2NTl2a3rl
	siY+No+tFyVN4CEiREVMo2jTwrxQd9bAZzkxg/EMqT9C3vVARDmTRLPn53t0VEHW9z18bu
	LhmZykhol1iWGLRrhrVr7+PEuWsHDTLrcyEQ2JthQ9gAU5biH4l812fGFSJhAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1666191366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zWMphmFfDq8OlVxrrPCchY88v/O4bwRw57cpKirymSQ=;
	b=Gq8pSMFow1Bxe2k6NvWVnYMVnjoP0hDNZGICKaqxJBt6kO5QnCEPHVFaH8KueqPAfoWClB
	v8NwqRojtfnaGHCQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: [PATCH printk v2 07/38] um: kmsg_dump: use console_is_enabled()
Date: Wed, 19 Oct 2022 17:01:29 +0206
Message-Id: <20221019145600.1282823-8-john.ogness@linutronix.de>
In-Reply-To: <20221019145600.1282823-1-john.ogness@linutronix.de>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221019_075609_545056_242487B1 
X-CRM114-Status: UNSURE (   9.18  )
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

Replace (console->flags & CON_ENABLED) usage with console_is_enabled().

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 arch/um/kernel/kmsg_dump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
index 0224fcb36e22..3a3bbbb22090 100644
--- a/arch/um/kernel/kmsg_dump.c
+++ b/arch/um/kernel/kmsg_dump.c
@@ -22,8 +22,8 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
 		return;
 
 	for_each_console(con) {
-		if(strcmp(con->name, "tty") == 0 &&
-		   (con->flags & (CON_ENABLED | CON_CONSDEV)) != 0) {
+		if (strcmp(con->name, "tty") == 0 &&
+		    (console_is_enabled(con) || (con->flags & CON_CONSDEV))) {
 			break;
 		}
 	}
-- 
2.30.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
