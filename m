Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ACA8CDB46D
	for <linux-um@archiver.kernel.org>; Sat, 20 Jun 2026 03:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5FCm6E9MkcU38NC2Mst8nilIoI1sQjvR7qI1VIqxRUE=; b=v7IUVGQ5DROlWXZ8wNepEL174O
	R/SJL0uTU4+fi8anJ3zJUj+4R1CAdpsRK5yph/KEBhSsp9pE8bgUsoNFC7JLKoWUityswPWTFQcDT
	h6059d/nurx8lQYymDsYBkAnpcP80O5wTfyDlD4SAVt7bwhjtP08Rj+QmNe3n4yowIHy/uyMcTsv4
	1TX7AVCNu0MP+3fy2ko/U8BgdU3jAuUFaa7O/XSdOaSNWzxX41OxRi5GppEbltS7a959MjhGBaBgi
	VvCsZRwVyi4n7UXORDy4o/jHwwu/O3qQSGtQHivIRw3z/x8Np9QYAS7Pq5+kq+TrUgoHlE3MCDW2b
	KZLVgdBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wamIL-000000038s0-0GvC;
	Sat, 20 Jun 2026 03:22:57 +0000
Received: from mail-dy1-x1336.google.com ([2607:f8b0:4864:20::1336])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wamIJ-000000038r0-0HIJ
	for linux-um@lists.infradead.org;
	Sat, 20 Jun 2026 03:22:56 +0000
Received: by mail-dy1-x1336.google.com with SMTP id 5a478bee46e88-304f590dd91so3070070eec.0
        for <linux-um@lists.infradead.org>; Fri, 19 Jun 2026 20:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781925774; x=1782530574; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5FCm6E9MkcU38NC2Mst8nilIoI1sQjvR7qI1VIqxRUE=;
        b=JLTyjHo3DOW6gj+zISyA6KCIkF33fcQpzuA04rehib09P3ycPbeMn4PgQ4p3mvDlPj
         HFI+IPVjcrdPWvtJh1xzTdLPHvVEHhC/TM7CV3eh5268BXG1qtstc2XdCs9jbcXLDO9E
         jmdQ3K0VWlGFNvqH6zQzvxOHDUggyNmzNNyLJVlGHxDA54XIsDqdVhA2AbWRhHZK/ldZ
         D9BDFOaMO6mR1pmubQ/B+q0ujBMujLU66WSvLoK1/zfnVdDrCwWDaN2JUlVZks5/PzCo
         f2EtRpR0vk4ku6tQQ5cQNW8hVN15T+JGDFrR+v5D0WNiVjlrPfdA5jmWoV/2Zcg0nQRM
         YgyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781925774; x=1782530574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5FCm6E9MkcU38NC2Mst8nilIoI1sQjvR7qI1VIqxRUE=;
        b=tS5H6HQIn2NGc5qwKAiptwc3DNcfImHtalksvUPXCrztwqe/FyTExUly/1JXwQR6X1
         PqIb8QgqjLdKyeWjebP9gSObalT7Ou5AjaD2ySkYbwLfCi7hG9oB0EWvrhG364uN9jdF
         o+GCXnPYPJXz9Ag0cKvQX2AVLTnLs9qNVsu5ktc7LaC6XiN1ri8wJ/iSs5cJq/GXkeg/
         RPNdR6n7g1L8Aw8RPVE8YQ8Fsxv7QbXZ+/clAzRlJvwX/z4jmZ2AfdzVOgspyEbplMkY
         fGR3KumwEM7Qizf2rLhq/5PMZWvWb/uM16sHl1X6Lmr/fwbiQ9pDtUnSrZWBYyOcVghv
         hGpg==
X-Forwarded-Encrypted: i=1; AFNElJ9VNQrjUDSAXStAWanh04EezTlvIfuovRV4KVqllvTdS4ggraCRYPwkwETGpMd4jsbQnS6poTW2gw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwzBbtK7SN/ZxvWYtQC8qEWAOW6KPmA7+qlRU/e3ynam3/TKL/C
	yeRgbK/1Mn2qXodQURULr0HYsbTRuaaR8jxfy5BTFGUlKhyLL70v/DNS
