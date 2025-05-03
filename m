Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A52F0C3ABAD
	for <linux-um@archiver.kernel.org>; Sat,  3 May 2025 08:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HtJXO2tp2KWXicq8zFD5UZuiDa79F98bwVuDoPSnvPg=; b=uhgQMhEQopNnYZSW5feoryWtEO
	YoBqE4uMcKhfVNessEq58v+aIsHk8Any+jn1sZJZdWBQsUKltddqEp4QV45nKxGcQrF2pwgtZ5bHk
	YXeHZECtEyfmsqqAotWiaw/skPFVRjMlStgTFDstA3Cas8MYiC0vV4IpfG0VTNwSC9oBaaxBMCbxF
	lARiq50Ezb332YJLDCGJg++4Ne2kDUvTBYvnyat2Hxc9CFG2V7wPHMoSFIf4/4Ts+KD3l3YKxmHFe
	MW9ECWQKozedPEXfsqY2DhjLSAVyA7NNXU59fbtUJAc2rvP6LxCwup3E+dXRoCagspXKs9doTgQUd
	i0/06jMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uB8Rb-00000003eV0-3KJV;
	Sat, 03 May 2025 08:41:59 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uB8RY-00000003eUE-2NfL
	for linux-um@lists.infradead.org;
	Sat, 03 May 2025 08:41:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CC9BD45134;
	Sat,  3 May 2025 08:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ABD6C4CEE9;
	Sat,  3 May 2025 08:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746261716;
	bh=+PcCraay1DizFcXkGnQrr4jLbEi5SeYlgRLvxR87H1w=;
	h=From:To:Cc:Subject:Date:From;
	b=icAiLkvxWq3doiPO+t5E/kfc2c/7ZDNGG4rWvNXdbSKcmAxQsX3Yylbo/wVxa4HQL
	 Ld/txHQM0xF3Hue7oRrEiwvy+OB8cA3xyG+QPqBQGoCWWy+KXP7KXSoMa6n6S9V2fK
	 JKVSuN4CHm9rpF0D/SEghlW2o8o5ayOvKy++D0rP3YCIxr4kox+L2tVJaAVlgoYIgp
	 al1/rA1hZGr5QwLfniQIvAYf8U9coCjZpxhQ/BeUCFNItMlCeh5JQPQgQ7fr2Py8qc
	 FKLZ33ZsB7I8ENpp7IaqN7ZkB1C8SzWfniK/PAdfFWqetqYlAudr/dKhLYo5+5kVGY
	 ZXr2leGqB6yrw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Richard Weinberger <richard@nod.at>,
	linux-um@lists.infradead.org
Subject: [PATCH] kbuild: introduce include/generated/global-rebuild.h
Date: Sat,  3 May 2025 17:41:43 +0900
Message-ID: <20250503084145.1994176-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250503_014156_645693_272454BF 
X-CRM114-Status: GOOD (  13.40  )
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

Sometimes we need to trigger a global rebuild of the kernel tree -
for instance, when any of the GCC plugins changes. [1]

This commit provides a simple mechanism to force a global rebuild
using a single header file.

The top-level Makefile creates include/generated/global-rebuild.h if
it does not exist, and this file is included by all kernel sources.

You can touch it in a build rule when a global rebuild is required.

The following is an example change to the GCC plugin build rule.

  quiet_cmd_plugin_cxx_so_c = HOSTCXX $@
 -      cmd_plugin_cxx_so_c = $(HOSTCXX) $(plugin_cxxflags) $(plugin_ldflags) -o $@ $<
 +      cmd_plugin_cxx_so_c = $(HOSTCXX) $(plugin_cxxflags) $(plugin_ldflags) -o $@ $<; touch include/generated/global-rebuild.h

Link: https://lore.kernel.org/linux-kbuild/CAK7LNATDbxc+3HQ6zoSk9t-Lkf4MSNmEUN6S5EqoVWnBQw_K6g@mail.gmail.com/T/#me069145443a17f0b464c13814424dbba0d970863 [1]
Cc: Kees Cook <kees@kernel.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile         | 9 ++++++++-
 arch/um/Makefile | 3 ++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 5aa9ee52a765..64811eebd549 100644
--- a/Makefile
+++ b/Makefile
@@ -558,7 +558,8 @@ USERINCLUDE    := \
 		-I$(srctree)/include/uapi \
 		-I$(objtree)/include/generated/uapi \
                 -include $(srctree)/include/linux/compiler-version.h \
-                -include $(srctree)/include/linux/kconfig.h
+                -include $(srctree)/include/linux/kconfig.h \
+                -include $(objtree)/include/generated/global-rebuild.h
 
 # Use LINUXINCLUDE when you must reference the include/ directory.
 # Needed to be compatible with the O= option
@@ -1257,6 +1258,11 @@ endif
 include/config/kernel.release: FORCE
 	$(call filechk,kernel.release)
 
+filechk_empty = printf ''
+
+include/generated/global-rebuild.h: FORCE
+	$(call filechk,empty)
+
 # Additional helpers built in scripts/
 # Carefully list dependencies so we do not try to build scripts twice
 # in parallel
@@ -1273,6 +1279,7 @@ scripts: scripts_basic scripts_dtc
 PHONY += prepare archprepare
 
 archprepare: outputmakefile archheaders archscripts scripts include/config/kernel.release \
+	include/generated/global-rebuild.h \
 	asm-generic $(version_h) include/generated/utsrelease.h \
 	include/generated/compile.h include/generated/autoconf.h \
 	include/generated/rustc_cfg remove-stale-files
diff --git a/arch/um/Makefile b/arch/um/Makefile
index 1d36a613aad8..f564a26c1364 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -73,7 +73,8 @@ USER_CFLAGS = $(patsubst $(KERNEL_DEFINES),,$(patsubst -I%,,$(KBUILD_CFLAGS))) \
 		-D_FILE_OFFSET_BITS=64 -idirafter $(srctree)/include \
 		-idirafter $(objtree)/include -D__KERNEL__ -D__UM_HOST__ \
 		-include $(srctree)/include/linux/compiler-version.h \
-		-include $(srctree)/include/linux/kconfig.h
+		-include $(srctree)/include/linux/kconfig.h \
+		-include $(objtree)/include/generated/global-rebuild.h
 
 #This will adjust *FLAGS accordingly to the platform.
 include $(srctree)/$(ARCH_DIR)/Makefile-os-Linux
-- 
2.43.0


