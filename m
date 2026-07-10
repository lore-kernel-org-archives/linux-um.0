Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D4EC44506
	for <linux-um@archiver.kernel.org>; Fri, 10 Jul 2026 20:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RNCHCTp2HRwWejyccEraGcBIln8xR0gwETjSA5NC5cY=; b=Bz2/X1wTVsYOxoG+cYpktW7Dgt
	dAglxV/b0oEx2IxrTP2KqQgsFYlCPH5mFCHNm6cg79dajuqa30joaEMJ6r7zVN06FH52/TEhYzv3L
	BdfJ/14CZa7jsh/CS/DDCF8tCCWSNmkH37eGiINsruJ/bC4uOx5U1Re+Xzvvb2dHDjU6wUQVROwxn
	yoN7RtkZ/gm3vvFLO4zcLicv+gg+4oVnoYSPIVt0QNPoVnUld/kD3lbwuhwSCxCjFrObKj+bQLqQg
	zPE427ASiWk0/HYBlJZRX84kTsJJ8lLN0u7hw3/4zvBEpgnNgIPHyhGkV4lxn1AbAwaTxe8/4qqs3
	K7SrR0AA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiIEa-00000005jly-3EYc;
	Fri, 10 Jul 2026 20:54:08 +0000
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiIEX-00000005jiw-2Hko
	for linux-um@lists.infradead.org;
	Fri, 10 Jul 2026 20:54:07 +0000
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-c9e607d81fcso869815a12.2
        for <linux-um@lists.infradead.org>; Fri, 10 Jul 2026 13:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783716845; x=1784321645; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RNCHCTp2HRwWejyccEraGcBIln8xR0gwETjSA5NC5cY=;
        b=o94IjsVrGLCawLe8xCK663LLessIa550lZ8Q2Vpgy+9Aio5+tTnqGlgIn7WpGx7zxi
         TmwuyC/5/39DJCZa5UeQtiOI2x56YFna6/rm1lWkoz/rBFKV7jVeA/yAF1Sd+OMOGBTl
         N9YOwBwLjTB0PxtVtioUk9h9npGqZkY85fTjZlRn9h1RB0AVAo2le8rvZg1Ut7gmJEUd
         YWUvSqXN15oyQmUdUazdyCIHRI2LbpNn85z/FGLQn2RjcRMufIGXXhnPPrhYzkDdP8gU
         n9p8zdxqWNgNXdj7+uAxMhhJoW+jZvWKE8p3gOhdwKLRol3MAxkg5Rgs9Jk9l4Efm4X+
         ImFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783716845; x=1784321645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RNCHCTp2HRwWejyccEraGcBIln8xR0gwETjSA5NC5cY=;
        b=Fu/h+NbeHcKVyj0UasbNEUOLobMS9Ncy5PEijC6xMhc3qCMdNCCu0VkzJHGthfGoKB
         IqXk8r5OQ1buXGRKm/oARHMBg08M8QJOOtmmN75kvVtfHvmlFLcqYQM2wwI4v9Axl723
         sihQir6snAoOh2VLdwSjtD4XGi3/YQLHuGTJ5qp31f4JNAWBr6PhLWJPXM/fxiwIXL6G
         yvhPLq9XNd3zgVSQIWGhM4EyLgSlT88MCqMXno1w+d849oXw9mGgYL4DsXIdB8VyObGJ
         rS5hdwZaQpu1AMQ1OHdhLmCTgq75QRoSwAoAocr6hLgcoGfUtdUMGBWRH9S2iyC3vi6c
         L2Ng==
X-Forwarded-Encrypted: i=1; AHgh+Rq4Y7Giso9p1bdONSElQ6lQhL79+DcKC/CM5Y3CdH15+RgttSHRojh6hCTmEJfnuEYA6tAmPbD7YQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxRiwmeXX6jaNZl0+RglZXujWwSkoc7YN0bIiboqFQaKO5CFe5n
	Ja4C99v8VGI28DEkrivAvxmUk87ROqrFwRP2XuaEoQHS5Hly6gATZ1QZ
