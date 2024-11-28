Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE65DD690EB
	for <linux-um@archiver.kernel.org>; Thu, 28 Nov 2024 08:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lxIXCRorLW2sU817OCg6DyAVblwJyARH0xNo7/PY00g=; b=3cBIjTAUICC1MbJLB63S1oA1+v
	rDdHBdBN1qgoeriP4If1qbdT7aGmz0Mbpyg4lQsmGn2w3FJxE1i6d7ewf5tVWj6wNyJUHftDT6IVg
	VuOw5ccdvth7vqlG7fNuS9MhVY1XAkEnh4lXaEqFy9nzgzDstVF9D0yykauPLesgZDNdNakB9fGWl
	IM4Q2A2XT+Ntr0U6rk9sWx4rcSWjCH6F+SuqQIDSiyFs+4yIp5hTBahPuTEeBXG0wStuA6hmthZAh
	8LNdLSh+gI0w+pdGVRXTVDsAMGjN2W1nY5JeJAdqYwGr4A9yOdA7GDBTluuQ8Qtjeed1aHgPIpC4K
	zXibJrNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGZlW-0000000EyYH-2MEq;
	Thu, 28 Nov 2024 08:20:46 +0000
Received: from out0-221.mail.aliyun.com ([140.205.0.221])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGZkg-0000000EyIK-30mh
	for linux-um@lists.infradead.org;
	Thu, 28 Nov 2024 08:19:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1732781990; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=lxIXCRorLW2sU817OCg6DyAVblwJyARH0xNo7/PY00g=;
	b=bfpy1uzuLq25HiOp7zFQ/Kov8b3lmlvz8nReRG0QeIy7GxvFHu8ctY+ABaP5VOB9rloLOjj7JbB0vMyEzov64bbwYGNTim9Ruy6lG9fOSFlOeFM6Avo362J6cxAw1gKgxSmYqyACoOm/rRhVhVnN9e6tobqkmFNSaXvrbZosEws=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.aP-8fox_1732781989 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 28 Nov 2024 16:19:49 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 3/3] um: Count iomem_size only once in physmem calculation
Date: Thu, 28 Nov 2024 16:19:39 +0800
Message-Id: <20241128081939.2216246-4-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128081939.2216246-1-tiwei.btw@antgroup.com>
References: <20241128081939.2216246-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241128_001954_953232_F30391D9 
X-CRM114-Status: UNSURE (   7.02  )
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

When calculating max_physmem, we've already factored in the space
used by iomem. We don't need to subtract it again.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/kernel/um_arch.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 62ddb865eb91..221cc89c9bec 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -376,9 +376,8 @@ int __init linux_main(int argc, char **argv, char **envp)
 	iomem_size = (iomem_size + PAGE_SIZE - 1) & PAGE_MASK;
 
 	max_physmem = TASK_SIZE - uml_physmem - iomem_size - MIN_VMALLOC;
-
-	if (physmem_size + iomem_size > max_physmem) {
-		physmem_size = max_physmem - iomem_size;
+	if (physmem_size > max_physmem) {
+		physmem_size = max_physmem;
 		os_info("Physical memory size shrunk to %llu bytes\n",
 			physmem_size);
 	}
-- 
2.34.1


