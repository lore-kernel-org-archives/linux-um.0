Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54AE8CDB46F
	for <linux-um@archiver.kernel.org>; Sat, 20 Jun 2026 03:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UQJZPDXyzYbdfHi5k5DDEvQTmfrd8Kt/5xF/6c2q/zU=; b=fptVNY4OIwTn8lSX52OO4pJ++9
	dspOkLq5KdRx7IhWZyo2bUrAkSLxk4Rt4xk4kZmdtUs7uFwiXQwWzj5+jSc9vvt7v3uQ26eO0P65X
	ZeX7aijJTn1PfPV59aka4Pmvkj8J8iKQgn6BHVwV+iy7QKuOWYY6cU0VeJAqNXw66OaBoD3hHWnak
	CbDlFRK5rIa7vz7G+s1QmKUv2peDBcwKlmfMiduunVOoyzAfdwYtn8PlMit6L1/DlnmG0Y3SkRU61
	qZ+BVbC0ynHfH3skSwx8nSVhS0aHbjByk3NyfjCkEUxso6iv189LusL6ochbwv1K2TRoeXXDNDPKU
	KjtrXw5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wamIN-000000038sg-2ZRn;
	Sat, 20 Jun 2026 03:22:59 +0000
Received: from mail-dy1-x1335.google.com ([2607:f8b0:4864:20::1335])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wamIK-000000038rV-1kow
	for linux-um@lists.infradead.org;
	Sat, 20 Jun 2026 03:22:57 +0000
Received: by mail-dy1-x1335.google.com with SMTP id 5a478bee46e88-30c03b09e02so3623128eec.1
        for <linux-um@lists.infradead.org>; Fri, 19 Jun 2026 20:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781925776; x=1782530576; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQJZPDXyzYbdfHi5k5DDEvQTmfrd8Kt/5xF/6c2q/zU=;
        b=V7ZDy+Nlvj13DxJCLZBNFcEnGPlEVyVq3bodQu1qhVd0uL3o70ubrmXJ472RuLK3MX
         uonMRTd1Ptfou1L7w81+gcavWpr2aX8uCp3m7pgMsfzir0QU/0FWN2iZlrLvdjDJIXuT
         UckZmwy7k1iqJpR7WPjAAMXUvm4pugxYI+0EGn7twcbmH9wUZjvwQcefqeoBfPE2f8ed
         zumO51lAZqAsKKgw4nZ8KFDy4ghoYwjrU2Ejy/e+PAkiSNJxu0fvjSu+FeboE3mr/HhS
         X8F2S9SCJCkIKLnY13m6TCIvDKasMq1qATQHrXiX6jOoSDjKd3ea86jqDeFJchXKxfsl
         a6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781925776; x=1782530576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UQJZPDXyzYbdfHi5k5DDEvQTmfrd8Kt/5xF/6c2q/zU=;
        b=pvY2SHLzbVwGAj9HjKH7FH2cMofw0o1/syLg1hyVNp7F9/vzg4bYzI8AvbHyk7LAPk
         Vywxpitnbs8o8KlrZzjh4NLJW90rmpCy2vXSQb35yoXf6tyNPJ6XPTW2q8/utuq8dvwD
         e+afnDdXjYneueDimPwDqvdYCRASkqAdjIMeIxXGsF1YYpzLxWVLF4/nWP74JMTfadwn
         pk90SPQv17OhlxNWpbzk0iaCUYHdlAQ4958aox2XLtHn26EuBjgiSqqBu/vSeiX0TE2z
         rU1IPjKzivcicRskNIJNXEJP5AIcms1LKFNKJ8XGrgfHTVMA8ku2zRemGVK5Lp+N5RFS
         Oq/Q==
X-Forwarded-Encrypted: i=1; AFNElJ9CFk4qY42/7EEmQzur+hF2RxJ2J+MWUxow89nbioMl6AHGf2O28MxW4cqi7Q3+08B25yUFA/9U9g==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywy/1qNs3xKHaKOs2nvJEngpis//kTi82r20OA1OYLVehAPUQiR
	B3VtJgkg4UHd745cbsNzpFwOGIaqqg4XQ4ZS9T2F8Pf+EpBMH60K7FXK
X-Gm-Gg: AfdE7ckJ4CFV5kU3HMrMMyErMYGDMLSpJ+cALXzzj0cRXBSbxCzLWjS9+ohUPB5iQMA
	QD+YnJxepy7hx8DJCnbynqHNu0L9+LJp6vKYstAtUtHaFBn25O9+BuhofkZG0NbrTnpTq0mqC76
	fuxt+p4mB9zF+MBCQMHx2nc9b5OF8d4/dOqg+6iUE3yLp+DwJONoU8lArD+0w4k4qaiLHTh8iLw
	067UFmQrSZVGb+Zdw9fQO9EV52f7y3nFHCH9jZAZZuG9/0W4hU2dlaP4JUkyu1psOeKg5qNWdxs
	mPsr9yoGJ8alQUfa+54URPec6GjFThR1ON5a/cXoTacxaa5/picTwFhTjIri4kHCkYURCIHnzd3
	hOitmawkmDOk5fZRaEmDZsodzrOu/6wk4zXNUXrQdnB+1FE9c//+CiL4vBQtTtYMK5ppfWp+4Es
	bR7xXuiGpTXw/gklLbchVNa+jLa0ahPFcNJ1KuuV7s6jUSaYEigg==
