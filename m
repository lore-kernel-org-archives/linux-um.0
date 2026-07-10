Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC75C43458
	for <linux-um@archiver.kernel.org>; Fri, 10 Jul 2026 20:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sCserWiFtJpC7hBtSNUd5SRB8rb8z/bWzdzLHsDDkzQ=; b=x570TbcrfR4W757oEALciNSoTl
	Qh1lbnMTzCDO6J7YICfGG4sV53zU6LayEeOBPhIabStavDiF2o8BUwcFY2zG3r61TMh5kLJWd52FL
	bW4+rn1IHsT3vuSaP6wZMtN2z4KtIli75RveINcE/QmrBUMmoQbwtnCrGcBlwf2OyVG+xz1uG0Sk8
	vOA8to2nuVmUjUkwgBUaiSsstnCcthZmypxozLy2md80TjKMrjzxV0GpO1LKGHMA8je3Vrv8Zqebd
	O+3W70hPPo7v2JOw1ieM2OzK38NdTvPQwPuxJmBpVnOKqifso0rKSGfORpR6GYyOANzchv5JmXa+s
	6WsBSnEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiIER-00000005jet-1FDq;
	Fri, 10 Jul 2026 20:53:59 +0000
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiIEO-00000005je8-2umi
	for linux-um@lists.infradead.org;
	Fri, 10 Jul 2026 20:53:58 +0000
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-ca7c1176317so1035330a12.1
        for <linux-um@lists.infradead.org>; Fri, 10 Jul 2026 13:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783716836; x=1784321636; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sCserWiFtJpC7hBtSNUd5SRB8rb8z/bWzdzLHsDDkzQ=;
        b=mCU6p7bPssjOQrbK45Z7vcjFf7UO961WjtPOtvC+sLT4aPxdbn8U6TBfn3Kx6SLapt
         77ZQ/KALih576LhDEZdFjlY9+NP5oeRtnxOzzzcLQXnIPMleqxDdTJjXdxVRmu0pVE4T
         Xgp4p+b2Ne3JrMJ47GDIwCGe/T9C+/nL1sjU/hpGySCJdiEcBwpCco1TtjBF3dYKva3Q
         UB00t2QVLntZZUhXhhZ/BY9hn+Pm/Or/TrRXM2MRiLsAgmtJx58wt+wNWOszPhCNHUoR
         6uMlSpBmuXwfLsaDsCZlS7sL5Df8Bmh5WPRSIzXbOPNK8fRim8Gso5gxr7NLwmesC44I
         uUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783716836; x=1784321636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sCserWiFtJpC7hBtSNUd5SRB8rb8z/bWzdzLHsDDkzQ=;
        b=TR/iAX9p2aSoQTm6F23WT6uGp0XsyC3HEyOLF7rOrIIwk259itOARfT6QcgdmAde2Z
         LBS+7sL8SjCNHn3avR1vLlLt0+P8ryK2gX0FWEqsmfa7tgHBM7AakQsj8fa/fP+gNGIW
         Kfy4e0fy6kcCmbZVOPwxo2j2E9Yzx1W87hVs+VBpVONRo0fzIHHGX+t8TSE8c4selLH6
         Ju6juaK1CMPyTPBb0ksOPyGXA8mNHehQQ9pV1ml85igJXQ55KicPDOlarQzXyqvgEEtV
         JA+rjPFLIWfADT3oQhSNXC5AR7S0bK5QiMRTgwfpKGY8Ch9ssc25F8RF5OCWm8b9hyux
         6xvA==
X-Forwarded-Encrypted: i=1; AHgh+Rqtqz6GsQtbDkQTqb64IBKgIWQayGERXqliMQOPDQSncCrq0yOyUH/PWCvjMm9IJO0TpBWMZwnIFw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzV3l3P0liuZpYiz0zNe5UQRdTDfwLMJVVIVT2c9dYyzp0eSped
	kLHd/j4nVyMcwGU46WXxtuAFWKBhPelZouNkK1zocFRm1h+WnVD/iUIJ
X-Gm-Gg: AfdE7cn4sE8TrfpEsMuAbaT2yeRcOaFXa/2PQndjVBZJo+C99Fcf2c8Hm7IZc6v0zke
	1ynK6pQ7E7RZoQkg0JTLLb28253ay5FXySSjtObB84RterNArgp9wkFH6uCJnm+WznuOqPr6VSZ
	NNQK9YiPVW3wB/S37Rzx2XyRo/Ss5goi9ezNHDn8u+r6VbbKJkVWDp+e6AEU39uUsPrBz49tw6L
	2v0r+NbMc+UwWjkZkdwKe8/GPpqPn6LzdxkD1GBMqi9W9NkEU9wppsphaRFoz5QrxFADQdw3zPe
	95xxXqnpn2gIzaDEkzwOR8+d3CLOQr5pugUg3v+hIieN9xyMH/dDVO8kk2AeK6KnT+OOV+qn4ju
	hvuW/eENBbWn3qTOJNa0EI3IfeMunD4e4GSSHmUc7tKCNc2pTppYI+G3J/bl+rJ4KIlIymmp91N
	shXliYHn3U073Yegb+Sr0Ns5aR5YVYA0qTBHzUGkXQBVIDTezIIaOWEiI=
