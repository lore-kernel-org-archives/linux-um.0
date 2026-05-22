Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB08CD5BB0
	for <linux-um@archiver.kernel.org>; Fri, 22 May 2026 14:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H+T5Xm2pme6Jcpih7VPFA5EZ9bN5jCyycTaeJz2Unis=; b=pktNi/9qmKMuoggXK0KreRbzd3
	vUSZJLgTp80YvocxE7hBoUxYNvPG8XuIsk7lRZX2Nvvyjrrtf+RZ7AxzARVcqgc8VFuVy8VDsORtT
	yLlo6mi6cV7tJSrx3Swkn6oGboW46+fPKoh86F4lGvA4WpTe1LM0QvWMULuD30Vo6zwoyLNYDf1ZP
	Y/Ho1YZihgU5XbHfqrL/c7N/PuaJKrBuwRf7k9bOf2QSnI9Vz6evLFoWJzkMF9JntM7Oi4WDomqrK
	BJzV2rqvbkyirYzYjDqqmVg5wwUlVp+OmMKY1b7FY5gOODEzHGSYeXVZZxIFQ/Vpi8xm3K+SsbOrT
	manM+wXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQQkB-0000000B78L-28p3;
	Fri, 22 May 2026 14:20:55 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQQk4-0000000B75u-0IbY
	for linux-um@lists.infradead.org;
	Fri, 22 May 2026 14:20:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7DCA74383B;
	Fri, 22 May 2026 14:20:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15CCA1F000E9;
	Fri, 22 May 2026 14:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779459647;
	bh=H+T5Xm2pme6Jcpih7VPFA5EZ9bN5jCyycTaeJz2Unis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D35guIUPEhT4eG7ItlkowbWJs8WBZz7vxTKCtrhnchfpIR0mk9FMHqtmbWaaUouh5
	 MuWu3h6iHSR6nfI8VdU9fzpsi4WmmLS5trO+6K/zSXhpJFQs2rUnr9Daqnmujyr77y
	 cndftdziCKUQv1fGV5ue0i3W6P5Pdymg/F0tJ1nZpWNxFQTGFF2am4YGYulMtPatlM
	 d6YRlBCMnwCOqdhJFrBaxjEWO11daXzIPVCitqWClQBtPx6HkLbbvK9rD5ceI7j99D
	 inU1LeqeqpBZgdUhAxX8GA7/u5DIGzUgKt8a9lqTcR+aBM7Cx/w+1FSpV2g8Ct4xEZ
	 0t4h66WZQN3ug==
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
Subject: [PATCH 5/8] x86: remove dependencies on CONFIG_M... CPU options
Date: Fri, 22 May 2026 16:19:56 +0200
Message-Id: <20260522141959.1071595-6-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260522141959.1071595-1-arnd@kernel.org>
References: <20260522141959.1071595-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260522_072048_148059_29CA68E6 
X-CRM114-Status: GOOD (  15.40  )
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

CPU specific features should generally be controlled by
CPU_SUP_xxx options rather than CONFIG_Mxxx, to allow
generic kernels to be built that work with all of them.

Replace the few options that don't follow this scheme
with checks on either CPU_SUP_xxx or X86_PAE by itself.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/kernel/tsc.c    | 2 +-
 arch/x86/xen/Kconfig     | 3 +--
 drivers/misc/mei/Kconfig | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index e7a43471783f..3d5d38035c52 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1213,7 +1213,7 @@ static void __init tsc_disable_clocksource_watchdog(void)
 
 static void __init check_system_tsc_reliable(void)
 {
-#if defined(CONFIG_MGEODEGX1) || defined(CONFIG_MGEODE_LX) || defined(CONFIG_X86_GENERIC)
+#if defined(CONFIG_CPU_SUP_CYRIX_32)
 	if (is_geode_lx()) {
 		/* RTSC counts during suspend */
 #define RTSC_SUSP 0x100
diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
index aa4040fd9215..7e74db652215 100644
--- a/arch/x86/xen/Kconfig
+++ b/arch/x86/xen/Kconfig
@@ -10,8 +10,7 @@ config XEN
 	select X86_HV_CALLBACK_VECTOR
 	select HIBERNATE_CALLBACKS
 	depends on X86_64 || (X86_32 && X86_PAE)
-	depends on X86_64 || (X86_GENERIC || MPENTIUM4 || MATOM)
-	depends on X86_LOCAL_APIC && X86_TSC
+	depends on X86_LOCAL_APIC
 	help
 	  This is the Linux Xen port.  Enabling this will allow the
 	  kernel to boot in a paravirtualized environment under the
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
2.39.5


