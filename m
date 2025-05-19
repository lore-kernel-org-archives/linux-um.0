Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 571D2C2D0CD
	for <linux-um@archiver.kernel.org>; Mon, 19 May 2025 21:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q8HDhOFVvm0M/VFvOLt6deiCIN03KZRtQW8BQBv9cS0=; b=PZxillLoQuZfl5TSHKRDsWGo7d
	BJiJw9GS18vRFbkmA+bgMjf7qlogN65OkQnzz4sOS62Z8qG4LyBNPTwQuYN1MZ5MhCXngrN8AXa3a
	kIPIHktW1gvycv6z2TfMn3L2ZmJ6MgvqaysMlQctvZ/35Ew4CVSqLqJAwpjGqv281JiTB88U7I7nW
	PrHTkg4fBlsQblbLHr0BK+v2GKUmO3JBPaPgohFJPQV0Nw0eyRB7AwgC6PM6guBaETXZGf69hq1kJ
	mdkp2mNNNIrMZ+XKlb+i8dLKlQPdry92NK+ITZ15U6wcVuO7AQgCqoGGn14xcEVAnOGJ1OaSryCK9
	VGUwNwmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH86O-0000000AZAC-0Auj;
	Mon, 19 May 2025 21:32:52 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH7wt-0000000AWLo-2RWm
	for linux-um@lists.infradead.org;
	Mon, 19 May 2025 21:23:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D1F0E5C55D9;
	Mon, 19 May 2025 21:20:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72100C4CEEB;
	Mon, 19 May 2025 21:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747689782;
	bh=6n+OngFmmbP+Dw1XzvTK/BDDrMreBDWb/qqniRIyRMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eUV9oAo67Clmf9ptaMkKfGs9Ks29RAo1yQ/Yw6ZhSZHvC7R4H2oX5gshu0BFRrNtV
	 PwpgQh1F+A49VIGWegexvkmLctqnvBkCiBGMNfyHSVxGTucZYSXBbiDQKlC0elQ1Q4
	 jcj5Ku5iOOyBUM1t9Nd8q3aSpCpKvqRXlXXLv/ITgh2DqpTFIuRiXTocVn0XvISCCl
	 QirUl/h1S57FvMCccvZmPOiki34CmAGB7RITfLz7t8Pxhqp3XEi0OSzjZyjE0vk9K5
	 Dk9BKoEOm1uaXWd0NRRJ5KRf90k2Hgy151X9BMXIkjUcGfrJc2ymFlsg2hVRKU0f23
	 atipN4XPKS0xQ==
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
Subject: [PATCH AUTOSEL 6.1 4/8] um: let 'make clean' properly clean underlying SUBARCH as well
Date: Mon, 19 May 2025 17:22:51 -0400
Message-Id: <20250519212255.1986527-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250519212255.1986527-1-sashal@kernel.org>
References: <20250519212255.1986527-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.139
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250519_142303_672103_8F695407 
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
index 778c50f273992..25d0501549f54 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -155,5 +155,6 @@ MRPROPER_FILES += $(HOST_DIR)/include/generated
 archclean:
 	@find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \
 		-o -name '*.gcov' \) -type f -print | xargs rm -f
+	$(Q)$(MAKE) -f $(srctree)/Makefile ARCH=$(HEADER_ARCH) clean
 
 export HEADER_ARCH SUBARCH USER_CFLAGS CFLAGS_NO_HARDENING OS DEV_NULL_PATH
-- 
2.39.5