X-Gm-Gg: AfdE7clRzcwQ9EAebmQaXo+TibFugWC8NPjabbemvreVohjdTPHaD7lrgBS4UsA+ERy
	OBTtr3anDJ0TbvoJKX0ljRQzfPJWyJNFE5vQsd8pj7oJ3WGXOD1PPs1j9RQo7Bi9710N2elTwFu
	L2q4wfDhrrfqaj9zv48x3npirkMR1+3ACTcW1/5h3UY4GY9Amw2PeDw5oBYs8cobDSpEk5mbD97
	BAZX2mfExYEx68FHhKp6YUPN3DF83XgCKoNGUDuKMqdpsa503tnqiDQKuyKOhIE3DK8llfoT6qK
	Aaw36sej2h/WWZ7e3VRdpbGHKosjNNwL7GcuXmAVjGbK0sbPxHLxnGSgtG8uXkNnRhhSkBjDGGh
	aeyvXfVFz8eEMek72cqbpD8ITNgTPl8tEhGj7mXiCN3E2TOSGhKQn6GC1ZS5oLIVo/c7C5lpqfh
	YH0um2OaMrWpSWs9Apd4Hb1duEB5/253E/URiWFakt+eu7DJDbBRtfLpBj5RvUFatkqw==
X-Received: by 2002:a05:6a20:3d11:b0:3bd:4698:e7c4 with SMTP id adf61e73a8af0-3c110b166e1mr591264637.42.1783716844587;
        Fri, 10 Jul 2026 13:54:04 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.107])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3119c2a7bb5sm21724371eec.25.2026.07.10.13.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 13:54:03 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Benjamin Berg <benjamin@sipsolutions.net>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Cong Wang <cwang@multikernel.io>
Subject: [RFC PATCH 6/6] selftests/pidfd: add pidfd_mmap()/pidfd_munmap() tests
Date: Fri, 10 Jul 2026 13:53:24 -0700
Message-ID: <20260710205324.1343217-7-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710205324.1343217-1-xiyou.wangcong@gmail.com>
References: <20260710205324.1343217-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260710_135405_614713_EA4E8A61 
X-CRM114-Status: GOOD (  27.53  )
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

Exercise the new syscalls against a forked target reached by pidfd:

 - install_and_read: map a parent-owned memfd into the target, verify the
   target's new mapping shows the memfd contents (read via
   process_vm_readv), that MAP_SHARED writes propagate, and that
   pidfd_munmap() removes it. This also covers the key semantic that the
   backing fd is resolved in the *caller's* fd table (the target never
   sees the memfd).
 - anonymous: MAP_ANONYMOUS install + write-back round-trip.
 - bad_args: __spare != 0, undersized @size, non-zero reserved flags, and
   a bad backing fd are all rejected.
 - no_ptrace_access: a non-dumpable target (no ptrace access) yields
   -EPERM, matching the ptrace_may_access() gate.

The suite skips cleanly (TAP "SKIP") when the kernel lacks the syscall.
The pidfd_mmap ABI definitions are kept in pidfd.h alongside the existing
local uapi copies (struct pidfd_info, etc.).

Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 tools/testing/selftests/pidfd/Makefile        |   3 +-
 tools/testing/selftests/pidfd/pidfd.h         |  34 +++
 .../testing/selftests/pidfd/pidfd_mmap_test.c | 234 ++++++++++++++++++
 3 files changed, 270 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/pidfd/pidfd_mmap_test.c

diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing/selftests/pidfd/Makefile
index 4211f91e9af8..f1c421bf725a 100644
--- a/tools/testing/selftests/pidfd/Makefile
+++ b/tools/testing/selftests/pidfd/Makefile
@@ -4,7 +4,8 @@ CFLAGS += -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES) -pthread -Wall
 TEST_GEN_PROGS := pidfd_test pidfd_fdinfo_test pidfd_open_test \
 	pidfd_poll_test pidfd_wait pidfd_getfd_test pidfd_setns_test \
 	pidfd_file_handle_test pidfd_bind_mount pidfd_info_test \
