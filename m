Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BB5C433FE
	for <linux-um@archiver.kernel.org>; Mon,  7 Nov 2022 14:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KKyPUijr7YI0uBKPi5olFLY1jkTR1X0euXdqVTrOVvI=; b=Z04/KUfTX5jl/U
	OkZ5aRBLLeBG00D7rg8vOSphAVaWHFmbqve8aGf+tRE7tyYF0nkiZ69WJiPr1iPpBkDd/oGlM7lOi
	9quPZBjoJ6r3IfnC9jUGXCNyluEGIp5F542dd/b2c4FikO/DyCszm+taelw7WwAmM9conYSSWjhLZ
	x7i5ix8cFrl5qSECwiiqz1bdqYToqlEmmCiJhf/SGNk9CMzfTG+9tdMgFgZYxZCp+XgpqnK35jGSL
	uFvde1lxfxUvpp+zK67IFT3wOmK6ohpJ6g3mtV4rw6zBYpugGfluUGJQ1IZIlivSSStmZ7XrjDXHV
	yeJMLTN0XxdY+aRIOEXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1os2vz-00F9mJ-UZ; Mon, 07 Nov 2022 14:17:07 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1os2vg-00F9au-La
	for linux-um@lists.infradead.org; Mon, 07 Nov 2022 14:16:51 +0000
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1667830604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=je6BJxg9zIGvpozBTcqdrPDtOdfb/xlqXdr2RuFn3Cs=;
	b=xStyNuRDwQZqAStcI5UdpJk/G1E5RxVmu6uOQl+HxB1LsyG+UGrqEo1GBdH5tNIsVYbp31
	0sGdsUMWqMJ/RIw/dqRua8mTPCiC2Bi6yXAUtwiWaId98XBGkDmKHPA2T1r7BIup48ey9t
	V9t+le50KAGrPTn4fCw91P4Os0mVXzm0RBzuzyUZYvXZ4/TFQS0VlpLfWhhNciYokn7bY0
	x6OS3kQVIDIkRsGimBU+tA3J0nxK/4cLvsdYUYYb7XEy3sJM89hJF40SlQ4jDenQhvJNj1
	T4y6vF+anyQgoWACwNMjdC5+tAh9Q1X1KynBM24kz9ifzeNZquHauzk0EDw2rQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1667830604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=je6BJxg9zIGvpozBTcqdrPDtOdfb/xlqXdr2RuFn3Cs=;
	b=fU3tEDpTAS3rUjjLodJQU8W30Uff0X7RCSHHMp6eNmbUMCNdxpTq68atryVxFBzRoHmaAA
	LJxSkx1rw4wUSjBA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: [PATCH printk v3 09/40] um: kmsg_dump: use console_is_enabled()
Date: Mon,  7 Nov 2022 15:22:07 +0106
Message-Id: <20221107141638.3790965-10-john.ogness@linutronix.de>
In-Reply-To: <20221107141638.3790965-1-john.ogness@linutronix.de>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221107_061648_902416_58D0BA6C 
X-CRM114-Status: UNSURE (   8.59  )
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
 arch/um/kernel/kmsg_dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
index 40abf1e9ccb1..f0233e2f8de0 100644
--- a/arch/um/kernel/kmsg_dump.c
+++ b/arch/um/kernel/kmsg_dump.c
@@ -32,7 +32,7 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
 		 * expected to output the crash information.
 		 */
 		if (strcmp(con->name, "ttynull") != 0 &&
-		    (con->flags & CON_ENABLED)) {
+		    console_is_enabled(con)) {
 			break;
 		}
 	}
-- 
2.30.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
