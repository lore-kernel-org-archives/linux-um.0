Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51254C46CD2
	for <linux-um@archiver.kernel.org>; Wed, 24 Jan 2024 14:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hcEpubtZD195rJh870/SKXWMskGL2zWUxNuiYBoGc5Y=; b=s+B/wWzy9RvONyBEvcx/TO7+g9
	COGa8yW1BE75hPFKiiEZE7/+Rb1hULtidvKwfl0i+7OY1KP+MR4DQG0joED9Cr7na4Jjx4DEHMCpj
	SnnqHbMqKbplHkJlkBBKAkv677P2bwMxS1K/CNt4UcK6DNF+q9qRBjVl6nZv6mwGUAbvbWhGo0wUx
	JaB6gkNmnbeIAe//6T1H8kgOu0fqhhW6+UJp7ALSi7h8tCoFrg0IVzaWV7tj2EGJrvP54wYGgS39h
	UE6OBNvd1dsxQg/f44J9c1BQl54erUOzOWa75uXBqZk7AfESSYp09SWkH5CU0hvQXO9R2K4YE63xG
	AKDpoYiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSeHy-003gkr-2Y;
	Wed, 24 Jan 2024 14:31:38 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSeHv-003giT-2S
	for linux-um@lists.infradead.org;
	Wed, 24 Jan 2024 14:31:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0602B61D74;
	Wed, 24 Jan 2024 14:31:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5024C433C7;
	Wed, 24 Jan 2024 14:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706106694;
	bh=mHvd9apj8BXG3CS5HPvF6zxU8m5QNDA90dsY+iDv3zY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RUsB3vPQ+K4OeuLIeE/zO/FpDe8K23/9M/krX34+3iDzSG+Qt4HEgmMC6Yo/UfhxU
	 fXhtir6ovFp03QnXHQgRl3jqhOo2hwxgc1qWJo3uOqQLTQNBmYO4Cn2lIZh9qghA0Q
	 fB1Wb/D+F4gNq9Ub/qZgVc4Xc7/ICczb6s/GYLI+xWhmDuleCf5qsjWYwUFtU3hhv+
	 CCcKrLvj6SX9M42qtNt2lcrkm25qgfVqhLCle3vBmQa7OqsGzLTMzp1tVwvZdt4ZG1
	 goq2QUmHZNQuyux2XPWGIr38FfBJFBR3jW6ibj2Z6cQ5TbNYE8aYSoVY+7GP2bkgcY
	 4zdbl0jFW0rrA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>,
	Richard Weinberger <richard@nod.at>,
	Sasha Levin <sashal@kernel.org>,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 3/6] um: Don't use vfprintf() for os_info()
Date: Wed, 24 Jan 2024 09:31:12 -0500
Message-ID: <20240124143124.1284462-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124143124.1284462-1-sashal@kernel.org>
References: <20240124143124.1284462-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_063135_896433_BB991DA4 
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
index ecf2f390fad2..b76ac4df5da5 100644
--- a/arch/um/os-Linux/util.c
+++ b/arch/um/os-Linux/util.c
@@ -166,23 +166,38 @@ __uml_setup("quiet", quiet_cmd_param,
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


