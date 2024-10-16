Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9072D2F7C0
	for <linux-um@archiver.kernel.org>; Wed, 16 Oct 2024 21:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cESl8map77BIhxGbXYwJRcXfGHopDYUoQkhkvy0OIk8=; b=wldkXo0Ji2VcUzaQba2zsVk2Iv
	fS7COVfsjlvC3DDrVrIulYffKP9al8qjDBkT6swFVxnzU0ZJqFmuybk/4k0Z9GpvpPRilUKpf7oA2
	lxGN1MbRKwrtZEmN4KHmozLbC1WyQpOnBQkQ3rZDVHFZ6Bui2Ne5QwaD8A6wFjTYFCR9/cYhzAhcb
	OgvkjfK2yBJ8k+lp9/fAjfTQR8tpa0ui1/BgVGxaQKENNbmSbcjjYWG6Bi2kNmKYLNhDRI6iywzoT
	3oTUnFA4P3LZ+ubH74bie0gvI17NVzIY3gWeKAPUgF8kC2IdoFTpFUEtCJUEr1mfVhmpF75HAHz3+
	50FGsYGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1BK7-0000000D1Vv-0IeG;
	Wed, 16 Oct 2024 21:12:51 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1BK4-0000000D1V0-2t4q
	for linux-um@lists.infradead.org;
	Wed, 16 Oct 2024 21:12:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id CE409A40A4C;
	Wed, 16 Oct 2024 21:12:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F412AC4CED0;
	Wed, 16 Oct 2024 21:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729113167;
	bh=Tx5OAIRhuHpTGueX/fN7PxdVTqTqNhozXaD5BbCIjDA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IY+/U/YaQ+GHR6P5Z7HHUVSFRkhLvT18LgLID1Zi9JO6JCYlb4soAQT8gkX0uzRyN
	 9k4WdN5mqNF82g8R5E1kdpKzKIPjY8I7a8KzznAYRh7tib49w0vPEDXUInmqT/DuPe
	 NTN10KXf3wQE8xxjZudaaGWTP1Jq40osfjJN9ACR6xDZcO6XpygX6qP0aa/sZuUS1Z
	 y0f8lJkookgf4JmUEeC4vaeYqcU/+jpyvxHKt5RFtx8fSEJx07NS2aS+Z0lWi7nk6d
	 MDih4wwBq75vhm9pHipCNP8Y+yy8xHmKrRarVebczynv1I+3esefwEdPtcghZvUedX
	 MMFx6zcnnlk4w==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 16 Oct 2024 14:12:38 -0700
Subject: [PATCH 2/2] um: Disable auto variable initialization for
 stub_exe.c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-uml-fix-stub_exe-clang-v1-2-3d6381dc5a78@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1734; i=nathan@kernel.org;
 h=from:subject:message-id; bh=Tx5OAIRhuHpTGueX/fN7PxdVTqTqNhozXaD5BbCIjDA=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDOkCOr69m9aqV71aunTbjgB9zSLGfX4hN5VE3i55yFbMm
 7dQOPNVRykLgxgXg6yYIkv1Y9XjhoZzzjLeODUJZg4rE8gQBi5OAZhIdTMjwxzTLYtOP/s706bQ
 vOTp+4MdDw5mPS+2blv2uGye9KoKSxuG/8k7QpiUk23rz9kZJL9JErzYM4trAotg0+LrthPFH0j
 l8wMA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241016_141248_839422_D044309D 
X-CRM114-Status: UNSURE (   9.62  )
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

When automatic variable initialization is enabled via
CONFIG_INIT_STACK_ALL_{PATTERN,ZERO}, clang will insert a call to
memset() to initialize an object created with __builtin_alloca(). This
ultimately breaks the build when linking stub_exe because it is a
standalone executable that does not include or link against memset().

  ld: arch/um/kernel/skas/stub_exe.o: in function `_start':
  arch/um/kernel/skas/stub_exe.c:83:(.ltext+0x15): undefined reference to `memset'

Disable automatic variable initialization for stub_exe.c by passing the
default value of 'uninitialized' to '-ftrivial-auto-var-init', which
avoids generating the call to memset(). This code is small and runs
quickly as it is just designed to set up an environment, so stack
variable initialization is unnecessary overhead for little gain.

Fixes: 32e8eaf263d9 ("um: use execveat to create userspace MMs")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/um/kernel/skas/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/um/kernel/skas/Makefile b/arch/um/kernel/skas/Makefile
index f93db893b8236cf805edd01b41501d51dd8f0a35..f6a219074772283f3c6c6d8d6ccaa8a1cfc24e33 100644
--- a/arch/um/kernel/skas/Makefile
+++ b/arch/um/kernel/skas/Makefile
@@ -39,6 +39,11 @@ targets += stub_exe.dbg stub_exe $(stub_exe_objs-y)
 
 CFLAGS_stub.o := $(CFLAGS_NO_HARDENING)
 CFLAGS_stub_exe.o := $(CFLAGS_NO_HARDENING)
+
+# Clang will call memset() from __builtin_alloca() when stack variable
+# initialization is enabled, which is used in stub_exe.c.
+CFLAGS_stub_exe.o += $(call cc-option, -ftrivial-auto-var-init=uninitialized)
+
 UNPROFILE_OBJS := stub.o stub_exe.o
 KCOV_INSTRUMENT := n
 

-- 
2.47.0


