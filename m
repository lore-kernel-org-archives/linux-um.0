Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C77BFC3064D
	for <linux-um@archiver.kernel.org>; Wed, 26 Jun 2024 13:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PGV0TF73Zr4HuatEzBEnmuQaBBOhOg0TD/YF3Qd4OoA=; b=LXcXH6+rdR1DG9J/nROlo6zKcK
	S8o2OAaVqy68GtGvY1EDdGSRdEkXS9UY814fTwozO5VbrBG2I1wCD+vfH1yZvETe2CCLtX5cjXwZn
	lLMWucZGXgXBsFoonpbhh4gy11uD/tg5d+seElsFBCojIbCFWfS1mWPsa454Ydhs7C9riQTj+6GAP
	vkpZgxaRYncL8DMTEdn2BBl+H6iI8QAlP7+USj1TwTQkT4CyN3WWTZ5tkhTp0w/T3q0KiVaDRkSLz
	HVU6mp2x2q4pyrPrxFITYVacJxjG/iVfUyJ6cQbaPKCMnGTAjkuJUIwgnZAqmB6SNOHOHp+TgNYaj
	SAvsWCyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMT8C-000000074iS-1Miw;
	Wed, 26 Jun 2024 13:56:16 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMT84-000000074e6-1q7I
	for linux-um@lists.infradead.org;
	Wed, 26 Jun 2024 13:56:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=PGV0TF73Zr4HuatEzBEnmuQaBBOhOg0TD/YF3Qd4OoA=;
	t=1719410168; x=1720619768; b=XoIcqobgyrH8Oq784Tcwqmp79rztJb3wfK8h5KC66YQxKy6
	5EEIbSCQq+cwqgJzoKtKTCjfkZH4MAjzIj4BH1lYdPNfTIFxoLcmxYL07R5zlP2bSsWAJlLpJ35+0
	G+VSa+Ne6GVG2t8U2fYnevrJ+fFaHb4Xxy2/IOBAq4Ud1+TUhb7TuFZRM9WudBjDuG33eyHbpfNlF
	TZVB05IPpJYAGB7KVeqv3nT+WRIlTzdqbCXASSm8hJ/hawxIF1hwQgARXQYrOlmZP7bppUbpbwOBH
	VTjSZRoL1oWTB0jgA1B81y1szMYLV87M3LuftwEAHtkwxVJLF9dr5PD4LdBBMmxA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sMT82-00000003rXd-1Mc3;
	Wed, 26 Jun 2024 15:56:06 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v6 5/7] um: Limit TASK_SIZE to the addressable range
Date: Wed, 26 Jun 2024 15:53:48 +0200
Message-ID: <20240626135350.493110-6-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240626135350.493110-1-benjamin@sipsolutions.net>
References: <20240626135350.493110-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_065608_507441_3D1DC5C9 
X-CRM114-Status: GOOD (  10.01  )
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
address with a three-level pagetable. Guard against that by clipping the
maximum TASK_SIZE to the maximum addressable area.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/kernel/um_arch.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 0d8b1a73cd5b..5ab1a92b6bf7 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -337,11 +337,16 @@ int __init linux_main(int argc, char **argv)
 	stub_start -= PAGE_SIZE;
 	host_task_size = stub_start;
 
+	/* Limit TASK_SIZE to what is addressable by the page table */
+	task_size = host_task_size;
+	if (task_size > PTRS_PER_PGD * PGDIR_SIZE)
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
2.45.2


