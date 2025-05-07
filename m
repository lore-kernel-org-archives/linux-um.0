Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1CD2C3ABC0
	for <linux-um@archiver.kernel.org>; Wed,  7 May 2025 08:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lbFgYWNa4ic7ubtFoCwYiMTMfA9HXSjJ+JUdvkdBZF4=; b=Fb8oCh9HRUWEjaSMDLkGZw7Us9
	QaIBTx/+jSMdDxGlhWBXqBkJUISxbUcjJXOHpvTcAusnXzNzhpWg/htpi4mhJLcfXNrpyT4DCrzm8
	S/PY/juG7p1uNdm6pXGNLgNgxNZ5T8CS6tfgsOK/iU/efJ9z0U2LNZWb0pD8WBc1qktF+Pbq/tjP+
	cJTHmY2NpZOQUFH+JA4gspkh83BfEI202aTRdQ/uYUIHE2bT2sSsPKhR36P9U+lXQPr40ZDtD6bCk
	qb65+bVUUGxBy755Zp2UFRE7SBZXZgU9UTdUVLTTT9+a3ClYCeSDU7kFKoTicj9Nxegfjd04+riWx
	6KSviJfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCaMu-0000000EnjE-2FBH;
	Wed, 07 May 2025 08:43:08 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCZXE-0000000EbHm-3RdO
	for linux-um@lists.infradead.org;
	Wed, 07 May 2025 07:49:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 9AFC1A474BD;
	Wed,  7 May 2025 07:49:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA50C4CEE7;
	Wed,  7 May 2025 07:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746604182;
	bh=aKVeXsVP1cmcQfXqQm3R+VpM9vL3zBUMDZE6Vqz1Ib0=;
	h=From:To:Cc:Subject:Date:From;
	b=TmRVgbtwaSR0HjomtUmH68y8XAFpWC7aZdgMOanCq7iAvSBE3Y7b8GevOKidbrHdt
	 I9EjH22spCzKxxSUQVsmpX54b2ZwCpHtHEXdY7OJ7Pa7jSxfwVXWds8V15ybapQ2yr
	 xhAWUdNH+5IzqwnRprjbAALxBg3F0bqfiTHeLgwaHz8SjPUl9JkBht4mQSefAEhnaB
	 cwkMV9EUC5Yzm/YZy3ymc6dEy7KjLIu9WMApSZr1MiC6P04OL284KUT9zFJ5CU0zEf
	 Ag/qa4jq5jdGjEsXaxaLj+Xtasl2riVoHXhg+8eiGwHT0x5OdPSnYLq1yLVX7ITyeR
	 SddZSSct/WJCg==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Richard Weinberger <richard@nod.at>,
	linux-um@lists.infradead.org
Subject: [PATCH] um: let 'make clean' properly clean underlying SUBARCH as well
Date: Wed,  7 May 2025 16:49:33 +0900
Message-ID: <20250507074936.486648-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_004944_922230_BAB56853 
X-CRM114-Status: GOOD (  10.47  )
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
---

 arch/um/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 1d36a613aad8..9ed792e565c9 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -154,5 +154,6 @@ MRPROPER_FILES += $(HOST_DIR)/include/generated
 archclean:
 	@find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \
 		-o -name '*.gcov' \) -type f -print | xargs rm -f
+	$(Q)$(MAKE) -f $(srctree)/Makefile ARCH=$(HEADER_ARCH) clean
 
 export HEADER_ARCH SUBARCH USER_CFLAGS CFLAGS_NO_HARDENING DEV_NULL_PATH
-- 
2.43.0