X-Received: by 2002:a05:6a21:46c5:b0:3bf:b40b:def2 with SMTP id adf61e73a8af0-3c11003092dmr563350637.9.1783716835815;
        Fri, 10 Jul 2026 13:53:55 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.107])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3119c2a7bb5sm21724371eec.25.2026.07.10.13.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 13:53:55 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Benjamin Berg <benjamin@sipsolutions.net>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Cong Wang <cwang@multikernel.io>
Subject: [RFC PATCH 1/6] pidfd: add pidfd_mmap()/pidfd_munmap() syscalls
Date: Fri, 10 Jul 2026 13:53:19 -0700
Message-ID: <20260710205324.1343217-2-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710205324.1343217-1-xiyou.wangcong@gmail.com>
References: <20260710205324.1343217-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260710_135356_742572_22EF3E62 
X-CRM114-Status: GOOD (  19.66  )
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

A supervisor that may PTRACE_ATTACH a target installs or removes a
mapping in the target's address space directly, without target-side
cooperation. The backing fd is resolved in the *caller's* fd table,
mirroring pidfd_getfd()'s cross-task install model.

pidfd_mmap() takes an extensible struct pidfd_mmap_args (clone3/openat2
style, versioned by a leading size field) since an mmap-shaped call
exceeds the 6-argument syscall limit. pidfd_munmap() is a flat 3-arg
call. Both are gated by ptrace_may_access(PTRACE_MODE_ATTACH_REALCREDS)
and wired for x86_64 and the asm-generic table.

Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 arch/x86/entry/syscalls/syscall_64.tbl |   2 +
 include/linux/syscalls.h               |   5 +
 include/uapi/linux/pidfd.h             |  18 ++++
 kernel/pid.c                           | 132 +++++++++++++++++++++++++
 scripts/syscall.tbl                    |   2 +
 5 files changed, 159 insertions(+)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 524155d655da..12e3cbeb0d2c 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -396,6 +396,8 @@
 469	common	file_setattr		sys_file_setattr
 470	common	listns			sys_listns
 471	common	rseq_slice_yield	sys_rseq_slice_yield
+472	common	pidfd_mmap		sys_pidfd_mmap
+473	common	pidfd_munmap		sys_pidfd_munmap
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 874d9067a43b..301a2d80823b 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -78,6 +78,7 @@ struct statmount;
 struct mnt_id_req;
 struct ns_id_req;
 struct xattr_args;
+struct pidfd_mmap_args;
 struct file_attr;
 
 #include <linux/types.h>
@@ -986,6 +987,10 @@ asmlinkage long sys_pidfd_send_signal(int pidfd, int sig,
 				       siginfo_t __user *info,
 				       unsigned int flags);
 asmlinkage long sys_pidfd_getfd(int pidfd, int fd, unsigned int flags);
