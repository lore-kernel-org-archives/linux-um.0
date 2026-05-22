Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 543B5CD5BB0
	for <linux-um@archiver.kernel.org>; Fri, 22 May 2026 14:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KMOg+jIFzKoR+MDQSP+sdqbBfrIpOv5CDMN5EJGNh5c=; b=DbbMJ6PlR4hm7bYk+JKMqJdsxb
	68hprfN2QtGZc7YUTPwRf9xfbuAZShoWjB/ChT9SoTA4mP/TayziyJU6jaSqtuk71QFKlFKE66vMC
	GPTmGPh7TuWQjzgMtcx32E4BR9M3gErCafzs6jYl64YjAWCarzYP0D5mOxLNQ3p7ZWbKRE4QELL9+
	zYBtz0b9nroi2t3r6dEIFVfpth6U5I78p798g5xeOZ3KMa4kLhQV49NnifR9V8ca8QlK8GZfWXmyO
	GvIrcgapQnZCR25obvFUt41xIRFAdYrLK/zu7ehsQMWY7vMAG3v6HBjkGp//pG5uy7nCf81Q/0Dha
	5gtc2Nsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQQjs-0000000B6zk-07QY;
	Fri, 22 May 2026 14:20:36 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQQjq-0000000B6zC-1CMj
	for linux-um@lists.infradead.org;
	Fri, 22 May 2026 14:20:34 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5D060601E8;
	Fri, 22 May 2026 14:20:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04131F00A3E;
	Fri, 22 May 2026 14:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779459633;
	bh=KMOg+jIFzKoR+MDQSP+sdqbBfrIpOv5CDMN5EJGNh5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E+W7wlmM3XJVZwZz2XX9vHRsZGSo+lrXIM85vfaQ8xDGxQLgQSvEvXFpR/EbiLbPL
	 hKhdIlR20CaaUl5QmgRrqgs8493yKARsqpG1gYSDCpzUFYBMwyVURUHzALAvI1moiO
	 CdYQSIA3Qxag8kLJRJLlmqM1yN7S/cNsp8xzzpZcB64z3KJHsnOwF/mQYwyQvS3Vta
	 2Sl8eKoJfXHcAMaS4DpeWdUbcrNmQ804CxKHqC2NDHMoIv/fvbu1RjTsulE9rykjQo
	 SqV5fYAu+miQFBNbXav4cqb6SIajfXfMoTQlz2QpyYwuOb2GJg1dcBnMM4S00VhWAc
	 keuiPXXwjI2Eg==
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
Subject: [PATCH 2/8] =?UTF-8?q?x86:=20remove=20AMD=20=C3=89lan=20remnants?=
Date: Fri, 22 May 2026 16:19:53 +0200
Message-Id: <20260522141959.1071595-3-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260522141959.1071595-1-arnd@kernel.org>
References: <20260522141959.1071595-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

There is one more leftover line in Kconfig and the detection for
AMD Generation 4 CPUs (5k86 and Élan) that can now get removed
following the increase of the minimum CPU level to 586TSC.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/Kconfig.cpu      |  1 -
 arch/x86/kernel/cpu/amd.c | 20 --------------------
 2 files changed, 21 deletions(-)

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 1377edd9a997..f4a12b74bed3 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -32,7 +32,6 @@ choice
 	  - "Athlon" for the AMD K7 family (Athlon/Duron/Thunderbird).
 	  - "Crusoe" for the Transmeta Crusoe series.
 	  - "Efficeon" for the Transmeta Efficeon series.
-	  - "AMD Elan" for the 32-bit AMD Elan embedded CPU.
 	  - "GeodeGX1" for Geode GX1 (Cyrix MediaGX).
 	  - "Geode GX/LX" For AMD Geode GX and LX processors.
 	  - "CyrixIII/VIA C3" for VIA Cyrix III or VIA C3.
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 62f74a7f2f8d..b04e1f6fe430 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -91,25 +91,6 @@ __asm__(".text\n"
 	"vide: ret\n");
 #endif
 
-static void init_amd_k5(struct cpuinfo_x86 *c)
-{
-#ifdef CONFIG_X86_32
-/*
- * General Systems BIOSen alias the cpu frequency registers
- * of the Elan at 0x000df000. Unfortunately, one of the Linux
- * drivers subsequently pokes it, and changes the CPU speed.
- * Workaround : Remove the unneeded alias.
- */
-#define CBAR		(0xfffc) /* Configuration Base Address  (32-bit) */
-#define CBAR_ENB	(0x80000000)
-#define CBAR_KEY	(0X000000CB)
-	if (c->x86_model == 9 || c->x86_model == 10) {
-		if (inl(CBAR) & CBAR_ENB)
-			outl(0 | CBAR_KEY, CBAR);
-	}
-#endif
-}
-
 static void init_amd_k6(struct cpuinfo_x86 *c)
 {
 #ifdef CONFIG_X86_32
@@ -1065,7 +1046,6 @@ static void init_amd(struct cpuinfo_x86 *c)
 		clear_cpu_cap(c, X86_FEATURE_MCE);
 
 	switch (c->x86) {
-	case 4:    init_amd_k5(c); break;
 	case 5:    init_amd_k6(c); break;
 	case 6:	   init_amd_k7(c); break;
 	case 0xf:  init_amd_k8(c); break;
-- 
2.39.5


