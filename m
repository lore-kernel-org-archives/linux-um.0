Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2EE8C2D0CD
	for <linux-um@archiver.kernel.org>; Mon, 19 May 2025 21:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xJVq6aaFqVCWitKw5bqNdqIhcTAha3GnoR3BxUOJjvw=; b=chmdqBYf2IK3epkAnjqWqyriNJ
	ne3UURhc/LUWswP4r1bL1NUFUEvazgv4E5nd+wqEVo8cmhoz9QDq/vGMmF9E76QcqqBYH2INn8Ir+
	4ld9faHCGHYLEiCNs8XZdYBsJ1U4n+gxBSjWJO2bs79dFICX7DNB8kKTLt+QlYkLDtrHpQjrZP2v3
	36FJRvaxoLIh6VF7SHQH23RphTA3V/aPMBeqioS75a4qtLJ6phSry2BSmX2ZebMHZqWtcDSgbGkVV
	khFRksmFMby8u6m8lqYLgbfkkswKAJbiJVk4EiWQy+sC4sypc3iz2q5lIIAK+Kn30jIeQIC4Fc3Jl
	6+xXlDYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH7ve-0000000AVmu-3R69;
	Mon, 19 May 2025 21:21:46 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH7vb-0000000AVkg-1Ky7
	for linux-um@lists.infradead.org;
	Mon, 19 May 2025 21:21:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id BC0314AB5D;
	Mon, 19 May 2025 21:21:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54678C4CEE9;
	Mon, 19 May 2025 21:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747689702;
	bh=KYLe2AhfSV9Xk4BDZ17de7Uw/ON1XQ1IFlFIrYLsaaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mnktO4p7jYkCLPA/j/1pJYX7XVHlzNSGhtYiTmrysDZdLnmQBkbOcZvAAfJWwZoq9
	 4G4bXxMx6s3PoeTb+ASal3OVwJO3YG3Z6Yj2gGFsZxD8063tNoDihu3E71sSnJq7Pk
	 VfrKm3fDHRXptAOwqSe2LwIX6exfrzNFrbP9VcH+d9YiYhU/jDGsl/ikoa6MUjlG+J
	 lQPEJM++w1sjwWzw4qPGFLwnbHNInn1KiRBF1UQjXryiNcn6mIV/vEp4gtmbnh6m/f
	 nMTg5QMhGcVQWNv0U34M5AMfqPc29kxDmIfBVf2pvO30uoCIX308cjKFIifyfSueSC
	 iePWuR6cyvV9w==
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
Subject: [PATCH AUTOSEL 6.14 07/23] um: let 'make clean' properly clean underlying SUBARCH as well
Date: Mon, 19 May 2025 17:21:14 -0400
Message-Id: <20250519212131.1985647-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250519212131.1985647-1-sashal@kernel.org>
References: <20250519212131.1985647-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.7
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250519_142143_382764_9DC98A5D 
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
index 1d36a613aad83..9ed792e565c91 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -154,5 +154,6 @@ MRPROPER_FILES += $(HOST_DIR)/include/generated
 archclean:
 	@find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \
 		-o -name '*.gcov' \) -type f -print | xargs rm -f
+	$(Q)$(MAKE) -f $(srctree)/Makefile ARCH=$(HEADER_ARCH) clean
 
 export HEADER_ARCH SUBARCH USER_CFLAGS CFLAGS_NO_HARDENING DEV_NULL_PATH
-- 
2.39.5


