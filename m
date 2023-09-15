Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4273DEE6425
	for <linux-um@archiver.kernel.org>; Fri, 15 Sep 2023 07:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:CC:To:Message-ID:MIME-Version:Subject:
	Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=RmTKxKibNya5eM+8NSe1Ih1SXhryVU0Kg2yAB1Tu5CM=; b=Orb/D605NHFqRq
	a3EFxVPJ9Zn4b/ocxTT3nWmln3oc2qzJiaN4tBX2iqY9qtrCSv8Ccxtry6iO2NLa8E7taRWA0l0H9
	D6PsoNylfDOsEai6DNU6NqpQwNWwy91yRhQFZZ7h7f5hNZ2rszzbryaojkeMNG8W0+3tGKrslzTur
	SLF/W2Io9eRvDJdUEkropCdBufm8y82d4H89Dlpfts0bbB/zKltkXeP5TSmOMH9zyp7Urdao/38nJ
	ok4oGg2FBSOlgVIkFzoeJJHvkTd9VGdgg5l+S27ohUN8OgsbNju4nHEXxinI0yy+6r7reUvkIcY7T
	Bn+i/YOBNjSNaUIfzU0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qh3HA-00A2vh-37;
	Fri, 15 Sep 2023 07:30:04 +0000
Received: from smtp1.axis.com ([195.60.68.17])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qh3H8-00A2tR-0t
	for linux-um@lists.infradead.org;
	Fri, 15 Sep 2023 07:30:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1694763002;
  x=1726299002;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=ZtQJD7Nx7MRDe9gv5VcJ0bJ+FN+0txe0L0UuBp9Hx9U=;
  b=DpzojDoJ7HTKgUjseJW2/x0Vxc2LFi2lf3cfd0S9brm507Cv832BrZ9k
   XwaZmcRaUXPku7u767RB6qv8G9McO9+23Hc4U5NJUHxvI+pPVtIvLTjxl
   KSUzGODqTvuHwq8W7+99qj3CICOKSV48KtexD+P87Cj0sKq1bpwB2KaPA
   CkKlXXI+dnrvriLZgbhhZ+PPVFwn5DcRh4BJL11gjG6PLLvRck2+f9t8g
   cf6r4HAheJSM1RlE6K83lbvi9yzfytVwzcUAySt37iz60kb1hI1Rg5rTp
   uLvkuePlmibmUogKxvLv4+4e2Oz7md81bEg+n4enuwCMCEPFBJOb+X0+a
   w==;
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
Date: Fri, 15 Sep 2023 09:29:52 +0200
Subject: [PATCH v2] x86: Fix build of UML with KASAN
MIME-Version: 1.0
Message-ID: <20230915-uml-kasan-v2-1-ef3f3ff4f144@axis.com>
X-B4-Tracking: v=1; b=H4sIAO8HBGUC/22Nyw6CMBBFf4XM2jGlgAFX/odhMfQhE7U1HSUYw
 r9bWLs8J/exgLjETuBcLJDcxMIxZNCHAsxI4eaQbWbQSlfqpDr8PB94J6GAuuq0tbWp2qaFnB9
 IHA6Jghm3ho9Rb/qVnOd5v7j2mUeWd0zf/XEqN/tvfCqxxMaTaW2tOlv7C80sRxOf0K/r+gOhX
 iW1uAAAAA==
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Frederic Weisbecker
	<frederic@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Peter Zijlstra <peterz@infradead.org>
CC: Richard Weinberger <richard@nod.at>, Anton Ivanov
	<anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>,
	<linux-um@lists.infradead.org>, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>, Andrey Konovalov
	<andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino
	<vincenzo.frascino@arm.com>, <kasan-dev@googlegroups.com>,
	<linux-kernel@vger.kernel.org>, <kernel@axis.com>, Vincent Whitchurch
	<vincent.whitchurch@axis.com>
