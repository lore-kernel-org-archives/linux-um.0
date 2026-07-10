Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF91BC43458
	for <linux-um@archiver.kernel.org>; Fri, 10 Jul 2026 20:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UWjxCj/TKTNYVdvKD41KqqSUzOm1MXKHzbWV9E2lCOM=; b=XD+iBlwPiekOIbDvAlystUCQHM
	a3FKVB2pjn0ogrgKymu6Sxst/IYfW+fI0G4BRW6MWl9XWLqrHfFrs+CsEgVt00eT+mFUyktwUIaCN
	4ESB4bQ4z+DiH+dFVsaAMMJaXWiwhEwqzVp9S3pBFaQ3SswELuChbCq+OLg6ot2LX+ksxvvXGlkTB
	QOUzWxcF8UWr9gBzpT18x1FdkN0xE3JaGUVe2RX5C+rnbWH/Sinfn+vsAi8/salRhrhZB3Un9urPB
	M+OaKjvXGPADvccxjuYK7EmU8uKqCBKPT/lqar1Zo15f1Bg7PTpr6+GH37pUQQ1kQD0ltIV+ggWdN
	hhzg3vDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiIEU-00000005jgu-1qzH;
	Fri, 10 Jul 2026 20:54:02 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiIES-00000005jfE-0RV1
	for linux-um@lists.infradead.org;
	Fri, 10 Jul 2026 20:54:01 +0000
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-384c94c9414so1419693a91.3
        for <linux-um@lists.infradead.org>; Fri, 10 Jul 2026 13:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783716839; x=1784321639; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UWjxCj/TKTNYVdvKD41KqqSUzOm1MXKHzbWV9E2lCOM=;
        b=K8ESu+k+YH/r3s9X0XgOrPe9EG3NN9iipeApRVLhKe6S8yAclEP6Z0XdUSpmJGeNZv
         MbKTR42pTI5KRRN8B17mxbIMc7ixdlwkqjSLnda9FnsJvZgdiiHmmYg4hl0K6LU0cIHb
         Fy3Ez6lVTTrXjJZiQ9QbsWMiFn4GcSqLutF7mKaYRzukqbQ5fX7cIzhEc8yKKBaWNg4O
         /oTEa/zoVsCBUsSXxfYtVqMLQWouo1DKR5ORmLj4Ms8xR2ejED5fJ27gfGJVMA4TD3c2
         MMnElfqISezhFsJ9rgkMzbhRTVAJLb5SPFUdCe831tQY9CKo78AlOZoLhM0pqQmtTatR
         BJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783716839; x=1784321639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UWjxCj/TKTNYVdvKD41KqqSUzOm1MXKHzbWV9E2lCOM=;
        b=rbWg93SWGN1o0fCCyFLj41tUv4hlPzGnBXWO1mOdoF7uBjZJc8u/xB1M6Ntpr/lGGs
         ndFZ5EOayJ/mW6qNwBxAUF9gsyIvXzD1sFCawLa0pZejy6GCbw/x3oFI894h8eC9UD8c
         HEuLX2pVtKZjb5em7CrtpXBVdPJ4b+a52SQ/EX4dbxN573zL+JPXBIF9/eGnUcCHUYMz
         N76Zueb2ehKdqz9D4t3cdzwzq1OA8wEFwfyTTlCVtndwemNmsM9ZRqiGQyOXRukm+O9A
         6Jt+WtlGn+lw2kI8vRFTRbX0t/K+C9Qcf96Oy8sZgAhCwZrLPHc0gg932hE1K3D9oPJe
         eLhg==
X-Forwarded-Encrypted: i=1; AHgh+RqI1/PpydCwykIqvFGuYVbT+s+4nBPdHnETFSMz4xx9pwBxJQ9HvJKoAr2z2reCPiFJ3di121LTjQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzDg2QTxLoIT4WgBBlmI2Q95ExvTHtmrIDRDFSPOH3m3C+2eOlU
	cogx88eSx0tCYlJuYYd1uQ3gT/eFFnHzWtYSRyBA/GjPrGJc4syqnJCC
