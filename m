Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC60D2F7C4
	for <linux-um@archiver.kernel.org>; Wed, 16 Oct 2024 21:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UuK0X+OAjWuxkl5H3q6cYbug0S4azhI2rDMTeszL9Fw=; b=ksiE/qJUGB3icoF/m+WyGjmWar
	o9Cr+34tCEj6wuvUSpdlxuipY7D4qpE7azlJZeghWWip7r7V2sVwjm7eXZCoVzbkCzlq6WaAH8+eR
	HnFNpzIMofJ+WvV6Gj++AofPiSiCQuRk2BbFmGsgqidD4gE4ITxqDAu67Llf/smpW3+ZoyOvIYS6q
	ak23tECYVQJFungV5yyik8oFQ+/o+E7h6uq8CElfGyLcQKZMC2jFJOhVsWCiGU0KTS/nBGkN6zRXf
	pKH07ZJiyLtsSeUHzsUf2cZ15SfBDXNtpGlP07q44mq280BQn+jxgX7VItDGMQXdMY8eoazGJqbEn
	KMUMpUaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1BK6-0000000D1Vp-39qj;
	Wed, 16 Oct 2024 21:12:50 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1BK4-0000000D1Uz-1H5F
	for linux-um@lists.infradead.org;
	Wed, 16 Oct 2024 21:12:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 52859A4285B;
	Wed, 16 Oct 2024 21:12:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E57AC4CECF;
	Wed, 16 Oct 2024 21:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729113166;
	bh=S/t7EO/pV80OVsSMddiDyh0HtBgYgcq4zwF02N632nI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uV/w0oHOwBQ+NDUL6z8FHft8RN4lgX3EMUBtvhnBIDFVDTtYXhSQOLnsDDHpooP3q
	 jdHe97X/Nm2Jinkw91UtpvCCHe/vwDD0iFwo5d4v+dpc0S143iJgsFNWc6a5oYW1Hu
	 XqOu/foVP1l6NnKmdib11PfJURzxrbUhaf85izGjGSrSrQo4yjizJ30YXpII9vhXF3
	 tVOwM2eacOKUoajpNotZXPn4xKMV/9a02aWLvU2TvgQkg1tZjZLmCM9oBj5PqUgN/h
	 c84s1PBSIyonAW5v42CwWERYZNs46o6XbaKRmffqKo8deOUKroyg/ViGumFZRSlM56
	 6wp4LgFSsy+Cg==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 16 Oct 2024 14:12:37 -0700
Subject: [PATCH 1/2] um: Fix passing '-n' to linker for stub_exe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-uml-fix-stub_exe-clang-v1-1-3d6381dc5a78@kernel.org>
References: <20241016-uml-fix-stub_exe-clang-v1-0-3d6381dc5a78@kernel.org>
In-Reply-To: <20241016-uml-fix-stub_exe-clang-v1-0-3d6381dc5a78@kernel.org>
To: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>
Cc: Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Benjamin Berg <benjamin.berg@intel.com>, linux-um@lists.infradead.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, patches@lists.linux.dev, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1041; i=nathan@kernel.org;
 h=from:subject:message-id; bh=S/t7EO/pV80OVsSMddiDyh0HtBgYgcq4zwF02N632nI=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDOkCOj5tr/Y7uLt9WCLE69N5tTU4cW94sGH/pkzzBxtNN
 gSo89/pKGVhEONikBVTZKl+rHrc0HDOWcYbpybBzGFlAhnCwMUpABNh4GD4w3NAqMg9M28Oc3Wk
 TqHbYnudXwsmt9zb8YdjgYel60HJTEaGd/6rJ3SVddWu/cm0i7mp7Mi6S9V71lVmV8w777SxJOk
 6LwA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241016_141248_440637_3BC99407 
X-CRM114-Status: GOOD (  10.38  )
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

When building stub_exe with clang, there is an error because '-n' is not
a recognized flag by the clang driver (which is being used to invoke the
linker):

  clang: error: unknown argument: '-n'

'-n' should be passed along to the linker, as it is the short flag for
'--nmagic', so prefix it with '-Wl,'.

Fixes: 32e8eaf263d9 ("um: use execveat to create userspace MMs")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/um/kernel/skas/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/skas/Makefile b/arch/um/kernel/skas/Makefile
index fbb61968055f44ac8a963d4c7d250e7c6bbbb321..f93db893b8236cf805edd01b41501d51dd8f0a35 100644
--- a/arch/um/kernel/skas/Makefile
+++ b/arch/um/kernel/skas/Makefile
@@ -27,7 +27,7 @@ quiet_cmd_stub_exe = STUB_EXE $@
 			   $(KBUILD_CFLAGS) $(STUB_EXE_LDFLAGS) \
 			   $(filter %.o,$^)
 
-STUB_EXE_LDFLAGS = -n -static
+STUB_EXE_LDFLAGS = -Wl,-n -static
 
 targets += stub_exe.dbg stub_exe $(stub_exe_objs-y)
 

-- 
2.47.0


