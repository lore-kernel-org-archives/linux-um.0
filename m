Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF7F9C4332F
	for <linux-um@archiver.kernel.org>; Fri, 10 Nov 2023 11:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JMqY2rLifcEMxT3c/LzoTksIAhexugAl9vbxQH8RoV8=; b=S9D+HjEdQfTJfF
	GlMP0CnsQtUYzbmOZOpUP/jUwlkL018AuPDlKhxkj2J0rh8polEVwlM/G7zgxJ2sHT+34AN4ISPPt
	KRT6jK1l0sTTG2ZEqc2/dbi0dxYpDoHWZqqQx9rz4uCMHa+AkX/BpV0n9B9KnNh+7fzwCKKJNzO07
	OOePO64YSpExXZrNp3ayBxpcHvDAaV4lmbnCqcNe4YmB0R0N0Jh8tkGQObEF0SkLK41HP2/FfU3PF
	R9jfg+b9o/pxa56NRp5NqpOotqeWOLKuCN8YQIdzuhaA1RHi318kPoz12dSEJxLjYS1HDVyPtfpVU
	Sk9BcubUzjoudBByCe8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r1PJK-008M0g-1c;
	Fri, 10 Nov 2023 11:04:26 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r1PJG-008Lul-1d
	for linux-um@lists.infradead.org;
	Fri, 10 Nov 2023 11:04:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=s67VSzbs2v54qIJVCAjVjZlND69HlpZxUrRaqXpkg1g=;
	t=1699614262; x=1700823862; b=O16/h0WrShHBpX0+4SaD/NOib5uZq3Il15nVgWKSPCZ1X6T
	9JNnTJIuNqo0OHNM0fedQdY/pfctMDCRFPSc3ImnSGdn7SqIQxKqwjcGg1+zMEFR2CwXGvgeJxLvs
	+m2bCSmoHTuiSnxYA788o0/G0/NoGipA3jxAe0RsuIM2dvu6UzYsgyt741k2s+wqbwpDVFPZsVleM
	zn9AWHI59qLOKUIF51jOo+OQwXJ9IXgowrWCHCLWpZLAdzQgRInHBFowVSy6YFmqQ2RWncu3Oil5a
	hEGwzwtxLds0w9gskzwsNLThjQRjI4K7LojCURBtkgEo1HdAUnyDnfDLWCidardA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1r1PJD-00000002xHc-04TD;
	Fri, 10 Nov 2023 12:04:19 +0100
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH v3 08/11] um: Always inline stub functions
Date: Fri, 10 Nov 2023 12:03:45 +0100
Message-ID: <20231110110348.1815612-9-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231110110348.1815612-1-benjamin@sipsolutions.net>
References: <20231110110348.1815612-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231110_030422_558881_2A918446 
X-CRM114-Status: UNSURE (   9.30  )
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

From: Benjamin Berg <benjamin@sipsolutions.net>

The stub executable page is remapped to a different location in the
userland process. As these functions may be used by the stub, they
really need to be always inlined rather than permitting the compiler to
emit a function.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/x86/um/shared/sysdep/stub_32.h | 21 +++++++++++----------
 arch/x86/um/shared/sysdep/stub_64.h | 17 +++++++++--------
 2 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/arch/x86/um/shared/sysdep/stub_32.h b/arch/x86/um/shared/sysdep/stub_32.h
index 38fa894b65d0..4e763f8b380f 100644
--- a/arch/x86/um/shared/sysdep/stub_32.h
+++ b/arch/x86/um/shared/sysdep/stub_32.h
@@ -12,7 +12,7 @@
 #define STUB_MMAP_NR __NR_mmap2
 #define MMAP_OFFSET(o) ((o) >> UM_KERN_PAGE_SHIFT)
 
-static inline long stub_syscall0(long syscall)
+static __always_inline long stub_syscall0(long syscall)
 {
 	long ret;
 
@@ -21,7 +21,7 @@ static inline long stub_syscall0(long syscall)
 	return ret;
 }
 
-static inline long stub_syscall1(long syscall, long arg1)
+static __always_inline long stub_syscall1(long syscall, long arg1)
 {
 	long ret;
 
@@ -30,7 +30,7 @@ static inline long stub_syscall1(long syscall, long arg1)
 	return ret;
 }
 
