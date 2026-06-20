Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43411CDB46B
	for <linux-um@archiver.kernel.org>; Sat, 20 Jun 2026 03:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qT9+SzDes0Z5D0pbybzrBYC2KXIoyIL2sm/1qClFdQc=; b=Wsc7++RhtiuRHioA4ykc8g28Pw
	QiIUNWRYy07yfNX3+L1bfW+H/g16rFxQ7kRkas0/H/vOguiyKqX5GgvaVahSCH1S7DpPnXP4nv/d7
	2rbjUWX8NmoXBG72d7pLRAGv5vTuSWsfjhgb+6WhuurglGWKoYORU5NT1z4Va+xoOaCcDSF3yO3If
	qbx3FjmVjhZz5I67gPFafOfBnGjBelPTZeWT6fO5JcQ/Nyv8zUhPx+KsCGdFdR58X3zzoTie9zWdW
	HFIGbpK4Z4r8gBSY+mWrloU+8lu8NngzbVBS1xeB6xxWzCFN4edTSqG7/pm5rslT99q4XSlQkDIOr
	HOGVhSSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wamIQ-000000038va-3vdz;
	Sat, 20 Jun 2026 03:23:02 +0000
Received: from mail-dy1-x1330.google.com ([2607:f8b0:4864:20::1330])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wamIO-000000038ta-1pvO
	for linux-um@lists.infradead.org;
	Sat, 20 Jun 2026 03:23:02 +0000
Received: by mail-dy1-x1330.google.com with SMTP id 5a478bee46e88-3078e0dcd67so2972950eec.0
        for <linux-um@lists.infradead.org>; Fri, 19 Jun 2026 20:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781925779; x=1782530579; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qT9+SzDes0Z5D0pbybzrBYC2KXIoyIL2sm/1qClFdQc=;
        b=I3cTZAu+oH5WeXZPUayui07aNHjeUCiqUcVFfj+fajtE+KNqIYTAo9J5AFgQ+hfW8b
         LvJKpca2swcr4J6bPMqN5+cXb4Imo8IIqFN4qA3fPtrIjaSopr0eQqgzsQ8eXxfMze3T
         V5K66bb1k6Yg60F7vhBanhjt3IiisH0fC4XwmqGJP+LtwwfGqYiwdzRxaF0p8wubF4lN
         ln/oot64PSNIn31XIu5jtLCmB81p/hVEaPjwzynWfp8e4NJ9L7OrOCnQ7CLdPP9E/Ezi
         RqtTi//LGeY6F1bY6Wchxp2oe2PCmga1Ah5RdHPjGUvw9cDevI36AwxPmiYIuC6BZGag
         8Eww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781925779; x=1782530579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qT9+SzDes0Z5D0pbybzrBYC2KXIoyIL2sm/1qClFdQc=;
        b=n37MkjuyQsCA5NvRDOES72ifF8tcIa/fGBSdSe1aEulLHLAgXj0DnRDTIz0gMuwwV4
         6nA8C7rvFpNTr80/6sDao9pA6pmGHcerlq2JacnDjDJyJJor7s7gfVbxRjYXJQwjq+wN
         F9dhV0MmQ1JIbx6L3wanffs8Xanv+6EjqovMqatQv0CQtjo5Q5yiBEiQaOCPEYpSZtmg
         ALqLIHr0ur1wIrWDL+6vNY9LM0PriVuqX6xcRwap6J8ga2UOJud/Yamt0SUo1v8HDXsh
         Poc5tFrOpb5VonriypJffNrq4KLN6P3LPz7kYXajOwwSqy4zQuRZtuW0iCtK/TtqKj6e
         sXEw==
X-Forwarded-Encrypted: i=1; AFNElJ9utRJH94i9518sjETgCjr68MhuKKE9Zbfg7uCKX8JXUfKE3GpMsVRBKtOoKlidu3KAb9qV5uadxw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxWFRMbUbzjtQYWzqkS1aU1LYJDmMZ7eJszftvC6omXX04aNqIo
	5g9YPxNlhDKk3AW/X2dfnO3c6eqaaqELzVADSEQqqV37mecUQK51uCrb