X-Mailer: b4 0.12.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230915_003002_656766_E00F72EB 
X-CRM114-Status: UNSURE (   8.06  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Building UML with KASAN fails since commit 69d4c0d32186 ("entry, kasan,
x86: Disallow overriding mem*() functions") with the following errors:

 $ tools/testing/kunit/kunit.py run --kconfig_add CONFIG_KASAN=y
 ...
 ld: mm/kasan/shadow.o: in function `memset':
 shadow.c:(.text+0x40): multiple definition of `memset';
 arch/x86/lib/memset_64.o:(.noinstr.text+0x0): first defined here
 ld: mm/kasan/shadow.o: in function `memmove':
 shadow.c:(.text+0x90): multiple definition of `memmove';
 arch/x86/lib/memmove_64.o:(.noinstr.text+0x0): first defined here
 ld: mm/kasan/shadow.o: in function `memcpy':
 shadow.c:(.text+0x110): multiple definition of `memcpy';
 arch/x86/lib/memcpy_64.o:(.noinstr.text+0x0): first defined here

UML does not use GENERIC_ENTRY and is still supposed to be allowed to
override the mem*() functions, so use weak aliases in that case.

Fixes: 69d4c0d32186 ("entry, kasan, x86: Disallow overriding mem*() functions")
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
Changes in v2:
- Use CONFIG_UML instead of CONFIG_GENERIC_ENTRY.
- Link to v1: https://lore.kernel.org/r/20230609-uml-kasan-v1-1-5fac8d409d4f@axis.com
---
 arch/x86/lib/memcpy_64.S  | 4 ++++
 arch/x86/lib/memmove_64.S | 4 ++++
 arch/x86/lib/memset_64.S  | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
index 8f95fb267caa..47b004851cf3 100644
--- a/arch/x86/lib/memcpy_64.S
+++ b/arch/x86/lib/memcpy_64.S
@@ -40,7 +40,11 @@ SYM_TYPED_FUNC_START(__memcpy)
 SYM_FUNC_END(__memcpy)
 EXPORT_SYMBOL(__memcpy)
 
+#ifdef CONFIG_UML
+SYM_FUNC_ALIAS_WEAK(memcpy, __memcpy)
+#else
 SYM_FUNC_ALIAS(memcpy, __memcpy)
+#endif
 EXPORT_SYMBOL(memcpy)
 
 SYM_FUNC_START_LOCAL(memcpy_orig)
diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
index 0559b206fb11..e3a76d38c278 100644
--- a/arch/x86/lib/memmove_64.S
+++ b/arch/x86/lib/memmove_64.S
@@ -212,5 +212,9 @@ SYM_FUNC_START(__memmove)
 SYM_FUNC_END(__memmove)
 EXPORT_SYMBOL(__memmove)
 
+#ifdef CONFIG_UML
+SYM_FUNC_ALIAS_WEAK(memmove, __memmove)
+#else
 SYM_FUNC_ALIAS(memmove, __memmove)
+#endif
 EXPORT_SYMBOL(memmove)
diff --git a/arch/x86/lib/memset_64.S b/arch/x86/lib/memset_64.S
index 7c59a704c458..6d1c247c821c 100644
--- a/arch/x86/lib/memset_64.S
+++ b/arch/x86/lib/memset_64.S
@@ -40,7 +40,11 @@ SYM_FUNC_START(__memset)
 SYM_FUNC_END(__memset)
 EXPORT_SYMBOL(__memset)
 
+#ifdef CONFIG_UML
+SYM_FUNC_ALIAS_WEAK(memset, __memset)
+#else
 SYM_FUNC_ALIAS(memset, __memset)
+#endif
 EXPORT_SYMBOL(memset)
 
 SYM_FUNC_START_LOCAL(memset_orig)

---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20230609-uml-kasan-2392dd4c3858

Best regards,
-- 
Vincent Whitchurch <vincent.whitchurch@axis.com>


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
