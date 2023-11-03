Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 628ABC41535
	for <linux-um@archiver.kernel.org>; Fri,  3 Nov 2023 16:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:CC:To:In-Reply-To:References:Message-ID
	:MIME-Version:Subject:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SI/L3YRsAFjFOIz4KKk9sDKzSuaUcBho6ELXxHyPlwo=; b=HfnjaplzykRHF0
	sYaOeG7jUesHp3f3K7qFbbrqlAK897Lq2r+f90fTwyS7qpBTUHt96Tva0QMoe76+Obd/FccyctJz5
	9c0s04GrT7SOrMJLuTnkdQPltyYFsm85+FXzXOBtxfe966t9LAq3RhZ2T4snZR7CQ7QlS97JtGRrG
	vAFM+zqiKsUrhBMt3wvPXaIuuX5X3FMEo8C5Ba20Bx70QV4EbUPHv0zRQtLWc6A9l6RLp+cOtgEtg
	7SoPQAm/uZUSp5Zm4KebxJdO6FUN1kaXKJ4Vj4raErK9HFCgjf6zYb+42ME5z0a8fkv7eupTgxBp4
	O28ZvNYMhU5q1QXLXJgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qyxFT-00Bnmr-25;
	Fri, 03 Nov 2023 16:42:19 +0000
Received: from mx1.uni-rostock.de ([139.30.22.71])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qyxFJ-00BnjT-0i
	for linux-um@lists.infradead.org;
	Fri, 03 Nov 2023 16:42:17 +0000
Received: from 139.30.22.84 by mx1.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Fri, 03 Nov 2023 16:42:00 GMT
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmze; 
 t=1699029720; bh=ku+pdHS1hzhBCoEm1LjBMLTCo9rq1iiLqvDYat5exh0=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=ed25519-sha256; b=
 N9B3A9xjQU8i+rs7agFNlK2lPp88QgpNQ97wccSpjQvCpPHYqZCh/zMDwKurumC0iV/NNHDWtSGC25XxJmPyBw==
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmz; 
 t=1699029720; bh=ku+pdHS1hzhBCoEm1LjBMLTCo9rq1iiLqvDYat5exh0=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=rsa-sha256; b=
 pZj4yqX59sdCmb2rRo7u31NhbBc/2rc6YlmByaDrIjC1RHgVOWB78E/7deXN2VubRK2mpd6esRvdrD4Mka/QmoyyZzLgkqH/DRYQKQNaIqlv42f/EPFlpKCwJ8IWdRLZ+xBh8NOpPtO5dZzNrxMtMjXEiX/nxCQTPNcnhbqdCpk=
