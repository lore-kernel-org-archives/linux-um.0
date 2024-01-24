Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF3EC47422
	for <linux-um@archiver.kernel.org>; Wed, 24 Jan 2024 14:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T4gVxcatPxx7jdeNBc81vfYzbbeDzY0Cnyi83FRPymA=; b=TpWFGjOQKX7NUPB/w+Bi/JaJNy
	gErknHWV+5MKAgmHEg9dy3DWUYXdx0UVWsSxec6TqoGiV3uV0ybrHGU44sEEbQYa4Wzg03n6ysAr3
	9YuhwSEUzHCnjlkDW6Opy7UJ5eMYnk0GQlguqNORDiDtN7wQDDsJfYt0GwDfbWugNtNRivS7k5Hbk
	fzUUpxWgPPoB650nZg61lwtispvO5fknr85xgxLvL36++Ks/LL1v8MZs0G5CsZSHQ4o8jdFlkHiJV
	Ux/F+rZwCh1LDY9UrhN5dnBiRtUbprONoFVUee6+55hLFGS2+TDzSn0LEhnxWd54reLu5RY20Desp
	WfljF3vQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSeHW-003gWz-2q;
	Wed, 24 Jan 2024 14:31:10 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSeHU-003gVT-0X
	for linux-um@lists.infradead.org;
	Wed, 24 Jan 2024 14:31:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id AF0FA61D73;
	Wed, 24 Jan 2024 14:31:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A057C433F1;
	Wed, 24 Jan 2024 14:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706106667;
	bh=/98Awh1CB37Jj8VC10X0uE1E820OU/1QxbbiYEcjqBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=azZ1dkw5CsaQqrKymBGPILUKjzPdMKCD30u7C3lJUgNH+6F00FoKiaPKmu2n8ah/4
	 3RS56RPGXTG0qFMk+38NSge8XOqe7tAyxK73Fd8jGPS8zdxkDhwSwHQg51AW3ubyXO
	 DXr0HaL5KbM+0R/+uqZH06cD8J592EmK1TS4rgDkSidsGPhyeOEy8vgNDygYuolNKk
	 F2bHCWiSK3d0TUVtILztH/OtAsuFVOCqBLS2c7dVCBqVhLQBQh0n/GiqvPKTigBISf
	 wcuIGObhD0o9Uf/PGTv90+67qB/cyokzkWvAXaLjA3v/827nnxsctywzRdfRZ0hl8l
	 2BEYUp2InH6iQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>,
	Richard Weinberger <richard@nod.at>,
	Sasha Levin <sashal@kernel.org>,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 3/7] um: Don't use vfprintf() for os_info()
Date: Wed, 24 Jan 2024 09:30:44 -0500
Message-ID: <20240124143057.1284274-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124143057.1284274-1-sashal@kernel.org>
References: <20240124143057.1284274-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_063108_247427_07543381 
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
index 07327425d06e..56d9589e1cd1 100644
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