X-Gm-Gg: AfdE7clL4VyopmICuCuuiQxOcpFzes1xmXUNDuxDfK3gxh0l6vruLJs4dwzQimLuz0H
	9V7aIOxcsnpBTIUw4AhUA13eqHPagJ7mCmjau0tPb+koI4HXrXKUUHbsdzPUVE3OKO1Iwdiqx0f
	qc2fIJZneRj4TeLDKIZcTfP7ZTxCLcS4DUgpKjcCbxpjTQEKcXdJvahsHl3ToYa9tGFLIpp5gf/
	cTQFkf6LWDE3Ii23znZAUsdsBnSdHqnudpuhhEqyotFp4ES2oKgCO1Y2spoaKvkm6OrImZQS59c
	1Tbj3ZK0WXKHwYOZ+a+Qwkmif3grQRKLCosSDsfBSYkv1JpV2AOykpv/Zm4LvY09vtBHFER4e8t
	G3PmnZAnx/YM/MqliRUaoKPC3w+glG0+dp6smKzymGOO8x+8hv6VXxOvm6pBT61HFCziB03I+BR
	eXIXlNFUpIEbAkLFdE0VE2s3HCBoxMG7pEMbp2N7jGb6NVqJ83kw==
X-Received: by 2002:a05:693c:3105:b0:304:dd1c:737e with SMTP id 5a478bee46e88-30c07156ec1mr3774349eec.16.1781925779531;
        Fri, 19 Jun 2026 20:22:59 -0700 (PDT)
Received: from pop-os.. ([2601:647:6802:dbc0:ce45:b713:5d9f:6abd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1ba1f14fsm1902019eec.5.2026.06.19.20.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 20:22:58 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH 5/7] um: skas: validate stub munmap() against the guest address range
Date: Fri, 19 Jun 2026 20:22:22 -0700
Message-ID: <79317fd985294cb54ec14aa6ae8837bc99b5f4cb.1781925126.git.xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1781925126.git.xiyou.wangcong@gmail.com>
References: <cover.1781925126.git.xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260619_202300_485969_50B106AE 
X-CRM114-Status: GOOD (  22.08  )
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

Route stub munmap() through the USER_NOTIF monitor too, and validate it
before letting it run. munmap() was previously SECCOMP_RET_ALLOW, so a
hijacked stub (jumping to the in-stub munmap with crafted registers) could
unmap arbitrary ranges, including the stub's own code/data pages, which
would sever the monitor's control over it, or guest mappings outside what
it is allowed to manage. After mmap, munmap was the remaining memory
primitive a hijacked stub could invoke with arbitrary arguments.

Unlike mmap(), there is no PTE left to check: by the time the stub unmaps
a guest page the kernel has already cleared the corresponding entry. So
stub_munmap_allowed() is range-based instead: the request must be
non-empty, must not wrap, and must lie entirely below STUB_START. That
confines the stub to the guest address space and keeps its own reserved
region off-limits. Both arguments are scalars captured in seccomp_data, so
CONTINUE carries no TOCTOU risk, same as mmap().

stub_munmap_allowed() lives in skas/uaccess.c next to stub_mmap_allowed();
the os-Linux notify handler dispatches on the syscall number and responds
CONTINUE or -EPERM, and the batch server counts STUB_SYSCALL_MUNMAP as
well as STUB_SYSCALL_MMAP.

Verified on UML: guest boots and survives heavy mmap/munmap churn with
zero false denials; the legitimate boot-time clear of the whole user
address space [0, STUB_START) is allowed (end == STUB_START), while a
range overlapping the stub region is denied.

Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 arch/um/include/shared/skas/skas.h |  2 ++
 arch/um/kernel/skas/stub_exe.c     |  4 ++--
 arch/um/kernel/skas/uaccess.c      | 12 ++++++++++++
 arch/um/os-Linux/skas/process.c    | 31 ++++++++++++++++++------------
 4 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/arch/um/include/shared/skas/skas.h b/arch/um/include/shared/skas/skas.h
index ce1b67b06b4b..ca2a62cef0c1 100644
--- a/arch/um/include/shared/skas/skas.h
+++ b/arch/um/include/shared/skas/skas.h
@@ -20,5 +20,7 @@ void initial_jmpbuf_unlock(void);
 
 int stub_mmap_allowed(struct mm_id *id, unsigned long addr,
 		      unsigned long prot, unsigned long offset);
+int stub_munmap_allowed(struct mm_id *id, unsigned long addr,
+			unsigned long len);
 
 #endif
diff --git a/arch/um/kernel/skas/stub_exe.c b/arch/um/kernel/skas/stub_exe.c
index 65ea2af5ca73..00eea0cb9463 100644
--- a/arch/um/kernel/skas/stub_exe.c
+++ b/arch/um/kernel/skas/stub_exe.c
@@ -175,7 +175,7 @@ noinline static void real_init(void)
 			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, STUB_MMAP_NR,
 				 5, 0),
 			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_munmap,
-				 3, 0),
+				 4, 0),
 #ifdef __i386__
 			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_set_thread_area,
 				 2, 0),
