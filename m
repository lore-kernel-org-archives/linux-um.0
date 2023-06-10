Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB547C7EE45
	for <linux-um@archiver.kernel.org>; Sat, 10 Jun 2023 09:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rpN+pA9EpzuSis015ulAXxbEzPTaeHOoJxPP/xW95wA=; b=anqNu1sPHUfKoz
	AG3XzFkJgdjlxn4ohiwGUM/nt5tvTUbMOu95dvnExRZWnZb9XOjuOuWtD8SDpUx/pucmjl5763j29
	24temGLX59SNwUtrmjeqKf2+6v+iqd6dJQzLsj8FKOU9dPQqp+Zwq0kltfHP3bkyyhGXovi5tjRoR
	PZOJW2S9OUlXDL1d+U/he/n3desPIXb2lB/WKkaTG4j8IZYUd5SWKiOXHIp8SuFbmtKo9N78UVHUt
	YbTwbf83CMYkhjA9mYl9/IoxS9JoGoDPWIl1YFauGN9dbLvHzWWlZ5ucGJyiTkKXYONomjxN44hNB
	x182SWAx9Ce07OPplypQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7ufA-00Fcak-1I;
	Sat, 10 Jun 2023 09:13:36 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7uf7-00FcZS-2v
	for linux-um@lists.infradead.org;
	Sat, 10 Jun 2023 09:13:35 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 3308B61EFC;
	Sat, 10 Jun 2023 09:13:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2618EC4339E;
	Sat, 10 Jun 2023 09:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686388412;
	bh=PG6qM3vqxiF+KiiI8e2eBOByJ2994aew6fGGaTXEDyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S6Prepz6fIDlWpYHwo+9GvbzqBuM0yICauO1hNBqTYUTFjVwRJ2A0lsojWnWQfAW9
	 E+H/EcPwloHdGH8EOaFUCpZZaKRYY/nC3wUDs2wo9W8ZC7EJKYS0F7zHR/ofrmlh/v
	 7fRcIPItpQmvYMQK/mgnO3kGpfNEMZjqCNkhTJ3wf6ElyFdIRm9M7pDSJs0759DCuD
	 G/WqKt24BtW4yNHYCFqDK5+RF7OMiSET7bdQXWtk0JtPjE7/fsD2+kH3G9V1tkragf
	 Nb6cmBtVQvYyCeoJXlKlnvj3e5BbZJ2JyfDObDdF5aEQX2ccufJamt9+gRcPCHVze6
	 CfmWqoWkESXqg==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-um@lists.infradead.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v8 01/11] Revert "[PATCH] uml: export symbols added by GCC hardened"
Date: Sat, 10 Jun 2023 18:13:10 +0900
Message-Id: <20230610091320.1054554-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230610091320.1054554-1-masahiroy@kernel.org>
References: <20230610091320.1054554-1-masahiroy@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230610_021334_019892_542652A5 
X-CRM114-Status: GOOD (  14.50  )
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
create weak symbols. If no external library is linked, they are left
undefined, but yet exported.

If a loadable module tries to access non-existing symbols, bad things
(a page fault, NULL pointer dereference, etc.) will happen. So, the
current code is wrong and dangerous.

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

One fix is to define weak symbols as shown above. An alternative is to
export them conditionally as follows:

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
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---

(no changes since v7)

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
