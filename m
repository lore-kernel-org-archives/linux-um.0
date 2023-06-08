Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EEDEC7EE29
	for <linux-um@archiver.kernel.org>; Thu,  8 Jun 2023 14:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=k7zgVWhSUjBLebkRqXfygof2ePXaU8MJpbYrp4CRiaI=; b=DzKTcgriaASz11
	1Jg2x+goACgsSM8w1KrOeYdHs0bG9/u0TSJ7xTfjFPBV50RV2+Ab6DyrwcLhp/ElxGzzE3BBpdJZm
	AetF8PMYvq//0hA4oMCPbWyqhjhIK6JsoJLaePN3Mvwi1zOvB+Te6WfxRn1tlQ8DXXz5+nrpctsEx
	W20Pw6UERXFICYciShEIFe6Wg5efBIlWxz951fAAs0nFt/P9/7DCs3l0HcbyqPrqsWoo6Q89wgjhP
	gOD/aE0IC/CChTpr585LBvaE7MZcT+t+VGhgRO2oym+j/44tcvyFp1wwA3qOxiX+Nga/BVSqfVJT/
	ONVjEWD5/+Rbdf+sNRZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7GZ7-009c9S-2T;
	Thu, 08 Jun 2023 14:24:41 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7GZ5-009c8T-0n
	for linux-um@lists.infradead.org;
	Thu, 08 Jun 2023 14:24:40 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D62CB64E21;
	Thu,  8 Jun 2023 14:24:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A036C433A0;
	Thu,  8 Jun 2023 14:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686234278;
	bh=7ZPyZ9apG1M05E0n0MB6gFR/gnPXwymtgzxIDVjhPog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lyb/aRQonk8gbaoHdI0/Cb4ItgDLwxIK+DRpbx0KcKc6rNJ6Rpj7K2KQKpzmumDnE
	 WdoNs13V76MCdMdX41tTHvhd5gocZxNMJEERi+nfhLvD9G4pTxmLMApimqHyX0L624
	 t4x+22sxF1nQMKsXUZNPeEion4PCNsIBz8S6PkOgZJ9Qxtcjj2th9w1H4u/onrZWcR
	 YwxVkKN4TQA7V4Fl4JLvBPwXVE6EZ6t49WjXaMMKaPucewyNKER1YTMUKrXUqI2n5k
	 VGJi/w9oqzpuvrSUmQueff5KNiMOeypROw8NYKdqqIjd158V/EnZqu6id2PKTe1LUF
	 4J3jIFYyTWWcg==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-um@lists.infradead.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v7 01/11] Revert "[PATCH] uml: export symbols added by GCC hardened"
Date: Thu,  8 Jun 2023 23:24:18 +0900
Message-Id: <20230608142428.256985-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230608142428.256985-1-masahiroy@kernel.org>
References: <20230608142428.256985-1-masahiroy@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230608_072439_355269_A685883D 
X-CRM114-Status: GOOD (  14.68  )
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

This reverts commit cead61a6717a9873426b08d73a34a325e3546f5d.

It exported __stack_smash_handler and __guard, while they may not be
defined by anyone.

The code *declares* __stack_smash_handler and __guard. It does not
create weak symbols. When the stack-protector is disabled, they are
left undefined, but yet exported.

If a loadable module tries to access non-existing symbols, bad things
(a page fault, NULL pointer dereference, etc.) will happen. So, the
current code is wrong.

If the code were written as follows, it would *define* them as weak
symbols so modules would be able to get access to them.

  void (*__stack_smash_handler)(void *) __attribute__((weak));
  EXPORT_SYMBOL(__stack_smash_handler);

  long __guard __attribute__((weak));
  EXPORT_SYMBOL(__guard);

In fact, modpost forbids exporting undefined symbols. It shows an error
message if it detects such a mistake.

  ERROR: modpost: "..." [...] was exported without definition

Unfortunately, it is checked only when the code is built as modular.
The problem described above has been unnoticed for a long time because
arch/um/os-Linux/user_syms.c is always built-in.

With a planned change in Kbuild, exporting undefined symbols will always
result in a build error instead of a run-time error. It is a good thing,
but we need to fix the breakage in advance.

One fix is to *define* weak symbols as shown above. An alternative is
to export them conditionally as follows:

  #ifdef CONFIG_STACKPROTECTOR
  extern void __stack_smash_handler(void *);
  EXPORT_SYMBOL(__stack_smash_handler);

  external long __guard;
  EXPORT_SYMBOL(__guard);
  #endif

This is what other architectures do; EXPORT_SYMBOL(__stack_chk_guard)
is guarded by #ifdef CONFIG_STACKPROTECTOR.

However, adding the #ifdef guard is not sensible because UML cannot
enable the stack-protector in the first place! (Please note UML does
not select HAVE_STACKPROTECTOR in Kconfig.)

So, the code is already broken (and unused) in multiple ways.

Just remove.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v7:
  - New patch

 arch/um/os-Linux/user_syms.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/um/os-Linux/user_syms.c b/arch/um/os-Linux/user_syms.c
index 9b62a9d352b3..a310ae27b479 100644
--- a/arch/um/os-Linux/user_syms.c
+++ b/arch/um/os-Linux/user_syms.c
@@ -37,13 +37,6 @@ EXPORT_SYMBOL(vsyscall_ehdr);
 EXPORT_SYMBOL(vsyscall_end);
 #endif
 
-/* Export symbols used by GCC for the stack protector. */
-extern void __stack_smash_handler(void *) __attribute__((weak));
-EXPORT_SYMBOL(__stack_smash_handler);
-
-extern long __guard __attribute__((weak));
-EXPORT_SYMBOL(__guard);
-
 #ifdef _FORTIFY_SOURCE
 extern int __sprintf_chk(char *str, int flag, size_t len, const char *format);
 EXPORT_SYMBOL(__sprintf_chk);
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
