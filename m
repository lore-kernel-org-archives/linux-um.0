Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C364606EEB6
	for <linux-um@archiver.kernel.org>; Thu,  5 Nov 2026 16:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1LQAQt/l;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R2nfc4Qn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=0pG7PBqkfLHgJEByKC7kPAegbyGB2e3dQGJkYxQHpns=; b=1LQAQt/lXgp4k0
	Q4/QfgXf9T3IAOfzSELr0W3aym1iLu87Gd7Dfmuk52DWuXNJBV6nKniuDPz2z7+X0mzc2nT8kAVj7
	MDm32Jox6jJ/Z0ajgKM65LbZ6RrOEluy3mQLhuZxvpBu3yoTME34vif8amzgKD7uHSFzmwk0y5W3W
	VKHGTW3k7Ftgu3bygDXv8SZuZKD9VDUJoJYtzxBZ1HOc2pez1X5M1wtK8xJm/+Wt+pYE/u7gSad7O
	4eimIpB8qFvFaHtpe6NH1IkPdsf4Ud6fBlZTObMwMAdYXRa+5vD2KrlaqpKPaJY9JL7pToH8LI8c6
	CYXufX3G8WJjuw99rB+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP0QW-00000009eUe-3EMF;
	Thu, 05 Nov 2026 16:35:00 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP0QS-00000009eSh-3YxG
	for linux-um@lists.infradead.org;
	Thu, 05 Nov 2026 16:34:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4C41B60A84;
	Thu,  5 Nov 2026 16:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4CD1F000C1;
	Thu,  5 Nov 2026 16:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793896496;
	bh=0pG7PBqkfLHgJEByKC7kPAegbyGB2e3dQGJkYxQHpns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R2nfc4Qn5AvsfFFInzrbtwoVPc4igI2oiq58odYntCecdj7BMi8y7LobvxYytYBt1
	 u0iYv8oHnjiTICzQmbItbU9QV/a7yrMxkWq3WxHaibPhX/nirD6DQ4Rj42ytb6fM0a
	 zVE1x1I8FsI3FXjx9o9qJKI56TeM2FY/5+tmtKawviSEa56vWiqXjRbO1pXjL1KqJl
	 pwRj06tkjl83nvS7p0l5Is6BD/GeGcmneFeu8UUuQ2DG6+vbLnhMzBzKKehOttBt0v
	 GL0MUDP/mDFP0aTzdtC5B+cDBBD3D4Ct6tqY70tk1eUPyGyBzIUmK45pg2ufKcXA6V
	 H90rjV1b8bUDw==
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
Subject: [PATCH 1/7] =?UTF-8?q?x86:=20remove=20AMD=20=C3=89lan=20remnants?=
Date: Thu,  5 Nov 2026 17:34:32 +0100
Message-ID: <20261105163440.2381661-2-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105163440.2381661-1-arnd@kernel.org>
References: <20261105163440.2381661-1-arnd@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
index 6e7a366f0798..5b67a4567434 100644
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
index 3972966cb023..cd468e47b68a 100644
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
@@ -1073,7 +1054,6 @@ static void init_amd(struct cpuinfo_x86 *c)
 		clear_cpu_cap(c, X86_FEATURE_MCE);
 
 	switch (c->x86) {
-	case 4:    init_amd_k5(c); break;
 	case 5:    init_amd_k6(c); break;
 	case 6:	   init_amd_k7(c); break;
 	case 0xf:  init_amd_k8(c); break;
-- 
2.53.0


