Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52111CAC5AA
	for <linux-um@archiver.kernel.org>; Fri, 19 Sep 2025 15:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RXl6ubRbFlom4y2e4H1GJqpLZi638eTvTDwJgOCQyw8=; b=u9KNr+/BaT+I/VeDfOMtBjgD58
	f6ongcORQWMn/kOeteZs2bS7BrOwt1ENU7YuPv5/uYgVksLPJ3iFodNIoNVMmE3MtL6GdBQRE8DZ7
	W5YuLD9n7J9KrsazBw9rL1hEy72ZmYqVlQoalX+sE0B5tGFz0RnYSKqrtl6UcCttMiBzyGD9D36g0
	fHr958OJrDPAayxIOOknZjaz3iOZ78QpX2dNcxaA4gc9TeviTreksYNPtzRPh20niVWTBayhqAY30
	Vt0kdqwqU3IJiUp5ufKgUiCG2VRctBizWYnboWh5+/rcEh5wnj7VZIawWNOULP3zn7HoFn77E6tzN
	kTJAdA1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzd9l-00000003MOR-0EsC;
	Fri, 19 Sep 2025 15:36:17 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzd9h-00000003MHI-1F2N
	for linux-um@lists.infradead.org;
	Fri, 19 Sep 2025 15:36:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=RXl6ubRbFlom4y2e4H1GJqpLZi638eTvTDwJgOCQyw8=;
	t=1758296173; x=1759505773; b=wbwLShnb+KLeFJU8uzk+i5H3+mXPOjkcTBr7Is4xOkgK8Gn
	0izvPupVFkXHstQ9nzGWmj6EPmwmuL79Oe4ze2MYF/AAN+HfAKZrN+HwFUAmAWEU+90gkH3bWTVVk
	4w7RbVW6V92elnttD6t6Fx94E++kwhp+9DhLwBJt5kyy/MXzxHGrTlESvUIDPNTv42eNGDoRBYB2l
	bLu3kLMp8N5uEBZ8eFHd9DG+nvy/VGeLDgzB2YQmnfg7SFuARHNx/H8KqoNVn7jqpGlbuJUydAFHD
	bSRmwj74KKFxQPpzXAkT9Z3NtCgTyauVP8a3EKx6VMq+SNU1HYW26ZdUrCxc+oyw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uzd9f-0000000G6O6-0Sob;
	Fri, 19 Sep 2025 17:36:11 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 10/11] tools/nolibc: add ptrace support
Date: Fri, 19 Sep 2025 17:34:19 +0200
Message-ID: <20250919153420.727385-11-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919153420.727385-1-benjamin@sipsolutions.net>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250919_083613_365297_F18611F8 
X-CRM114-Status: GOOD (  13.72  )
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

From: Benjamin Berg <benjamin.berg@intel.com>

Add ptrace support, as it will be useful in UML.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 tools/include/nolibc/Makefile                |  1 +
 tools/include/nolibc/nolibc.h                |  1 +
 tools/include/nolibc/sys/ptrace.h            | 52 ++++++++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c |  2 +
 4 files changed, 56 insertions(+)
 create mode 100644 tools/include/nolibc/sys/ptrace.h

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index 9bbbba32dac6..8e0cac3ac522 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -53,6 +53,7 @@ all_files := \
 		sys/mman.h \
 		sys/mount.h \
 		sys/prctl.h \
+		sys/ptrace.h \
 		sys/random.h \
 		sys/reboot.h \
 		sys/resource.h \
diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index b4bc1c9b883d..590eef545ca6 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -101,6 +101,7 @@
 #include "sys/mman.h"
 #include "sys/mount.h"
 #include "sys/prctl.h"
+#include "sys/ptrace.h"
 #include "sys/random.h"
 #include "sys/reboot.h"
 #include "sys/resource.h"
diff --git a/tools/include/nolibc/sys/ptrace.h b/tools/include/nolibc/sys/ptrace.h
new file mode 100644
index 000000000000..3119abdeeecb
--- /dev/null
+++ b/tools/include/nolibc/sys/ptrace.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * ptrace for NOLIBC
+ * Copyright (C) 2017-2021 Willy Tarreau <w@1wt.eu>
+ * Copyright (C) 2025 Intel Corporation
+ */
+
+/* make sure to include all global symbols */
+#include "../nolibc.h"
+
+#ifndef _NOLIBC_SYS_PTRACE_H
+#define _NOLIBC_SYS_PTRACE_H
+
+#include "../sys.h"
+#include "uio.h"
+
+
+#include <linux/ptrace.h>
+
+/*
+ * long ptrace(int op, pid_t pid, void *addr, void *data);
+ *
+ * However, addr may also be an integer in some cases.
+ */
+static __attribute__((unused))
+long sys_vptrace(int op, pid_t pid, va_list args)
+{
+	return my_syscall4(__NR_ptrace, op, pid,
+			   va_arg(args, void *), va_arg(args, void *));
+}
+
+static __attribute__((unused))
+ssize_t sys_ptrace(int op, pid_t pid, ...)
+{
+	va_list args;
+
+	va_start(args, pid);
+	return sys_vptrace(op, pid, args);
+	va_end(args);
+}
+
+static __attribute__((unused))
+ssize_t ptrace(int op, pid_t pid, ...)
+{
+	va_list args;
+
+	va_start(args, pid);
+	return __sysret(sys_vptrace(op, pid, args));
+	va_end(args);
+}
+
+#endif /* _NOLIBC_SYS_PTRACE_H */
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 1907128bc3f6..4c1b9ee32b7d 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -17,6 +17,7 @@
 #include <sys/mman.h>
 #include <sys/mount.h>
 #include <sys/prctl.h>
+#include <sys/ptrace.h>
 #include <sys/random.h>
 #include <sys/reboot.h>
 #include <sys/resource.h>
@@ -1404,6 +1405,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(readv_zero);        EXPECT_SYSZR(1, readv(1, NULL, 0)); break;
 		CASE_TEST(writev_badf);       EXPECT_SYSER(1, writev(-1, &iov_one, 1), -1, EBADF); break;
 		CASE_TEST(writev_zero);       EXPECT_SYSZR(1, writev(1, NULL, 0)); break;
+		CASE_TEST(ptrace);            EXPECT_SYSER(1, ptrace(PTRACE_CONT, getpid(), NULL, NULL), -1, ESRCH); break;
 		CASE_TEST(syscall_noargs);    EXPECT_SYSEQ(1, syscall(__NR_getpid), getpid()); break;
 		CASE_TEST(syscall_args);      EXPECT_SYSER(1, syscall(__NR_statx, 0, NULL, 0, 0, NULL), -1, EFAULT); break;
 		CASE_TEST(namespace);         EXPECT_SYSZR(euid0 && proc, test_namespace()); break;
-- 
2.51.0


