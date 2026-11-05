Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8264606A91E
	for <linux-um@archiver.kernel.org>; Thu,  5 Nov 2026 16:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GzKgLXKN;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ls8Raz9q
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=e2ztWCUIFbvaoqpwhwvFVgI1sGkz5O9pvvPNBwZKqYs=; b=GzKgLXKN+WRE8Y
	sYnUS6BhR6bBP63cb6KsWbrnUxpRj8chndfiHNCmWp0dx71gTkPPn1pVIffuXQVL4eMyshIlQh/RU
	PYamI2Ak7pDw27s726qGS+eJyoZPitzJ9siCR32lI4a/kQfE+0C2ppG6mdGSTLA/XPEklU0xSOUZR
	tNHLzRzfFopqRuXfCxAvAptrhSzpcAjAsjSZCtJzQJXJFjcCqzxZ5sTzJi8+aemlaZBnZpouhrZwd
	BhefoAlZ9Q+g2iU1lq5f+gx4HjJmJ4Zi6ogXWKlfPY+nJLfIp4MNURrjJNCrQ4MHjrCLILrheYole
	UApPtMRuSCWztsWpcMPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP0R5-00000009ejI-2mWj;
	Thu, 05 Nov 2026 16:35:35 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP0Qv-00000009ed5-0rDP
	for linux-um@lists.infradead.org;
	Thu, 05 Nov 2026 16:35:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9785E60A6A;
	Thu,  5 Nov 2026 16:35:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149041F00A02;
	Thu,  5 Nov 2026 16:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793896524;
	bh=e2ztWCUIFbvaoqpwhwvFVgI1sGkz5O9pvvPNBwZKqYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ls8Raz9qVlcGHcu9+FVj6z1c1vBoBKB/jakU6Lu8YrKYnGZqY5t2rEY8JxipHMdtk
	 7qHUYq+71xsAFUuZUyYDI6OboesMNH7/jytVMpplfH6E4WR1ddKkvc6c6LKkBkxNDH
	 q8ZWxRcwCnC6tMCj124corHQ2ckC9K6IlXu4O/0XeEmfHahyxaAa6LgGUdVRpLNY/F
	 ExH6o7HCuony4tMLzH2AQHly10SYx8pP4fjrCGr17KjLuprUmI7wY60K2qhq+Jnhrh
	 KySenRkj5mukWo3FO8VBiSMx9Y/xJHgv7M5ue4JstHGt7goQyxuFae9GwI1nh0fkOb
	 35B6tlVhiEnow==
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
Subject: [PATCH 7/7] x86: simplify 32-bit instruction set selection
Date: Thu,  5 Nov 2026 17:34:38 +0100
Message-ID: <20261105163440.2381661-8-arnd@kernel.org>
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

The -march= compiler flags select both instruction set and tuning for
a particular CPU, which works well when building a kernel that can only
run on this one type, but has some counterintuitive effects because it
is not always clear which models are compatible.

E.g. building for Geode LX results in a kernel that can work on all on
all 686-class CPUs but crashes on CPUs without the CMOV instructions.
Building a kernel for 686 could work on Geode LX and Crusoe but fails
because of the CPU generation check that detects these as 585-class.
Similarly, building for Intel Atom produces a 32-bit kernel that uses
the MOVBE instructions and does not work on any other 32-bit CPU or
even 64-bit CPUs before Haswell/Excavator.

Change the CPU selection to build everything with either -march=i586
or -march=i686 and make the specific options only change the -mtune=
parameter where this was previously handled by -march=. Note that
the only -mtune= options that gcc or clang understand for x86-32
are i486, pentium, pentiumpro, pentium4, atom, geode, k6 and athlon,
the other ten are just aliases for one of them.

Selecting any 586-class configuration option now produces a kernel that
works on every supported CPU, while selecting a 686-class configuration
works on all 686-class CPUs but no 586-class ones.

Consequently, the vermagic.h logic can be simplified to just these
two cases.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/Kconfig.cpu            | 13 +++++-------
 arch/x86/Makefile_32.cpu        | 16 +++++++--------
 arch/x86/include/asm/vermagic.h | 36 ++-------------------------------
 3 files changed, 15 insertions(+), 50 deletions(-)

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 21026e0cb569..121881c4d076 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -6,9 +6,9 @@ choice
 	default M686
 	help
 	  This is the processor type of your CPU. This information is
-	  used for optimizing purposes. In order to compile a kernel
-	  that can run on all supported x86 CPU types (albeit not
-	  optimally fast), you can specify "586" here.
+	  used to pick between i586-class and i686-class processors,
+	  as well as to optimize for a particular microarchitecture
+	  within the two classes.
 
 	  Note that the 386 and 486 is no longer supported, this includes
 	  AMD/Cyrix/Intel 386DX/DXL/SL/SLC/SX, Cyrix/TI 486DLC/DLC2,
@@ -164,16 +164,13 @@ config MCYRIXIII
 	  treat this chip as a generic 586. Whilst the CPU is 686 class,
 	  it lacks the cmov extension which gcc assumes is present when
 	  generating 686 code.
-	  Note that Nehemiah (Model 9) and above will not boot with this
-	  kernel due to them lacking the 3DNow! instructions used in earlier
-	  incarnations of the CPU.
 
 config MVIAC3_2
 	bool "VIA C3-2 (Nehemiah)"
 	depends on X86_32
 	help
-	  Select this for a VIA C3 "Nehemiah". Selecting this enables usage
-	  of SSE and tells gcc to treat the CPU as a 686.
+	  Select this for a VIA C3 "Nehemiah". Selecting tells gcc to treat
+	  the CPU as a 686.
 	  Note, this kernel will not boot on older (pre model 9) C3s.
 
 config MVIAC7