@@ -192,7 +192,7 @@ noinline static void real_init(void)
 			/* [18] Permitted call for the stub */
 			BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_ALLOW),
 
-			/* [19] mmap: route to the monitor for validation */
+			/* [19] mmap and munmap: route to the monitor for validation */
 			BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_USER_NOTIF),
 		};
 		struct sock_fprog prog = {
diff --git a/arch/um/kernel/skas/uaccess.c b/arch/um/kernel/skas/uaccess.c
index 9359ede8a04b..feb267637735 100644
--- a/arch/um/kernel/skas/uaccess.c
+++ b/arch/um/kernel/skas/uaccess.c
@@ -14,6 +14,7 @@
 #include <asm/futex.h>
 #include <os.h>
 #include <skas.h>
+#include <as-layout.h>
 
 /*
  * Same mapping as MMAP_OFFSET() in <sysdep/stub.h>, but usable from kernel
@@ -79,6 +80,17 @@ int stub_mmap_allowed(struct mm_id *id, unsigned long addr,
 	return 1;
 }
 
+int stub_munmap_allowed(struct mm_id *id, unsigned long addr, unsigned long len)
+{
+	if (len == 0 || addr + len < addr)
+		return 0;
+
+	if (addr + len > STUB_START)
+		return 0;
+
+	return 1;
+}
+
 static pte_t *maybe_map(unsigned long virt, int is_write)
 {
 	pte_t *pte = virt_to_pte(current->mm, virt);
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 0987eb79ce76..2010b4529c41 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -193,7 +193,7 @@ static int seccomp_notify_serve(struct mm_id *mm_idp)
 	struct seccomp_notif req = {};
 	struct seccomp_notif_resp resp = {};
 	int notify_fd = mm_idp->seccomp_notify_fd;
-	int ret;
+	int allowed, ret;
 
 	CATCH_EINTR(ret = ioctl(notify_fd, SECCOMP_IOCTL_NOTIF_RECV, &req));
 	if (ret < 0)
@@ -201,13 +201,19 @@ static int seccomp_notify_serve(struct mm_id *mm_idp)
 
 	resp.id = req.id;
 
-	if (req.data.nr == STUB_MMAP_NR &&
-	    stub_mmap_allowed(mm_idp, req.data.args[0], req.data.args[2],
-			      req.data.args[5])) {
+	if (req.data.nr == STUB_MMAP_NR)
+		allowed = stub_mmap_allowed(mm_idp, req.data.args[0],
+					    req.data.args[2], req.data.args[5]);
+	else if (req.data.nr == __NR_munmap)
+		allowed = stub_munmap_allowed(mm_idp, req.data.args[0],
+					      req.data.args[1]);
+	else
+		allowed = 0;
+
+	if (allowed)
 		resp.flags = SECCOMP_USER_NOTIF_FLAG_CONTINUE;
-	} else {
+	else
 		resp.error = -EPERM;
-	}
 
 	CATCH_EINTR(ret = ioctl(notify_fd, SECCOMP_IOCTL_NOTIF_SEND, &resp));
 	if (ret < 0)
@@ -231,19 +237,20 @@ static void seccomp_notify_drain(struct mm_id *mm_idp)
 			break;
 }
 
-static void seccomp_serve_mmaps(struct mm_id *mm_idp)
+static void seccomp_serve_stub_syscalls(struct mm_id *mm_idp)
 {
 	struct stub_data *data = (void *)mm_idp->stack;
-	int i, n_mmaps = 0;
+	int i, n_notif = 0;
 
 	if (mm_idp->seccomp_notify_fd < 0)
 		return;
 
 	for (i = 0; i < data->syscall_data_len; i++)
-		if (data->syscall_data[i].syscall == STUB_SYSCALL_MMAP)
-			n_mmaps++;
+		if (data->syscall_data[i].syscall == STUB_SYSCALL_MMAP ||
+		    data->syscall_data[i].syscall == STUB_SYSCALL_MUNMAP)
+			n_notif++;
 
-	for (i = 0; i < n_mmaps; i++)
+	for (i = 0; i < n_notif; i++)
 		seccomp_notify_serve(mm_idp);
 }
 
@@ -255,7 +262,7 @@ void wait_stub_done_seccomp(struct mm_id *mm_idp, int running, int wait_sigsys)
 	do {
 		if (!running) {
 			wake_seccomp_stub(mm_idp);
-			seccomp_serve_mmaps(mm_idp);
+			seccomp_serve_stub_syscalls(mm_idp);
 		}
 
 		do {
-- 
2.43.0