X-Gm-Gg: AfdE7cnXMjiG3iFhZ3vzJDMafoXNeTuFPpwJ/JxLVrcHwH0E7ZUDVU+U/9/cqyr0BLY
	zk/lxb5eE+qGnkRVrerl+MOebrQqBQ4x7+bqi0On3vnAOC9a9QJJS9uuMi4HaSUsk90oHtL7l2M
	tjzL+MR5cfVRiTq4vMNAOvBOErLvw58Rl6rRn/PpGTOCSTLJqZNE4FMEQak9z5zRqpONU4q2JUK
	MCoursClEMTgQvNnDqIsIVAvC4EMoA83T6/ZjolPzeM0NLFgHcrWCeINuMvUAU+gvpB/PaQ6FUR
	Qm+u8UjiS5X8BOir2EwgzGxM7N4vbE95x2rMjU3kzgK5MNoOo9VVTCX18vhog65lhnuH24kTOS1
	CgcJMGVyqxFg8c3VcATnj8DkWp5AxIlXs1Cmaajnx4STL1IpviN9aiaqsmauYDJ5GQ5W/cb2aMb
	v1D81T9lPmeAhhSDBkBBRi+FFUOBFMdaZ9EJV2uUmmgHv6OBgFRg==
X-Received: by 2002:a05:7300:6ca7:b0:30c:5a5:df4f with SMTP id 5a478bee46e88-30c07000e2amr3719479eec.16.1781925774012;
        Fri, 19 Jun 2026 20:22:54 -0700 (PDT)
Received: from pop-os.. ([2601:647:6802:dbc0:ce45:b713:5d9f:6abd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1ba1f14fsm1902019eec.5.2026.06.19.20.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 20:22:53 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH 1/7] um: skas: create a seccomp USER_NOTIF listener and hand it to the monitor
Date: Fri, 19 Jun 2026 20:22:18 -0700
Message-ID: <11160b08c2b828d6684983502e7d6c8c88e5b230.1781925126.git.xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1781925126.git.xiyou.wangcong@gmail.com>
References: <cover.1781925126.git.xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260619_202255_112326_1F428C66 
X-CRM114-Status: GOOD (  20.27  )
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

First step toward validating stub mmap() calls (the intra-guest /
host-escape disclosure issue in stub.c "Known security issues"): give the
monitor a SECCOMP_RET_USER_NOTIF listener for each stub's filter, so a
later change can route mmap to the monitor for per-call validation.

The stub installs its seccomp filter with NEW_LISTENER (plus TSYNC_ESRCH,
which the kernel requires to combine NEW_LISTENER with TSYNC); the
seccomp() return value is the listener fd. mmap still returns RET_ALLOW,
so there is no behavioural change yet.

The stub cannot hand the fd over itself: once the filter is installed,
every syscall it makes from outside the stub page traps with SIGSYS
instead of executing, so it can neither sendmsg() nor close() the fd.
Instead the monitor pulls it with pidfd_getfd(): the listener is, by
construction, fd 1 in the stub (close_range() left only fd 0 open before
seccomp() allocated it). Leaving the stub's copy open is harmless:
ioctl (NOTIF_RECV/SEND) is not on the syscall allowlist, so a hijacked
stub cannot self-approve. The monitor stores the fd in mm_id.

Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 arch/um/include/shared/skas/mm_id.h |  1 +
 arch/um/kernel/skas/stub_exe.c      | 12 ++++++---
 arch/um/os-Linux/skas/process.c     | 38 +++++++++++++++++++++++++++--
 3 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/arch/um/include/shared/skas/mm_id.h b/arch/um/include/shared/skas/mm_id.h
index 18c0621430d2..46164d71554b 100644
--- a/arch/um/include/shared/skas/mm_id.h
+++ b/arch/um/include/shared/skas/mm_id.h
@@ -17,6 +17,7 @@ struct mm_id {
 
 	/* Only used with SECCOMP mode */
 	int sock;
+	int seccomp_notify_fd;
 	int syscall_fd_num;
 	int syscall_fd_map[STUB_MAX_FDS];
 };
diff --git a/arch/um/kernel/skas/stub_exe.c b/arch/um/kernel/skas/stub_exe.c
index cbafaa684e66..b5432f6ccbc7 100644
--- a/arch/um/kernel/skas/stub_exe.c
+++ b/arch/um/kernel/skas/stub_exe.c
@@ -196,10 +196,14 @@ noinline static void real_init(void)
 			.len = sizeof(filter) / sizeof(filter[0]),
 			.filter = filter,
 		};