-static inline long stub_syscall2(long syscall, long arg1, long arg2)
+static __always_inline long stub_syscall2(long syscall, long arg1, long arg2)
 {
 	long ret;
 
@@ -40,7 +40,8 @@ static inline long stub_syscall2(long syscall, long arg1, long arg2)
 	return ret;
 }
 
-static inline long stub_syscall3(long syscall, long arg1, long arg2, long arg3)
+static __always_inline long stub_syscall3(long syscall, long arg1, long arg2,
+					  long arg3)
 {
 	long ret;
 
@@ -50,8 +51,8 @@ static inline long stub_syscall3(long syscall, long arg1, long arg2, long arg3)
 	return ret;
 }
 
-static inline long stub_syscall4(long syscall, long arg1, long arg2, long arg3,
-				 long arg4)
+static __always_inline long stub_syscall4(long syscall, long arg1, long arg2,
+					  long arg3, long arg4)
 {
 	long ret;
 
@@ -61,8 +62,8 @@ static inline long stub_syscall4(long syscall, long arg1, long arg2, long arg3,
 	return ret;
 }
 
-static inline long stub_syscall5(long syscall, long arg1, long arg2, long arg3,
-				 long arg4, long arg5)
+static __always_inline long stub_syscall5(long syscall, long arg1, long arg2,
+					  long arg3, long arg4, long arg5)
 {
 	long ret;
 
@@ -72,12 +73,12 @@ static inline long stub_syscall5(long syscall, long arg1, long arg2, long arg3,
 	return ret;
 }
 
-static inline void trap_myself(void)
+static __always_inline void trap_myself(void)
 {
 	__asm("int3");
 }
 
-static inline void remap_stack_and_trap(void)
+static __always_inline void remap_stack_and_trap(void)
 {
 	__asm__ volatile (
 		"movl %%esp,%%ebx ;"
diff --git a/arch/x86/um/shared/sysdep/stub_64.h b/arch/x86/um/shared/sysdep/stub_64.h
index 2de1c8f88173..b24168ef0ac4 100644
--- a/arch/x86/um/shared/sysdep/stub_64.h
+++ b/arch/x86/um/shared/sysdep/stub_64.h
@@ -16,7 +16,7 @@
 #define __syscall_clobber "r11","rcx","memory"
 #define __syscall "syscall"
 
-static inline long stub_syscall0(long syscall)
+static __always_inline long stub_syscall0(long syscall)
 {
 	long ret;
 
@@ -27,7 +27,7 @@ static inline long stub_syscall0(long syscall)
 	return ret;
 }
 
-static inline long stub_syscall2(long syscall, long arg1, long arg2)
+static __always_inline long stub_syscall2(long syscall, long arg1, long arg2)
 {
 	long ret;
 
@@ -38,7 +38,8 @@ static inline long stub_syscall2(long syscall, long arg1, long arg2)
 	return ret;
 }
 
-static inline long stub_syscall3(long syscall, long arg1, long arg2, long arg3)
+static __always_inline long stub_syscall3(long syscall, long arg1, long arg2,
+					  long arg3)
 {
 	long ret;
 
@@ -50,7 +51,7 @@ static inline long stub_syscall3(long syscall, long arg1, long arg2, long arg3)
 	return ret;
 }
 
-static inline long stub_syscall4(long syscall, long arg1, long arg2, long arg3,
+static __always_inline long stub_syscall4(long syscall, long arg1, long arg2, long arg3,
 				 long arg4)
 {
 	long ret;
@@ -64,8 +65,8 @@ static inline long stub_syscall4(long syscall, long arg1, long arg2, long arg3,
 	return ret;
 }
 
-static inline long stub_syscall5(long syscall, long arg1, long arg2, long arg3,
-				 long arg4, long arg5)
+static __always_inline long stub_syscall5(long syscall, long arg1, long arg2,
+					  long arg3, long arg4, long arg5)
 {
 	long ret;
 
@@ -78,12 +79,12 @@ static inline long stub_syscall5(long syscall, long arg1, long arg2, long arg3,
 	return ret;
 }
 
-static inline void trap_myself(void)
+static __always_inline void trap_myself(void)
 {
 	__asm("int3");
 }
 
-static inline void remap_stack_and_trap(void)
+static __always_inline void remap_stack_and_trap(void)
 {
 	__asm__ volatile (
 		"movq %0,%%rax ;"
-- 
2.41.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
