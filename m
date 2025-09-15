Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD9CCA101F
	for <linux-um@archiver.kernel.org>; Mon, 15 Sep 2025 07:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UVHwzh9sHs6Xo02VEWpZXjxZy4cbskfDXgmFGFBhsbs=; b=qOPiOVFaq6wDjBQZ+ox0ezMgkk
	hf2i4dli+8N9e3vVY/JbPb2H/llKv8o/cjHnYgTxKQ3ci6cQd54EsdOmv/C/D30XyXRRScE1NmR87
	fPsXbMP4COou3ld31OhxE6fLF52JQlQotHxn8uxRqwhVfIkR38VGVZV28fAferBiD1jfp5gq20X18
	67yRK9BrzYBxrgkHL+RKfTBP8GIx2QiK7ozPaQzpmC+qinMdc83UaZnRADOBPu0JXenrnYc9t8oX0
	R9jumiMBzprhCH5xz5jm3j2xSgzznXMLHBNDhjaB0oixZuN7Nw3zsp/o0rmXH88b7wRGRR+nJoVLw
	pG4o1K/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy3XT-000000031u1-1rv8;
	Mon, 15 Sep 2025 07:22:15 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy3XP-000000031nS-3ilp
	for linux-um@lists.infradead.org;
	Mon, 15 Sep 2025 07:22:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=UVHwzh9sHs6Xo02VEWpZXjxZy4cbskfDXgmFGFBhsbs=;
	t=1757920931; x=1759130531; b=g3p/nEhWujUontV/eephpeYBJqkB9bDOL/diVMhDL5wWeDp
	QkeOzFGPvnJLhZvw5xONN9FwU+iL7G+wabQrbqGwZtGKsJYE5dxuEJw+VVzRMjTEwnfo7rTbjl1cG
	svwDD428ZA1zFAvJYEnxGYbnNW6yUcsW968Hgm1ESgXvutyoOy2mocBks+jIn68iCuf2pFnJJNtLe
	O/NdpQSuGb1cCtD50DqUAgV5z3ktB+E6vB1GcMobcMxO0rhz7Krgk1RLoFKEXTxBvp5mBzgiBpgKW
	y8nJmsbSd1YOgw216McNUELG3IF3Af5Sg7iZjWAd16Wac+5g0SyNubdddSGsPWOg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uy3XN-00000005w6o-0J1R;
	Mon, 15 Sep 2025 09:22:09 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 8/9] um: use nolibc for the --showconfig implementation
Date: Mon, 15 Sep 2025 09:11:14 +0200
Message-ID: <20250915071115.1429196-9-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915071115.1429196-1-benjamin@sipsolutions.net>
References: <20250915071115.1429196-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_002211_974273_BC4F2613 
X-CRM114-Status: UNSURE (   9.76  )
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

From: Benjamin Berg <benjamin.berg@intel.com>

This is one of the simplest files and it can be switched over to use
nolibc without any modifications.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/kernel/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index b8f4e9281599..4b206a40b611 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -26,7 +26,7 @@ obj-$(CONFIG_OF) += dtb.o
 obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
 obj-$(CONFIG_STACKTRACE) += stacktrace.o
 
-USER_OBJS := config.o
+NOLIBC_OBJS := config.o
 
 include $(srctree)/arch/um/scripts/Makefile.rules
 
-- 
2.51.0


