Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F03CC28B2F
	for <linux-um@archiver.kernel.org>; Fri, 14 Mar 2025 07:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XgJ3xmVB8Q+Qlov1OOwzrPoA5VYL2CgjG+ZWo4y/fRM=; b=5Dj9BfA4gxNYSGgmCmpd0g06ix
	NB2nAcTqAEhH0ogErBJQjotgHdfbLh4daqd0NLUw2l6HCXKtvlhunsnlLP3jFqB3TXrawp+UewtWZ
	y3YjCuDFn3IuzAw4xsCFSmJyYCLkLN+ULsRaS3s+KRETSllARHki06jH86S49N+T5v8RLN868TeJq
	Y7byJ8RAfX4X9/0GIPj/YJ8vIfmnk5Ge78KlpjwIeoZq3Kq4OHzEY9BrsIFHGppWNlR+SWFt5eX83
	5lM8b5gY4t753QYeuQRQRBuOPm+ZT54hLVYgUtjFA4EXKNYUlPYbf/I+IYHi/dCGDyl/Uiuq0SHWb
	N8sKxLjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tszEA-0000000DHHA-1xkC;
	Fri, 14 Mar 2025 07:13:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tszE8-0000000DHG6-1I7i
	for linux-um@lists.infradead.org;
	Fri, 14 Mar 2025 07:13:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741936383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XgJ3xmVB8Q+Qlov1OOwzrPoA5VYL2CgjG+ZWo4y/fRM=;
	b=fPsCjNMfF2J0+9vVJ863KbduA9HiNYE8z5kyyE5955CFBo1tiuR8Q0bezS7ZxVXsWKRjZj
	jShRCE6vzFg+1WLDfzFD7v4ozHqv7ZSg+rGyzpN7gMDIHXkkJnNX0AnjG0x0fW/LOI489L
	E3phcMzQCtV2CCIQnOuI9CgNhfR8eiM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-PKxp5eKfMNKY2P031irecA-1; Fri,
 14 Mar 2025 03:12:59 -0400
X-MC-Unique: PKxp5eKfMNKY2P031irecA-1
X-Mimecast-MFC-AGG-ID: PKxp5eKfMNKY2P031irecA_1741936378
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94D53195608B;
	Fri, 14 Mar 2025 07:12:58 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A6F9A18001DE;
	Fri, 14 Mar 2025 07:12:54 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	Thomas Huth <thuth@redhat.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: [PATCH 35/41] um: Replace __ASSEMBLY__ with __ASSEMBLER__ in the usermode headers
Date: Fri, 14 Mar 2025 08:10:06 +0100
Message-ID: <20250314071013.1575167-36-thuth@redhat.com>
In-Reply-To: <20250314071013.1575167-1-thuth@redhat.com>
References: <20250314071013.1575167-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250314_001304_416022_DCA05DD6 
X-CRM114-Status: GOOD (  15.43  )
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

While the GCC and Clang compilers already define __ASSEMBLER__
automatically when compiling assembly code, __ASSEMBLY__ is a
macro that only gets defined by the Makefiles in the kernel.
This can be very confusing when switching between userspace
and kernelspace coding, so let's standardize on the __ASSEMBLER__
macro that is provided by the compilers now.

This is a completely mechanical patch (done with a simple "sed -i"
statement).

Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/um/include/asm/cpufeature.h     | 4 ++--
 arch/um/include/asm/current.h        | 4 ++--
 arch/um/include/asm/page.h           | 4 ++--
 arch/um/include/asm/ptrace-generic.h | 2 +-
 arch/um/include/asm/thread_info.h    | 2 +-
 arch/um/include/shared/as-layout.h   | 2 +-
 6 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/um/include/asm/cpufeature.h b/arch/um/include/asm/cpufeature.h
index 1eb8b834fbec3..4354f6984271c 100644
--- a/arch/um/include/asm/cpufeature.h
+++ b/arch/um/include/asm/cpufeature.h
@@ -4,7 +4,7 @@
 
 #include <asm/processor.h>
 
-#if defined(__KERNEL__) && !defined(__ASSEMBLY__)
+#if defined(__KERNEL__) && !defined(__ASSEMBLER__)
 
 #include <asm/asm.h>
 #include <linux/bitops.h>
@@ -137,5 +137,5 @@ static __always_inline bool _static_cpu_has(u16 bit)
 #define CPU_FEATURE_TYPEVAL		boot_cpu_data.x86_vendor, boot_cpu_data.x86, \
 					boot_cpu_data.x86_model
 
-#endif /* defined(__KERNEL__) && !defined(__ASSEMBLY__) */
+#endif /* defined(__KERNEL__) && !defined(__ASSEMBLER__) */
 #endif /* _ASM_UM_CPUFEATURE_H */
diff --git a/arch/um/include/asm/current.h b/arch/um/include/asm/current.h
index de64e032d66c1..8accc6d6f5026 100644
--- a/arch/um/include/asm/current.h
+++ b/arch/um/include/asm/current.h
@@ -5,7 +5,7 @@
 #include <linux/compiler.h>
 #include <linux/threads.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct task_struct;
 extern struct task_struct *cpu_tasks[NR_CPUS];
@@ -18,6 +18,6 @@ static __always_inline struct task_struct *get_current(void)
 
 #define current get_current()
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* __ASM_CURRENT_H */
diff --git a/arch/um/include/asm/page.h b/arch/um/include/asm/page.h
index 3d516f3ca9c74..6f54254aaf443 100644
--- a/arch/um/include/asm/page.h
+++ b/arch/um/include/asm/page.h
@@ -11,7 +11,7 @@
 
 #include <vdso/page.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct page;
 
@@ -94,7 +94,7 @@ extern unsigned long uml_physmem;
 #include <asm-generic/memory_model.h>
 #include <asm-generic/getorder.h>
 
-#endif	/* __ASSEMBLY__ */
+#endif	/* __ASSEMBLER__ */
 
 #ifdef CONFIG_X86_32
 #define __HAVE_ARCH_GATE_AREA 1
diff --git a/arch/um/include/asm/ptrace-generic.h b/arch/um/include/asm/ptrace-generic.h
index 4696f24d14920..86d74f9d33cf2 100644
--- a/arch/um/include/asm/ptrace-generic.h
+++ b/arch/um/include/asm/ptrace-generic.h
@@ -6,7 +6,7 @@
 #ifndef __UM_PTRACE_GENERIC_H
 #define __UM_PTRACE_GENERIC_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <sysdep/ptrace.h>
 
diff --git a/arch/um/include/asm/thread_info.h b/arch/um/include/asm/thread_info.h
index f9ad06fcc991a..398e86fe3d051 100644
--- a/arch/um/include/asm/thread_info.h
+++ b/arch/um/include/asm/thread_info.h
@@ -9,7 +9,7 @@
 #define THREAD_SIZE_ORDER CONFIG_KERNEL_STACK_ORDER
 #define THREAD_SIZE ((1 << CONFIG_KERNEL_STACK_ORDER) * PAGE_SIZE)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <asm/types.h>
 #include <asm/page.h>
diff --git a/arch/um/include/shared/as-layout.h b/arch/um/include/shared/as-layout.h
index ea65f151bf484..07721d7210b1f 100644
--- a/arch/um/include/shared/as-layout.h
+++ b/arch/um/include/shared/as-layout.h
@@ -26,7 +26,7 @@
 #define STUB_DATA_PAGES 2 /* must be a power of two */
 #define STUB_END (STUB_DATA + STUB_DATA_PAGES * UM_KERN_PAGE_SIZE)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <sysdep/ptrace.h>
 
-- 
2.48.1