diff --git a/arch/x86/Makefile_32.cpu b/arch/x86/Makefile_32.cpu
index c5aa169b596d..1735a5f95d33 100644
--- a/arch/x86/Makefile_32.cpu
+++ b/arch/x86/Makefile_32.cpu
@@ -11,26 +11,26 @@ align		:= -falign-functions=0 -falign-jumps=0 -falign-loops=0
 endif
 
 cflags-$(CONFIG_M586TSC)	+= -march=i586
-cflags-$(CONFIG_M586MMX)	+= -march=pentium-mmx
+cflags-$(CONFIG_M586MMX)	+= -march=i586
 cflags-$(CONFIG_M686)		+= -march=i686
 cflags-$(CONFIG_MPENTIUMII)	+= -march=i686 $(call tune,pentium2)
 cflags-$(CONFIG_MPENTIUMIII)	+= -march=i686 $(call tune,pentium3)
 cflags-$(CONFIG_MPENTIUMM)	+= -march=i686 $(call tune,pentium3)
 cflags-$(CONFIG_MPENTIUM4)	+= -march=i686 $(call tune,pentium4)
-cflags-$(CONFIG_MK6)		+= -march=k6
+cflags-$(CONFIG_MK6)		+= -march=i586 $(call tune,k6)
 # Please note, that patches that add -march=athlon-xp and friends are pointless.
 # They make zero difference whatsosever to performance at this time.
-cflags-$(CONFIG_MK7)		+= -march=athlon
+cflags-$(CONFIG_MK7)		+= -march=i686 $(call tune,athlon)
 cflags-$(CONFIG_MCRUSOE)	+= -march=i686 $(align)
 cflags-$(CONFIG_MEFFICEON)	+= -march=i686 $(call tune,pentium3) $(align)
-cflags-$(CONFIG_MCYRIXIII)	+= $(call cc-option,-march=c3,-march=i486) $(align)
-cflags-$(CONFIG_MVIAC3_2)	+= $(call cc-option,-march=c3-2,-march=i686)
+cflags-$(CONFIG_MCYRIXIII)	+= -march=i586 $(call tune,i486) $(align)
+cflags-$(CONFIG_MVIAC3_2)	+= -march=i686
 cflags-$(CONFIG_MVIAC7)		+= -march=i686
-cflags-$(CONFIG_MATOM)		+= -march=atom
+cflags-$(CONFIG_MATOM)		+= -march=i686 $(call tune,atom)
 
 # Geode GX1 support
-cflags-$(CONFIG_MGEODEGX1)	+= -march=pentium-mmx
-cflags-$(CONFIG_MGEODE_LX)	+= $(call cc-option,-march=geode,-march=pentium-mmx)
+cflags-$(CONFIG_MGEODEGX1)	+= -march=i586 $(call tune,geode)
+cflags-$(CONFIG_MGEODE_LX)	+= -march=i586 $(call tune,geode)
 # add at the end to overwrite eventual tuning options from earlier
 # cpu entries
 cflags-$(CONFIG_X86_GENERIC) 	+= $(call tune,generic,$(call tune,i686))
diff --git a/arch/x86/include/asm/vermagic.h b/arch/x86/include/asm/vermagic.h
index e26061df0c9b..5323ed585bc9 100644
--- a/arch/x86/include/asm/vermagic.h
+++ b/arch/x86/include/asm/vermagic.h
@@ -5,42 +5,10 @@
 
 #ifdef CONFIG_X86_64
 /* X86_64 does not define MODULE_PROC_FAMILY */
-#elif defined CONFIG_M586TSC
-#define MODULE_PROC_FAMILY "586TSC "
-#elif defined CONFIG_M586MMX
-#define MODULE_PROC_FAMILY "586MMX "
-#elif defined CONFIG_MATOM
-#define MODULE_PROC_FAMILY "ATOM "
-#elif defined CONFIG_M686
+#elif CONFIG_X86_MINIMUM_CPU_FAMILY == 6
 #define MODULE_PROC_FAMILY "686 "
-#elif defined CONFIG_MPENTIUMII
-#define MODULE_PROC_FAMILY "PENTIUMII "
-#elif defined CONFIG_MPENTIUMIII
-#define MODULE_PROC_FAMILY "PENTIUMIII "
-#elif defined CONFIG_MPENTIUMM
-#define MODULE_PROC_FAMILY "PENTIUMM "
-#elif defined CONFIG_MPENTIUM4
-#define MODULE_PROC_FAMILY "PENTIUM4 "
-#elif defined CONFIG_MK6
-#define MODULE_PROC_FAMILY "K6 "
-#elif defined CONFIG_MK7
-#define MODULE_PROC_FAMILY "K7 "
-#elif defined CONFIG_MCRUSOE
-#define MODULE_PROC_FAMILY "CRUSOE "
-#elif defined CONFIG_MEFFICEON
-#define MODULE_PROC_FAMILY "EFFICEON "
-#elif defined CONFIG_MCYRIXIII
-#define MODULE_PROC_FAMILY "CYRIXIII "
-#elif defined CONFIG_MVIAC3_2
-#define MODULE_PROC_FAMILY "VIAC3-2 "
-#elif defined CONFIG_MVIAC7
-#define MODULE_PROC_FAMILY "VIAC7 "
-#elif defined CONFIG_MGEODEGX1
-#define MODULE_PROC_FAMILY "GEODEGX1 "
-#elif defined CONFIG_MGEODE_LX
-#define MODULE_PROC_FAMILY "GEODE "
 #else
-#error unknown processor family
+#define MODULE_PROC_FAMILY "586 "
 #endif
 
 #ifdef CONFIG_X86_32
-- 
2.53.0


