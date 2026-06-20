Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14414CD98F6
	for <linux-um@archiver.kernel.org>; Sat, 20 Jun 2026 03:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=denyd7/DJf6K/1NoER/Dxb5q4O70rtudkvVdUrIy9Zo=; b=LIGb6YlR4TmZiRRtWYK09d3ZeW
	yyMkKdu6xjOvOOkAWRXDwXP32okS8TJ8oqnvDxhwDIZlQzibPy6e+QpK4+CQM20AthyWNGdy4XoCV
	aEJRwinhHxGfcMfa6xnRhnxkcd8x0EshotMcyL3ijeRQr1us+njPw4DhXCrSNM2/7NJcHeYhLk646
	jDTG179QnBR190WksblGxHrj9koNbiFWNBJ11mr8hltCPTbJbxOwz0abfWNiFoV4lFc802hGmXBcq
	x9x2+N7jRekGxjK3d1OOJ/45g1uUJrorfxoWLr6BTKzdNaVKbI8bqEA/cDCSna6Hvl4wBYLB062+G
	Al3IwqBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wamIO-000000038tv-3My0;
	Sat, 20 Jun 2026 03:23:00 +0000
Received: from mail-dl1-x1236.google.com ([2607:f8b0:4864:20::1236])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wamIM-000000038s7-068V
	for linux-um@lists.infradead.org;
	Sat, 20 Jun 2026 03:22:59 +0000
Received: by mail-dl1-x1236.google.com with SMTP id a92af1059eb24-137eb0d76beso2640552c88.0
        for <linux-um@lists.infradead.org>; Fri, 19 Jun 2026 20:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781925777; x=1782530577; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=denyd7/DJf6K/1NoER/Dxb5q4O70rtudkvVdUrIy9Zo=;
        b=fZR7YX7o27p1kpAO5fO/djeDONnx6sT8SGZsO+APu4lY9XH+VKgk6Z6OMKeA+XDlgt
         iEMvtD/2S0kOlkIABUxlD6mm5AhfNwEeHuDodS1E+pLSziJZvlnCkQis3v/WzYirfZI0
         GFQg0iSLbp1Ga7GlneqVkFo90cjjt3nv6r3898dT7ZD6iJR94Xm3mGk32I+zc3iM7Xk6
         +ld6+e/cev7ce5YL6Ap0p3Q++oYlLXPiM2EhY8kXTBE3Ys2Rao9zR0LpGEhZe7CCj+qq
         hcFypNc5qSWKXxPO0Qui8iiOiCDLCDA8jzuFzFjnl8gyOficIZLA42VQkIXJuoQr/cYu
         tg3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781925777; x=1782530577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=denyd7/DJf6K/1NoER/Dxb5q4O70rtudkvVdUrIy9Zo=;
        b=nWluuO3N0KDkBxBkT7f6mWaRA+6/SDWtKRfqLr9yciIfTkVJlMSeAs7wbpzKecli7U
         duW1wTtWxH6GL9K/dHSEYmJEqahRIxkJb3GUR6/u/V4avzM3djtqpP+lTwPrBjz2/aTw
         r4FGl0Ua/kGw5E+4YDHykLrKbkGLEqPw2ZrtLU2alMgLXbp419WLbmFQNteFjyu1MV4d
         5xpvMor3yyRHSEljqK//nJYcAJgdjIweWL9oXj22noO/JjqtTwthWDZoO1Xf57kaHpus
         OV3YugJV7GXUxVm87+rnq5g2gKQfNRTcLv++1fxMEcXHMX7lYowrk6fFL93rRhsemzkz
         jMPA==
X-Forwarded-Encrypted: i=1; AFNElJ+6DWDG7g4kAYiY3D3CKJqPd/8VVtoVQalVfBrHQ6PuG2fZHwTn+J0kAI0+iNbormACU+Rn89Huaw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yznvw1m/gzMmt30KjLoyCswGePB9Nl/Szzb40CMqHxOafYssN9P
	X1ZQCCmx6AnsjbNeGYcEJ1laDbwE6eBh+cDZ/JrzPqU7rXyVeXcrKE4U
