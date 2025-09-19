Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E83A7CAC59A
	for <linux-um@archiver.kernel.org>; Fri, 19 Sep 2025 15:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7Np3imODxsjoOhAuPXHTzANt4hW9A1qllEuJgkf7Rf4=; b=iy0fUbiM4HyyoAul9bzKurmzfz
	JUgDO/Om0Y5aI0Iu8TYMgqRYEy2/kYiXQfDXLByvQEXZNweturROsiI+QKi2N9RPYcEbyQrci1ONw
	gERTmQ6Jn5C3MyJm4wLB0bmd926+2kidTYIpB5uHX1zgK/EqZbTA8c0JUhLQqTB3itfpuvGFcevX9
	9DNkee3fbq7ijo7R20TYF1aDg7KAZ6CGM9w8B9s/UsmooCdZ5ROsPzT90oVtdc8/kB5bE+iKVlRib
	VOSkq/0avm6DC9JniasS5n/arsQsQqGm2KIUs/4JzEuq+qNhNpa9YQMqvqx+tov/uV68fmGx4phZh
	CtjiXiXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzd9k-00000003MNr-2xiF;
	Fri, 19 Sep 2025 15:36:16 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzd9h-00000003MGl-0Hzj
	for linux-um@lists.infradead.org;
	Fri, 19 Sep 2025 15:36:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=7Np3imODxsjoOhAuPXHTzANt4hW9A1qllEuJgkf7Rf4=;
	t=1758296172; x=1759505772; b=Xng8rc993TqVzjh6AfRuGaRGNsecG9kkDpd93UyTrZADpBe
	oxrpBK5s+EmHKZEHHDz1lrGMRqGBEv/pBZZGbpk6m6dKgsu7lJ99Q+S05xzOuUPZXMI01QsWMPCY+
	J17fc9kCBZTKK3+s2BTiDfp970ILAgdWAZDcrYfibqufvpyHUnRyXo7wOKt7HQzLQxcRXGTPkpIFv
	CR8tXA0idiUxhz/6/FBka4KVIISoPHrnCEqMVallUG9g+pgR+oDATAygnveVwiCL41I0x01G/u2UA
	l8QV4gAXhLMgPrzudElvbvVhMgceXods6krAatEqHsiSBfmXudsqIlC70WIJCmJA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uzd9d-0000000G6O6-2qln;
	Fri, 19 Sep 2025 17:36:10 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 09/11] tools/nolibc: add uio.h with readv and writev
Date: Fri, 19 Sep 2025 17:34:18 +0200
Message-ID: <20250919153420.727385-10-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919153420.727385-1-benjamin@sipsolutions.net>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250919_083613_149333_F7D37592 
X-CRM114-Status: GOOD (  14.74  )
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

This is generally useful and struct iovec is also needed for other
purposes such as ptrace.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 tools/include/nolibc/Makefile                |  1 +
 tools/include/nolibc/nolibc.h                |  1 +
 tools/include/nolibc/sys/uio.h               | 49 ++++++++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c |  9 ++++
 4 files changed, 60 insertions(+)
 create mode 100644 tools/include/nolibc/sys/uio.h

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index 143c2d2c2ba6..9bbbba32dac6 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -62,6 +62,7 @@ all_files := \
 		sys/time.h \
 		sys/timerfd.h \
 		sys/types.h \
+		sys/uio.h \
 		sys/utsname.h \
 		sys/wait.h \
 		time.h \
diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index c199ade200c2..b4bc1c9b883d 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -109,6 +109,7 @@
 #include "sys/sysmacros.h"
 #include "sys/time.h"
 #include "sys/timerfd.h"
+#include "sys/uio.h"
 #include "sys/utsname.h"
 #include "sys/wait.h"
 #include "ctype.h"
diff --git a/tools/include/nolibc/sys/uio.h b/tools/include/nolibc/sys/uio.h
new file mode 100644
index 000000000000..7ad42b927d2f
--- /dev/null
+++ b/tools/include/nolibc/sys/uio.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * uio for NOLIBC
+ * Copyright (C) 2017-2021 Willy Tarreau <w@1wt.eu>
+ * Copyright (C) 2025 Intel Corporation
+ */
+
+/* make sure to include all global symbols */
+#include "../nolibc.h"
+
+#ifndef _NOLIBC_SYS_UIO_H
+#define _NOLIBC_SYS_UIO_H
+
+#include "../sys.h"
+#include <linux/uio.h>
+
+
+/*
+ * ssize_t readv(int fd, const struct iovec *iovec, int count);
+ */
+static __attribute__((unused))
+ssize_t sys_readv(int fd, const struct iovec *iovec, int count)
+{
+	return my_syscall3(__NR_readv, fd, iovec, count);
+}
+
+static __attribute__((unused))
+ssize_t readv(int fd, const struct iovec *iovec, int count)
+{
+	return __sysret(sys_readv(fd, iovec, count));
+}
+
+/*
+ * ssize_t writev(int fd, const struct iovec *iovec, int count);
+ */
+static __attribute__((unused))
+ssize_t sys_writev(int fd, const struct iovec *iovec, int count)
+{
+	return my_syscall3(__NR_writev, fd, iovec, count);
+}
+
+static __attribute__((unused))
+ssize_t writev(int fd, const struct iovec *iovec, int count)
+{
+	return __sysret(sys_writev(fd, iovec, count));
+}
+
+
+#endif /* _NOLIBC_SYS_UIO_H */
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index a297ee0d6d07..1907128bc3f6 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -25,6 +25,7 @@
 #include <sys/sysmacros.h>
 #include <sys/time.h>
 #include <sys/timerfd.h>
+#include <sys/uio.h>
 #include <sys/utsname.h>
 #include <sys/wait.h>
 #include <dirent.h>
@@ -1283,6 +1284,10 @@ int run_syscall(int min, int max)
 	int proc;
 	int test;
 	int tmp;
+	struct iovec iov_one = {
+		.iov_base = &tmp,
+		.iov_len = 1,
+	};
 	int ret = 0;
 	void *p1, *p2;
 	int has_gettid = 1;
@@ -1395,6 +1400,10 @@ int run_syscall(int min, int max)
 		CASE_TEST(waitpid_child);     EXPECT_SYSER(1, waitpid(getpid(), &tmp, WNOHANG), -1, ECHILD); break;
 		CASE_TEST(write_badf);        EXPECT_SYSER(1, write(-1, &tmp, 1), -1, EBADF); break;
 		CASE_TEST(write_zero);        EXPECT_SYSZR(1, write(1, &tmp, 0)); break;
+		CASE_TEST(readv_badf);        EXPECT_SYSER(1, readv(-1, &iov_one, 1), -1, EBADF); break;
+		CASE_TEST(readv_zero);        EXPECT_SYSZR(1, readv(1, NULL, 0)); break;
+		CASE_TEST(writev_badf);       EXPECT_SYSER(1, writev(-1, &iov_one, 1), -1, EBADF); break;
+		CASE_TEST(writev_zero);       EXPECT_SYSZR(1, writev(1, NULL, 0)); break;
 		CASE_TEST(syscall_noargs);    EXPECT_SYSEQ(1, syscall(__NR_getpid), getpid()); break;
 		CASE_TEST(syscall_args);      EXPECT_SYSER(1, syscall(__NR_statx, 0, NULL, 0, 0, NULL), -1, EFAULT); break;
 		CASE_TEST(namespace);         EXPECT_SYSZR(euid0 && proc, test_namespace()); break;
-- 
2.51.0


