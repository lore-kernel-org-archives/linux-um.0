Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC744C4828F
	for <linux-um@archiver.kernel.org>; Fri,  2 Feb 2024 20:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6ibBvNWtj9I8biZ96CkFZ4v4tfreGCPhIbpTACz17i8=; b=DFzk33TuPcXdyTQCM3ZqadExSC
	stmLPNABa9V474oH9lrLidWsiRpj+mDEklmGsk5wMSgTUFyBinpKUmmbWkZhsDWHVouIjMZy1zG9p
	526LyloXl53NyiiMWZxY7VBbE8qVj3LKSx7G28o2fxBsfutcSuGr2NEfu6gknt7W8ODU9L1SCQTfw
	SHWRs9whiYtFo/Q1X04dDNYPg3ORcCB6Uo3NLlHVd4z7gP7pypScfxczFH9SSxJbc6UPksGt8ybLu
	DFxoulNa6DE453xHMc8Oids40LPzbEZdxnjvjiBRBCbfbSxX6RvqLkdPySUYkNWKPb8BBL71ulNhj
	YmH//zrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVziA-0000000DIdQ-3WH2;
	Fri, 02 Feb 2024 20:00:30 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVzgy-0000000DI3h-0bbE;
	Fri, 02 Feb 2024 19:59:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6684E62872;
	Fri,  2 Feb 2024 19:59:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A256FC43601;
	Fri,  2 Feb 2024 19:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706903955;
	bh=Ik7PysFz2Q/PQymMpEmnCsC39bu2MIXYeb1T3HpNV9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CKk7oRVPGb6C4HwkiFVL7iT8eK5Iik/EDFzYFOWPTWd77I5UUfPzNd7aKEoHobNdK
	 k6Iw7l3n0kK1QlfHNjMomlOOIirYwU1YpZobTyaCqSTvK63/LTQWC3U/94Wr+aCo1K
	 394zegdhvm14D9LJ9NsIivpUSTTgKA8VMQ+qda/ZZNZWNO9pqhQWXlJ356r8GK1dg/
	 Y9EE2/Xe7HhWLyB8r206UzMDMPWCWCqSs4f0n5ApmA9aFdeFK0zgM70sRYd1vQf03A
	 xHklCpZJB3PdHRb1/vDAF5/fzpbWmHhXlWWWVeSgi2bjCoLOEJCf9ZpZ0n4+cooxP7
	 oZE/QJs34kWsw==
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
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v3 5/7] arm64: Unconditionally call unflatten_device_tree()
Date: Fri,  2 Feb 2024 11:59:06 -0800
Message-ID: <20240202195909.3458162-6-sboyd@kernel.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240202195909.3458162-1-sboyd@kernel.org>
References: <20240202195909.3458162-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240202_115916_391906_463F37D5 
X-CRM114-Status: GOOD (  12.32  )
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
When ACPI is in use, unflatten_device_tree() ignores the
'initial_boot_params' pointer so the live DT on those systems won't be
whatever that's pointing to. Similarly, when kexec copies the DT data
the previous kernel to the new one on ACPI systems,
of_kexec_alloc_and_setup_fdt() will ignore the live DT (the empty root
one) and copy the 'initial_boot_params' data.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: <linux-arm-kernel@lists.infradead.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 arch/arm64/kernel/setup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 417a8a86b2db..ede3d59dabf0 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -351,8 +351,7 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
 	/* Parse the ACPI tables for possible boot-time configuration */
 	acpi_boot_table_init();
 
-	if (acpi_disabled)
-		unflatten_device_tree();
+	unflatten_device_tree();
 
 	bootmem_init();
 
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


