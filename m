Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D892F6082BE1
	for <linux-um@archiver.kernel.org>; Thu,  5 Nov 2026 16:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1nt/dUjn;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RCN2Kp7m
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=5KJ6eV8CwRFrce/nsRU3xf8dfm2BrAfBMI23/cbPj44=; b=1nt/dUjnfOYYqk
	/vKzwGzQdnRlMApSUOBdOtUW5NjnenJ0ZHRVrfeQw+CZJ8rymkwo8tNS1ThdHauRQpR626y4qI2Gh
	bl2a5y89EtOG0T1BFhKyRfYaxtUh54mju4SqqeOraAv1z3xk/xkmGH2DyUh0uKPGO/Xe/Er7ExfE2
	fNWoGuHGrxPHjK3W5f7uELBBdzdMPAU0dEW5EryiaUiPo99oLChVXRB+YknMqXZ+Gr39wdxIBVTpw
	ReuUjcQVVTV8WRwzgRYCocaelxK9u9G6mJS8yFGwXEoK+zmeCTwYS/eajCTD/tubzUN8yAMcmExIB
	XZm7AEOgihCQ1BknDDyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP0Qw-00000009eez-29qM;
	Thu, 05 Nov 2026 16:35:26 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP0Ql-00000009eaI-1Ng8
	for linux-um@lists.infradead.org;
	Thu, 05 Nov 2026 16:35:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0B8C84040C;
	Thu,  5 Nov 2026 16:35:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2EA21F000C1;
	Thu,  5 Nov 2026 16:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793896514;
	bh=5KJ6eV8CwRFrce/nsRU3xf8dfm2BrAfBMI23/cbPj44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RCN2Kp7mimblpNJ22ntY3FYW87qgecqG+csfpDP6Nf/G+gBipiZnb7ma2xn0PsmTn
	 CTynqIYhn4+Zk78mpZ2UUqQGqqCdsm7aju90C5llkt9M/BZSxFp+c0rU6O2YjtSgWz
	 kHGbqO4bKa+PFj4b4oLqYiBa/iXy1v1WLhOK9fmeMbRlmfH77u3zAA+cJDMoKXiQjg
	 BZORfCdqjdoqR1pwWzP+Qlo+1POlOm8R7XUTRxhfapBODLCWdfHPCsvUifatx6wca7
	 S67fGkbtbVOX5HxRgiqMTXAZpKRQzLkkJoCASk6mO1zXLZNtBZyUSwlIpMkkldWXY4
	 ys5Ou7ld5iYQw==
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
Subject: [PATCH 5/7] x86: remove dependencies on CONFIG_M... CPU options
Date: Thu,  5 Nov 2026 17:34:36 +0100
Message-ID: <20261105163440.2381661-6-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105163440.2381661-1-arnd@kernel.org>
References: <20261105163440.2381661-1-arnd@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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

CPU specific features should generally be controlled by
CPU_SUP_xxx options rather than CONFIG_Mxxx, to allow
generic kernels to be built that work with all of them.

Replace the few options that don't follow this scheme
with checks on either CPU_SUP_xxx or X86_PAE by itself.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/kernel/tsc.c    | 2 +-
 arch/x86/xen/Kconfig     | 1 -
 drivers/misc/mei/Kconfig | 2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 02269dcbde1f..d8b79d1151da 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1212,7 +1212,7 @@ static void __init tsc_disable_clocksource_watchdog(void)
 
 static void __init check_system_tsc_reliable(void)
 {
-#if defined(CONFIG_MGEODEGX1) || defined(CONFIG_MGEODE_LX) || defined(CONFIG_X86_GENERIC)
+#if defined(CONFIG_CPU_SUP_CYRIX_32)
 	if (is_geode_lx()) {
 		/* RTSC counts during suspend */
 #define RTSC_SUSP 0x100
diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
index 609e79942fcb..0655ddd6fd39 100644
--- a/arch/x86/xen/Kconfig
+++ b/arch/x86/xen/Kconfig
@@ -10,7 +10,6 @@ config XEN
 	select X86_HV_CALLBACK_VECTOR
 	select HIBERNATE_CALLBACKS
 	depends on X86_64 || (X86_32 && X86_PAE)
-	depends on X86_64 || (X86_GENERIC || MPENTIUM4 || MATOM)
 	depends on X86_LOCAL_APIC
 	help
 	  This is the Linux Xen port.  Enabling this will allow the
diff --git a/drivers/misc/mei/Kconfig b/drivers/misc/mei/Kconfig
index 2d1bc5b4d11b..faa451584002 100644
--- a/drivers/misc/mei/Kconfig
+++ b/drivers/misc/mei/Kconfig
@@ -4,7 +4,7 @@ config INTEL_MEI
 	tristate "Intel Management Engine Interface"
 	depends on PCI
 	depends on X86 || DRM_XE!=n || COMPILE_TEST
-	default X86_64 || MATOM
+	default X86_64 || CPU_SUP_INTEL
 	help
 	  The Intel Management Engine (Intel ME) provides Manageability,
 	  Security and Media services for system containing Intel chipsets.
-- 
2.53.0