X-Received: by 2002:a05:7301:7bc3:b0:304:188d:d0be with SMTP id 5a478bee46e88-30c0d065c0bmr2662154eec.16.1781925775529;
        Fri, 19 Jun 2026 20:22:55 -0700 (PDT)
Received: from pop-os.. ([2601:647:6802:dbc0:ce45:b713:5d9f:6abd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1ba1f14fsm1902019eec.5.2026.06.19.20.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 20:22:54 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH 2/7] um: skas: gate stub mmap() through the USER_NOTIF monitor
Date: Fri, 19 Jun 2026 20:22:19 -0700
Message-ID: <b256f2d9655225ab723c766c76c2005703bebe38.1781925126.git.xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1781925126.git.xiyou.wangcong@gmail.com>
References: <cover.1781925126.git.xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260619_202256_462995_67FDEFE1 
X-CRM114-Status: GOOD (  20.78  )
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

Route the stub's mmap to SECCOMP_RET_USER_NOTIF instead of RET_ALLOW, and
have the monitor service the resulting notifications inline. This is the
mechanism that a following change uses to validate each mmap's arguments;
for now every stub mmap is allowed (responded with
SECCOMP_USER_NOTIF_FLAG_CONTINUE), so behaviour is unchanged.

CONTINUE is safe for mmap: its arguments are all scalars captured in
seccomp_data, so there is no TOCTOU re-read of user memory.

The stub runs queued mmap batches in two places: syscall_stub_flush()
and the userspace() resume path, both of which wake the stub via
wait_stub_done_seccomp(). Servicing therefore lives there: after waking,
the monitor issues one NOTIF_RECV/CONTINUE per STUB_SYSCALL_MMAP in the
batch the stub is about to run. Signals are masked while the stub
executes the batch inside its SIGSYS handler, so notifications arrive in
queued order with nothing interleaved, and a simple counted loop is
sufficient. The pre-existing wake logic is factored into
wake_seccomp_stub() so both the wake and the wait-only paths share it.

Verified on UML: guest boots and survives a fork/exec storm plus heavy
demand paging with every stub mmap round-tripping through the monitor.

Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 arch/um/kernel/skas/stub_exe.c  |   5 +-
 arch/um/os-Linux/skas/process.c | 121 ++++++++++++++++++++++----------
 2 files changed, 89 insertions(+), 37 deletions(-)

diff --git a/arch/um/kernel/skas/stub_exe.c b/arch/um/kernel/skas/stub_exe.c
index b5432f6ccbc7..65ea2af5ca73 100644
--- a/arch/um/kernel/skas/stub_exe.c
+++ b/arch/um/kernel/skas/stub_exe.c
@@ -173,7 +173,7 @@ noinline static void real_init(void)
 			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K,__NR_close,
 				 5, 0),
 			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, STUB_MMAP_NR,
-				 4, 0),
+				 5, 0),
 			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_munmap,
 				 3, 0),
 #ifdef __i386__
@@ -191,6 +191,9 @@ noinline static void real_init(void)
 
 			/* [18] Permitted call for the stub */
 			BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_ALLOW),
+
+			/* [19] mmap: route to the monitor for validation */
+			BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_USER_NOTIF),
 		};
 		struct sock_fprog prog = {
 			.len = sizeof(filter) / sizeof(filter[0]),
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 0ab1d109a68d..63b426b2c523 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -29,7 +29,9 @@
 #include <sysdep/stub.h>
 #include <sysdep/mcontext.h>
 #include <linux/futex.h>
+#include <linux/seccomp.h>
 #include <linux/threads.h>
+#include <sys/ioctl.h>
 #include <timetravel.h>
 #include <asm-generic/rwonce.h>
 #include "../internal.h"
@@ -147,49 +149,89 @@ void wait_stub_done(int pid)
 	fatal_sigsegv();
 }
 
