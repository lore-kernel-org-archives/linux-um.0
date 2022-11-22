Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6894BC43217
	for <linux-um@archiver.kernel.org>; Tue, 22 Nov 2022 10:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CKveaBap9dpDELrRSWkft/bmRAASXK/kUMKLtZyIwmA=; b=RyE7auGDujoa2A
	HrEykbebsIeMcWrFwuwu5coUZhZ50JpXp2C5QkSKuMS4iGeyHEGAvNvk0cOQleCXJ9eeOB1P8SKZW
	uORf/301zgo5H/k5o9Ycsmjbk+WjtP2a8Dp4cmH3NJ784pGbSLZMAMtH9UN6Qsh79AaVW3jp508ap
	39H8TxQ4GbRp8h/1ivSD+4AJxilOsALvLz2IyAo3s9PzQvZj9co7HJnV7+cnqpFJyDPrPwSXl9sJt
	OebCq9uneZ9XSchR2ORei5iGTEOScCNAMHePEqNY6lJPK0yqzcOztsoVKA2b3jF5s8dG/5UOgJai9
	1zveyUnvm5Xifz5/9gpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQUY-007nz8-1j; Tue, 22 Nov 2022 10:27:02 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQTM-007nM8-7c
	for linux-um@bombadil.infradead.org; Tue, 22 Nov 2022 10:25:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=RmEhw37rPMmh/HTLZ71he/0l90Se9YjO1qde8mmgvsI=; b=lV8FCQBevNQPo5T1xFoBEvjxr+
	q6Pp81xWmPidckIMc3Hf/UsHIDtbtawBv4wueLWP4Ql/ZTW4EmKTWe5xITofHduxNalwjWisWJbKK
	aka8tg+cMkuPtoByj1xWnWjMs+iSZStB1DODD7WEd4edAcONXtPksY1QNQatrLzgf9eqNl61xZYiv
	Frtg9ZL1t/X+hG86UwgmQDcA3Ux/3ZftwRvG23IqRfc0Qcg6KbIOuY5MZ+M6pF57KZW0tn/uayPKN
	+/SdrTlmihvJQpri59wx7NthJLrDNMLGtlZeggs5jZJxJKg3M0+TTMjWvpA8F0HKuFeE1iiy6+sa5
	bkPh4ihQ==;
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQF1-003P1r-HD
	for linux-um@lists.infradead.org; Tue, 22 Nov 2022 10:11:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=RmEhw37rPMmh/HTLZ71he/0l90Se9YjO1qde8mmgvsI=;
	t=1669111858; x=1670321458; b=VN3UGlm9YIKUqZmtL0Ht46ix227AeQSNado+DE8SZ11k5Js
	I7GNtXkPOckPUBXQ8LzB8n561wFaZcqQ/yxC3UCm4TFt8OA0b/AqHOyqOfvJJmrZB4S6JsWNtLbde
	l5rZQO6Y4w1RZHyGq8Pi2ST6CWG74U1Rmc+VelXQHuhbEoZvhTCmi8sKatqDVK49ngl1fCk5NqPTz
	uhAWe2vzY8kr84Cp7lBhZnE8VAh4MG/vSyRhF/goq9QYPicGxiMb6o9PR5TrF29jrGUlV1zMCFcV/
	hJWA7fS4Yh7OoPpyIV3ohxyqAyfGZHDQeDwY0VK8GBQJJUdMVOkGx6hw1hOPddjQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1oxQEp-006IGn-03;
	Tue, 22 Nov 2022 11:10:47 +0100
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH v2 10/28] um: Always inline stub functions
Date: Tue, 22 Nov 2022 11:07:41 +0100
Message-Id: <20221122100759.208290-11-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221122100759.208290-1-benjamin@sipsolutions.net>
References: <20221122100759.208290-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_101100_572690_2DE0CE35 
X-CRM114-Status: UNSURE (   9.05  )
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
 arch/x86/um/shared/sysdep/stub_64.h | 15 ++++++++-------
 2 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/arch/x86/um/shared/sysdep/stub_32.h b/arch/x86/um/shared/sysdep/stub_32.h
index 4c6c2be0c899..dc04d8cc2791 100644
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
index 92ea1670cf1c..da6fd28fa95e 100644
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
2.38.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
