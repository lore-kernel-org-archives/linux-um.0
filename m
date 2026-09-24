Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47675C98310
	for <linux-um@archiver.kernel.org>; Thu, 24 Sep 2026 06:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=21jpBxmvuQ92CO8E8Zg7rELSGSLKN9AW+6p0kf6nq1U=; b=1FbuDQr9hmsOClTbU5d873JFT7
	HBSEpEB3Sy9xto3sWjOEL2CZWu84mA87S1aBs4RPW8mEbJMkJ0Z8PpiOjelUEttD+ZVWPmOzP3cSc
	I66j0i/c/DDosA6RzThMZlTz5luyPJ9Uhj99k7EhYebFZTTFlDkDrm1UzV7Ni0Z5LmgTVgY548waQ
	C1U6XW28Loayygp3fl75IzYgY0nlc0IX4JKod4pQ5k3wmmJfBYdkiG8POfjzofXGL+EKKEIw9qYQ6
	VXRII4EqzOkV/EfuLYxLGbMQSt0XoYSb7auSU2N0gumU10Ktmw8n8YqdM778+O2/H6MMoqtjFRvRy
	x3SJJ+tA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9dHW-0000000ABZ2-428y;
	Thu, 24 Sep 2026 06:50:10 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9dHU-0000000ABXQ-2HpS
	for linux-um@lists.infradead.org;
	Thu, 24 Sep 2026 06:50:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=21jpBxmvuQ92CO8E8Zg7rELSGSLKN9AW+6p0kf6nq1U=; t=1790232608; x=1791442208; 
	b=LHn459pkASBqIa4WtKC1AKbNaCDj3nhWP1hAWE9783j+jT3kkKN+xYQH1JT8wuZcYQZhBkHlro7
	hB13ghuOW6+6EUErU0SlZS+vpimJH9NM+6taNtL/i1T2KenoLJmuDkXZBM+8vXc5/B50dfhz3qyKM
	zrPtRvactcd9iG/PedfHOZVwUxT0GHC2dgcPyKGU0L+8VKUNgUFw4Jqyym+w95brtzPG9wiayuje6
	eWiGqeMavu5bxQ252h67F1/oZxrCd0w7WOaB8FZOn4IbYnjWI3RhZIoJx5fhepJueE8y8o7fRFF0c
	t4MRBnGnTubVom0Nd9sbZN+xXhckdwrZP3Ag==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1x9dHQ-00000008t1V-2KYe;
	Thu, 24 Sep 2026 08:50:04 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] um: use %pB to print functions in stack traces
Date: Thu, 24 Sep 2026 08:50:01 +0200
Message-ID: <20260924085002.3ff9ca1de60a.I5ff299b6f3196ad3c51c3032a90c7158c1bbccda@changeid>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260923_235008_642718_0BCB6898 
X-CRM114-Status: GOOD (  11.62  )
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

From: Johannes Berg <johannes.berg@intel.com>

In a stack trace we get the return address, so if the call is at
the end of a function, it can get printed as the next function,
e.g.

  vpanic+0x1d3/0x435
  abort+0x0/0x4e
  do_exit+0x29c/0xcb7
  sys_exit_group+0x0/0x16
  pid_child_should_wake+0x0/0x83

Use %pB like on x86, which resolves the name with address - 1,
in the same example I get:

  vpanic+0x1d3/0x435
  panic+0x55/0x55
  do_exit+0x29c/0xcb7
  do_group_exit+0xbe/0xbe
  sys_exit_group+0x16/0x16

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/kernel/sysrq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/sysrq.c b/arch/um/kernel/sysrq.c
index 13ee5666668d..5a2c28e09294 100644
--- a/arch/um/kernel/sysrq.c
+++ b/arch/um/kernel/sysrq.c
@@ -18,7 +18,7 @@ static void _print_addr(void *data, unsigned long address, int reliable)
 {
 	const char *loglvl = data;
 
-	printk("%s [<%08lx>] %s%pS\n", loglvl, address, reliable ? "" : "? ",
+	printk("%s [<%08lx>] %s%pB\n", loglvl, address, reliable ? "" : "? ",
 		(void *)address);
 }
 
-- 
2.55.0