X-Gm-Gg: AfdE7cnSr6qM/qDOnGtORpippR1SVY/NrmQnCZGRkl6qd0oErdDzf5GqXblIZnq5zqI
	4DdXrJYUnRxSWJn66PwAk2uqFphsnWXqhrJ5qe75YmMsr8nkA+8GClQyPz218qwmlmx1ICV7kbd
	Ue/NNMtePtzfX01g2da8IYrsROC9mA9O516q9uU7UFV2yvqIsi+Ee92dXzKwoC8EZZHQGDy7Pcp
	F+x1aj0fmflaQqtBhjoEeenrHVOW+PjlKy4+mn7DrmBmX1JEI906ALj5kEEsHm1BuAVijE6vSRL
	G0LhIoLzT4zozsXlVpiBfIIFgRn+FvdbwN73Qnr1AGrVEpL7cbRSZ9TJF/fXlE+tnW2tSj0MF2e
	NF27ATG9Dv298RShtMJQCg6jaFGEboFWdXUsmdUvp1REw6b8sHlGIRJpvwHw68h041ACNY506yu
	iRHOlgUUREuxekg27HfQHgjnC/AItHJt5L35+SJ9TkChklwNnLAhikRHI=
X-Received: by 2002:a17:90b:5583:b0:383:f52b:d616 with SMTP id 98e67ed59e1d1-38dc75e3a5fmr461534a91.10.1783716839175;
        Fri, 10 Jul 2026 13:53:59 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.107])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3119c2a7bb5sm21724371eec.25.2026.07.10.13.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 13:53:58 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Benjamin Berg <benjamin@sipsolutions.net>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Cong Wang <cwang@multikernel.io>
Subject: [RFC PATCH 3/6] um: install guest mappings via pidfd_mmap() in seccomp mode
Date: Fri, 10 Jul 2026 13:53:21 -0700
Message-ID: <20260710205324.1343217-4-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710205324.1343217-1-xiyou.wangcong@gmail.com>
References: <20260710205324.1343217-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260710_135400_147829_703FF301 
X-CRM114-Status: GOOD (  13.69  )
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

In SECCOMP mode, map()/unmap() now install into the stub's address
space directly from the monitor via pidfd_mmap()/pidfd_munmap(),
resolving the physmem fd in the monitor's own fd table. The stub neither
receives the fd nor executes mmap/munmap itself.

The ptrace (SKAS0) mode is unchanged: it keeps batching STUB_SYSCALL_MMAP
/MUNMAP for the stub to execute, which works on any host kernel and
needs no new syscall. Only the seccomp path, where the stub is
sandboxed, is converted.

Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 arch/um/os-Linux/skas/mem.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/um/os-Linux/skas/mem.c b/arch/um/os-Linux/skas/mem.c
index 8b9921ac3ef8..f751a1ea1c4c 100644
--- a/arch/um/os-Linux/skas/mem.c
+++ b/arch/um/os-Linux/skas/mem.c
@@ -9,6 +9,8 @@
 #include <errno.h>
 #include <string.h>
 #include <sys/mman.h>
+#include <sys/syscall.h>
+#include <linux/pidfd.h>
 #include <init.h>
 #include <as-layout.h>
 #include <mm_id.h>
@@ -236,6 +238,21 @@ int map(struct mm_id *mm_idp, unsigned long virt, unsigned long len, int prot,
 {
 	struct stub_syscall *sc;
 
+	if (using_seccomp) {
+		struct pidfd_mmap_args args = {
+			.size	= sizeof(args),
+			.addr	= virt,
+			.len	= len,
+			.prot	= prot,
+			.flags	= MAP_SHARED | MAP_FIXED,
+			.pgoff	= offset >> UM_KERN_PAGE_SHIFT,
+			.fd	= phys_fd,
+		};
+		long res = syscall(__NR_pidfd_mmap, mm_idp->stub_pidfd, &args, 0);
+
+		return res < 0 ? -errno : 0;
+	}
+
 	/* Compress with previous syscall if that is possible */
 	sc = syscall_stub_get_previous(mm_idp, STUB_SYSCALL_MMAP, virt);
 	if (sc && sc->mem.prot == prot &&
@@ -268,6 +285,13 @@ int unmap(struct mm_id *mm_idp, unsigned long addr, unsigned long len)
 {
 	struct stub_syscall *sc;
 
+	if (using_seccomp) {
+		long res = syscall(__NR_pidfd_munmap, mm_idp->stub_pidfd,
+				   addr, len);
+
+		return res < 0 ? -errno : 0;
+	}
+
 	/* Compress with previous syscall if that is possible */
 	sc = syscall_stub_get_previous(mm_idp, STUB_SYSCALL_MUNMAP, addr);
 	if (sc) {
-- 
2.43.0


