Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B586CD12D77
	for <linux-um@archiver.kernel.org>; Mon, 11 Nov 2024 06:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LDAmKXGbtDJjiaikFG+gdRryv6+QLSbmKiwO1FENW/U=; b=i4RzPUphZ0c7XZ+gwK/bjT5k2Q
	SxffvriTw8vLlyvw6CLBIcOpfiFFRjXb4AXN4WaNBlDr2ItmyZoY1TApOtTVmCaJWvDBPjnzqd8lD
	LrwHsljfhO3x4Vt7Zzz/QFAnBVMJt0Op+raFp9BqyS68VSNgEAbnt8UXgO31qGieo3MBPbXkJ/6Lf
	W6FYUIwdtTxFQiza1cYZrJW+UwVyxFhr2zQk2UV2FDbVC2s7JZ2s+nkvYl1hboLlvBtlP4WiK4gWg
	pr/1ttbWOLwRzGv0+aybiqN7ZdSQ6XzVwHjprKDx1nF11yj6Lg7NThG5rxpkcr3zdDq98qbGiTNPy
	W2KQn5tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tANuP-0000000GUFE-1vlq;
	Mon, 11 Nov 2024 06:28:21 +0000
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tANuN-0000000GUEl-1QDW
	for linux-um@lists.infradead.org;
	Mon, 11 Nov 2024 06:28:20 +0000
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-71e5a62031aso3206454b3a.1
        for <linux-um@lists.infradead.org>; Sun, 10 Nov 2024 22:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731306498; x=1731911298; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDAmKXGbtDJjiaikFG+gdRryv6+QLSbmKiwO1FENW/U=;
        b=hQ7NPgIPsTbvjJHj/lI6VwofRgg7dF7LYtIaoB7KOTXX6PlswUvOPJ3m8BYBLKpKdJ
         TPBrHkyy4bCoqbd6YxFVviZ++u9fV1qJPCKFcddt3bymy0kFIuHVE7PjBi3lyHBkayFe
         MdrWM6qKnbESMuXZOy11gTseixqX4ub1U5V4988YH4QkvO5JE59blu5dgcX/kKGEF2Xp
         0PVB6tM3Ao0anQFr12CZdmzAh8x/2bhA2oSWkw76DW3TQIr8SYIJk4lACKz0obigtSYC
         9TFMCEtLduynd80M7oxPwCTKwp5MN9Jnt1dJqrIse8QcGPABrK4L6HMtiBeYJM43ZFFt
         6/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731306498; x=1731911298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LDAmKXGbtDJjiaikFG+gdRryv6+QLSbmKiwO1FENW/U=;
        b=q+v+F55D/0TnOWA+kO2yDqQJPaIfAZ9PJSLc8FNOx7yKv/CFy+RrKoYqJw30LlQNdm
         8s/lw3LR+eehSjrHBRgkT7CYWHPL0RR45UFwzhk/h424+NZKmaWQcU/dio4YqMMLufL9
         yHoPy5vrhyKGBwLqFTy3s16edh/102eLMlEmzyXvdcpx+OAzx5tHDHEgEtuAS39kb+uX
         SPa8Q64+c0w3/MVMCM5tc71C1IoKHkx2nw6VLTGiJ5rz5i+Ci12TyyDtQ3YWYPGcIy81
         LqwgHRzfdqWAPdtpW33z9L19F0TolmSakL/LlM8WaLrNSJFCpAO3MS205aZRG40fYJQ/
         TqYg==
X-Gm-Message-State: AOJu0YxgFIXCfR/c/dszoFjiXTEfqslwjBFKyo9kzIbzzD4+SCA92Hzw
	lz8oVJ38kOXmZ9FqY63V3xgPtsmXHLy8J9Yij1coj4dahxxGGjxcw44dnw==
X-Google-Smtp-Source: AGHT+IFAA3HxMKVVGu2ErJm7CjX9/6A24s2Q/3wZkwNmTRxvGNJ6v45JVy0ryMV/gb9tk8u6Y22xSQ==
X-Received: by 2002:a05:6a00:21cc:b0:71e:3b51:e850 with SMTP id d2e1a72fcca58-724132788c8mr14958538b3a.2.1731306498328;
        Sun, 10 Nov 2024 22:28:18 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a187f4sm8516951b3a.144.2024.11.10.22.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 22:28:17 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id C794DDBA91E; Mon, 11 Nov 2024 15:28:15 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [RFC PATCH v2 06/13] um: nommu: prevent host syscalls from userspace by seccomp filter
Date: Mon, 11 Nov 2024 15:27:06 +0900
Message-ID: <7da099d239edb0ca4ef4a5c8c6a5155e0f1b0c4c.1731290567.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731290567.git.thehajime@gmail.com>
References: <cover.1731290567.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241110_222819_406143_BEB4028E 
X-CRM114-Status: GOOD (  14.36  )
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

As syscall translation done by zpoline assumes that there are no direct
syscalls issued by userspace code, but there would be possibly issued by
1) dlopen-ed code containing syscall instructions, or 2) JIT-generated
code.  This commit add a seccomp filter to prevent such syscalls from
userspace code.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/um/include/shared/os.h |  3 ++
 arch/um/kernel/um_arch.c    |  4 ++
 arch/um/os-Linux/process.c  | 76 +++++++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 6874be0c38a8..5a6722f254d5 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -220,6 +220,9 @@ extern int os_unmap_memory(void *addr, int len);
 extern int os_drop_memory(void *addr, int length);
 extern int can_drop_memory(void);
 extern int os_mincore(void *addr, unsigned long len);
