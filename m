Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 836EEC677C4
	for <linux-um@archiver.kernel.org>; Fri,  6 Jun 2025 12:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mC3Byk4vYixYtR9/E873GeQIu44pq2w2vb1wyFywZgM=; b=DgOQwzNNTEIzufSfHuTV5ofP8K
	6xoPNWXc8q0Qbxl2dHljRLqEGe1Qc14kmxUyvAeqOAtvWzEEjYMENtyyBYxebgJRQVChi2TyeOds3
	a9i5KoZfL+dRmJ8XVLXhEn3FjbSS+2RoTzPrMEhBGX2RaHiYblZZeVYYCGTHwwEz4ZkXZaVy3zcnM
	HPHS8MC/fm1bkR7Z2vtKwXjVOlihqrkW+QiI74FkMELuhciE32Xy8TETPaaMmZtiBgHoFU3trPTo6
	WF6J/dik/4hEP6u+S2YZZriuxepqQFAJUPVunsOOBNM2GPzF/1m9YxI9an/elCNvQ2kym4v1GRpFf
	KKvHLshg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNWRO-00000000Gzn-0eVa;
	Fri, 06 Jun 2025 12:44:58 +0000
Received: from out0-211.mail.aliyun.com ([140.205.0.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNWRK-00000000Gnp-0GYf
	for linux-um@lists.infradead.org;
	Fri, 06 Jun 2025 12:44:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1749213886; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=mC3Byk4vYixYtR9/E873GeQIu44pq2w2vb1wyFywZgM=;
	b=HqXKMc/QK/Rdi5yforZsMSxS2jdIX4rlll/kgoMBvTGrD1Yma9o/J8ioLHcEZL+GjqEqQ1jVH63k9diNDUU3BE6djRl1/6IJCEbsTOcxQWzNr6WJu65dpDG3oght7DBtNWyf0XJEjuQ1R0cHSCgpAPzT0luGDuVJmZursC/I3sY=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.dD3Yx0Z_1749213882 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 06 Jun 2025 20:44:43 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 1/4] um: ubd: Add missing error check in start_io_thread()
Date: Fri, 06 Jun 2025 20:44:25 +0800
Message-Id: <20250606124428.148164-2-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250606124428.148164-1-tiwei.btw@antgroup.com>
References: <20250606124428.148164-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250606_054454_480644_26245A15 
X-CRM114-Status: UNSURE (   8.62  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

The subsequent call to os_set_fd_block() overwrites the previous
return value. OR the two return values together to fix it.

Fixes: f88f0bdfc32f ("um: UBD Improvements")
Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/drivers/ubd_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/ubd_user.c b/arch/um/drivers/ubd_user.c
index c5e6545f6fcf..8e8a8bf518b6 100644
--- a/arch/um/drivers/ubd_user.c
+++ b/arch/um/drivers/ubd_user.c
@@ -41,7 +41,7 @@ int start_io_thread(struct os_helper_thread **td_out, int *fd_out)
 	*fd_out = fds[1];
 
 	err = os_set_fd_block(*fd_out, 0);
-	err = os_set_fd_block(kernel_fd, 0);
+	err |= os_set_fd_block(kernel_fd, 0);
 	if (err) {
 		printk("start_io_thread - failed to set nonblocking I/O.\n");
 		goto out_close;
-- 
2.34.1


