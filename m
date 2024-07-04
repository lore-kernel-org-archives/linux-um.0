Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4593C3814E
	for <linux-um@archiver.kernel.org>; Thu,  4 Jul 2024 19:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vjQoz/5CTFM/VYY0zOeSPbxeRzdNCA+DsDOOxwBCxy4=; b=Wdn2Fphx72gDCmW+G+U1NdR8VE
	UUcIso8g4G7F5ZtXO3UMbDTk3cJUIavFrbOXlnUbfR/fpW6N0rbYkdOSziksf5Wtv/LvRg5/QVy07
	ep9NNj829pu10E9DwI1Nbyv8MhDY1hEgPbHXL0LN2AUJ81jruRy1Ao8Ndc7idMd4KUn2e+IJA7lv4
	fRCy/QOLluFOSg4PPDZKjPCWgH0LcpBW+rHqgvXn4/pNV47/tXU4+jsL0IUd1S719CHe4MlwdkQTg
	HugNhqr3WZ6w/I0c3oVsCCrWLnQ3ChJZ9z5tIjHBf0iAv8vV4yeSDCwE3A0vNRVa7AYtmqwjnwRUh
	A+Incj5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPRlg-0000000EEF5-1wKa;
	Thu, 04 Jul 2024 19:05:20 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPRle-0000000EEDR-1ohP
	for linux-um@lists.infradead.org;
	Thu, 04 Jul 2024 19:05:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=vjQoz/5CTFM/VYY0zOeSPbxeRzdNCA+DsDOOxwBCxy4=;
	t=1720119918; x=1721329518; b=Wf28twNRqVMbxg93Kqso9p2zviVqNX0G+nkQlxouuGaQ7kB
	Q3TLD9nGdpzhznVS9ywR6yKH4TC4quRBQE7lvEeA4PlabhaP11odqKDLKEB45oHsun+CDSFgv30U3
	zD7ynpI6WT0GBPpIBS+2D7oyqIEM7np+SB5wfb4eFGiUV71qSjsbpKtfWwqqpLYFDMN+k1pV58q6a
	QfxShTI92xgKORnLiwMTaZGR8GeJgRdGcDr3D/3w4s1iy95ng0ROhpgwYMas5M2rSsYkEWwmDrigO
	JHn0qzYSJuKOyoKA/8PaR5EV7ZKHPb+HDJ0JD4vSuV6CyC7SaejOkp632wgpR3Nw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sPRlb-0000000DrZs-3TxW;
	Thu, 04 Jul 2024 21:05:16 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v8 3/7] um: Fix stub_start address calculation
Date: Thu,  4 Jul 2024 21:05:02 +0200
Message-ID: <20240704190506.1438493-4-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704190506.1438493-1-benjamin@sipsolutions.net>
References: <20240704190506.1438493-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240704_120518_480175_6A0C747A 
X-CRM114-Status: UNSURE (   9.42  )
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


