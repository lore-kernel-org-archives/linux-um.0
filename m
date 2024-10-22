Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F94D1CDD3
	for <linux-um@archiver.kernel.org>; Tue, 22 Oct 2024 10:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m9A8NsFBAFTswSqlww6Y4t2F/qBPyrFIIj2x1KFfI8E=; b=jiI8mNCe2qMgaiFESBJtDMDtKU
	MV5Pj263srjXfkeEoZWG7G7w3lyZz9g6HdN8qyUiQ7IgEz5aNZ7+1qo4/9+45t06S5D5P70iwI6Gg
	kXptnPglRTQhVjkLHWftdxRYdhI1iWrzyVjp3JEwo3RH3oWMAfApiMBdxhDKpDwfNA6VNn3m2Nv8K
	GzpE1hqQL2LcAA46++zPGmJhvfWO1Pd+A6lAwhPBvbYwA9aLHAV4sdbOUEA1ChS+XejfPipa+jAa1
	vQgDsWvg7kNcpZJFu+TXmeoopjAZCJQrGsUFB1MpOXKkQVueOUix29Gmj9VbfUgomVIpImpb7ILrx
	hcOxwBFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3Bwi-0000000AVIg-15AJ;
	Tue, 22 Oct 2024 10:17:00 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3BsR-0000000AUMU-0EAj
	for linux-um@lists.infradead.org;
	Tue, 22 Oct 2024 10:12:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=m9A8NsFBAFTswSqlww6Y4t2F/qBPyrFIIj2x1KFfI8E=;
	t=1729591954; x=1730801554; b=m6/NDGM+EzLJ5vfwJqMD4fH+wsDJAYAGRQPy3uOzwNn6EzZ
	DurhXiFNRqwmOh0AImnXoHM0DK/0nFq5DcTXf09OG7QYMsBRUr85Pv0Oc4QkD61slbHvH9MnLGgNx
	ulV4y50XO8ZpeaJAkagOtpO0MMd71HL207BrtldYuZqheCgEQjV4Id/GFdRej9WLhLtRVUX8KstTq
	56OWtqcPmCZrqBHregIHWapG1MoctmxwcHzatPT8j+jHFXZMey4r0CUq2+FoLJt3Lc3RhM2aO7Olz
	SaREl/ZTr2wqLdTPyEtP3dhKdAtF8SOGSkNkQOHplKnegvZR6xdGLTy7MgJLoYmg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t3BsN-00000001fw4-1Pnq;
	Tue, 22 Oct 2024 12:12:31 +0200
Message-ID: <242801ccf39e42dfc8305c248649cd3a5a3bee10.camel@sipsolutions.net>
Subject: Re: [PATCH v2] um: Fix misaligned stack in stub_exe
From: Johannes Berg <johannes@sipsolutions.net>
To: David Gow <davidgow@google.com>, Benjamin Berg <benjamin.berg@intel.com>
Cc: linux-um@lists.infradead.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Date: Tue, 22 Oct 2024 12:12:30 +0200
In-Reply-To: <20241022101016.2565249-2-davidgow@google.com>
References: <20241022101016.2565249-2-davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241022_031235_148096_AD786BB8 
X-CRM114-Status: GOOD (  13.75  )
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

Thanks :)
>=20
> Changes since v1:
> https://lore.kernel.org/linux-um/20241017231007.1500497-2-davidgow@google=
.com/
> - Use force_arg_align_pointer on real_init() instead of naked on
>   __start, which works with clang.

I already applied it, so need to fix on top of it now, not replace it.

However I was just playing with the below - was just looking at the size
though, but what do you think?

johannes


From 57c5a80a4db2de33a11a5a20fcbea8f3643844f5 Mon Sep 17 00:00:00 2001
From: Johannes Berg <johannes.berg@intel.com>
Date: Tue, 22 Oct 2024 11:48:21 +0200
Subject: [PATCH] um: make stub_exe _start() pure inline asm

Since __attribute__((naked)) cannot be used with functions
containing C statements, just generate the few instructions
it needs in assembly directly.

Fixes: 8508a5e0e9db ("um: Fix misaligned stack in stub_exe")
Link: https://lore.kernel.org/linux-um/CABVgOSntH-uoOFMP5HwMXjx_f1osMnVdhgK=
RKm4uz6DFm2Lb8Q@mail.gmail.com/
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/kernel/skas/stub_exe.c      | 8 +-------
 arch/x86/um/shared/sysdep/stub_32.h | 8 ++++++++
 arch/x86/um/shared/sysdep/stub_64.h | 8 ++++++++
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/um/kernel/skas/stub_exe.c b/arch/um/kernel/skas/stub_exe.=
c
index 722ce6267476..a61f9c008233 100644
--- a/arch/um/kernel/skas/stub_exe.c
+++ b/arch/um/kernel/skas/stub_exe.c
@@ -81,11 +81,5 @@ noinline static void real_init(void)
=20
 __attribute__((naked)) void _start(void)
 {
-	char *alloc;
-
-	/* Make enough space for the stub (including space for alignment) */
-	alloc =3D __builtin_alloca((1 + 2 * STUB_DATA_PAGES - 1) * UM_KERN_PAGE_S=
IZE);
-	asm volatile("" : "+r,m"(alloc) : : "memory");
-
-	real_init();
+	stub_start(real_init);
 }
diff --git a/arch/x86/um/shared/sysdep/stub_32.h b/arch/x86/um/shared/sysde=
p/stub_32.h
index 631a18d0ff44..760e8ce8093f 100644
--- a/arch/x86/um/shared/sysdep/stub_32.h
+++ b/arch/x86/um/shared/sysdep/stub_32.h
@@ -123,4 +123,12 @@ static __always_inline void *get_stub_data(void)
=20
 	return (void *)ret;
 }
+
+#define stub_start(fn)							\
+	asm volatile (							\
+		"subl %0,%%esp ;"					\
+		"movl %1, %%eax ; "					\
+		"call *%%eax ;"						\
+		:: "i" ((STUB_DATA_PAGES + 1) * UM_KERN_PAGE_SIZE),	\
+		   "i" (&fn))
 #endif
diff --git a/arch/x86/um/shared/sysdep/stub_64.h b/arch/x86/um/shared/sysde=
p/stub_64.h
index 17153dfd780a..148bf423289e 100644
--- a/arch/x86/um/shared/sysdep/stub_64.h
+++ b/arch/x86/um/shared/sysdep/stub_64.h
@@ -126,4 +126,12 @@ static __always_inline void *get_stub_data(void)
=20
 	return (void *)ret;
 }
+
+#define stub_start(fn)							\
+	asm volatile (							\
+		"subq %0,%%rsp ;"					\
+		"movq %1,%%rax ;"					\
+		"call *%%rax ;"						\
+		:: "i" ((STUB_DATA_PAGES + 1) * UM_KERN_PAGE_SIZE),	\
+		   "i" (&fn))
 #endif
--=20
2.47.0



