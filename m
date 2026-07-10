Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 955F1C44507
	for <linux-um@archiver.kernel.org>; Fri, 10 Jul 2026 20:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H+bYaPwfClCvmZMCpl+tD+9q31JoaywpOhKbQK6CIro=; b=ZmmzqFCUZpgyn7/T2rcuevhwaQ
	5Z2qXlmndwthP3kN1lbLV6YVbqfzEjEkdemALMDwl4Rsj2OeVx8+wzLh8vlVlWMrUqtyUVn1ocB1N
	eglIG6sYhwEidBss2vsd2gZY6LnRKCjDFvL/AHwpaAE5PGzcWYzRMCB0CIqZFzjLjuEmuiojuCzQb
	mMEtquJsgsEqOu31uIZQYVIuAe5m73OB+ifsgEWFRUdH3BusU6tdPj5EdBfW5QbA7fcNo0uIi9xj3
	LQyF9PaS2FFuW2iXNFD7ffNuLwt4B8NR5eRLpcT2ab3lu6shrrTi9WS9hzhP8QuBz2t8FrwAVrHrL
	hECvOmfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiIES-00000005jfY-1Ssc;
	Fri, 10 Jul 2026 20:54:00 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiIEQ-00000005jeT-0Nx7
	for linux-um@lists.infradead.org;
	Fri, 10 Jul 2026 20:53:59 +0000
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso1643799a91.2
        for <linux-um@lists.infradead.org>; Fri, 10 Jul 2026 13:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783716837; x=1784321637; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H+bYaPwfClCvmZMCpl+tD+9q31JoaywpOhKbQK6CIro=;
        b=ErWrXqltbGPA9p0+UHeE3HwarxCJEcyPJJk9sRbdwheZav29jFPPlH+t6xI8JB3V2d
         yHI9mmPy3SXnQSR+H6fLG5lfebz4PSQPxfsU18W3mV8NpnuRFfFnEM1JKBGoJYHbi4AW
         XP2RvY6gW8CvW3qCTQLg73OFW/l1iQRRbFFqlKHYDl4XZGCazpo/suriKPvIyBFM9EIB
         t07JzlEYTzDLPZm55ZnAUagl/I9OzMw5rcAWc92s0y4zUDwu80FmWiokzrTwFrddcuK3
         RIl359l0/i65bfi+AqoanWcRb6ZOMK+bF/yRyuIwPuS6vKufiJKp6/dXtEH/gJRG+Zs8
         sxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783716837; x=1784321637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H+bYaPwfClCvmZMCpl+tD+9q31JoaywpOhKbQK6CIro=;
        b=D6vKWCAOyrS6qGOKqnAUQnQKyCILHx6sv3b6VyusegYIPnYJ8gDxo246q5H4bGdrXq
         n8k8222XsAdwWT/NHrnVE3AjG30J4tU2hFX6/Y0AACitFhyXHwmyuwna6saZrnc0Hh8Q
         NL469NOdy92VEla9tK/sa1VlP6B9eYdFxuSeC73r8TZqBdP3Gen4DvrO03cmPa1onMxb
         HKgnDJ2gy5BlgnBqHRg53QQQ5cxDTJmUFMg7jM2h8kyN9Jy2vTcQUcIpYaxR+2dviiN7
         S0Jq6myxXu7lXela3bAgfxAoRwBVJbs4Cc4xzROqjf4uUWxLwZp3QOU4X7akV+Hvxa7U
         1pHQ==
X-Forwarded-Encrypted: i=1; AHgh+RqIhynry8O7czvGKDVbu9EkOWv9HK3dnMDZ/hwGfBjCPrzlvNTa7lNR2v6DLMRtpiu+piSWrJgYDg==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywe1M6KpIs3XJc/NJ5gg5Q7ipcPeBJd4ldT8Lqz/AyyAVPc5+O+
	gkGwAWdITJWoktXQVdnuh8naO6Tt9e3ATtxkX+riNOZ9vvSUaj6E0RaO
X-Gm-Gg: AfdE7cnxjxM+JPlO1huSONxlc979spdrA7Ev7qTlgkfdSA4v5DeNBDXLFnW4P5efAl1
	sWu9kCZn4Yj2awFLEf0E7KhlWdWZ5jFg1SnkAcLUTd45ypWR78my4F0T4oVa63tY8DTO9S/XNW/
	WpESzhOPo/oKClz6bKdX7W0BXHvWdtxf3+42MkaXtIEC5wgapuYaxkCMzqkRs/XRK/vhOts3dAG
	GUbrwCRv27KFtHojtPjTix/qRo8BUNbvSEbIjUKOpFG1Os/u7xKrjNu8Jpja2vQHaRpcLaxYHhD
	VkIbHeALF9+jgg2c1i5DZeEJI6XxABBLHwIXHjR2mU7Tx80H2hszZtaZTXhkjO1EXam9hdwLlKP
	rBi+un3PNPfOPtO6F+uhm8X6T74pl1D01KhJSyyVW88hrPQve1OxzlFZtCyf9meKcHm3w689+cF
	EJ4ES4+qYNv14si60fYQh8Ppa4PmlEDXqVCohzzgNPtYlISJUGgO6yodw=
