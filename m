Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF10C3DA40
	for <linux-um@archiver.kernel.org>; Thu,  4 Jul 2024 16:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vjQoz/5CTFM/VYY0zOeSPbxeRzdNCA+DsDOOxwBCxy4=; b=dZstaRxehZ0wUpeTnhBQe9D60t
	B2n27c8o5/FCPSTefjID/hg0z78QRMRsojpQrVCh8L1ufdCyOkS9Abvi+FLWJe19iD8ji72AM4Dad
	WejaoBi0tRaL8/GCEKi0QkBimdzIZUiBcjUc+6eDo7mfLQ95N5JYR/FPp9pb+fDsG9pxDctujysRV
	zD9MHph55eD/dEImKlQTv7IGYBbOSpRZm09TAKb7T4RyawMwsBXHeYIezLeaYoKmKkJsj5o8Rn9Q/
	cvKNjZPjCIpe5AurDpwM+PyznxmCgUF3tvJ+YiEKVkxmZfEv1GZ3OCMjGAooPqydCbtP1cHbwsm20
	8KMR344Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPPJH-0000000DqGl-30N3;
	Thu, 04 Jul 2024 16:27:51 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPPJF-0000000DqEr-2Naf
	for linux-um@lists.infradead.org;
	Thu, 04 Jul 2024 16:27:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=vjQoz/5CTFM/VYY0zOeSPbxeRzdNCA+DsDOOxwBCxy4=;
	t=1720110469; x=1721320069; b=k7PCn8UmWpg09NwZOxtlYwupwORf+JclG+K3iTaC2ghTxoY
	QporXxWtaDQI/mIwIisfq8nnZzHqiFaWXvHjOU+SECJZhryyAnZOCjTvIrTHzAOfgvuQ+5E32aJtc
	V+OfSZdNLmAlF14K+to/6z4BVjTc67B0wiVuam+gJnM5xZ37dNdAXfAORNotS1nORlQi7A1f4ORWo
	3+lXVdEK9UR3VYd3bouL0sZ47NPRsvT0xQyvJTcbLZwRkMFgOP+1gT5/kMIsYZUPoH77la2tLNfxp
	AashoXUibjfqu8tuafUm/nIUmSpdTrtH5FG2sCHnWGknT/ii4N2qaSCt6b1rIDpg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sPPJC-0000000DOu8-2ksy;
	Thu, 04 Jul 2024 18:27:47 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v7 3/7] um: Fix stub_start address calculation
Date: Thu,  4 Jul 2024 18:27:13 +0200
Message-ID: <20240704162717.1417338-4-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704162717.1417338-1-benjamin@sipsolutions.net>
References: <20240704162717.1417338-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240704_092749_635723_BE6D76E0 
X-CRM114-Status: UNSURE (   9.43  )
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

From: Benjamin Berg <benjamin.berg@intel.com>

The calculation was wrong as it only subtracted one and then rounded
down for alignment. However, this is incorrect if host_task_size is not
already aligned.

This probably worked fine because on 64 bit the host_task_size is bigger
than returned by os_get_top_address.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/kernel/um_arch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 8e594cda6d77..25cd2c6d7e95 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -328,7 +328,8 @@ int __init linux_main(int argc, char **argv)
 	/* reserve a few pages for the stubs (taking care of data alignment) */
 	/* align the data portion */
 	BUILD_BUG_ON(!is_power_of_2(STUB_DATA_PAGES));
-	stub_start = (host_task_size - 1) & ~(STUB_DATA_PAGES * PAGE_SIZE - 1);
+	stub_start = (host_task_size - STUB_DATA_PAGES * PAGE_SIZE) &
+		     ~(STUB_DATA_PAGES * PAGE_SIZE - 1);
 	/* another page for the code portion */
 	stub_start -= PAGE_SIZE;
 	host_task_size = stub_start;
-- 
2.45.2


