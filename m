Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67ACDD0C5E8
	for <linux-um@archiver.kernel.org>; Fri, 25 Oct 2024 08:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9w+Dyx67WIMHM+cYps1OS6tmVvlUvQZLrcmxUWiLtLA=; b=AAWbPzk4mHtibT4cesPUCcEoLh
	TN0ha6UsxVJuP0jhgNp0xFv/wF4/znvLnn8UY7JnpYYPUroR1UA9olVwMMsbcwZtz8bUEC27Cy1op
	50DQRv3Fr7whTqW4VS/T5jV7AN0DkNbQId0uk9SPMfql9nO4BsLb+deVEMxu5/+NV2hr/gqH+qnLV
	UOqS3RjWm9XXPFN32tMWh9iFeMschGgCVF9zs/BSNaz44trz1ZYo6WLegKbK/WoCoyzINkS0YjsF9
	P83eM6d3HbKZYIhZdEn73SaQzgzU3xl/emCTHxnu7YQKaLRw9R76y/6v2PeagUD3BkGVL8t8D2LAG
	rVTUlVkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4Ffm-00000002ye4-3dbR;
	Fri, 25 Oct 2024 08:27:54 +0000
Received: from s3.sipsolutions.net ([168.119.38.16] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4Ff7-00000002yYh-2UD6
	for linux-um@lists.infradead.org;
	Fri, 25 Oct 2024 08:27:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=9w+Dyx67WIMHM+cYps1OS6tmVvlUvQZLrcmxUWiLtLA=; t=1729844831; x=1731054431; 
	b=ImzI6Ig+ET2BgPZbDCapQzWTAF62TypUl+BTsM5kCH9H4OLJzZodFln0nGgOi5utEX/iQLEv5oI
	IEDlsv+GjzM1gwTuwJRmqu49cgTLpIwNrM+u1zLtYfnHqrgfDaNyi9hF37Zrob+76Ag5qrNpnUSSr
	NLsr5DQfjNfBbFFvzZvKUGOOxFrRGsraAjNi3sLZkJF2hXTfQl/nF5c8564aOtzBxfUaTqi02fLYS
	Dv+i9nSV+fybtr9o0i9hnXRpM8Tu27cZGgmV9ZzoOSs/Sl+70SAYhAHQ31EwP4zU8zotTm8+Dw2Vb
	ejhwl4v2S51RlKTYPvRdrlxQKW5Eu63XtKlw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t4Fez-00000004R3e-3v0w;
	Fri, 25 Oct 2024 10:27:06 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Nathan Chancellor <nathan@kernel.org>,
	benjamin@sipsolutions.net,
	Johannes Berg <johannes.berg@intel.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] um: fix stub exe build with CONFIG_GCOV
Date: Fri, 25 Oct 2024 10:27:01 +0200
Message-ID: <20241025102700.9fbb9c34473f.I7f1537fe075638f8da64beb52ef6c9e5adc51bc3@changeid>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_012713_667903_42C737BA 
X-CRM114-Status: GOOD (  12.09  )
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

CONFIG_GCOV is special and only in UML since it builds the
kernel with a "userspace" option. This is fine, but the stub
is even more special and not really a full userspace process,
so it then fails to link as reported.

For good measure, also remove the GPROF options, even though
they don't seem to cause build failures now.

To be able to do this, export the specific options (GCOV_OPT
and GPROF_OPT) but rename them so there's less chance of any
conflicts.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202410242238.SXhs2kQ4-lkp@intel.com/
Fixes: 32e8eaf263d9 ("um: use execveat to create userspace MMs")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/Makefile-skas        | 14 +++++++-------
 arch/um/kernel/skas/Makefile |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/um/Makefile-skas b/arch/um/Makefile-skas
index 67323b028999..1a27e65bcb9c 100644
--- a/arch/um/Makefile-skas
+++ b/arch/um/Makefile-skas
@@ -3,15 +3,15 @@
 # Licensed under the GPL
 #
 
-GPROF_OPT += -pg
+export UM_GPROF_OPT += -pg
 
 ifdef CONFIG_CC_IS_CLANG
-GCOV_OPT += -fprofile-instr-generate -fcoverage-mapping
+export UM_GCOV_OPT += -fprofile-instr-generate -fcoverage-mapping
 else
-GCOV_OPT += -fprofile-arcs -ftest-coverage
+export UM_GCOV_OPT += -fprofile-arcs -ftest-coverage
 endif
 
-CFLAGS-$(CONFIG_GCOV) += $(GCOV_OPT)
-CFLAGS-$(CONFIG_GPROF) += $(GPROF_OPT)
-LINK-$(CONFIG_GCOV) += $(GCOV_OPT)
-LINK-$(CONFIG_GPROF) += $(GPROF_OPT)
+CFLAGS-$(CONFIG_GCOV) += $(UM_GCOV_OPT)
+CFLAGS-$(CONFIG_GPROF) += $(UM_GPROF_OPT)
+LINK-$(CONFIG_GCOV) += $(UM_GCOV_OPT)
+LINK-$(CONFIG_GPROF) += $(UM_GPROF_OPT)
diff --git a/arch/um/kernel/skas/Makefile b/arch/um/kernel/skas/Makefile
index f6a219074772..3384be42691f 100644
--- a/arch/um/kernel/skas/Makefile
+++ b/arch/um/kernel/skas/Makefile
@@ -24,7 +24,7 @@ $(obj)/stub_exe: $(obj)/stub_exe.dbg FORCE
 
 quiet_cmd_stub_exe = STUB_EXE $@
       cmd_stub_exe = $(CC) -nostdlib -o $@ \
-			   $(KBUILD_CFLAGS) $(STUB_EXE_LDFLAGS) \
+			   $(filter-out $(UM_GPROF_OPT) $(UM_GCOV_OPT),$(KBUILD_CFLAGS)) $(STUB_EXE_LDFLAGS) \
 			   $(filter %.o,$^)
 
 STUB_EXE_LDFLAGS = -Wl,-n -static
-- 
2.47.0