X-Gm-Gg: AfdE7cmpWhEba43yWT9scWARW20TkUYCE9GHDI/d34XmRriUanRA/L7HPWIB0tymdjD
	zf3NuU/gc6flAY6XQYDqSg9zJDAvrfHqn8vx49FcKdLcXZ/x/UKJCf73AVHc3OFT2nYNo1gR/Un
	F7gu+CvK8WHiaIs+inh7/+/pvYH1oYv6PEK5gZa+7RbAAlGDbDO3IpabgCb4LyL1RUQB39uYEpP
	9SGiGpjYLdoqKluA9UbyzZpme5ZqiJ3YuOHK3ZMspz8DfKPGwU4W81gM+qlWPWQ5oYhEnrY1xsH
	sBExWDZtRBn/Lxc+89CMw6yjv9YLRBAeYriC0FRdjq3hb20JMgRMsDPZzi8QjSz2b/sNpUN7pWI
	vcaBWRWexKz65fkxQbYKHvMb59oPe+qphzlT9SldBw5eJ37MO9CjUMkPcNkBAcZ9mJvuKOPdsQW
	TbA1dWyf+JJqh/qUVXSZ7617wSYHal+gAj+3FhSdjjCLcAwYUOfA==
X-Received: by 2002:a05:7301:438a:b0:30b:f451:e817 with SMTP id 5a478bee46e88-30c079daf13mr2048493eec.14.1781925776969;
        Fri, 19 Jun 2026 20:22:56 -0700 (PDT)
Received: from pop-os.. ([2601:647:6802:dbc0:ce45:b713:5d9f:6abd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1ba1f14fsm1902019eec.5.2026.06.19.20.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 20:22:56 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH 3/7] um: skas: validate stub mmap() against the guest page table
Date: Fri, 19 Jun 2026 20:22:20 -0700
Message-ID: <7c38eec25d3ddc70893f1debc415d613dcf90a3b.1781925126.git.xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1781925126.git.xiyou.wangcong@gmail.com>
References: <cover.1781925126.git.xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260619_202258_071400_525AD61C 
X-CRM114-Status: GOOD (  22.23  )
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

From: Cong Wang <cwang@multikernel.io>

Replace the allow-all USER_NOTIF response with the actual security check.
When a stub mmap traps to the monitor, validate its arguments against the
mm's page table: the call is allowed iff this mm's PTE for the target
address maps exactly the physical frame named by the mmap offset, and the
requested protection does not exceed what the PTE grants. Otherwise the
mmap is rejected with -EPERM.

This is what closes the disclosure issue documented in stub.c. A hijacked
stub (jumping to the in-stub mmap with crafted registers) can no longer
choose an arbitrary physmem offset: it is confined to the frames its own
mm's PTEs already reference. On this base (single physmem fd, no
kernel/user split) the same check also blocks host escape: a mapping of
a UML-kernel frame has no authorizing user PTE, so it is denied.

The check is a pure function of state the monitor already owns (it *is*
the UML kernel and holds the guest pgd, freshly synced before the stub
mmap is issued), so it needs no per-batch bookkeeping or fd-identity
tracking. stub_mmap_allowed() lives in skas/uaccess.c next to
virt_to_pte(); the os-Linux notify handler calls it and responds CONTINUE
or -EPERM.

Verified on UML: guest boots and survives a fork/exec storm plus heavy
demand paging with zero false denials.

Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 arch/um/include/shared/skas/skas.h |  3 +++
 arch/um/kernel/skas/uaccess.c      | 36 ++++++++++++++++++++++++++++++
 arch/um/os-Linux/skas/process.c    | 21 ++++++++---------
 3 files changed, 50 insertions(+), 10 deletions(-)

diff --git a/arch/um/include/shared/skas/skas.h b/arch/um/include/shared/skas/skas.h
index 2237ffedec75..ce1b67b06b4b 100644
--- a/arch/um/include/shared/skas/skas.h
+++ b/arch/um/include/shared/skas/skas.h
@@ -18,4 +18,7 @@ extern void current_mm_sync(void);
 void initial_jmpbuf_lock(void);
 void initial_jmpbuf_unlock(void);
 
+int stub_mmap_allowed(struct mm_id *id, unsigned long addr,
+		      unsigned long prot, unsigned long offset);
+
 #endif
diff --git a/arch/um/kernel/skas/uaccess.c b/arch/um/kernel/skas/uaccess.c
index caef1deef795..9359ede8a04b 100644
--- a/arch/um/kernel/skas/uaccess.c
+++ b/arch/um/kernel/skas/uaccess.c
@@ -13,6 +13,18 @@
 #include <kern_util.h>
 #include <asm/futex.h>
 #include <os.h>