X-Received: by 2002:a17:90b:33c8:b0:387:e0db:3fb1 with SMTP id 98e67ed59e1d1-38dc77993c3mr515274a91.42.1783716837230;
        Fri, 10 Jul 2026 13:53:57 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.107])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3119c2a7bb5sm21724371eec.25.2026.07.10.13.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 13:53:56 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Benjamin Berg <benjamin@sipsolutions.net>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Cong Wang <cwang@multikernel.io>
Subject: [RFC PATCH 2/6] um: acquire a stub pidfd via CLONE_PIDFD in seccomp mode
Date: Fri, 10 Jul 2026 13:53:20 -0700
Message-ID: <20260710205324.1343217-3-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710205324.1343217-1-xiyou.wangcong@gmail.com>
References: <20260710205324.1343217-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260710_135358_134403_59C6D58E 
X-CRM114-Status: GOOD (  18.53  )
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

In SECCOMP mode the monitor will install guest mappings into the stub's
address space directly via pidfd_mmap(), so it needs a pidfd to the
stub. Acquire one atomically at clone() time via CLONE_PIDFD (returned
through the legacy-clone parent_tid argument), store it in
mm_id->stub_pidfd, and close it on teardown. The ptrace (SKAS0) mode
does not use pidfd_mmap and leaves stub_pidfd as -1.

Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 arch/um/include/shared/skas/mm_id.h |  1 +
 arch/um/kernel/skas/mmu.c           |  6 ++++++
 arch/um/os-Linux/skas/process.c     | 24 ++++++++++++++++++++++--
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/um/include/shared/skas/mm_id.h b/arch/um/include/shared/skas/mm_id.h
index 18c0621430d2..cec97189f12b 100644
--- a/arch/um/include/shared/skas/mm_id.h
+++ b/arch/um/include/shared/skas/mm_id.h
@@ -16,6 +16,7 @@ struct mm_id {
 	int syscall_data_len;
 
 	/* Only used with SECCOMP mode */
+	int stub_pidfd;		/* pidfd to the stub, or -1 */
 	int sock;
 	int syscall_fd_num;
 	int syscall_fd_map[STUB_MAX_FDS];
diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index b5017096028b..441dcf94ec9c 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -54,6 +54,7 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
 		goto out;
 
 	new_id->stack = stack;
+	new_id->stub_pidfd = -1;
 	new_id->syscall_data_len = 0;
 	new_id->syscall_fd_num = 0;
 
@@ -103,6 +104,11 @@ void destroy_context(struct mm_struct *mm)
 		mmu->id.pid = -1;
 	}
 
+	if (mmu->id.stub_pidfd >= 0) {
+		os_close_file(mmu->id.stub_pidfd);
+		mmu->id.stub_pidfd = -1;
+	}
+
 	if (using_seccomp && mmu->id.sock)
 		os_close_file(mmu->id.sock);
 
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index d6c22f8aa06d..3dd97ca7999a 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -34,6 +34,10 @@
 #include <asm-generic/rwonce.h>
 #include "../internal.h"
 
+#ifndef CLONE_PIDFD
+#define CLONE_PIDFD 0x00001000
+#endif
+
 int is_skas_winch(int pid, int fd, void *data)
 {
 	return pid == getpgrp();
@@ -448,6 +452,9 @@ int start_userspace(struct mm_id *mm_id)
 	void *stack;
 	unsigned long sp;
 	int status, n, err;
+	int stub_pidfd = -1;
+
+	mm_id->stub_pidfd = -1;
 
 	/* setup a temporary stack page */
 	stack = mmap(NULL, UM_KERN_PAGE_SIZE,
@@ -474,15 +481,25 @@ int start_userspace(struct mm_id *mm_id)
 	if (using_seccomp)
 		proc_data->futex = FUTEX_IN_CHILD;
 
+	/*
+	 * In SECCOMP mode, acquire a pidfd to the stub via CLONE_PIDFD (it is
+	 * returned through the legacy-clone parent_tid argument). The monitor
+	 * installs guest mappings into the stub's mm directly via pidfd_mmap(),
+	 * so the stub itself never needs the mmap capability. The ptrace mode
+	 * does not use it and drives the stub directly.
+	 */
 	mm_id->pid = clone(userspace_tramp, (void *) sp,
-		    CLONE_VFORK | CLONE_VM | SIGCHLD,
-		    (void *)&tramp_data);
+		    CLONE_VFORK | CLONE_VM | (using_seccomp ? CLONE_PIDFD : 0) |
+		    SIGCHLD,
+		    (void *)&tramp_data, &stub_pidfd);
 	if (mm_id->pid < 0) {
 		err = -errno;
 		printk(UM_KERN_ERR "%s : clone failed, errno = %d\n",
 		       __func__, errno);
 		goto out_close;
 	}
+	if (using_seccomp)
+		mm_id->stub_pidfd = stub_pidfd;
 
 	if (using_seccomp) {
 		wait_stub_done_seccomp(mm_id, 1, 1);
@@ -534,8 +551,11 @@ int start_userspace(struct mm_id *mm_id)
 out_close:
 	close(tramp_data.sockpair[0]);
 	close(tramp_data.sockpair[1]);
+	if (stub_pidfd >= 0)
+		close(stub_pidfd);
 
 	mm_id->pid = -1;
+	mm_id->stub_pidfd = -1;
 
 	return err;
 }
-- 
2.43.0


