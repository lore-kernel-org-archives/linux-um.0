Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03924C54756
	for <linux-um@archiver.kernel.org>; Mon, 19 May 2025 21:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B4UzQjKfW4X5ZMrWDk+5j93l71ntgJWSBAnqAmb9J6k=; b=DwMfPMo6WCZQGf09a/d5ghXLQb
	/wAh2opfPYBBNvs5rDsnIYmvPHOAzHpoKyc4fStptHFwiar0wZFL9nbW3WGeSJZaUSN7yCXETdfM4
	clzVyjxI0/OfJpaMvIrGnO+QfKj86NLvzz0G1Z1B+wUXwHTJoC0Wur7mR/C6q6oAR0QDMQ1UO2751
	HQe3U0rE/XgwzODVeJtjFWxrgFBleYKEKBJVZoDBlq1vLFYo3h54t0ZWr389B1mEPG4/uvUIc9+9Q
	K4s+HajK32HktOVtvyThLWDXvQdA90ESqYeyhlawwrWMMHIxbeDwFGBm1T1o+s5Zsdm1lkig/wyLK
	6e+KHYMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH804-0000000AXES-2ZmZ;
	Mon, 19 May 2025 21:26:20 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH7w9-0000000AW0l-1vZA
	for linux-um@lists.infradead.org;
	Mon, 19 May 2025 21:22:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E05D5629DD;
	Mon, 19 May 2025 21:22:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 525FAC4CEEB;
	Mon, 19 May 2025 21:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747689736;
	bh=1fJVId28LO8VYcmUKnPr0/4A/64dGWmqoZ8gpVd+k8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OqiJAmx707UF1wWAbKx1GvcvYiPhyNmAqVaTKff1lzbS+TM1MOysSu3dM2S9wJFC2
	 +AOaoSL2ai8o3qGbZ8vjhkW/GA1Rkac4i7z4QoJXsnHMMlXUd9NpHY5aT3Dj5j1gH7
	 K2v4rC1qRi7APzX8CZPQ+Oii6U16TtphlDFPfOFTAPUzaQCFkD9ESR1NL2SYoaTH1y
	 Y1XnnVMOaVzCvhCbjJLiqY/WlRxGqTxRI+WWunDG+ubqMzzSTTyjjJLTzXYUj3O0Hi
	 7FrYWecsgWSkhEF7vu01i/bUPYFUJiiH3cOBM1h3ueO5F/yH0eYIFmqLsGs6+xuzUr
	 SEXGNVP6LBXkw==
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
Subject: [PATCH AUTOSEL 6.12 05/18] um: let 'make clean' properly clean underlying SUBARCH as well
Date: Mon, 19 May 2025 17:21:54 -0400
Message-Id: <20250519212208.1986028-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250519212208.1986028-1-sashal@kernel.org>
References: <20250519212208.1986028-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.29
Content-Transfer-Encoding: 8bit
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
index 00b63bac5effb..3317d87e20920 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -151,5 +151,6 @@ MRPROPER_FILES += $(HOST_DIR)/include/generated
 archclean:
 	@find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \
 		-o -name '*.gcov' \) -type f -print | xargs rm -f
+	$(Q)$(MAKE) -f $(srctree)/Makefile ARCH=$(HEADER_ARCH) clean
 
 export HEADER_ARCH SUBARCH USER_CFLAGS CFLAGS_NO_HARDENING DEV_NULL_PATH
-- 
2.39.5


