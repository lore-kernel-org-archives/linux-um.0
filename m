Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77385D3C939
	for <linux-um@archiver.kernel.org>; Tue, 22 Oct 2024 12:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MRBYaGAapneiQCkniSg8l7MrU2F0LoZwUU/G70ta3lQ=; b=lrYGbq41F91JxMzkb2M8T1hrU9
	PtRJZ+lJg8buJnHjN/U6dUe2U456vCFUnO/E/AaSNp0hbMBQdyQspchTfS15iXwO+kJp0QwmS1Di4
	47vXRzcdWX8l3JXodYk3BzMoRpsyYypgYHj1/JsIBzA9B7QTuApRvIUOBNCZo3Rqri9ygyTzOmCsq
	XuEe1OlllR8qZ3oYMcPlvpPGfTREqe3QI53NsG08f3X6zemkABhQG9xeRyLEh2VcK5TY0qHkV3tCe
	SLjqBQO0nc+Wosx3NYqwvtuqTomhZT+/Mvcx5mY9LnWx1AfEFHKYtAH2IWbxl31NifBlrPNyQcOGq
	bVRR4RPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3Db8-0000000Am4U-02f2;
	Tue, 22 Oct 2024 12:02:50 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3Db4-0000000Am33-3oho
	for linux-um@lists.infradead.org;
	Tue, 22 Oct 2024 12:02:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=MRBYaGAapneiQCkniSg8l7MrU2F0LoZwUU/G70ta3lQ=; t=1729598564; x=1730808164; 
	b=WDt+tYMk4Kc6G+lkxZljnl87BoQNqyfXVac2Bx6qpgrPvMEMgYQOaW+UuUjxQFnxRPMtXRHTkJQ
	EnVGBgajMswm3RlFQXwwbl1QvFFAZveUQIJKdk6yoXfFN0H6raYjFkagKLRhy5Vzc5IJNcuXrWaLW
	I2dMZbZqnn/BAxsm+63q8bWb3R+eVafCguidowd6iK40w/UVgVii5xZh7BQKc6suJ7s2v7FMD2PVk
	WccN//o3YJj0aF0M73VgUiWclOdeJ17OBJjtxUBaCml+SjU/nwS3pOau/6KY84WtR6xUbdMmUaehW
	Y2vgpUyO+HJePvMCPMqGJLQiTZx6THiID4PA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t3Daz-00000001iZy-0b3m;
	Tue, 22 Oct 2024 14:02:41 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: David Gow <davidgow@google.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] um: make stub_exe _start() pure inline asm
Date: Tue, 22 Oct 2024 14:02:38 +0200
Message-ID: <20241022120238.546980-2-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241022_050246_979475_7FC55CCB 
X-CRM114-Status: GOOD (  12.71  )
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

From: Johannes Berg <johannes.berg@intel.com>

Since __attribute__((naked)) cannot be used with functions
containing C statements, just generate the few instructions
it needs in assembly directly.

While at it, fix the stack usage ("1 + 2*x - 1" is odd) and
document what it must do, and why it must adjust the stack.

Fixes: 8508a5e0e9db ("um: Fix misaligned stack in stub_exe")
Link: https://lore.kernel.org/linux-um/CABVgOSntH-uoOFMP5HwMXjx_f1osMnVdhgKRKm4uz6DFm2Lb8Q@mail.gmail.com/
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/kernel/skas/stub_exe.c      | 18 +++++++++++-------
 arch/x86/um/shared/sysdep/stub_32.h |  8 ++++++++
 arch/x86/um/shared/sysdep/stub_64.h |  8 ++++++++
 3 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/arch/um/kernel/skas/stub_exe.c b/arch/um/kernel/skas/stub_exe.c
index 722ce6267476..ff5471986c52 100644
--- a/arch/um/kernel/skas/stub_exe.c
+++ b/arch/um/kernel/skas/stub_exe.c
@@ -81,11 +81,15 @@ noinline static void real_init(void)
 
 __attribute__((naked)) void _start(void)
 {
-	char *alloc;
-
-	/* Make enough space for the stub (including space for alignment) */
-	alloc = __builtin_alloca((1 + 2 * STUB_DATA_PAGES - 1) * UM_KERN_PAGE_SIZE);
-	asm volatile("" : "+r,m"(alloc) : : "memory");
-
-	real_init();
+	/*
+	 * Since the stack after exec() starts at the top-most address,
+	 * but that's exactly where we also want to map the stub data
+	 * and code, this must:
+	 *  - push the stack by 1 code and STUB_DATA_PAGES data pages
+	 *  - call real_init()
+	 * This way, real_init() can use the stack normally, while the
+	 * original stack further down (higher address) is no longer
+	 * accessible after the mmap() calls above.
+	 */
+	stub_start(real_init);
 }
diff --git a/arch/x86/um/shared/sysdep/stub_32.h b/arch/x86/um/shared/sysdep/stub_32.h
index 631a18d0ff44..390988132c0a 100644
--- a/arch/x86/um/shared/sysdep/stub_32.h
+++ b/arch/x86/um/shared/sysdep/stub_32.h
@@ -123,4 +123,12 @@ static __always_inline void *get_stub_data(void)
 
 	return (void *)ret;
 }
+
+#define stub_start(fn)							\
+	asm volatile (							\
+		"subl %0,%%esp ;"					\
+		"movl %1, %%eax ; "					\
+		"call *%%eax ;"						\
+		:: "i" ((1 + STUB_DATA_PAGES) * UM_KERN_PAGE_SIZE),	\
+		   "i" (&fn))
 #endif
diff --git a/arch/x86/um/shared/sysdep/stub_64.h b/arch/x86/um/shared/sysdep/stub_64.h
index 17153dfd780a..294affbec742 100644
--- a/arch/x86/um/shared/sysdep/stub_64.h
+++ b/arch/x86/um/shared/sysdep/stub_64.h
@@ -126,4 +126,12 @@ static __always_inline void *get_stub_data(void)
 
 	return (void *)ret;
 }
+
+#define stub_start(fn)							\
+	asm volatile (							\
+		"subq %0,%%rsp ;"					\
+		"movq %1,%%rax ;"					\
+		"call *%%rax ;"						\
+		:: "i" ((1 + STUB_DATA_PAGES) * UM_KERN_PAGE_SIZE),	\
+		   "i" (&fn))
 #endif
-- 
2.47.0


