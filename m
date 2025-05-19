Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBADC3ABDD
	for <linux-um@archiver.kernel.org>; Mon, 19 May 2025 21:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LGlcQmXWjl5ZVmbr1fENYp9XhvjKno5bCdfwtnieJnI=; b=DvQ8vNK4i+qQYrdBmaszFEL/qf
	ti5n0iGS0S/Yh9HJgLtXn4PDtVUw8m4G5QNJrUNkJY2nVgmhus2K4ASSkQSvqOF87Om7qBAwy1PKu
	MBQoeEh6Vl87OwVwq6tj3OP9HwzuYno36BIrNxEvN8/ZVM1o3VZu/bAEnpdWxxN+R48OS3lNiUjO5
	HbLsiooXniN2QCbJItTP5iWqhd+HdzzpMiESSnYYjbu8tPr0ajjFvjQdo0jF/SP0SHs0fFDmP6P+x
	k0nUDFLVI+ywQ+jbcv+jaVK36WAbWZIHjXz32jvPZ9OWU16bVzKtj5M6BYuM3tQ6tZqb5Wmz/QeUu
	oBG+q/7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH88U-0000000AZrQ-3N1x;
	Mon, 19 May 2025 21:35:02 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH7x6-0000000AWPL-1mOp
	for linux-um@lists.infradead.org;
	Mon, 19 May 2025 21:23:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 20F4749E25;
	Mon, 19 May 2025 21:23:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11E5C4CEED;
	Mon, 19 May 2025 21:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747689796;
	bh=01V2kp9PR7OuzoxgYCqNxryI2MMU4E7MhSbRS54NI7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T/sDpt9EARXbj9sgQ9sZu/80cXKnT95njuh+msu2/mXg18P7CUlDUUiGz5mPmU2rk
	 EGzHR0AEMXpnD1eQmgabprd9I1OiS1Yp/FWrFIJdjbBdjxz1Jk8qwwjNNdfTyJFhSM
	 vI7IUF2fIdqgl94dF0TI2xl0T2hlb0v6yipt+k54MeItauXXuT2AcBP75KUogH4dsy
	 TDV+HK+QOwTf8mJqOPX9PEG2k0/1xjiKw7ZM4Q8w8iGqY87qre0lxg03TCdoS/Hz4X
	 uxprMqZDJa8SwKMXvkHi69OjZ3kITxWfBDSm9oMqPdMv9PgZMaEd1umAUM8mHBb17J
	 U90cWfMEir5sg==
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
Subject: [PATCH AUTOSEL 5.15 4/7] um: let 'make clean' properly clean underlying SUBARCH as well
Date: Mon, 19 May 2025 17:23:05 -0400
Message-Id: <20250519212308.1986645-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250519212308.1986645-1-sashal@kernel.org>
References: <20250519212308.1986645-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.183
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250519_142316_485945_EC2FFA90 
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
index 3dbd0e3b660ea..1257ef03d1b7a 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -153,5 +153,6 @@ MRPROPER_FILES += $(HOST_DIR)/include/generated
 archclean:
 	@find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \
 		-o -name '*.gcov' \) -type f -print | xargs rm -f
+	$(Q)$(MAKE) -f $(srctree)/Makefile ARCH=$(HEADER_ARCH) clean
 
 export HEADER_ARCH SUBARCH USER_CFLAGS CFLAGS_NO_HARDENING OS DEV_NULL_PATH
-- 
2.39.5