+static void wake_seccomp_stub(struct mm_id *mm_idp)
+{
+	struct stub_data *data = (void *)mm_idp->stack;
+	const char byte = 0;
+	struct iovec iov = {
+		.iov_base = (void *)&byte,
+		.iov_len = sizeof(byte),
+	};
+	union {
+		char data[CMSG_SPACE(sizeof(mm_idp->syscall_fd_map))];
+		struct cmsghdr align;
+	} ctrl;
+	struct msghdr msgh = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+	};
+
+	if (mm_idp->syscall_fd_num) {
+		unsigned int fds_size = sizeof(int) * mm_idp->syscall_fd_num;
+		struct cmsghdr *cmsg;
+
+		msgh.msg_control = ctrl.data;
+		msgh.msg_controllen = CMSG_SPACE(fds_size);
+		cmsg = CMSG_FIRSTHDR(&msgh);
+		cmsg->cmsg_level = SOL_SOCKET;
+		cmsg->cmsg_type = SCM_RIGHTS;
+		cmsg->cmsg_len = CMSG_LEN(fds_size);
+		memcpy(CMSG_DATA(cmsg), mm_idp->syscall_fd_map, fds_size);
+
+		CATCH_EINTR(syscall(__NR_sendmsg, mm_idp->sock, &msgh, 0));
+	}
+
+	data->signal = 0;
+	data->futex = FUTEX_IN_CHILD;
+	CATCH_EINTR(syscall(__NR_futex, &data->futex,
+			    FUTEX_WAKE, 1, NULL, NULL, 0));
+}
+
+static int seccomp_notify_serve(int notify_fd)
+{
+	struct seccomp_notif req = {};
+	struct seccomp_notif_resp resp = {};
+	int ret;
+
+	CATCH_EINTR(ret = ioctl(notify_fd, SECCOMP_IOCTL_NOTIF_RECV, &req));
+	if (ret < 0)
+		return -errno;
+
+	resp.id = req.id;
+	resp.flags = SECCOMP_USER_NOTIF_FLAG_CONTINUE;
+
+	CATCH_EINTR(ret = ioctl(notify_fd, SECCOMP_IOCTL_NOTIF_SEND, &resp));
+	if (ret < 0)
+		return -errno;
+
+	return 0;
+}
+
+static void seccomp_serve_mmaps(struct mm_id *mm_idp)
+{
+	struct stub_data *data = (void *)mm_idp->stack;
+	int i, n_mmaps = 0;
+
+	if (mm_idp->seccomp_notify_fd < 0)
+		return;
+
+	for (i = 0; i < data->syscall_data_len; i++)
+		if (data->syscall_data[i].syscall == STUB_SYSCALL_MMAP)
+			n_mmaps++;
+
+	for (i = 0; i < n_mmaps; i++)
+		seccomp_notify_serve(mm_idp->seccomp_notify_fd);
+}
+
 void wait_stub_done_seccomp(struct mm_id *mm_idp, int running, int wait_sigsys)
 {
 	struct stub_data *data = (void *)mm_idp->stack;
 	int ret;
 
 	do {
-		const char byte = 0;
-		struct iovec iov = {
-			.iov_base = (void *)&byte,
-			.iov_len = sizeof(byte),
-		};
-		union {
-			char data[CMSG_SPACE(sizeof(mm_idp->syscall_fd_map))];
-			struct cmsghdr align;
-		} ctrl;
-		struct msghdr msgh = {
-			.msg_iov = &iov,
-			.msg_iovlen = 1,
-		};
-
 		if (!running) {
-			if (mm_idp->syscall_fd_num) {
-				unsigned int fds_size =
-					sizeof(int) * mm_idp->syscall_fd_num;
-				struct cmsghdr *cmsg;
-
-				msgh.msg_control = ctrl.data;
-				msgh.msg_controllen = CMSG_SPACE(fds_size);
-				cmsg = CMSG_FIRSTHDR(&msgh);
-				cmsg->cmsg_level = SOL_SOCKET;
-				cmsg->cmsg_type = SCM_RIGHTS;
-				cmsg->cmsg_len = CMSG_LEN(fds_size);
-				memcpy(CMSG_DATA(cmsg), mm_idp->syscall_fd_map,
-				       fds_size);
-
-				CATCH_EINTR(syscall(__NR_sendmsg, mm_idp->sock,
-						&msgh, 0));
-			}
-
-			data->signal = 0;
-			data->futex = FUTEX_IN_CHILD;
-			CATCH_EINTR(syscall(__NR_futex, &data->futex,
-					    FUTEX_WAKE, 1, NULL, NULL, 0));
+			wake_seccomp_stub(mm_idp);
+			seccomp_serve_mmaps(mm_idp);
 		}
 
 		do {
@@ -246,6 +288,13 @@ void wait_stub_done_seccomp(struct mm_id *mm_idp, int running, int wait_sigsys)
 		fatal_sigsegv();
 }
 
+/*
+ * Service one SECCOMP_RET_USER_NOTIF notification from a stub mmap: read the
+ * suspended call, then respond CONTINUE so the stub's real mmap runs. CONTINUE
+ * is safe here because mmap takes only scalar arguments (no TOCTOU on user
+ * memory). Validation of (addr, len, prot, fd, offset) is added later; for now
+ * every stub mmap is allowed.
+ */
 extern unsigned long current_stub_stack(void);
 
 static void get_skas_faultinfo(int pid, struct faultinfo *fi)
-- 
2.43.0


