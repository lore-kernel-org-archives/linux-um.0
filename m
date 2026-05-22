Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C02CD5BB4
	for <linux-um@archiver.kernel.org>; Fri, 22 May 2026 14:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oXIK+cBu6urjvTGhsBL+5S0tHUK0ISof8qCbA0I9wM0=; b=jy/+1kn6c6kIea1WUp3/ThKeRu
	/IBFjVbus6JfBoXrnU0Bjt45r3sdv9mxYUKOpS1QSCVSYf/hkK5MRElZYnYAQ7Uodh416IS/Lkg2i
	EJ3ZYdbsfJpdYlclHOkYyu+Q5Zy7QvAsGo81vWPG+MZP7yleHpWL3IGnKqigF/isnQAi9iZ/sM/C6
	ljVEI8FSfLuiO/HQ4JTY6Zq04dbVSxyYsQjk5BNZ5zfY15zFE8LV4n1nlbXaYr1MTaKk2CxGClOQy
	NeiFwEXc5dah6sBlsoXW+5Eag+CAkxSt4QLFs4kLhCiR9tZ1AYahwDwdqp4EL8u8YDcpz0/bKgamw
	Rm+UYfJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQQkB-0000000B78V-2NAP;
	Fri, 22 May 2026 14:20:55 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQQk8-0000000B77K-2Hcq
	for linux-um@lists.infradead.org;
	Fri, 22 May 2026 14:20:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 45C9C401B6;
	Fri, 22 May 2026 14:20:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FAC1F00A3D;
	Fri, 22 May 2026 14:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779459652;
	bh=oXIK+cBu6urjvTGhsBL+5S0tHUK0ISof8qCbA0I9wM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V7oxZJv+MZWhFVDAePYoRiHd0Y1Z2pxNTc0iupY1Lbc5/AT3qsmjUeCUdYSBuBC7N
	 Jsf3dRLSoaK3hrq2tjTAmQNsX7a1K2UHPDNG/pDNdrdAGbxfYCq3DDVqXLQiZjWZfh
	 mSiVR0ltKpAwJV1d+7VNThin5o+u+c6yvB9uD2dI+bd1xGwXhXQL9x+la6GZREgmtk
	 5KMvsoc+gfF+5Sa7Og/wYYtSeZVHiJIQNcsYMkw1S0sdLQV8N0ngW/p2NR2vuHy97q
	 M2l7UT8R3JtiSvwPxa45EgNhdLrDeN9ZMoED/CVnBLrqAsv7G7xHseP8nqMr9hCX67
	 H7u8j4b4IBAJQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Ingo Molnar <mingo@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: [PATCH 6/8] x86: require minimum 64 byte cache lines
Date: Fri, 22 May 2026 16:19:57 +0200
Message-Id: <20260522141959.1071595-7-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260522141959.1071595-1-arnd@kernel.org>
References: <20260522141959.1071595-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260522_072053_387831_B6E7B0F8 
X-CRM114-Status: GOOD (  11.89  )
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

From: Arnd Bergmann <arnd@arndb.de>

Later x86-32 CPUs like Pentium-M, K7 and Atom use 64 byte cache lines
and are incompatible with kernels built for smaller values of
X86_L1_CACHE_SHIFT.

Pentium-4 CPUs have 128 byte cache lines but are compatible with
cache operations that expect the lines to be 64 bytes.

Older CPUs have smaller cache lines of 16 or 32 bytes but work
correctly when X86_L1_CACHE_SHIFT is set to a larger value.

Remove the per-CPU tuning and always build for 64 or 128 byte
cache lines that work correctly in any CPU.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/Kconfig.cpu | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 65d887274dd8..4991b633047e 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -180,8 +180,8 @@ config MVIAC7
 	bool "VIA C7"
 	depends on X86_32
 	help
-	  Select this for a VIA C7.  Selecting this uses the correct cache
-	  shift and tells gcc to treat the CPU as a 686.
+	  Select this for a VIA C7.  Selecting this tells gcc to treat the
+	  CPU as a 686.
 
 config MATOM
 	bool "Intel Atom"
@@ -239,9 +239,7 @@ config X86_INTERNODE_CACHE_SHIFT
 config X86_L1_CACHE_SHIFT
 	int
 	default "7" if MPENTIUM4
-	default "6" if MK7 || MPENTIUMM || MATOM || MVIAC7 || X86_GENERIC || X86_64
-	default "4" if MGEODEGX1
-	default "5" if MCRUSOE || MEFFICEON || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || MVIAC3_2 || MGEODE_LX
+	default "6"
 
 config X86_F00F_BUG
 	def_bool y
-- 
2.39.5


