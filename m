Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 223A8C48BF5
	for <linux-um@archiver.kernel.org>; Sat, 17 Feb 2024 01:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YWxi4pmLeontrS8EkVTzHt4J8Of/kxPfQuPQpS8fPKQ=; b=Y7ro6VwC2UDtaSbGkDwUkQULtW
	EzxhLcyHXib0pKVKdAXoIvkAGFdJmM2G8HWlBHmcNqnTDGD5ekWALDolo2D4Meub88JyJxR9E/aL8
	UmwtiSBf2g5pZBjT8LGt0YiwfCDswUXVn8BMeb4QllNFPnOPm6mGcM3ApOh8F74JgzFHS2zcgP06c
	9VNFLAXM8DsLKj/CGgJm5cGPkg4UkaIw6n828k7rsmVBF53Eui4nqCrCzuv9kOOdIVSE5UGwNQeNR
	IaSUbGh7kK3AQBvW1aQZwDqHu+ts1BYBHcpmnxsrGWP9rtHBoXJwaCYZErn1XJZ7oA6/Y+5YHY3qX
	u2xIB81w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rb99r-00000004Lvx-25Sj;
	Sat, 17 Feb 2024 01:06:23 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rb99W-00000004Lhg-2RMt;
	Sat, 17 Feb 2024 01:06:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id DA08361E68;
	Sat, 17 Feb 2024 01:06:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5C5C433C7;
	Sat, 17 Feb 2024 01:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708131961;
	bh=cR6lBuTsNe2p1GQlv5k9m41XDe+JPSu/qcoX4YFfeKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OLeOAuh9JcnWjMkP28AX6Wosr7CaT8IJDTe++OAPlHmV45oUdqI2baYVKvuONQLRM
	 REHahxweGolZgJoq4cIcJM609d280RUEZ6QOylnu7b84K0JrmRW4grtFnLrDKr7DHm
	 od2AR/PNbdj2WdEHoiw6v8AipspdwQHYwREzjurg2ModO/udqB4MN4PvqStRsntvhO
	 wln6USBTGOZIWd5lhk/LBgFW7h/6nkbg9ak53wpgvk1GtkpGxA34gf8jlkqNrtppj+
	 JGioc/KE+Kekqcl6YX6Z2urk1MRDsmJJzTSr56lOvTWTsRk1loY1rrmLedb/9jx56h
	 wnp6VBWh8/MAQ==
From: Stephen Boyd <sboyd@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	linux-um@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	devicetree@vger.kernel.org,
	Frank Rowand <frowand.list@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: [PATCH v4 4/7] x86/of: Unconditionally call unflatten_and_copy_device_tree()
Date: Fri, 16 Feb 2024 17:05:53 -0800
Message-ID: <20240217010557.2381548-5-sboyd@kernel.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240217010557.2381548-1-sboyd@kernel.org>
References: <20240217010557.2381548-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240216_170602_748955_5076B400 
X-CRM114-Status: GOOD (  12.36  )
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

Call this function unconditionally so that we can populate an empty DTB
on platforms that don't boot with a firmware provided or builtin DTB.
There's no harm in calling unflatten_device_tree() unconditionally here.
If there isn't a non-NULL 'initial_boot_params' pointer then
unflatten_device_tree() returns early.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: <x86@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Tested-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 arch/x86/kernel/devicetree.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index afd09924094e..650752d112a6 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -283,22 +283,24 @@ void __init x86_flattree_get_config(void)
 	u32 size, map_len;
 	void *dt;
 
-	if (!initial_dtb)
-		return;
+	if (initial_dtb) {
+		map_len = max(PAGE_SIZE - (initial_dtb & ~PAGE_MASK), (u64)128);
 
-	map_len = max(PAGE_SIZE - (initial_dtb & ~PAGE_MASK), (u64)128);
+		dt = early_memremap(initial_dtb, map_len);
+		size = fdt_totalsize(dt);
+		if (map_len < size) {
+			early_memunmap(dt, map_len);
+			dt = early_memremap(initial_dtb, size);
+			map_len = size;
+		}
 
-	dt = early_memremap(initial_dtb, map_len);
-	size = fdt_totalsize(dt);
-	if (map_len < size) {
-		early_memunmap(dt, map_len);
-		dt = early_memremap(initial_dtb, size);
-		map_len = size;
+		early_init_dt_verify(dt);
 	}
 
-	early_init_dt_verify(dt);
 	unflatten_and_copy_device_tree();
-	early_memunmap(dt, map_len);
+
+	if (initial_dtb)
+		early_memunmap(dt, map_len);
 }
 #endif
 
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


