Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E649C9831C
	for <linux-um@archiver.kernel.org>; Thu, 24 Sep 2026 12:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FSZpwLgOJPdOKAc/3G0H25D/GGiZaAGASzntlGWjFxM=; b=GZ3tEEgAOxrpRVds9v3p98pcA/
	215W+tpR1cQ/TKRx+wPzwBJqFfdkQms+25qZfn/jeiVqMLMWb3/gwgOmCzsOyuTcpzAyueh6XjZJ9
	ABhjbXINbXQCf3PPahb8i/FAIHwhDEN7h3YH5XorMj8bUl3tNh7oIle2c2B50KMuUsva7iYUfOMRl
	R6gAhEGB9BETz8XZfpMuELCHQoybhKX2trTqb8cVC5vO32eDIzhUMTXOMRPBjUQp6K+yHDbmYF6Al
	KHFIc1rm18fP+p7AGE0WEqkbNPqWdre5APyOPsPqh7+GN/6CLC7rp0VSEgbzYyq6er6f7fXA1OUzF
	p3a5ibWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9il2-0000000B08e-0QPq;
	Thu, 24 Sep 2026 12:41:00 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9il0-0000000B07F-1CxX
	for linux-um@bombadil.infradead.org;
	Thu, 24 Sep 2026 12:40:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=FSZpwLgOJPdOKAc/3G0H25D/GGiZaAGASzntlGWjFxM=; b=TAcxbhi79kfZ9/Sbr0Wskzqzzp
	CfihFVVGdg9jYEZ5EwixG6NYr+w8EdMPWoLIvrD4FRfn4x1ARF2FZ1Ea4OzVvBwo6In162b/SbaGS
	i17SGYkeWQ3cY+Dj5jx9cO97MpPRcCVORUOS4e++3GpYU2aK57cnVJmB5drBjdmAKQ2Pfm6UzGhBG
	OBvw9KEz8rES86K+zpuC1yT4g6Rwq2yyQMNsqxpj+G4O6i+b8j3975YZ5Ex7Gd8xDJnGAXW23iRUW
	+AlCeMdAU0nzKavG/71y8HMG6CbZFQFSkOTwkXjU6LZ7/DFteOBXrB/zQ6knXO4Bbpcp859FWawck
	lBoBEMkg==;
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x9ikw-0000000Fyko-481N
	for linux-um@lists.infradead.org;
	Thu, 24 Sep 2026 12:40:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=FSZpwLgOJPdOKAc/3G0H25D/GGiZaAGASzntlGWjFxM=;
	t=1790253654; x=1791463254; b=DJftwZYafQ24kegn+uwkmfL/5FTqQElimEt3T8zhFsHWHq1
	AGKg+uov+3zm9C9QVI5Hnq3hx/wbwCzr8s7BQLp3yn48L1Q/01XKV1AVWagUmtmfGxydN3/x412E3
	QofSiGnCk2U/ikEKCX6cJ6Ua9RgqJMH/tHPN568K0X/OJycNGLcMuvX83Cl3H9ws5gtGbrLa+eHyL
	mndv1gH9iMLHFAJCiNmByh+T1kiOVqmmByi1nCfoR6N0KLeQGOO2LcyC5/vM45sgVf7KyFHU2S6yR
	bIeqxsjvLA3J+htZKNrRIx9rZTTLY9cN/1Tn032WSEM62pWVMxdrpfwuZpi5WeqA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1x9ikt-000000092x8-0JIB;
	Thu, 24 Sep 2026 14:40:51 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-um@lists.infradead.org,
	linux-s390@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/4] ORC: unify orc_hash.h generation
Date: Thu, 24 Sep 2026 14:35:52 +0200
Message-ID: <20260924144039.7f1bd78fad93.Ibd2ade12789c15c5fa6c45b4661d471fbb4e177b@changeid>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924124039.1621965-6-johannes@sipsolutions.net>
References: <20260924124039.1621965-6-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260924_134055_179679_132EDBB9 
X-CRM114-Status: UNSURE (   9.04  )
X-CRM114-Notice: Please train this message.
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

