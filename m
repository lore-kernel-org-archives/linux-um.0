Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E5AC7EE25
	for <linux-um@archiver.kernel.org>; Fri,  9 Jun 2023 11:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:CC:To:Message-ID:MIME-Version:Subject:
	Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=sAdAgFr8u/Z8KUAfkRH2PvR0RMu7m9UL99HzT92YxXk=; b=2StrDDAPweumKy
	eERrvkDhnuoJ5mu7jeuGR0pBdPqGBfdGJdhaiy0eZe/kXebbhNiYU2SkdFjcpWFNPY0ekvJgKRKHS
	w/blrrrhClNzmLeNT4ZOOUtI2GB88UYGuu2mFzkBIzVPynnP2Tknj6srN0TqG4tGEFy71I136z5Mw
	YD1uH4/fwFZkLjujb57j6FSNuE5pAaaek5bmWK6EU+lKqqCYx67aqABkjeowaLQ+k5d6rttJmRck7
	TJw/y3ot8dFcFBJcFCe1E+su8fK/Lvzu97oEX0jzkHiETKEZ6fNgXEJi4qZA0XZLwkdF+EU5Nbix5
	s3YfwCpiNhKQ/h+Sn8/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7a97-00Ckmh-2S;
	Fri, 09 Jun 2023 11:19:09 +0000
Received: from smtp1.axis.com ([195.60.68.17])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7a94-00CklP-23
	for linux-um@lists.infradead.org;
	Fri, 09 Jun 2023 11:19:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1686309546;
  x=1717845546;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=7XMigKyzIzkGYn81G4evNo2KHPOOkw2Qm++AiRLE9eM=;
  b=aSA3XIcUxGFfXpt0gGZwL0ZDecZ1WZi8EKDvaspeWgTWNyhI/JTsYOXy
   QxnQin987ak2uYxriDYW+HFMZAD7bvVNojgJioUZC/vGf0B01qDcBjzfU
   /GiugXKZD2C+SREfGrdeLXfdZ26TPoc6QzNk9MqK3287+FIhg0nyasnne
   B8oeQ7OOjcrvAy1TRoDHxcBoXuevE0aSiMe/daJgYVvoFzyn1BsXz2Mtw
   QzR3qdDqBzYiNpKBnvLXlHibrIvrd0nKyGAh0KLf6IXrmNoukYvFE+hFH
   wQS0blZ0LbLhC0ZgxIUycsl6wkcgFpGOBWVTGRfcapmQhFkl11tY74XbW
   A==;
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
Date: Fri, 9 Jun 2023 13:18:54 +0200
Subject: [PATCH] x86: Fix build of UML with KASAN
MIME-Version: 1.0
Message-ID: <20230609-uml-kasan-v1-1-5fac8d409d4f@axis.com>
X-B4-Tracking: v=1; b=H4sIAJ0Kg2QC/x2N0QrCMAxFf2Xk2UBNnWz+iviQtZkLm600KMLYv
 9vt8VzO5axgUlQMbs0KRb5qmlOF86mBMHF6CmqsDOTIu6vr8fNacGbjhOR7ivESfNd2UP2BTXA
 onMK0P8acaZ/fRUb9HYn7Y9v+0FOpHXIAAAA=
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
X-Mailer: b4 0.12.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230609_041907_158837_D88CE82B 
X-CRM114-Status: UNSURE (   7.49  )
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

If I'm reading that commit right, the !GENERIC_ENTRY case is still
supposed to be allowed to override the mem*() functions, so use weak
aliases in that case.

Fixes: 69d4c0d32186 ("entry, kasan, x86: Disallow overriding mem*() functions")
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 arch/x86/lib/memcpy_64.S  | 4 ++++
 arch/x86/lib/memmove_64.S | 4 ++++
 arch/x86/lib/memset_64.S  | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
index 8f95fb267caa7..5dc265b36ef0b 100644
--- a/arch/x86/lib/memcpy_64.S
+++ b/arch/x86/lib/memcpy_64.S
@@ -40,7 +40,11 @@ SYM_TYPED_FUNC_START(__memcpy)
 SYM_FUNC_END(__memcpy)
 EXPORT_SYMBOL(__memcpy)
 
+#ifdef CONFIG_GENERIC_ENTRY
 SYM_FUNC_ALIAS(memcpy, __memcpy)
+#else
+SYM_FUNC_ALIAS_WEAK(memcpy, __memcpy)
+#endif
 EXPORT_SYMBOL(memcpy)
 
 SYM_FUNC_START_LOCAL(memcpy_orig)
diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
index 02661861e5dd9..3b1a02357fb29 100644
--- a/arch/x86/lib/memmove_64.S
+++ b/arch/x86/lib/memmove_64.S
@@ -215,5 +215,9 @@ SYM_FUNC_START(__memmove)
 SYM_FUNC_END(__memmove)
 EXPORT_SYMBOL(__memmove)
 
+#ifdef CONFIG_GENERIC_ENTRY
 SYM_FUNC_ALIAS(memmove, __memmove)
+#else
+SYM_FUNC_ALIAS_WEAK(memmove, __memmove)
+#endif
 EXPORT_SYMBOL(memmove)
diff --git a/arch/x86/lib/memset_64.S b/arch/x86/lib/memset_64.S
index 7c59a704c4584..fe27538a355db 100644
--- a/arch/x86/lib/memset_64.S
+++ b/arch/x86/lib/memset_64.S
@@ -40,7 +40,11 @@ SYM_FUNC_START(__memset)
 SYM_FUNC_END(__memset)
 EXPORT_SYMBOL(__memset)
 
+#ifdef CONFIG_GENERIC_ENTRY
 SYM_FUNC_ALIAS(memset, __memset)
+#else
+SYM_FUNC_ALIAS_WEAK(memset, __memset)
+#endif
 EXPORT_SYMBOL(memset)
 
 SYM_FUNC_START_LOCAL(memset_orig)

---
base-commit: 9561de3a55bed6bdd44a12820ba81ec416e705a7
change-id: 20230609-uml-kasan-2392dd4c3858

Best regards,
-- 
Vincent Whitchurch <vincent.whitchurch@axis.com>


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
