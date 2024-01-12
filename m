Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E46C4706C
	for <linux-um@archiver.kernel.org>; Fri, 12 Jan 2024 20:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CqOU6E/fmILrxzO1+PqTUQ2BhTLfjR8U6sXhToy/ht4=; b=2d8K0YlPXXbNS0+/iqndo45Xmf
	KYU3hpReX4ikGGddIbd2+zeRsV+R7Kbl9iGfl/9ymFKerZAf8FYYNXxvoAbSMs3HahoqQHK1S7eyT
	sP48gDsaObZmqZmr+LSYTQ2zG5au+utaDUG2KE4BCBMegT1pgzUACQRSLvOgyHf7ZvNvi16ASOEIJ
	3Xc4dTinAnFr0AndGbaO1vHPE92FhBEu5Sa/NarFZqsi1gqakuomulUA3QWuFcNdX8FoC2q1cjWIj
	DOIcPjydhgJpu+LMPF+cbamefRHoz+yV94qFojcWMyaiAYfouO/9P9q3P+V/As4Y7HRhFTqC1NKz0
	0/mVr3gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rONp2-003u3f-03;
	Fri, 12 Jan 2024 20:08:08 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rONos-003tsl-24;
	Fri, 12 Jan 2024 20:08:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id CE8ABCE2470;
	Fri, 12 Jan 2024 20:07:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6629AC43390;
	Fri, 12 Jan 2024 20:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705090072;
	bh=Ftr3BKZw8coGMgoBGEKihNEJ4LajJ+HPG/Va2fa5Q/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nGnzveG/zSlluWPqK50MsRXFZgcqSqsT+b/j0PKAXVP7ZtdQyKAg1m3guf/d+IBVA
	 07pgc33Sbuh8cKPwsn4TbkcS4oenSfh3ljankCMJg+3KSR3xYKkq/FmivEMPbadwki
	 Gnq+l6slqsgHmDwxM4NPuJLHDFpi9gubCjnjUfdn8Sxy8LDYoDjOakf6QcAqDVrAdr
	 MDEBQQjx5CgxrWGB2llxj/Yj47M6+dU6XpmzgIP+dv/eye+gmUbhi9gVZJmKU4tJND
	 6j9+++zKYkaAyoMnCs8uOcZrzTy3AjyU8ipiPD0bw/T6SgAUz0oA+ED7fSzqWiE2Uf
	 xFRtahWLY3/DA==
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
	Will Deacon <will@kernel.org>
Subject: [PATCH 1/6] arm64: Unconditionally call unflatten_device_tree()
Date: Fri, 12 Jan 2024 12:07:44 -0800
Message-ID: <20240112200750.4062441-2-sboyd@kernel.org>
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
In-Reply-To: <20240112200750.4062441-1-sboyd@kernel.org>
References: <20240112200750.4062441-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240112_120758_874450_CC038352 
X-CRM114-Status: GOOD (  10.23  )
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
There's no harm in calling unflatten_device_tree() unconditionally. If
there isn't a valid initial_boot_params dtb then unflatten_device_tree()
returns early.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
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


