Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6F8CDD552
	for <linux-um@archiver.kernel.org>; Thu, 19 Sep 2024 12:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e8scBRWWo9W08vUFhaDXyigBOzLsHUQdgMahMtblGa8=; b=LG1+ZJnM6BWo7/EHTN1VWFqa1i
	d+R2BokwxXskU1gxbl1EQ1qAcY6CEOcE4TaYBcdf/w7C0YvHONe1HjTl7sDo4JguBgpQNnUBMq72W
	Z3i2oTVQ5bA+o2q4B+x2S6nkjgjMJ3JOYbM45UtQFLGL55hEdmwDb0kFoWUfM2aau32/Vb1ckHOqy
	gBq+3kc1fugWj/U7kp/7+2EjFRpjV1uRnI3O6CPko90WGjX2G4udobsgxEQoC12qj0xLRmYUJjZlf
	4Ud1KZYJQuvXTHr19z+AFNS3gHxg9uPAkgHx6leSTXGc+G2ymFhlMVxQyWk62kgylHocF4kENY7bQ
	5YYKVHrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1srGXe-0000000AGtw-1srP;
	Thu, 19 Sep 2024 12:45:50 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1srGXb-0000000AGrf-20la
	for linux-um@lists.infradead.org;
	Thu, 19 Sep 2024 12:45:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=e8scBRWWo9W08vUFhaDXyigBOzLsHUQdgMahMtblGa8=;
	t=1726749947; x=1727959547; b=AzfyrYd3GrBYL+fdMQdTxYTDN0XBvnSF80efF2bAsNrXDrH
	OxMt8hlwviEGcDP7/HngUALDhs418P70pfvKbia2QA+Btl7rh7v070QW2iGRN7pF+VkY15CJYc5vf
	NQTAD7vV8QyhGJY4xngVSTEnaMvE84CN4uk2xVvtI564hfZI800oOqu6s5JlMOlLzvavY7fkK4GAK
	EfzHU+6mJ25gLakWv/eEtRixodWV2W1FLJbLNTn9CgAfg++c9TpdXhZkj6TmpjFnR0BgBsdkbZRkK
	C4zypnqRHHDBWYmXcRjURsLqAijrMY4eHfw0C3yOkrrQoHQ6hatz2EbtsdgFztxQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1srGXZ-000000047AZ-0mvO;
	Thu, 19 Sep 2024 14:45:45 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v9 07/10] um: Limit TASK_SIZE to the addressable range
Date: Thu, 19 Sep 2024 14:45:08 +0200
Message-ID: <20240919124511.282088-8-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240919124511.282088-1-benjamin@sipsolutions.net>
References: <20240919124511.282088-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240919_054547_622020_A93E03DD 
X-CRM114-Status: GOOD (  11.11  )
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

We may have a TASK_SIZE from the host that is bigger than UML is able to
address with a three-level pagetable on 64-bit. Guard against that by
clipping the maximum TASK_SIZE to the maximum addressable area.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

---

v9: This patch is technically not needed anymore, but does not hurt
v7: Fix integer overflow on 32 bit with 3-level page tables
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/kernel/um_arch.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 44589cbd4174..6f0bedbf048a 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -331,11 +331,16 @@ int __init linux_main(int argc, char **argv)
 	stub_start -= PAGE_SIZE;
 	host_task_size = stub_start;
 
+	/* Limit TASK_SIZE to what is addressable by the page table */
+	task_size = host_task_size;
+	if (task_size > (unsigned long long) PTRS_PER_PGD * PGDIR_SIZE)
+		task_size = PTRS_PER_PGD * PGDIR_SIZE;
+
 	/*
 	 * TASK_SIZE needs to be PGDIR_SIZE aligned or else exit_mmap craps
 	 * out
 	 */
-	task_size = host_task_size & PGDIR_MASK;
+	task_size = task_size & PGDIR_MASK;
 
 	/* OS sanity checks that need to happen before the kernel runs */
 	os_early_checks();
-- 
2.46.0


