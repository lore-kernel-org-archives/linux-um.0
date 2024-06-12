Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19974C27C7B
	for <linux-um@archiver.kernel.org>; Wed, 12 Jun 2024 14:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d89DrUEs1kIDLyhtwQqJqL6IksFgShhaBWcU6xLTz3Q=; b=CBNnT8j8dWLmb8BAPGw5HkiJSo
	f6Ca3KYdLGeXUczS+SZYRhuwlRfhne98oEoLPvTNrKBKmmmForSR7DyzNHB6JiIDp+k2V2wncnUXi
	asesYEeM/sm8pRHFmo50DXAsxsYXaV+PLHN8/HKdpX2ZYLvpkPcRsrFvxGXgQ8XXAVgLKUGZfku0i
	dkOUv0qnxcgIpCmjx1EB8SBPyEbPzSN5p2NAohWkNYDBsRf0TameWE2vpXN69JYXKvvZZleVwMbEj
	zAi/WtdV9MPKUyt30hGWH/P4qnYFyyoScoQrnX/ANlD/dFZJj6e9lOPO3z01QJQR1/PCvjPlm2SPQ
	rnlhSNpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHOgn-0000000CtbD-2Z66;
	Wed, 12 Jun 2024 14:11:01 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHOgk-0000000CtYN-1s7i
	for linux-um@lists.infradead.org;
	Wed, 12 Jun 2024 14:10:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=d89DrUEs1kIDLyhtwQqJqL6IksFgShhaBWcU6xLTz3Q=;
	t=1718201458; x=1719411058; b=eVhFVDgYK95gdICLOJ5MyRxnWVOts5jcIA7ZBXH7hwetEBe
	CSATsD6z6IqqLKdY0jFRB/V5gdNxHWSG1Pe0TtawWnQWZvyu8JY4hC5VjBpZ2miFtBmqvD2grygK4
	p/RcRkrxz/ppGbV7Mp7TYAK/sTFl3GMQBHbTSqy0HJpAnmZPJXzUUhPNCx/fl0eO8CJntrmrEAd+z
	Tmh0YvJpuNT1wHYifkOSyJlsKCFw1zB7EOOnH9WjR3d3KE398CVQ/GrSl4GXT9APkARrNG80L55ZJ
	4LUPRpEhpff0VV0UoUKiEaNrAHfsHLxPjSPAQ3B9f/a+/e3zhpVrI+f58bDuf3vg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sHOgi-0000000AN5N-05Xj;
	Wed, 12 Jun 2024 16:10:56 +0200
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v3 1/5] um: Fix stub_start address calculation
Date: Wed, 12 Jun 2024 16:10:43 +0200
Message-ID: <20240612141047.1633303-2-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240612141047.1633303-1-benjamin@sipsolutions.net>
References: <20240612141047.1633303-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240612_071058_492537_E231763E 
X-CRM114-Status: UNSURE (   9.62  )
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
index e95f805e5004..0d8b1a73cd5b 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -331,7 +331,8 @@ int __init linux_main(int argc, char **argv)
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
2.45.1


