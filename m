Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 051BEC47422
	for <linux-um@archiver.kernel.org>; Wed, 24 Jan 2024 14:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JEKMUnlVXClGT3m4fsCwsO03hA6baqrwiOcNBeXmKKs=; b=KV0p9HLh7Jsi1LR6avuVZJJATf
	ZAnuH+gFHgiU1KT2X8Ro0U1zE2Tr2Yt9XCN+HRUsiiY6ghYlGb5EYSslRUmu86Wm0kuJV+VMoT+MU
	qIQVPZQcDHawBhvrfWAqlLhrJ24i9bDv/rS3Td+Z1Yw+67ZxydRwFcmiMdpO1N9lYXMwfOeyY8eul
	Apha3OXASJTEHvqNLgjSn1PWSc0FusFz9UAeM/8xdNIm9tLpjUZ0agya0KD957vxCY0nWf8cO5XXt
	0wIdO0FGdrmW8jmusvbX0vKkjaX45SQwGQ9adCIrqpULYa+go6Oav7sAwlrEUgFjbdgCNNhc3chdQ
	JeLy6RwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSeGR-003fze-1X;
	Wed, 24 Jan 2024 14:30:03 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSeGO-003fxt-2W
	for linux-um@lists.infradead.org;
	Wed, 24 Jan 2024 14:30:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4D9D161D5F;
	Wed, 24 Jan 2024 14:30:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE74CC43394;
	Wed, 24 Jan 2024 14:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706106600;
	bh=+qlLwOJdjpq6kAvTrgjUE93HI6aqQtx2W3k1oDhQX4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EBZmWUOWcgC74I7XjMyzWkgj6fiDrY8Dvg8zArIIQELw0esESOdGnW7geQWyq+689
	 cuKREQV7dm/uY+VaCB0cXUx3NVG/iOECLGFuYli+8V+v0JyER4GHToAa9UMq8bg6a5
	 XkndqnjYWihrlIzJtHWAU55+kktknydf3ujqFfcutKv+7S1l/d1iLIzXIwoLyDVH8V
	 x3gsx6iDCtKyvaFShcfcv5CIlS/vzSm+ffenykCTwydSKMqs3aE4ksr2Boh6+ZNa95
	 t3mxyMekII9XUJyEslfjmITHBP29b3ydGUt9ioe73/a0HL/0jyZopxkHrTJSp802OJ
	 hhZlXQgyFk1hQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>,
	Richard Weinberger <richard@nod.at>,
	Sasha Levin <sashal@kernel.org>,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 3/9] um: Don't use vfprintf() for os_info()
Date: Wed, 24 Jan 2024 09:29:33 -0500
Message-ID: <20240124142949.1283818-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124142949.1283818-1-sashal@kernel.org>
References: <20240124142949.1283818-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.74
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_063000_861810_679AEB43 
X-CRM114-Status: GOOD (  11.50  )
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

From: Benjamin Berg <benjamin@sipsolutions.net>

[ Upstream commit 236f9fe39b02c15fa5530b53e9cca48354394389 ]

The threads allocated inside the kernel have only a single page of
stack. Unfortunately, the vfprintf function in standard glibc may use
too much stack-space, overflowing it.

To make os_info safe to be used by helper threads, use the kernel
vscnprintf function into a smallish buffer and write out the information
to stderr.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/os-Linux/util.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/um/os-Linux/util.c b/arch/um/os-Linux/util.c
index fc0f2a9dee5a..1dca4ffbd572 100644
--- a/arch/um/os-Linux/util.c
+++ b/arch/um/os-Linux/util.c
@@ -173,23 +173,38 @@ __uml_setup("quiet", quiet_cmd_param,
 "quiet\n"
 "    Turns off information messages during boot.\n\n");
 
+/*
+ * The os_info/os_warn functions will be called by helper threads. These
+ * have a very limited stack size and using the libc formatting functions
+ * may overflow the stack.
+ * So pull in the kernel vscnprintf and use that instead with a fixed
+ * on-stack buffer.
+ */
+int vscnprintf(char *buf, size_t size, const char *fmt, va_list args);
+
 void os_info(const char *fmt, ...)
 {
+	char buf[256];
 	va_list list;
+	int len;
 
 	if (quiet_info)
 		return;
 
 	va_start(list, fmt);
-	vfprintf(stderr, fmt, list);
+	len = vscnprintf(buf, sizeof(buf), fmt, list);
+	fwrite(buf, len, 1, stderr);
 	va_end(list);
 }
 
 void os_warn(const char *fmt, ...)
 {
+	char buf[256];
 	va_list list;
+	int len;
 
 	va_start(list, fmt);
-	vfprintf(stderr, fmt, list);
+	len = vscnprintf(buf, sizeof(buf), fmt, list);
+	fwrite(buf, len, 1, stderr);
 	va_end(list);
 }
-- 
2.43.0