-
-		if (stub_syscall3(__NR_seccomp, SECCOMP_SET_MODE_FILTER,
-				  SECCOMP_FILTER_FLAG_TSYNC,
-				  (unsigned long)&prog) != 0)
+		long listener;
+
+		listener = stub_syscall3(__NR_seccomp, SECCOMP_SET_MODE_FILTER,
+					 SECCOMP_FILTER_FLAG_TSYNC |
+					 SECCOMP_FILTER_FLAG_NEW_LISTENER |
+					 SECCOMP_FILTER_FLAG_TSYNC_ESRCH,
+					 (unsigned long)&prog);
+		if (listener < 0)
 			stub_syscall1(__NR_exit, 21);
 
 		/* Fall through, the exit syscall will cause SIGSYS */
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index d6c22f8aa06d..0ab1d109a68d 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -428,6 +428,34 @@ __initcall(init_stub_exe_fd);
 
 int using_seccomp;
 
+/*
+ * Obtain the SECCOMP_RET_USER_NOTIF listener fd the stub created. The stub
+ * cannot hand it over itself: after installing the filter, every syscall it
+ * makes traps with SIGSYS rather than executing (so it can neither sendmsg()
+ * it nor close() it). Instead the listener is, by construction, the first free
+ * fd in the stub -- fd 1, since close_range() left only fd 0 open before
+ * seccomp() allocated it -- so the monitor duplicates it directly with
+ * pidfd_getfd(). ptrace_may_access() holds because the monitor is the stub's
+ * parent.
+ */
+#define STUB_LISTENER_FD 1
+static int get_stub_listener(struct mm_id *mm_id)
+{
+	int pidfd, lfd;
+
+	pidfd = syscall(__NR_pidfd_open, mm_id->pid, 0);
+	if (pidfd < 0)
+		return -errno;
+
+	lfd = syscall(__NR_pidfd_getfd, pidfd, STUB_LISTENER_FD, 0);
+	close(pidfd);
+	if (lfd < 0)
+		return -errno;
+
+	mm_id->seccomp_notify_fd = lfd;
+	return 0;
+}
+
 /**
  * start_userspace() - prepare a new userspace process
  * @mm_id: The corresponding struct mm_id
@@ -449,6 +477,8 @@ int start_userspace(struct mm_id *mm_id)
 	unsigned long sp;
 	int status, n, err;
 
+	mm_id->seccomp_notify_fd = -1;
+
 	/* setup a temporary stack page */
 	stack = mmap(NULL, UM_KERN_PAGE_SIZE,
 		     PROT_READ | PROT_WRITE | PROT_EXEC,
@@ -522,10 +552,14 @@ int start_userspace(struct mm_id *mm_id)
 	}
 
 	close(tramp_data.sockpair[0]);
-	if (using_seccomp)
+	if (using_seccomp) {
 		mm_id->sock = tramp_data.sockpair[1];
-	else
+		err = get_stub_listener(mm_id);
+		if (err)
+			goto out_kill;
+	} else {
 		close(tramp_data.sockpair[1]);
+	}
 
 	return 0;
 
-- 
2.43.0


