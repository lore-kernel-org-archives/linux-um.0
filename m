Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12EF9EEC28C
	for <linux-um@archiver.kernel.org>; Mon, 23 Feb 2026 21:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=RURSBnkwM+zLebNk+SZfL3iqg62rBU4smk2gg/TBv1E=; b=YvuA6VGiJX87NaoAg32Wt0AC0l
	s2X5W3hPMP3iqV3awnMfUn3UHFoHpsp53TrN4AlzFXG1lH1TQ49VkhbXog5JY3TEksbly77Ov55sv
	LvkCvWooAettEUoL2VWORhBLachyJeWSoVmpZSQ4j885OGN7EdjTKd0tbX5So57WudDQ7heScA+68
	UvkzYctw5oVX8St73BtchJQn5Atj6HIwGY89s2Upvt65qWlZJI++GqxTB81lXndObCvliGpWvUmMx
	8Erwbgbq8Ty0AQQzM+Cfm2xhpuyzkYVNujCIjD40RuS/VVmUZpXbownBCGYtDKCtkR5Sz0NYmVWqB
	vROT1VxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vudia-000000014e3-2Pbh;
	Mon, 23 Feb 2026 21:43:52 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vudiY-000000014dV-0qhG
	for linux-um@lists.infradead.org;
	Mon, 23 Feb 2026 21:43:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id DE45B40B7C;
	Mon, 23 Feb 2026 21:43:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D8DC116C6;
	Mon, 23 Feb 2026 21:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771883027;
	bh=le7nxH2n1wzBURuB5NLlqkQiOQh+DSw2VYcDL5WOhdM=;
	h=From:To:Cc:Subject:Date:From;
	b=cViLij+8fPVHZNBtPQI04qbTq4VNDwsrNC0MlQMvmtdSYtEOQeCZ6dMbisKKxlFv6
	 /67Mu1darC0fJrG4qUCy+SmHg3SZXozLY0UK03+oYSrt6meZgjjyD1ceM0Sw/8JfpK
	 z/V4RvRGugrYGeYjA6MDmlSRAnZoEhN5MLXJAxJJ8jGBioMVoW57MOFiJv6BgJcZI/
	 BoWFDRfAwl1xrDpONgPb09+6L0OCfyceyDyEdtQxzrJB/4+pSKVbUNvLYAeT8YrwHz
	 510tTYDeO5M4rvxdj4AC/IKUB9vSRmcvFNAW2woikfVayifDUnFlLMcJlo3o5TdK+i
	 JIJDXkpzfpwGg==
From: Kees Cook <kees@kernel.org>
To: Richard Weinberger <richard@nod.at>
Cc: Kees Cook <kees@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jens Axboe <axboe@kernel.dk>,
	Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	linux-um@lists.infradead.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] ubd: Use pointer-to-pointers for io_thread_req arrays
Date: Mon, 23 Feb 2026 13:43:45 -0800
Message-Id: <20260223214341.work.846-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2496; i=kees@kernel.org; h=from:subject:message-id; bh=le7nxH2n1wzBURuB5NLlqkQiOQh+DSw2VYcDL5WOhdM=; b=owGbwMvMwCVmps19z/KJym7G02pJDJlzTgmozeuv/uB6ddqTgOwG5el/V0pnVwScb2YLkbK2q I07XXCio5SFQYyLQVZMkSXIzj3OxeNte7j7XEWYOaxMIEMYuDgFYCK7FzL8FavTORv7I5gpwItv 8yWPB4WT3+9bwtGw7PWpCUfiXpZtMGL4KyUSxr+HR3f9tMUbbqe81zNK8N/kpPhI5Pi971Pf9WR x8wAA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260223_134350_301735_CC802A1F 
X-CRM114-Status: GOOD (  15.05  )
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

Having an unbounded array for irq_req_buffer and io_req_buffer doesn't
provide any bounds safety, and confuses the needed allocation type,
which is returning a pointer to pointers. Instead of the implicit cast,
switch the variable types.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/all/b04b6c13-7d0e-4a89-9e68-b572b6c686ac@roeck-us.net
Fixes: 69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Hannes Reinecke <hare@suse.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Tiwei Bie <tiwei.btw@antgroup.com>
Cc: <linux-um@lists.infradead.org>
---
 arch/um/drivers/ubd_kern.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 012b2bcaa8a0..20fc33300a95 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -69,11 +69,11 @@ struct io_thread_req {
 };
 
 
-static struct io_thread_req * (*irq_req_buffer)[];
+static struct io_thread_req **irq_req_buffer;
 static struct io_thread_req *irq_remainder;
 static int irq_remainder_size;
 
-static struct io_thread_req * (*io_req_buffer)[];
+static struct io_thread_req **io_req_buffer;
 static struct io_thread_req *io_remainder;
 static int io_remainder_size;
 
@@ -398,7 +398,7 @@ static int thread_fd = -1;
 
 static int bulk_req_safe_read(
 	int fd,
-	struct io_thread_req * (*request_buffer)[],
+	struct io_thread_req **request_buffer,
 	struct io_thread_req **remainder,
 	int *remainder_size,
 	int max_recs
@@ -465,7 +465,7 @@ static irqreturn_t ubd_intr(int irq, void *dev)
 			&irq_remainder, &irq_remainder_size,
 			UBD_REQ_BUFFER_SIZE)) >= 0) {
 		for (i = 0; i < len / sizeof(struct io_thread_req *); i++)
-			ubd_end_request((*irq_req_buffer)[i]);
+			ubd_end_request(irq_req_buffer[i]);
 	}
 
 	if (len < 0 && len != -EAGAIN)
@@ -1512,7 +1512,7 @@ void *io_thread(void *arg)
 		}
 
 		for (count = 0; count < n/sizeof(struct io_thread_req *); count++) {
-			struct io_thread_req *req = (*io_req_buffer)[count];
+			struct io_thread_req *req = io_req_buffer[count];
 			int i;
 
 			io_count++;
-- 
2.34.1