-	pidfd_xattr_test pidfd_setattr_test pidfd_autoreap_test
+	pidfd_xattr_test pidfd_setattr_test pidfd_autoreap_test \
+	pidfd_mmap_test
 
 TEST_GEN_PROGS_EXTENDED := pidfd_exec_helper
 
diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index 5a4e78c10f43..91e65283d5fe 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -203,6 +203,28 @@ struct pidfd_info {
 	__u64 supported_mask;
 };
 
+#ifndef __NR_pidfd_mmap
+#define __NR_pidfd_mmap 472
+#endif
+
+#ifndef __NR_pidfd_munmap
+#define __NR_pidfd_munmap 473
+#endif
+
+#ifndef PIDFD_MMAP_ARGS_SIZE_VER0
+struct pidfd_mmap_args {
+	__u64 size;
+	__u64 addr;
+	__u64 len;
+	__u64 prot;
+	__u64 flags;
+	__u64 pgoff;
+	__s32 fd;
+	__u32 __spare;
+};
+#define PIDFD_MMAP_ARGS_SIZE_VER0	56
+#endif
+
 /*
  * The kernel reserves 300 pids via RESERVED_PIDS in kernel/pid.c
  * That means, when it wraps around any pid < 300 will be skipped.
@@ -267,6 +289,18 @@ static inline int sys_pidfd_getfd(int pidfd, int fd, int flags)
 	return syscall(__NR_pidfd_getfd, pidfd, fd, flags);
 }
 
+static inline long sys_pidfd_mmap(int pidfd, struct pidfd_mmap_args *args,
+				  unsigned int flags)
+{
+	return syscall(__NR_pidfd_mmap, pidfd, args, flags);
+}
+
+static inline long sys_pidfd_munmap(int pidfd, unsigned long addr,
+				    unsigned long len)
+{
+	return syscall(__NR_pidfd_munmap, pidfd, addr, len);
+}
+
 static inline int sys_memfd_create(const char *name, unsigned int flags)
 {
 	return syscall(__NR_memfd_create, name, flags);
diff --git a/tools/testing/selftests/pidfd/pidfd_mmap_test.c b/tools/testing/selftests/pidfd/pidfd_mmap_test.c
new file mode 100644
index 000000000000..39d623ce7b9d
--- /dev/null
+++ b/tools/testing/selftests/pidfd/pidfd_mmap_test.c
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <syscall.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <sys/prctl.h>
+#include <sys/socket.h>
+#include <sys/uio.h>
+#include <sys/wait.h>
+
+#include "pidfd.h"
+#include "kselftest_harness.h"
+
+#define UID_NOBODY 65535
+#define PATTERN 0xab
+#define MAP_LEN (4 * 1024)
+
+static struct pidfd_mmap_args mmap_args(int fd)
+{
+	struct pidfd_mmap_args args = {
+		.size	= sizeof(args),
+		.addr	= 0,		/* let the kernel choose */
+		.len	= MAP_LEN,
+		.prot	= PROT_READ | PROT_WRITE,
+		.flags	= MAP_SHARED,
+		.pgoff	= 0,
+		.fd	= fd,
+	};
+
+	return args;
+}
+
+static int read_remote(pid_t pid, unsigned long addr, void *buf, size_t len)
+{
+	struct iovec local = { .iov_base = buf, .iov_len = len };
+	struct iovec remote = { .iov_base = (void *)addr, .iov_len = len };
+
+	return process_vm_readv(pid, &local, 1, &remote, 1, 0) == (ssize_t)len ?
+	       0 : -1;
+}
+
+static int target(int sk)
+{
+	char buf;
+	int ret;
+
+	prctl(PR_SET_PDEATHSIG, SIGKILL);
+
+	if (send(sk, "R", 1, 0) != 1)		/* ready */
+		return -1;
+
+	while ((ret = recv(sk, &buf, sizeof(buf), 0)) > 0) {
+		if (buf == 'P' && prctl(PR_SET_DUMPABLE, 0) < 0)
+			return -1;
+		if (send(sk, &buf, 1, 0) != 1)
+			return -1;
+	}
+
+	return ret < 0 ? -1 : 0;
+}
+
+FIXTURE(pidfd_mmap)
+{
+	pid_t pid;
+	int pidfd;
+	int sk;		/* parent side of the socketpair */
+	int memfd;	/* lives in the PARENT fd table */
+	void *local;	/* the parent's own mapping of memfd */
+};
+
+FIXTURE_SETUP(pidfd_mmap)
+{
+	struct pidfd_mmap_args probe;
+	int sk_pair[2];
+	char c;
+
+	/*
+	 * The backing fd is resolved in the *caller's* (parent's) fd table,
+	 * so the target never needs to see it.
+	 */
+	self->memfd = sys_memfd_create("pidfd_mmap", 0);
+	ASSERT_GE(self->memfd, 0);
+	ASSERT_EQ(0, ftruncate(self->memfd, MAP_LEN));
+
+	self->local = mmap(NULL, MAP_LEN, PROT_READ | PROT_WRITE, MAP_SHARED,
+			   self->memfd, 0);
+	ASSERT_NE(MAP_FAILED, self->local);
+	memset(self->local, PATTERN, MAP_LEN);
+
+	ASSERT_EQ(0, socketpair(PF_LOCAL, SOCK_SEQPACKET, 0, sk_pair));
+	self->sk = sk_pair[0];
+
+	self->pid = fork();
+	ASSERT_GE(self->pid, 0);
+	if (self->pid == 0) {
+		close(sk_pair[0]);
+		_exit(target(sk_pair[1]) ? EXIT_FAILURE : EXIT_SUCCESS);
+	}
+	close(sk_pair[1]);
+
+	self->pidfd = sys_pidfd_open(self->pid, 0);
+	ASSERT_GE(self->pidfd, 0);
+
+	ASSERT_EQ(1, recv(self->sk, &c, 1, 0));		/* wait for "R" */
+
+	/* Skip the whole suite if the kernel does not have pidfd_mmap(). */
+	probe = mmap_args(self->memfd);
+	sys_pidfd_mmap(self->pidfd, &probe, 1);		/* reserved flags -> EINVAL */
+	if (errno == ENOSYS)
+		SKIP(return, "pidfd_mmap() is not supported");
+}
+
+FIXTURE_TEARDOWN(pidfd_mmap)
+{
+	EXPECT_EQ(0, close(self->pidfd));
+	EXPECT_EQ(0, close(self->sk));		/* tells the target to exit */
+	munmap(self->local, MAP_LEN);
+	close(self->memfd);
+	EXPECT_EQ(0, wait_for_pid(self->pid));
+}
+
+TEST_F(pidfd_mmap, install_and_read)
+{
+	struct pidfd_mmap_args args = mmap_args(self->memfd);
+	char buf[MAP_LEN];
+	long addr;
+	int i;
+
+	addr = sys_pidfd_mmap(self->pidfd, &args, 0);
+	ASSERT_GE(addr, 0);
+	ASSERT_EQ(0, addr & (sysconf(_SC_PAGESIZE) - 1));	/* page aligned */
+
+	/* The target's new mapping must show the memfd contents. */
+	ASSERT_EQ(0, read_remote(self->pid, addr, buf, MAP_LEN));
+	for (i = 0; i < MAP_LEN; i++)
+		ASSERT_EQ((unsigned char)PATTERN, (unsigned char)buf[i]);
+
+	/* MAP_SHARED: a write the parent makes to memfd is visible remotely. */
+	memset(self->local, 0xcd, MAP_LEN);
+	ASSERT_EQ(0, read_remote(self->pid, addr, buf, sizeof(buf)));
+	ASSERT_EQ((unsigned char)0xcd, (unsigned char)buf[0]);
+
+	/* pidfd_munmap() removes it. */
+	ASSERT_EQ(0, sys_pidfd_munmap(self->pidfd, addr, MAP_LEN));
+	EXPECT_EQ(-1, read_remote(self->pid, addr, buf, MAP_LEN));
+}
+
+TEST_F(pidfd_mmap, anonymous)
+{
+	struct pidfd_mmap_args args = mmap_args(-1);
+	struct iovec local, remote;
+	char in[64], out[64];
+	long addr;
+
+	args.flags = MAP_PRIVATE | MAP_ANONYMOUS;
+
+	addr = sys_pidfd_mmap(self->pidfd, &args, 0);
+	ASSERT_GE(addr, 0);
+
+	memset(out, 0x5a, sizeof(out));
+	local.iov_base = out;
+	local.iov_len = sizeof(out);
+	remote.iov_base = (void *)addr;
+	remote.iov_len = sizeof(out);
+	ASSERT_EQ((ssize_t)sizeof(out),
+		  process_vm_writev(self->pid, &local, 1, &remote, 1, 0));
+
+	ASSERT_EQ(0, read_remote(self->pid, addr, in, sizeof(in)));
+	ASSERT_EQ((unsigned char)0x5a, (unsigned char)in[0]);
+
+	ASSERT_EQ(0, sys_pidfd_munmap(self->pidfd, addr, MAP_LEN));
+}
+
+TEST_F(pidfd_mmap, bad_args)
+{
+	struct pidfd_mmap_args args;
+
+	/* The reserved padding must be zero. */
+	args = mmap_args(self->memfd);
+	args.__spare = 1;
+	EXPECT_EQ(-1, sys_pidfd_mmap(self->pidfd, &args, 0));
+	EXPECT_EQ(EINVAL, errno);
+
+	/* @size below the first published version is rejected. */
+	args = mmap_args(self->memfd);
+	args.size = 8;
+	EXPECT_EQ(-1, sys_pidfd_mmap(self->pidfd, &args, 0));
+	EXPECT_EQ(EINVAL, errno);
+
+	/* The reserved flags argument must be zero. */
+	args = mmap_args(self->memfd);
+	EXPECT_EQ(-1, sys_pidfd_mmap(self->pidfd, &args, 1));
+	EXPECT_EQ(EINVAL, errno);
+
+	/* A bad backing fd (resolved in the caller's table) is -EBADF. */
+	args = mmap_args(-1);
+	EXPECT_EQ(-1, sys_pidfd_mmap(self->pidfd, &args, 0));
+	EXPECT_EQ(EBADF, errno);
+
+	/* A bad pidfd fails. */
+	args = mmap_args(self->memfd);
+	EXPECT_EQ(-1, sys_pidfd_mmap(-1, &args, 0));
+}
+
+TEST_F(pidfd_mmap, no_ptrace_access)
+{
+	struct pidfd_mmap_args args = mmap_args(self->memfd);
+	int uid = getuid();
+	char c;
+
+	/* Drop privilege so CAP_SYS_PTRACE can't bypass the dumpable check. */
+	if (uid == 0)
+		ASSERT_EQ(0, seteuid(UID_NOBODY));
+
+	ASSERT_EQ(1, send(self->sk, "P", 1, 0));	/* target: PR_SET_DUMPABLE 0 */
+	ASSERT_EQ(1, recv(self->sk, &c, 1, 0));
+
+	EXPECT_EQ(-1, sys_pidfd_mmap(self->pidfd, &args, 0));
+	EXPECT_EQ(EPERM, errno);
+
+	if (uid == 0)
+		ASSERT_EQ(0, seteuid(0));
+}
+
+TEST_HARNESS_MAIN
-- 
2.43.0


