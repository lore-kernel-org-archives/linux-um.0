Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B143C87FD3
	for <linux-um@archiver.kernel.org>; Thu,  7 Aug 2025 02:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=N7DPBFQAufQxv6xrZOxkYWoWR64wqv6X35FvaO9S9Yg=; b=QU5L/srLFKOXbeZtYdoghv7Y+9
	2HNMOQfTczTvKkyGAJ9xzvNTFlToqNcbIqttX5EFc56sfifbgl9BXNN4Y9plqHFp79Se6cUGV240I
	k9ixfxvo1aK8i+d6GXMmLS7CDUDoeFvymO5l9ippH8XwTfqrzEoroJid26CY2Kus2nTDKnPgg3cTb
	9HUgjZbUJZltru8VgLvA3hkSvCtJ8wLCAVqyxRslqucntxSD6HDD10QbmXIDtLKiaIiR10YXOc/6V
	n1OhHtmV6AHtItl4l/mK1NDFEG/iJknFdFh18aiR5woFVoaeXtNh9DS4ZtJAG9ks5yjbkes7NLQm3
	FI9cmvbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujqQw-0000000H8JE-2usr;
	Thu, 07 Aug 2025 02:32:46 +0000
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujqQs-0000000H8Ib-49zr
	for linux-um@lists.infradead.org;
	Thu, 07 Aug 2025 02:32:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754533957; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=N7DPBFQAufQxv6xrZOxkYWoWR64wqv6X35FvaO9S9Yg=;
	b=aH6CHexdcR1OGlb1GbBw6n7OCm2+W3pqTH8hTu3VFDX+3Subt4bC21ElAvEOVsbjh+Kj0hpAQvvR1xGAiRDnsp4ukOGKdVCIy6A8noCZ/5US7rahdmHOgruMUFj7w7d1kE7CTEqqNzwhl7RM+V8lMbwK4hcruZX7i7C21GzPXR8=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WlCW3XV_1754533948 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 07 Aug 2025 10:32:34 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: richard@nod.at
Cc: anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] um: Use ARRAY_SIZE for array length
Date: Thu,  7 Aug 2025 10:32:27 +0800
Message-ID: <20250807023227.2443863-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250806_193243_542025_ED8993E5 
X-CRM114-Status: UNSURE (   7.58  )
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

Use of macro ARRAY_SIZE to calculate array size minimizes
the redundant code and improves code reusability.

./arch/um/kernel/skas/stub_exe.c:196:23-24: WARNING: Use ARRAY_SIZE.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=23410
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 arch/um/kernel/skas/stub_exe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/skas/stub_exe.c b/arch/um/kernel/skas/stub_exe.c
index cbafaa684e66..01a938a5bb4f 100644
--- a/arch/um/kernel/skas/stub_exe.c
+++ b/arch/um/kernel/skas/stub_exe.c
@@ -193,7 +193,7 @@ noinline static void real_init(void)
 			BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_ALLOW),
 		};
 		struct sock_fprog prog = {
-			.len = sizeof(filter) / sizeof(filter[0]),
+			.len = ARRAY_SIZE(filter),
 			.filter = filter,
 		};
 
-- 
2.43.5


