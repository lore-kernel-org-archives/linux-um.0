Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B13C2D0CD
	for <linux-um@archiver.kernel.org>; Mon, 19 May 2025 21:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JQWBuZmfj4EyxpUzcW+bfxROnTWbE2/ZN4g/GrBQTas=; b=yZ+8gTjZ7z7FEaM2vIJc2spTpR
	aDY4w0LiWfDuvn8GoYZOyMINULbSopBHRqpEsgpKtDzIdJNQWWLW6QoQcfzn5JpDf7fvucaDllyhr
	K4Hh9QEE5tAqTxkrx1fpNsAr/KOoqfWBbp+txJtMd1WcBB/IOdUw5/7Cn0Evit8NPVYT35w8WhDro
	j9BOA+n2rA6YLqCmKXeOnuQVFediZ3VuTV/OTj0q0Ck1LFU68A6A9NL1vM5hyp7+F0s44TLHULaZH
	xO+UYVxqSB+1rWpP4wON79XlvCQGarOjHVhEEkWhF36Vw/whuSVj7QwonN2YbzSgiwZ/76fa7QpME
	niXOItbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH8Ch-0000000AbLM-3ch9;
	Mon, 19 May 2025 21:39:23 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH7xT-0000000AWWA-0cjI
	for linux-um@lists.infradead.org;
	Mon, 19 May 2025 21:23:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6D47C5C55C7;
	Mon, 19 May 2025 21:21:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDE6C4CEEB;
	Mon, 19 May 2025 21:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747689818;
	bh=Y2fcy43w1c29ZAiohb+yJAKWKqujaYpYj9pN82NIrVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TmRduaLeaG1Tpl4l1jYvrx6SzHw68cSMfpd2itfrDcB8pxnge7w+6MVbJKnkXfV2S
	 7k5Xhv2mN3Eea/jfJd2swJGHpQSB7Wk6w/3AOxV6ck58STkhR0RH9eTceevrpC6mQ1
	 7DTTdLqYuSX0ysxtCd8H6vBOUBtoDPeMCvFtivc2OIXyzfcu4t/Wke/r15/98z1GbT
	 RAdqkRh+cU28iNS1KRRpgH4/NcZu7RxQUUIJ8tufWqVSNWx63somwMCLsadnKEsGge
	 +oFmhQb1mACy8yotKc6JA6f76PtYdg18NoTEwxWNlzCqc1xWKLQMaE3idlhoeAmsTb
	 gFfbeod2T02LQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	David Gow <davidgow@google.com>,
	Sasha Levin <sashal@kernel.org>,
	jdike@addtoit.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 4/5] um: let 'make clean' properly clean underlying SUBARCH as well
Date: Mon, 19 May 2025 17:23:30 -0400
Message-Id: <20250519212331.1986865-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250519212331.1986865-1-sashal@kernel.org>
References: <20250519212331.1986865-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250519_142339_231222_92F9DE8B 
X-CRM114-Status: GOOD (  11.25  )
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

From: Masahiro Yamada <masahiroy@kernel.org>

[ Upstream commit ab09da75700e9d25c7dfbc7f7934920beb5e39b9 ]

Building the kernel with O= is affected by stale in-tree build artifacts.

So, if the source tree is not clean, Kbuild displays the following:

  $ make ARCH=um O=build defconfig
  make[1]: Entering directory '/.../linux/build'
  ***
  *** The source tree is not clean, please run 'make ARCH=um mrproper'
  *** in /.../linux
  ***
  make[2]: *** [/.../linux/Makefile:673: outputmakefile] Error 1
  make[1]: *** [/.../linux/Makefile:248: __sub-make] Error 2
  make[1]: Leaving directory '/.../linux/build'
  make: *** [Makefile:248: __sub-make] Error 2

Usually, running 'make mrproper' is sufficient for cleaning the source
tree for out-of-tree builds.

However, building UML generates build artifacts not only in arch/um/,
but also in the SUBARCH directory (i.e., arch/x86/). If in-tree stale
files remain under arch/x86/, Kbuild will reuse them instead of creating
new ones under the specified build directory.

This commit makes 'make ARCH=um clean' recurse into the SUBARCH directory.

Reported-by: Shuah Khan <skhan@linuxfoundation.org>
Closes: https://lore.kernel.org/lkml/20250502172459.14175-1-skhan@linuxfoundation.org/
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Acked-by: Johannes Berg <johannes@sipsolutions.net>
Reviewed-by: David Gow <davidgow@google.com>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 94cea8d46b222..daec900ed4631 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -154,5 +154,6 @@ MRPROPER_DIRS += arch/$(SUBARCH)/include/generated
 archclean:
 	@find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \
 		-o -name '*.gcov' \) -type f -print | xargs rm -f
+	$(Q)$(MAKE) -f $(srctree)/Makefile ARCH=$(HEADER_ARCH) clean
 
 export HEADER_ARCH SUBARCH USER_CFLAGS CFLAGS_NO_HARDENING OS DEV_NULL_PATH
-- 
2.39.5


