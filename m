Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70DC0C47DDF
	for <linux-um@archiver.kernel.org>; Tue, 30 Jan 2024 00:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vpjgLxIwtNZ6dYdnrby39x6x+nBi40eSONvJZRhoq/8=; b=aqcUlQoDzxata5rxb8PXeCtzHO
	BKJKqwzfMVdsecMSABUOoh9VA4q8WLZ9vBrJKVSyIpIn1ti3iIAvaqZ8c+tBx2Oj6jiClQn7bCrF1
	ki/13Zkqn83xHIyrAblTdPk4Nt2ngj+fAG5bOSoMy14O9TBb26mASaOEfIbBnKhj1A//Imn3VZ3i4
	U5C6sYcAbwfsS7+pT+EmOaS+semkz7ljOXs4y3AavQOBxewz3e/iBy90+vxkVhb1zq+7y2WmOlWj2
	06mw7yxlmIItmO7uX90ItovNDxmKr0l8zME2BRQHOkzqLLbHvbPVH9TTK63SqPkNAC07W3sTKZXrE
	a0S28Onw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUcG3-0000000Ejk8-0QyM;
	Tue, 30 Jan 2024 00:45:47 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUcFX-0000000EjOo-0Cyr;
	Tue, 30 Jan 2024 00:45:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 5583ACE170E;
	Tue, 30 Jan 2024 00:45:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430F2C4166C;
	Tue, 30 Jan 2024 00:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706575513;
	bh=RoHfW0J4DhoHi6CIUbHFtKoJEfAKysJC1Fo3xRXVigg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qAgYYRtbWJ5viR41vOf0Q8IcMgBCtlOzDpcv/45U9U4fYJYMSujLD6JfR2osY9ATY
	 4bStYc/TK7bqQzxeqWCsW9bvUgnTTtJJ8FKM0Kme5fVfrFfuPG6NDEZ8G+M9fe+crH
	 9ByGZOm401zpjqEGrrIHWvkq3Y6jn2TnJD6D7vJtCKzLG5iUGLZNqtGPq5D9/aESld
	 EK4qSV4IXVc7i2yKDT4qA/2Ji5egQXFQIAAjoVgxvqb3Gqfsyw5YbBpJn7iyNgtMCd
	 qBIGYbb+stxyLQrNEHZ+Z413GV36NRwX4SrxjuMtQxugmXLfho8V3HuuGCNZNsblTL
	 vBQ1Ri0YWWNSg==
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
Subject: [PATCH v2 3/7] x86/of: Unconditionally call unflatten_and_copy_device_tree()
Date: Mon, 29 Jan 2024 16:45:02 -0800
Message-ID: <20240130004508.1700335-4-sboyd@kernel.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240130004508.1700335-1-sboyd@kernel.org>
References: <20240130004508.1700335-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_164515_322722_7902AACF 
X-CRM114-Status: GOOD (  12.41  )
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

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: <x86@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>
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