+#ifndef CONFIG_MMU
+extern int os_setup_seccomp(void);
+#endif
 
 void os_set_pdeathsig(void);
 
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index ec17576ce9fc..694e428ddf35 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -433,6 +433,10 @@ void __init setup_arch(char **cmdline_p)
 		add_bootloader_randomness(rng_seed, sizeof(rng_seed));
 		memzero_explicit(rng_seed, sizeof(rng_seed));
 	}
+
+#ifndef CONFIG_MMU
+	os_setup_seccomp();
+#endif
 }
 
 void __init arch_cpu_finalize_init(void)
diff --git a/arch/um/os-Linux/process.c b/arch/um/os-Linux/process.c
index ef1a2f0aa06a..ed3d99301dc8 100644
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -17,7 +17,11 @@
 #include <asm/unistd.h>
 #include <init.h>
 #include <longjmp.h>
+#include <as-layout.h>
 #include <os.h>
+#include <sys/prctl.h>
+#include <linux/filter.h>
+#include <linux/seccomp.h>
 
 void os_alarm_process(int pid)
 {
@@ -209,3 +213,75 @@ void os_set_pdeathsig(void)
 {
 	prctl(PR_SET_PDEATHSIG, SIGKILL);
 }
+
+#ifndef CONFIG_MMU
+int os_setup_seccomp(void)
+{
+	int err;
+	unsigned long __userspace_start = uml_reserved,
+		__userspace_end = high_physmem;
+
+	struct sock_filter filter[] = {
+		/* if (IP_high > __userspace_end) allow; */
+		BPF_STMT(BPF_LD + BPF_W + BPF_ABS,
+			 offsetof(struct seccomp_data, instruction_pointer) + 4),
+		BPF_JUMP(BPF_JMP + BPF_JGT + BPF_K, __userspace_end >> 32,
+			 /*true-skip=*/0, /*false-skip=*/1),
+		BPF_STMT(BPF_RET + BPF_K, SECCOMP_RET_ALLOW),
+
+		/* if (IP_high == __userspace_end && IP_low >= __userspace_end) allow; */
+		BPF_STMT(BPF_LD + BPF_W + BPF_ABS,
+			 offsetof(struct seccomp_data, instruction_pointer) + 4),
+		BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, __userspace_end >> 32,
+			 /*true-skip=*/0, /*false-skip=*/3),
+		BPF_STMT(BPF_LD + BPF_W + BPF_ABS,
+			 offsetof(struct seccomp_data, instruction_pointer)),
+		BPF_JUMP(BPF_JMP + BPF_JGE + BPF_K, __userspace_end,
+			 /*true-skip=*/0, /*false-skip=*/1),
+		BPF_STMT(BPF_RET + BPF_K, SECCOMP_RET_ALLOW),
+
+		/* if (IP_high < __userspace_start) allow; */
+		BPF_STMT(BPF_LD + BPF_W + BPF_ABS,
+			 offsetof(struct seccomp_data, instruction_pointer) + 4),
+		BPF_JUMP(BPF_JMP + BPF_JGE + BPF_K, __userspace_start >> 32,
+			 /*true-skip=*/1, /*false-skip=*/0),
+		BPF_STMT(BPF_RET + BPF_K, SECCOMP_RET_ALLOW),
+
+		/* if (IP_high == __userspace_start && IP_low < __userspace_start) allow; */
+		BPF_STMT(BPF_LD + BPF_W + BPF_ABS,
+			 offsetof(struct seccomp_data, instruction_pointer) + 4),
+		BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, __userspace_start >> 32,
+			 /*true-skip=*/0, /*false-skip=*/3),
+		BPF_STMT(BPF_LD + BPF_W + BPF_ABS,
+			 offsetof(struct seccomp_data, instruction_pointer)),
+		BPF_JUMP(BPF_JMP + BPF_JGE + BPF_K, __userspace_start,
+			 /*true-skip=*/1, /*false-skip=*/0),
+		BPF_STMT(BPF_RET + BPF_K, SECCOMP_RET_ALLOW),
+
+		/* other address; trap  */
+		BPF_STMT(BPF_RET + BPF_K, SECCOMP_RET_TRAP),
+	};
+	struct sock_fprog prog = {
+		.len = ARRAY_SIZE(filter),
+		.filter = filter,
+	};
+
+	err = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	if (err)
+		os_warn("PR_SET_NO_NEW_PRIVS (err=%d, ernro=%d)\n",
+		       err, errno);
+
+	err = syscall(SYS_seccomp, SECCOMP_SET_MODE_FILTER,
+		      SECCOMP_FILTER_FLAG_TSYNC, &prog);
+	if (err) {
+		os_warn("SECCOMP_SET_MODE_FILTER (err=%d, ernro=%d)\n",
+		       err, errno);
+		exit(-1);
+	}
+
+	os_info("seccomp: filter syscalls in the range: 0x%lx-0x%lx\n",
+		__userspace_start, __userspace_end);
+
+	return 0;
+}
+#endif
-- 
2.43.0