+asmlinkage long sys_pidfd_mmap(int pidfd, struct pidfd_mmap_args __user *uargs,
+			       unsigned int flags);
+asmlinkage long sys_pidfd_munmap(int pidfd, unsigned long addr,
+				 unsigned long len);
 asmlinkage long sys_landlock_create_ruleset(const struct landlock_ruleset_attr __user *attr,
 		size_t size, __u32 flags);
 asmlinkage long sys_landlock_add_rule(int ruleset_fd, enum landlock_rule_type rule_type,
diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
index 0919246a1611..d68a11d844e3 100644
--- a/include/uapi/linux/pidfd.h
+++ b/include/uapi/linux/pidfd.h
@@ -107,6 +107,24 @@ struct pidfd_info {
 	__u64 supported_mask;	/* Mask flags that this kernel supports */
 };
 
+/*
+ * Argument block for pidfd_mmap(). Extensible: @size is sizeof(struct) as
+ * known to userspace; the kernel zero-extends older/smaller structs and
+ * rejects unknown non-zero trailing bytes (see copy_struct_from_user()).
+ */
+struct pidfd_mmap_args {
+	__u64 size;	/* sizeof(struct pidfd_mmap_args) */
+	__u64 addr;	/* MAP_FIXED target address, or 0 to let the kernel choose */
+	__u64 len;	/* length in bytes */
+	__u64 prot;	/* PROT_* protection bits */
+	__u64 flags;	/* MAP_* flags */
+	__u64 pgoff;	/* page offset into @fd */
+	__s32 fd;	/* backing fd in the caller's fd table, or -1 (MAP_ANONYMOUS) */
+	__u32 __spare;	/* must be zero */
+};
+
+#define PIDFD_MMAP_ARGS_SIZE_VER0	56 /* sizeof first published struct */
+
 #define PIDFS_IOCTL_MAGIC 0xFF
 
 #define PIDFD_GET_CGROUP_NAMESPACE            _IO(PIDFS_IOCTL_MAGIC, 1)
diff --git a/kernel/pid.c b/kernel/pid.c
index f55189a3d07d..d51471a36f3e 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -28,6 +28,12 @@
  */
 
 #include <linux/mm.h>
+#include <linux/mman.h>
+#include <linux/audit.h>
+#include <linux/file.h>
+#include <linux/ptrace.h>
+#include <linux/sched/mm.h>
+#include <linux/uaccess.h>
 #include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/init.h>
@@ -972,3 +978,129 @@ SYSCALL_DEFINE3(pidfd_getfd, int, pidfd, int, fd,
 
 	return pidfd_getfd(pid, fd);
 }
+
+/*
+ * Resolve @pidfd to its task's mm, gated like a ptrace attach. On success the
+ * caller owns the returned mm reference and must mmput() it. Mirrors the
+ * cross-task authorization of pidfd_getfd(): a supervisor that may
+ * PTRACE_ATTACH the target may install into its address space.
+ */
+static int pidfd_target_mm(int pidfd, struct mm_struct **mmp)
+{
+	struct task_struct *task;
+	struct mm_struct *mm;
+	unsigned int f_flags;
+
+	task = pidfd_get_task(pidfd, &f_flags);
+	if (IS_ERR(task))
+		return PTR_ERR(task);
+
+	if (!ptrace_may_access(task, PTRACE_MODE_ATTACH_REALCREDS)) {
+		put_task_struct(task);
+		return -EPERM;
+	}
+
+	mm = get_task_mm(task);
+	put_task_struct(task);
+	if (!mm)
+		return -ESRCH;
+
+	*mmp = mm;
+	return 0;
+}
+
+/**
+ * sys_pidfd_mmap() - install a mapping into another process's address space.
+ * @pidfd: pidfd of the target task.
+ * @uargs: pointer to a struct pidfd_mmap_args describing the mapping.
+ * @flags: reserved, must be zero.
+ *
+ * The backing fd (if any) is resolved in the *caller's* fd table, so a
+ * supervisor maps from its own descriptors into the target -- the target
+ * never needs to receive the fd. Gated by ptrace_may_access(); LSM/fsnotify
+ * hooks run against the caller.
+ *
+ * Returns the mapped address on success, or a negative errno.
+ */
+SYSCALL_DEFINE3(pidfd_mmap, int, pidfd, struct pidfd_mmap_args __user *, uargs,
+		unsigned int, flags)
+{
+	struct pidfd_mmap_args args;
+	struct mm_struct *mm;
+	struct file *file = NULL;
+	unsigned long ret;
+	u64 usize;
+	int err;
+
+	if (flags)
+		return -EINVAL;
+
+	if (get_user(usize, &uargs->size))
+		return -EFAULT;
+	if (usize < PIDFD_MMAP_ARGS_SIZE_VER0)
+		return -EINVAL;
+	if (usize > PAGE_SIZE)
+		return -E2BIG;
+
+	err = copy_struct_from_user(&args, sizeof(args), uargs, usize);
+	if (err)
+		return err;
+	if (args.__spare)
+		return -EINVAL;
+
+	if (args.flags & MAP_HUGETLB)
+		return -EINVAL;
+	if (args.addr != (unsigned long)args.addr ||
+	    args.len != (unsigned long)args.len ||
+	    args.prot != (unsigned long)args.prot ||
+	    args.flags != (unsigned long)args.flags ||
+	    args.pgoff != (unsigned long)args.pgoff)
+		return -EINVAL;
+
+	err = pidfd_target_mm(pidfd, &mm);
+	if (err)
+		return err;
+
+	if (!(args.flags & MAP_ANONYMOUS)) {
+		audit_mmap_fd(args.fd, args.flags);
+		file = fget(args.fd);
+		if (!file) {
+			ret = -EBADF;
+			goto out_mm;
+		}
+	}
+
+	ret = vm_mmap_remote(mm, file, args.addr, args.len, args.prot,
+			     args.flags, args.pgoff, 0);
+
+	if (file)
+		fput(file);
+out_mm:
+	mmput(mm);
+	return ret;
+}
+
+/**
+ * sys_pidfd_munmap() - remove a mapping from another process's address space.
+ * @pidfd: pidfd of the target task.
+ * @addr: start address of the range to unmap.
+ * @len: length in bytes.
+ *
+ * Gated by ptrace_may_access(), like sys_pidfd_mmap().
+ *
+ * Returns 0 on success, or a negative errno.
+ */
+SYSCALL_DEFINE3(pidfd_munmap, int, pidfd, unsigned long, addr,
+		unsigned long, len)
+{
+	struct mm_struct *mm;
+	int ret;
+
+	ret = pidfd_target_mm(pidfd, &mm);
+	if (ret)
+		return ret;
+
+	ret = vm_munmap_remote(mm, addr, len);
+	mmput(mm);
+	return ret;
+}
diff --git a/scripts/syscall.tbl b/scripts/syscall.tbl
index 7a42b32b6577..f4fa7826232b 100644
--- a/scripts/syscall.tbl
+++ b/scripts/syscall.tbl
@@ -412,3 +412,5 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	pidfd_mmap			sys_pidfd_mmap
+473	common	pidfd_munmap			sys_pidfd_munmap
-- 
2.43.0


