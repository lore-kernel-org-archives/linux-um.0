Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C63FE95A97
	for <linux-um@archiver.kernel.org>; Mon,  9 Oct 2023 12:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ByltcH+7z6kDxHcdb0kVnfEUF5L652UL7k5WGUlGNu0=; b=lQITpnBLD1bM2H
	GVACmV/fVnIVXLEccGcDRGoYaKyMF8b2DMce7NGegJ6IsQ8tWDdnzDpEiUSocK4aNb1FRvj9tGq1b
	RdkNvd1dsqdbVZtY5DtbrIJvvvQ68prKKVf5MnvUpJRjuUw846wGsR8FihKHPhi/YQMwW5iAIQcME
	QDYGkJeVwTNbhEa5LYEWBy8qKtil4RHExyt5ZSg/OtvJdsiXNAIese+XWbU4xGp2pRg3FbpBhfM25
	2PB6o0tYtdY6V4AQWunyJJsUeSz8WURumgggdxdQOh9TBBbQorVWQdWkMQPBEQEHajfsNaOW1KPTb
	R+v8WYujSj4RYrVWY9kQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qppad-00Ahe8-2X;
	Mon, 09 Oct 2023 12:42:27 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qppaZ-00Ahag-0R;
	Mon, 09 Oct 2023 12:42:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 4CA1FB81141;
	Mon,  9 Oct 2023 12:42:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23E8C433CB;
	Mon,  9 Oct 2023 12:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696855340;
	bh=0Mvn9evzK2eDTt9ImjWv6gFTvimaT+Ux65IlUsSU9J4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a+nTKzlQYxS210dCgf5bEFFzKx9iYFpjdrYTH5DJ6GVdRyI9ueR8xc3qJhRYOTEt+
	 hGNE7G28BPmLvowjslnpOULS/Gij+RwY5hxX6KdVqrON7G+tGhMAoH1kCQmoX+GbD2
	 SwDW8g6Y2b5udj3KUO+ZS95oNT//z+FLa5v8TMzOHOOtnx4wsUULlfbZBBnFkzOfII
	 f0eEVUOXXZg7LVO+2scQ9jU18eJfnam2vELwA7kFzSfLe8O6IajPX+tb2QVp6+SZxN
	 0J4oVhunK66t5+4zMUgOeLUbA7VI540cA73O4xzziJ6Lrs8MQRVZ65g4f6pOczPY0j
	 txTCCRRjkdTFQ==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org,
	x86@kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Richard Weinberger <richard@nod.at>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 2/5] UML: remove unused cmd_vdso_install
Date: Mon,  9 Oct 2023 21:42:07 +0900
Message-Id: <20231009124210.1064021-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009124210.1064021-1-masahiroy@kernel.org>
References: <20231009124210.1064021-1-masahiroy@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231009_054223_323540_CE5F4E5C 
X-CRM114-Status: UNSURE (   8.65  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

You cannot run this code because arch/um/Makefile does not define the
vdso_install target.

It appears that this code was blindly copied from another architecture.

Remove the dead code.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/x86/um/vdso/Makefile | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
index 6825e146a62f..b86d634730b2 100644
--- a/arch/x86/um/vdso/Makefile
+++ b/arch/x86/um/vdso/Makefile
@@ -67,15 +67,3 @@ quiet_cmd_vdso = VDSO    $@
 
 VDSO_LDFLAGS = -fPIC -shared -Wl,--hash-style=sysv -z noexecstack
 GCOV_PROFILE := n
-
-#
-# Install the unstripped copy of vdso*.so listed in $(vdso-install-y).
-#
-quiet_cmd_vdso_install = INSTALL $@
-      cmd_vdso_install = cp $(obj)/$@.dbg $(MODLIB)/vdso/$@
-$(vdso-install-y): %.so: $(obj)/%.so.dbg FORCE
-	@mkdir -p $(MODLIB)/vdso
-	$(call cmd,vdso_install)
-
-PHONY += vdso_install $(vdso-install-y)
-vdso_install: $(vdso-install-y)
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