From: Johannes Berg <johannes.berg@intel.com>

There's no real reason this needs to be duplicated,
and while not a lot of code, I'm adding it yet again
for UML. Move it out to the common Makefile.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 Makefile                | 13 +++++++++++++
 arch/loongarch/Makefile | 12 ------------
 arch/x86/Makefile       | 12 ------------
 3 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/Makefile b/Makefile
index 751a08643bf8..110aa0036e3f 100644
--- a/Makefile
+++ b/Makefile
@@ -1490,6 +1490,19 @@ filechk_compile.h = $(srctree)/scripts/mkcompile_h \
 include/generated/compile.h: FORCE
 	$(call filechk,compile.h)
 
+ifdef CONFIG_UNWINDER_ORC
+orc_hash_dir := arch/$(or $(HEADER_ARCH),$(SRCARCH))/include
+orc_hash_h := $(orc_hash_dir)/generated/asm/orc_hash.h
+orc_hash_sh := $(srctree)/scripts/orc_hash.sh
+targets += $(orc_hash_h)
+quiet_cmd_orc_hash = GEN     $@
+      cmd_orc_hash = mkdir -p $(dir $@); \
+		     $(CONFIG_SHELL) $(orc_hash_sh) < $< > $@
+$(orc_hash_h): $(srctree)/$(orc_hash_dir)/asm/orc_types.h $(orc_hash_sh) FORCE
+	$(call if_changed,orc_hash)
+archprepare: $(orc_hash_h)
+endif
+
 PHONY += headerdep
 headerdep:
 	$(Q)find $(srctree)/include/ -name '*.h' | xargs --max-args 1 \
diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index 4b22f95aaafb..96ceda11e307 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -35,18 +35,6 @@ endif
 CC_FLAGS_FPU		:= -mfpu=64
 CC_FLAGS_NO_FPU		:= -msoft-float
 
-ifdef CONFIG_UNWINDER_ORC
-orc_hash_h := arch/$(SRCARCH)/include/generated/asm/orc_hash.h
-orc_hash_sh := $(srctree)/scripts/orc_hash.sh
-targets += $(orc_hash_h)
-quiet_cmd_orc_hash = GEN     $@
-      cmd_orc_hash = mkdir -p $(dir $@); \
-		     $(CONFIG_SHELL) $(orc_hash_sh) < $< > $@
-$(orc_hash_h): $(srctree)/arch/loongarch/include/asm/orc_types.h $(orc_hash_sh) FORCE
-	$(call if_changed,orc_hash)
-archprepare: $(orc_hash_h)
-endif
-
 ifdef CONFIG_DYNAMIC_FTRACE
 KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
 CC_FLAGS_FTRACE := -fpatchable-function-entry=2
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 8af6b80cffdd..9089318a621c 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -331,18 +331,6 @@ ifeq ($(RETPOLINE_CFLAGS),)
 endif
 endif
 
-ifdef CONFIG_UNWINDER_ORC
-orc_hash_h := arch/$(SRCARCH)/include/generated/asm/orc_hash.h
-orc_hash_sh := $(srctree)/scripts/orc_hash.sh
-targets += $(orc_hash_h)
-quiet_cmd_orc_hash = GEN     $@
-      cmd_orc_hash = mkdir -p $(dir $@); \
-		     $(CONFIG_SHELL) $(orc_hash_sh) < $< > $@
-$(orc_hash_h): $(srctree)/arch/x86/include/asm/orc_types.h $(orc_hash_sh) FORCE
-	$(call if_changed,orc_hash)
-archprepare: $(orc_hash_h)
-endif
-
 archclean:
 	$(Q)rm -rf $(objtree)/arch/i386
 	$(Q)rm -rf $(objtree)/arch/x86_64
-- 
2.55.0


