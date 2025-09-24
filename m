Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F121BCAC5B1
	for <linux-um@archiver.kernel.org>; Wed, 24 Sep 2025 14:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LP9bDhgXxCDJw6Oc9+3jyKgig0nV2Eyo34N0Tx+L9L8=; b=2oyd9YgyEn6vtzpaS/hnsVoBsF
	hUSJZK/PySvrXumkEhdUAXNXQBcvZGbkhQV40XgCQvvfXolq2O2do2qZ5RhEPa1HZTrEzslNgrP7r
	8sUYERflweWcYtmvcxHGUxAUjNO26U0K0WmCifvakTNxCkE4gZKoPsca0d3HYhRsHlRf/uPOrOWiV
	5wfDGn2o+b9WPo5LrL/7Xa4UtkDw5qMUvgbPhppyVjMbmXPhYaWvn/gJzTOzgl1d+iY08XPsZ65rd
	JmBUSUfTt4Xp4MUqXmQleNO7EndAIzgsoYPJg3S0dcSODwrjVPYnMEz6Cwf6zlOyQMqa9kS7KQRWV
	biSoCdDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1QNm-00000000b9l-35Bc;
	Wed, 24 Sep 2025 14:22:10 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1QNk-00000000b5K-1aXe
	for linux-um@lists.infradead.org;
	Wed, 24 Sep 2025 14:22:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=LP9bDhgXxCDJw6Oc9+3jyKgig0nV2Eyo34N0Tx+L9L8=;
	t=1758723728; x=1759933328; b=xpUc39h4LQ/0eT2fWWnT0nNTZZ6isgculv8h10V5JNT3Xx3
	BZq9y+zYS+A9sxzTnOK19nUpgTUt2zSOZR2ClYL5KHHsScDtJbbJhAxDTpRw40PjrFQ+Cc8s17QgJ
	RlfdPJpluh8rVaJP1d+ujQVpmvYH+ZcfstNyRx2ZlOxm+2i3hq5pN5yjTXnnKNsvRFuqFzmnxgTEM
	faL93xgDHkgIj5T/cAFmPx0ZQap/PL/7nTAo0bexOBL8pGdkHT+0WHWyYDnCAUqXyoD4A+zDYRRSl
	8vtKZ0T7lMAi5CZRcsZ+gEqmjkPX8aZSq8aQneNWl0Z6rSbrVDhvQNYqaVIFOW0Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1v1QNg-000000090Bz-25Cd;
	Wed, 24 Sep 2025 16:22:04 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v3 11/12] tools/nolibc: add ptrace support
Date: Wed, 24 Sep 2025 16:20:58 +0200
Message-ID: <20250924142059.527768-12-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924142059.527768-1-benjamin@sipsolutions.net>
References: <20250924142059.527768-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250924_072208_423074_1E7F1700 
X-CRM114-Status: GOOD (  14.44  )
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
v3:
- Only use variardic for ptrace and not for sys_ptrace
---
 tools/include/nolibc/Makefile                |  1 +
 tools/include/nolibc/nolibc.h                |  1 +
 tools/include/nolibc/sys/ptrace.h            | 44 ++++++++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c |  2 +
 4 files changed, 48 insertions(+)
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
index 000000000000..5d1e52965878
--- /dev/null
+++ b/tools/include/nolibc/sys/ptrace.h
@@ -0,0 +1,44 @@
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
+ */
+static __attribute__((unused))
+long sys_ptrace(int op, pid_t pid, void *addr, void *data)
+{
+	return my_syscall4(__NR_ptrace, op, pid, addr, data);
+}
+
+static __attribute__((unused))
+ssize_t ptrace(int op, pid_t pid, ...)
+{
+	ssize_t ret;
+	va_list args;
+
+	va_start(args, pid);
+	ret = __sysret(sys_ptrace(op, pid,
+				  va_arg(args, void *),
+				  va_arg(args, void *)));
+	va_end(args);
+
+	return ret;
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