Received: from mininet-experimente.amd.e-technik.uni-rostock.de (139.30.201.3)
 by mail1.uni-rostock.de (139.30.22.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 3 Nov 2023 17:41:56 +0100
From: Benjamin Beichler <benjamin.beichler@uni-rostock.de>
Date: Fri, 3 Nov 2023 16:41:39 +0000
Subject: [PATCH RFC 01/11] um: Make UBD requests synchronous in TT
 ext/infcpu mode
MIME-Version: 1.0
Message-ID: <20231103-bb-timetravel-patches-v1-1-e2c68efcf664@uni-rostock.de>
References: <20231103-bb-timetravel-patches-v1-0-e2c68efcf664@uni-rostock.de>
In-Reply-To: <20231103-bb-timetravel-patches-v1-0-e2c68efcf664@uni-rostock.de>
To: Richard Weinberger <richard@nod.at>, Anton Ivanov
	<anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>
CC: <linux-um@lists.infradead.org>, Benjamin Beichler
	<benjamin.beichler@uni-rostock.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699029716; l=4067;
 i=benjamin.beichler@uni-rostock.de; s=20231103; h=from:subject:message-id;
 bh=mHSC/EGIqAsNU/257dn5ioekUbBHZoYRsc6T5DoJHuA=;
 b=CnLAeGUOFYidPJ1tueSdtk8Bppb9fEbPOtnz8VnS2H7Sb7ysi1TminCft0G5Y5LLCJiHBTeeB
 aalx58/SM9pC6SsE5gGoevuC6PELZnGWKhXNjxIy9Lso4KTLRsKeIAW
X-Developer-Key: i=benjamin.beichler@uni-rostock.de; a=ed25519;
 pk=fla2/IRwqFWH5W+fACqQyDu/mTc6mEcSPQtqb/SoX8o=
X-Originating-IP: [139.30.201.3]
X-ClientProxiedBy: email3.uni-rostock.de (139.30.22.83) To
 mail1.uni-rostock.de (139.30.22.84)
X-TM-SNTS-SMTP: 52108EC476349399D14442841CF80F1F0342D8ADC61B484C816BD26B5AB0817C2000:8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231103_094210_124290_5F9E9408 
X-CRM114-Status: GOOD (  16.13  )
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

The UBD driver employs multiple threads to enhance block device accesses
in userspace. These threads communicate via pipes and are triggered by
interrupts that utilize the SIGIO handler.

However, in TT mode, both inf-cpu and external modes, this asynchronous,
multithreaded request processing lead to issues where requests are not
processed. This occurs because there is no dedicated time travel handler
for the UBD interrupt.

Since asynchronous, multithreaded request processing does not provide
substantial benefits in time travel mode and may even introduce
additional overhead (as multiple threads are scheduled sequentially to
execute requests in TT mode with infinite CPU power), this patch
switches to synchronous request processing directly within the
submit_request call for the respective TT modes.

Signed-off-by: Benjamin Beichler <benjamin.beichler@uni-rostock.de>
---
 arch/um/drivers/ubd_kern.c | 45 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 7 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 50206feac577..cdad289d5032 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -44,6 +44,7 @@
 #include "ubd.h"
 #include <os.h>
 #include "cow.h"
+#include "timetravel.h"
 
 /* Max request size is determined by sector mask - 32K */
 #define UBD_MAX_REQUEST (8 * sizeof(long))
@@ -456,6 +457,17 @@ static int bulk_req_safe_read(
 	return n;
 }
 
+static void finalize_request(struct io_thread_req *io_req)
+{
+	if ((io_req->error == BLK_STS_NOTSUPP) &&
+	    (req_op(io_req->req) == REQ_OP_DISCARD)) {
+		blk_queue_max_discard_sectors(io_req->req->q, 0);
+		blk_queue_max_write_zeroes_sectors(io_req->req->q, 0);
+	}
+	blk_mq_end_request(io_req->req, io_req->error);
+	kfree(io_req);
+}
+
 /* Called without dev->lock held, and only in interrupt context. */
 static void ubd_handler(void)
 {
@@ -479,13 +491,7 @@ static void ubd_handler(void)
 		}
 		for (count = 0; count < n/sizeof(struct io_thread_req *); count++) {
 			struct io_thread_req *io_req = (*irq_req_buffer)[count];
-
-			if ((io_req->error == BLK_STS_NOTSUPP) && (req_op(io_req->req) == REQ_OP_DISCARD)) {
-				blk_queue_max_discard_sectors(io_req->req->q, 0);
-				blk_queue_max_write_zeroes_sectors(io_req->req->q, 0);
-			}
-			blk_mq_end_request(io_req->req, io_req->error);
-			kfree(io_req);
+			finalize_request(io_req);
 		}
 	}
 }
@@ -1136,6 +1142,17 @@ static int __init ubd_driver_init(void){
 		/* Letting ubd=sync be like using ubd#s= instead of ubd#= is
 		 * enough. So use anyway the io thread. */
 	}
+
+#ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
+	/* do not initialize asynchronous io-thread and corresponding irq
+	 * in inf-cpu or ext time travel, as we need synchronous io logic
+	 */
+
+	if (time_travel_mode == TT_MODE_INFCPU ||
+	    time_travel_mode == TT_MODE_EXTERNAL)
+		return 0;
+#endif
+
 	stack = alloc_stack(0, 0);
 	io_pid = start_io_thread(stack + PAGE_SIZE, &thread_fd);
 	if(io_pid < 0){
@@ -1312,8 +1329,11 @@ static struct io_thread_req *ubd_alloc_req(struct ubd *dev, struct request *req,
 	return io_req;
 }
 
+static void do_io(struct io_thread_req *req, struct io_desc *desc);
+
 static int ubd_submit_request(struct ubd *dev, struct request *req)
 {
+	int i;
 	int segs = 0;
 	struct io_thread_req *io_req;
 	int ret;
@@ -1334,6 +1354,17 @@ static int ubd_submit_request(struct ubd *dev, struct request *req)
 	if (segs)
 		ubd_map_req(dev, io_req, req);
 
+#ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
+	//do the request sychronous (bypass io_thread and ubd_handler)
+	if (time_travel_mode == TT_MODE_INFCPU ||
+	    time_travel_mode == TT_MODE_EXTERNAL) {
+		for (i = 0; !io_req->error && i < io_req->desc_cnt; i++)
+			do_io(io_req, &io_req->io_desc[i]);
+		finalize_request(io_req);
+		return 0;
+	}
+#endif
+
 	ret = os_write_file(thread_fd, &io_req, sizeof(io_req));
 	if (ret != sizeof(io_req)) {
 		if (ret != -EAGAIN)

-- 
2.34.1



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
