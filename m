Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB1E3E95A9B
	for <linux-um@archiver.kernel.org>; Mon,  9 Oct 2023 12:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WRXa6IsWfgz6VqYGI+Iguoadf6ANsU1EemByBP0/FvA=; b=tEwPrYBvqrAPhM
	qb9tyfZoqmVsNCxUTirbE4AfNq9iRuFsZewVsT1qjFxkgRAJn05LiwuiIotNLUPoKAsZAetTjV3CV
	fLgp542REufa2gu7JskU9JD62XlgVl2FMmv3Fa4ySrIirk64j4RKvSRVh9AmE27mBGtczgdyBR7HS
	bk1ypKtD0/pn0GLjAtZ1b4wDHFQ19M3i83rUOxWVF7qSJhy3/ErqiLdxMjpiQFcIkWdHXlwb+Ynrf
	1wZjsad0AGUSFoEfI9n7bugkJI8w9lzp/uCDdThgGc3gqsjFJRf8l5p6AHP+goFmocvc8DjwIgmCN
	4q/Bku4cTFWFxkq37MkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qppag-00AhgL-1N;
	Mon, 09 Oct 2023 12:42:30 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qppab-00AhcW-0r;
	Mon, 09 Oct 2023 12:42:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id EED39B811A5;
	Mon,  9 Oct 2023 12:42:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160ADC433C7;
	Mon,  9 Oct 2023 12:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696855343;
	bh=2pDAXsYdr6lnZaEYy+XyoiLH0SPTSNq4AwXsBcAaKjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OHYkpZWPOomWrfTFYsYVR0dUXhsAstX8BQkaIe3nW9TdyVFGMja92VWRyCVFwtvLu
	 CbD7EBBZEDbE6fCV4YR61vYddvnMXW67ZL85pe26/hUqPjUmqu0OAa8XY0PvvwbenC
	 /oGofIlRr4w/Og4GChSzkelChds0+PIHOQPVgEybQ6zx+9uKj1+hy9HriCG/xUVpot
	 U3xkmlZXMutL2G9oSGHhPB7gSKKDzof5imbxXPmpSZKgOHnUaD+6xRQHglYQzxwJjW
	 yT5ERsvwknSJqNYTvtNznli7Pq9cxsMmX8BJaFSR2Egmg1Nb1Tb44If/mAVcG+esbL
	 kM3C1xQExPh2Q==
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
	Helge Deller <deller@gmx.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: [PATCH 3/5] parisc: remove broken vdso_install
Date: Mon,  9 Oct 2023 21:42:08 +0900
Message-Id: <20231009124210.1064021-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009124210.1064021-1-masahiroy@kernel.org>
References: <20231009124210.1064021-1-masahiroy@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231009_054225_443280_11CD1D73 
X-CRM114-Status: UNSURE (   8.80  )
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

'make ARCH=parisc vdso_install' has never worked. It attempts to
descend into arch/parisc/kernel/vdso/, which does not exist.

The command just fails:

  scripts/Makefile.build:41: arch/parisc/kernel/vdso/Makefile: No such file or directory

The second line is also meaningless because parisc does not define
CONFIG_COMPAT_VDSO.

It appears that this code was copied from another architecture without
proper adaptation.

Remove the broken code.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/parisc/Makefile | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
index 968ebe17494c..4222fa73c34a 100644
--- a/arch/parisc/Makefile
+++ b/arch/parisc/Makefile
@@ -177,13 +177,6 @@ vdso_prepare: prepare0
 	$(Q)$(MAKE) $(build)=arch/parisc/kernel/vdso32 include/generated/vdso32-offsets.h
 endif
 
-PHONY += vdso_install
-
-vdso_install:
-	$(Q)$(MAKE) $(build)=arch/parisc/kernel/vdso $@
-	$(if $(CONFIG_COMPAT_VDSO), \
-		$(Q)$(MAKE) $(build)=arch/parisc/kernel/vdso32 $@)
-
 install: KBUILD_IMAGE := vmlinux
 zinstall: KBUILD_IMAGE := vmlinuz
 install zinstall:
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