+#include <skas.h>
+
+/*
+ * Same mapping as MMAP_OFFSET() in <sysdep/stub.h>, but usable from kernel
+ * code (that header pulls in the host <sys/mman.h>). 64-bit stubs use mmap()
+ * with a byte offset; 32-bit stubs use mmap2() with a page offset.
+ */
+#ifdef CONFIG_64BIT
+#define stub_mmap_offset(phys)	(phys)
+#else
+#define stub_mmap_offset(phys)	((phys) >> PAGE_SHIFT)
+#endif
 
 pte_t *virt_to_pte(struct mm_struct *mm, unsigned long addr)
 {
@@ -43,6 +55,30 @@ pte_t *virt_to_pte(struct mm_struct *mm, unsigned long addr)
 	return pte_offset_kernel(pmd, addr);
 }
 
+int stub_mmap_allowed(struct mm_id *id, unsigned long addr,
+		      unsigned long prot, unsigned long offset)
+{
+	struct mm_context *ctx = container_of(id, struct mm_context, id);
+	struct mm_struct *mm = container_of(ctx, struct mm_struct, context);
+	pte_t *pte;
+
+	pte = virt_to_pte(mm, addr);
+	if (pte == NULL || !pte_present(*pte))
+		return 0;
+
+	/* Must map exactly the frame this PTE references. */
+	if (stub_mmap_offset(pte_val(*pte) & PAGE_MASK) != offset)
+		return 0;
+
+	/* Must not grant more access than the PTE allows. */
+	if ((prot & UM_PROT_WRITE) && !pte_write(*pte))
+		return 0;
+	if ((prot & UM_PROT_EXEC) && !pte_exec(*pte))
+		return 0;
+
+	return 1;
+}
+
 static pte_t *maybe_map(unsigned long virt, int is_write)
 {
 	pte_t *pte = virt_to_pte(current->mm, virt);
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 63b426b2c523..3a31e52cdcf8 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -187,10 +187,11 @@ static void wake_seccomp_stub(struct mm_id *mm_idp)
 			    FUTEX_WAKE, 1, NULL, NULL, 0));
 }
 
-static int seccomp_notify_serve(int notify_fd)
+static int seccomp_notify_serve(struct mm_id *mm_idp)
 {
 	struct seccomp_notif req = {};
 	struct seccomp_notif_resp resp = {};
+	int notify_fd = mm_idp->seccomp_notify_fd;
 	int ret;
 
 	CATCH_EINTR(ret = ioctl(notify_fd, SECCOMP_IOCTL_NOTIF_RECV, &req));
@@ -198,7 +199,14 @@ static int seccomp_notify_serve(int notify_fd)
 		return -errno;
 
 	resp.id = req.id;
-	resp.flags = SECCOMP_USER_NOTIF_FLAG_CONTINUE;
+
+	if (req.data.nr == STUB_MMAP_NR &&
+	    stub_mmap_allowed(mm_idp, req.data.args[0], req.data.args[2],
+			      req.data.args[5])) {
+		resp.flags = SECCOMP_USER_NOTIF_FLAG_CONTINUE;
+	} else {
+		resp.error = -EPERM;
+	}
 
 	CATCH_EINTR(ret = ioctl(notify_fd, SECCOMP_IOCTL_NOTIF_SEND, &resp));
 	if (ret < 0)
@@ -220,7 +228,7 @@ static void seccomp_serve_mmaps(struct mm_id *mm_idp)
 			n_mmaps++;
 
 	for (i = 0; i < n_mmaps; i++)
-		seccomp_notify_serve(mm_idp->seccomp_notify_fd);
+		seccomp_notify_serve(mm_idp);
 }
 
 void wait_stub_done_seccomp(struct mm_id *mm_idp, int running, int wait_sigsys)
@@ -288,13 +296,6 @@ void wait_stub_done_seccomp(struct mm_id *mm_idp, int running, int wait_sigsys)
 		fatal_sigsegv();
 }
 
-/*
- * Service one SECCOMP_RET_USER_NOTIF notification from a stub mmap: read the
- * suspended call, then respond CONTINUE so the stub's real mmap runs. CONTINUE
- * is safe here because mmap takes only scalar arguments (no TOCTOU on user
- * memory). Validation of (addr, len, prot, fd, offset) is added later; for now
- * every stub mmap is allowed.
- */
 extern unsigned long current_stub_stack(void);
 
 static void get_skas_faultinfo(int pid, struct faultinfo *fi)
-- 
2.43.0


