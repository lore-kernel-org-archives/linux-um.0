Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 700E6CD4F20
	for <linux-um@archiver.kernel.org>; Thu,  5 Sep 2024 04:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jW6I4KlKpWNl1um24TbUQhbPOR/dUQpViYAJ7YTZhdQ=; b=nifWaXm/w1cWG/SKhVUhr6j4xu
	CWo/Z5cfx3nizSp/8nrt4NazJ7sZmsa6fTp8WzQnEp+xDn+rUiP2iZ0YdP2FNj2W1TTMI/aHeioTS
	ur2I9c/aTdVO+SRdtDc4ZXb3254ez1MM1RJlvO4f8TnxeDIxipOJl5Ie3Unbp4coaSfKSIYa0/M1E
	RXFt7SD50paPt/ZXrGHjbP5nZ+RpzhHM+nWyF6G3aK1XDyl5B4ZA6pT7aacDd57SkOAyPxM6r7YGq
	dO6Isf6jgqxZ0Z77yS6pTzUu69ItNcpR73ZDFZROU/KEq/T5N47svsSP8ycwQ/jbyJv4/RTCzweE9
	zPVNirtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sm4LB-00000006yKd-2FyK;
	Thu, 05 Sep 2024 04:43:29 +0000
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sm4By-00000006waR-0zoD
	for linux-um@lists.infradead.org;
	Thu, 05 Sep 2024 04:34:00 +0000
Received: by mail-qt1-x841.google.com with SMTP id d75a77b69052e-457ce5fda1aso2221361cf.1
        for <linux-um@lists.infradead.org>; Wed, 04 Sep 2024 21:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=illinois-edu.20230601.gappssmtp.com; s=20230601; t=1725510837; x=1726115637; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jW6I4KlKpWNl1um24TbUQhbPOR/dUQpViYAJ7YTZhdQ=;
        b=GCZZ2MuzNmNXBc26X03LheyK+GD+KrZ52td8ByWnvFXXKoxqAQnby9psH8I/FT//SD
         oxc+QOsWyk/q4xbJDZJb29wG+Ifsvt7nBRqqVlKK463vEvQGhylYFpYfnUeAvj8UV3y7
         Ni/rzFmSS8v0BbN6tlt2iEYz0NFIqiUnA4fCIsZd/ZvTCIB+lLieOiKSWkImgjmVE+WY
         7DF5eGvY4l8VQ5lvJv3aH9JNTjc8o7fhjk0ia7G1Uosm/Ol6qOe/dU4GJixu3+oyFe9P
         ILuiTXyChN/qOoBQv+vDM602dfWQS3XpuEhaHyAKrDvqa9lYl4QKe5MmCnVdZiPnnEjl
         E76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725510837; x=1726115637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jW6I4KlKpWNl1um24TbUQhbPOR/dUQpViYAJ7YTZhdQ=;
        b=ajWK8JYAJk51CyWOL2EG1S9xBG8snidxa2sssDiycEWX07XnaWEnvqQMZD1SwOk0kh
         AQ2zituuPpRx/xmzaU3gk/uGJOVslp4wiOKuGUcguOHv/2gDwRCc1pQdfEr4tATtOdBa
         2C5ui2CuJX9kztrcgw01mLDuM+w8p+e9lz8Eo1ohp7vXZDhk0WwFd7Yp55ds8dMpgaBx
         Pp7Sr7JZtdd0R2y31E2XNovUWFh/NM7O0h1Fg4Cx3LkmmQkw+zz1DiFfIMMjSfD4NBAU
         97WfRNjoG4KMibl+JS9vsEVOyF77EQoiDy/+VqxttQiJQdOiY668oQ+Y4TXxlMzWQAAl
         1SKg==
X-Forwarded-Encrypted: i=1; AJvYcCULwycNeixfKcLpcEP5IP3qrcdJzoJAOWK27ZacW30jk+8l7REdWzmjpDGUPK+o7CS8ZnUNTnCQJw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz0Dt0QpidDyMrxFVAuqIgXV177ItJXmv/sukeizZvbmiHSdqWj
	N25HEl8mYW10vcWwkUYuOjbU/35HqvXCc37DSHJAvZxfe9BPhTWN1/AouIPY5Q==
X-Google-Smtp-Source: AGHT+IEwycr1qI7QIGtRJjijdKQqvya606M/pAcD8gbo2l0V5EfT0U4aoTx9gaHs3Uo6LI6oljlesw==
X-Received: by 2002:a05:622a:1bab:b0:457:d253:7ad4 with SMTP id d75a77b69052e-457d2537c56mr123750421cf.43.1725510836506;
        Wed, 04 Sep 2024 21:33:56 -0700 (PDT)
Received: from node0.kernel3.linux-mcdc-pg0.utah.cloudlab.us ([128.110.218.246])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801b4cf4csm4182341cf.48.2024.09.04.21.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 21:33:56 -0700 (PDT)
From: Wentao Zhang <wentaoz5@illinois.edu>
To: wentaoz5@illinois.edu
Cc: Matt.Kelly2@boeing.com,
	akpm@linux-foundation.org,
	andrew.j.oppelt@boeing.com,
	anton.ivanov@cambridgegreys.com,
	ardb@kernel.org,
	arnd@arndb.de,
	bhelgaas@google.com,
	bp@alien8.de,
	chuck.wolber@boeing.com,
	dave.hansen@linux.intel.com,
	dvyukov@google.com,
	hpa@zytor.com,
	jinghao7@illinois.edu,
	johannes@sipsolutions.net,
	jpoimboe@kernel.org,
	justinstitt@google.com,
	kees@kernel.org,
	kent.overstreet@linux.dev,
	linux-arch@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	llvm@lists.linux.dev,
	luto@kernel.org,
	marinov@illinois.edu,
	masahiroy@kernel.org,
	maskray@google.com,
	mathieu.desnoyers@efficios.com,
	matthew.l.weber3@boeing.com,
	mhiramat@kernel.org,
	mingo@redhat.com,
	morbo@google.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	oberpar@linux.ibm.com,
	paulmck@kernel.org,
	peterz@infradead.org,
	richard@nod.at,
	rostedt@goodmis.org,
	samitolvanen@google.com,
	samuel.sarkisian@boeing.com,
	steven.h.vanderleest@boeing.com,
	tglx@linutronix.de,
	tingxur@illinois.edu,
	tyxu@illinois.edu,
	x86@kernel.org
Subject: [PATCH v2 1/4] llvm-cov: add Clang's Source-based Code Coverage support
Date: Wed,  4 Sep 2024 23:32:42 -0500
Message-ID: <20240905043245.1389509-2-wentaoz5@illinois.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240905043245.1389509-1-wentaoz5@illinois.edu>
References: <20240824230641.385839-1-wentaoz5@illinois.edu>
 <20240905043245.1389509-1-wentaoz5@illinois.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_213358_297611_7E6AE3AC 
X-CRM114-Status: GOOD (  26.48  )
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

Add infrastructure to support Clang's source-based code coverage [1]. This
includes debugfs entries for serializing profiles and resetting
counters/bitmaps.  Also adds coverage flags and kconfig options.

The newly added kernel/llvm-cov/ directory complements the existing gcov
implementation. Gcov works at the object code level which may better
reflect actual execution. However, Gcov lacks the necessary information to
correlate coverage measurement with source code location when compiler
optimization level is non-zero (which is the default when building the
kernel). In addition, gcov reports are occasionally ambiguous when
attempting to compare with source code level developer intent.

In the following gcov example from drivers/firmware/dmi_scan.c, an
expression with four conditions is reported to have six branch outcomes,
which is not ideally informative in many safety related use cases, such as
automotive, medical, and aerospace.

        5: 1068:	if (s == e || *e != '/' || !month || month > 12) {
branch  0 taken 5 (fallthrough)
branch  1 taken 0
branch  2 taken 5 (fallthrough)
branch  3 taken 0
branch  4 taken 0 (fallthrough)
branch  5 taken 5

On the other hand, Clang's Source-based Code Coverage instruments at the
compiler frontend which maintains an accurate mapping from coverage
measurement to source code location. Coverage reports reflect exactly how
the code is written regardless of optimization and can present advanced
metrics like branch coverage and MC/DC in a clearer way. Coverage report
for the same snippet by llvm-cov would look as follows:

 1068|      5|	if (s == e || *e != '/' || !month || month > 12) {
  ------------------
  |  Branch (1068:6): [True: 0, False: 5]
  |  Branch (1068:16): [True: 0, False: 5]
  |  Branch (1068:29): [True: 0, False: 5]
  |  Branch (1068:39): [True: 0, False: 5]
  ------------------

This work reuses a portion of code from a previous effort by Sami Tolvanen
et al. [2], specifically its debugfs interface and the underlying profile
processing, but discards all its PGO-specific parts, notably value
profiling.  To our end (code coverage required for high assurance), we
require instrumentation at the compiler front end, instead of IR; we care
about counters and bitmaps, but not value profiling.

Link: https://clang.llvm.org/docs/SourceBasedCodeCoverage.html [1]
Link: https://lore.kernel.org/lkml/20210407211704.367039-1-morbo@google.com/ [2]
Signed-off-by: Wentao Zhang <wentaoz5@illinois.edu>
Reviewed-by: Chuck Wolber <chuck.wolber@boeing.com>
Tested-by: Chuck Wolber <chuck.wolber@boeing.com>
---
 Makefile                          |   3 +
 arch/Kconfig                      |   1 +
 include/asm-generic/vmlinux.lds.h |  36 +++++
 kernel/Makefile                   |   1 +
 kernel/llvm-cov/Kconfig           |  64 ++++++++
 kernel/llvm-cov/Makefile          |   5 +
 kernel/llvm-cov/fs.c              | 253 ++++++++++++++++++++++++++++++
 kernel/llvm-cov/llvm-cov.h        | 156 ++++++++++++++++++
 scripts/Makefile.lib              |  11 ++
 scripts/mod/modpost.c             |   2 +
 10 files changed, 532 insertions(+)
 create mode 100644 kernel/llvm-cov/Kconfig
 create mode 100644 kernel/llvm-cov/Makefile
 create mode 100644 kernel/llvm-cov/fs.c
 create mode 100644 kernel/llvm-cov/llvm-cov.h

diff --git a/Makefile b/Makefile
index d57cfc689..51498134c 100644
--- a/Makefile
+++ b/Makefile
@@ -737,6 +737,9 @@ endif # KBUILD_EXTMOD
 # Defaults to vmlinux, but the arch makefile usually adds further targets
 all: vmlinux
 
+CFLAGS_LLVM_COV := -fprofile-instr-generate -fcoverage-mapping
+export CFLAGS_LLVM_COV
+
 CFLAGS_GCOV	:= -fprofile-arcs -ftest-coverage
 ifdef CONFIG_CC_IS_GCC
 CFLAGS_GCOV	+= -fno-tree-loop-im
diff --git a/arch/Kconfig b/arch/Kconfig
index 975dd22a2..0727265f6 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1601,6 +1601,7 @@ config ARCH_HAS_KERNEL_FPU_SUPPORT
 	  the kernel, as described in Documentation/core-api/floating-point.rst.
 
 source "kernel/gcov/Kconfig"
+source "kernel/llvm-cov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
 
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 1ae447931..82f5badbd 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -334,6 +334,42 @@
 #define THERMAL_TABLE(name)
 #endif
 
+#ifdef CONFIG_LLVM_COV_KERNEL
+#define LLVM_COV_DATA							\
+	__llvm_prf_data : AT(ADDR(__llvm_prf_data) - LOAD_OFFSET) {	\
+		BOUNDED_SECTION_POST_LABEL(__llvm_prf_data,		\
+					   __llvm_prf_data,		\
+					   _start, _end)		\
+	}								\
+	__llvm_prf_cnts : AT(ADDR(__llvm_prf_cnts) - LOAD_OFFSET) {	\
+		BOUNDED_SECTION_POST_LABEL(__llvm_prf_cnts,		\
+					   __llvm_prf_cnts,		\
+					   _start, _end)		\
+	}								\
+	__llvm_prf_names : AT(ADDR(__llvm_prf_names) - LOAD_OFFSET) {	\
+		BOUNDED_SECTION_POST_LABEL(__llvm_prf_names,		\
+					   __llvm_prf_names,		\
+					   _start, _end)		\
+	}								\
+	__llvm_prf_bits : AT(ADDR(__llvm_prf_bits) - LOAD_OFFSET) {	\
+		BOUNDED_SECTION_POST_LABEL(__llvm_prf_bits,		\
+					   __llvm_prf_bits,		\
+					   _start, _end)		\
+	}								\
+	__llvm_covfun : AT(ADDR(__llvm_covfun) - LOAD_OFFSET) {		\
+		BOUNDED_SECTION_POST_LABEL(__llvm_covfun,		\
+					   __llvm_covfun,		\
+					   _start, _end)		\
+	}								\
+	__llvm_covmap : AT(ADDR(__llvm_covmap) - LOAD_OFFSET) {		\
+		BOUNDED_SECTION_POST_LABEL(__llvm_covmap,		\
+					   __llvm_covmap,		\
+					   _start, _end)		\
+	}
+#else
+#define LLVM_COV_DATA
+#endif
+
 #define KERNEL_DTB()							\
 	STRUCT_ALIGN();							\
 	__dtb_start = .;						\
diff --git a/kernel/Makefile b/kernel/Makefile
index 3c13240df..773e6a9ee 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -117,6 +117,7 @@ obj-$(CONFIG_HAVE_STATIC_CALL) += static_call.o
 obj-$(CONFIG_HAVE_STATIC_CALL_INLINE) += static_call_inline.o
 obj-$(CONFIG_CFI_CLANG) += cfi.o
 obj-$(CONFIG_NUMA) += numa.o
+obj-$(CONFIG_LLVM_COV_KERNEL) += llvm-cov/
 
 obj-$(CONFIG_PERF_EVENTS) += events/
 
diff --git a/kernel/llvm-cov/Kconfig b/kernel/llvm-cov/Kconfig
new file mode 100644
index 000000000..9241fdfb0
--- /dev/null
+++ b/kernel/llvm-cov/Kconfig
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: GPL-2.0-only
+menu "Clang's source-based kernel coverage measurement (EXPERIMENTAL)"
+
+config ARCH_HAS_LLVM_COV
+	bool
+
+config ARCH_HAS_LLVM_COV_PROFILE_ALL
+	bool
+
+config LLVM_COV_KERNEL
+	bool "Enable Clang's source-based kernel coverage measurement"
+	depends on DEBUG_FS
+	depends on ARCH_HAS_LLVM_COV
+	depends on CC_IS_CLANG && CLANG_VERSION >= 180000
+	default n
+	help
+	  This option enables Clang's Source-based Code Coverage.
+
+	  If unsure, say N.
+
+	  On a kernel compiled with this option, run your test suites, and
+	  download the raw profile from /sys/kernel/debug/llvm-cov/profraw.
+	  This file can then be converted into the indexed format with
+	  llvm-profdata and used to generate coverage reports with llvm-cov.
+
+	  Additionally specify CONFIG_LLVM_COV_PROFILE_ALL=y to get profiling
+	  data for the entire kernel. To enable profiling for specific files or
+	  directories, add a line similar to the following to the respective
+	  Makefile:
+
+	  For a single file (e.g. main.o):
+	          LLVM_COV_PROFILE_main.o := y
+
+	  For all files in one directory:
+	          LLVM_COV_PROFILE := y
+
+	  To exclude files from being profiled even when
+	  CONFIG_LLVM_COV_PROFILE_ALL is specified, use:
+
+	          LLVM_COV_PROFILE_main.o := n
+	  and:
+	          LLVM_COV_PROFILE := n
+
+	  Note that a kernel compiled with coverage flags will be significantly
+	  larger and run slower.
+
+	  Note that the debugfs filesystem has to be mounted to access the raw
+	  profile.
+
+config LLVM_COV_PROFILE_ALL
+	bool "Profile entire Kernel"
+	depends on !COMPILE_TEST
+	depends on LLVM_COV_KERNEL
+	depends on ARCH_HAS_LLVM_COV_PROFILE_ALL
+	default n
+	help
+	  This options activates profiling for the entire kernel.
+
+	  If unsure, say N.
+
+	  Note that a kernel compiled with profiling flags will be significantly
+	  larger and run slower.
+
+endmenu
diff --git a/kernel/llvm-cov/Makefile b/kernel/llvm-cov/Makefile
new file mode 100644
index 000000000..f6a236562
--- /dev/null
+++ b/kernel/llvm-cov/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+GCOV_PROFILE		:= n
+LLVM_COV_PROFILE	:= n
+
+obj-y	+= fs.o
diff --git a/kernel/llvm-cov/fs.c b/kernel/llvm-cov/fs.c
new file mode 100644
index 000000000..c56f660a1
--- /dev/null
+++ b/kernel/llvm-cov/fs.c
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019	Sami Tolvanen <samitolvanen@google.com>, Google, Inc.
+ * Copyright (C) 2024	Jinghao Jia   <jinghao7@illinois.edu>,   UIUC
+ * Copyright (C) 2024	Wentao Zhang  <wentaoz5@illinois.edu>,   UIUC
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#define pr_fmt(fmt)	"llvm-cov: " fmt
+
+#include <linux/kernel.h>
+#include <linux/debugfs.h>
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/spinlock.h>
+#include "llvm-cov.h"
+
+/*
+ * This lock guards both counter/bitmap reset and serialization of the
+ * raw profile data. Keeping both of these activities separate via locking
+ * ensures that we don't try to serialize data that's being reset.
+ */
+DEFINE_SPINLOCK(llvm_cov_lock);
+
+static struct dentry *directory;
+
+struct llvm_cov_private_data {
+	char *buffer;
+	unsigned long size;
+};
+
+/*
+ * Raw profile data format:
+ * https://llvm.org/docs/InstrProfileFormat.html#raw-profile-format. We will
+ * only populate information that's relevant to basic Source-based Code Coverage
+ * before serialization. Other features like binary IDs, continuous mode,
+ * single-byte mode, value profiling, type profiling etc are not implemented.
+ */
+
+static void llvm_cov_fill_raw_profile_header(void **buffer)
+{
+	struct __llvm_profile_header *header = *(struct __llvm_profile_header **)buffer;
+
+	header->magic = INSTR_PROF_RAW_MAGIC_64;
+	header->version = INSTR_PROF_RAW_VERSION;
+	header->binary_ids_size = 0;
+	header->num_data = __llvm_prf_data_count();
+	header->padding_bytes_before_counters = 0;
+	header->num_counters = __llvm_prf_cnts_count();
+	header->padding_bytes_after_counters =
+		__llvm_prf_get_padding(__llvm_prf_cnts_size());
+	header->num_bitmap_bytes = __llvm_prf_bits_size();
+	header->padding_bytes_after_bitmap_bytes =
+		__llvm_prf_get_padding(__llvm_prf_bits_size());
+	header->names_size = __llvm_prf_names_size();
+	header->counters_delta = (u64)__llvm_prf_cnts_start -
+				 (u64)__llvm_prf_data_start;
+	header->bitmap_delta   = (u64)__llvm_prf_bits_start -
+				 (u64)__llvm_prf_data_start;
+	header->names_delta    = (u64)__llvm_prf_names_start;
+#if defined(CONFIG_CC_IS_CLANG) && CONFIG_CLANG_VERSION >= 190000
+	header->num_v_tables = 0;
+	header->v_names_size = 0;
+#endif
+	header->value_kind_last = IPVK_LAST;
+
+	*buffer += sizeof(*header);
+}
+
+/*
+ * Copy the source into the buffer, incrementing the pointer into buffer in the
+ * process.
+ */
+static void llvm_cov_copy_section_to_buffer(void **buffer, void *src,
+					    unsigned long size)
+{
+	memcpy(*buffer, src, size);
+	*buffer += size;
+}
+
+static unsigned long llvm_cov_get_raw_profile_size(void)
+{
+	return sizeof(struct __llvm_profile_header) +
+	       __llvm_prf_data_size() +
+	       __llvm_prf_cnts_size() +
+	       __llvm_prf_get_padding(__llvm_prf_cnts_size()) +
+	       __llvm_prf_bits_size() +
+	       __llvm_prf_get_padding(__llvm_prf_bits_size()) +
+	       __llvm_prf_names_size() +
+	       __llvm_prf_get_padding(__llvm_prf_names_size());
+}
+
+/*
+ * Serialize in-memory data into a format LLVM tools can understand
+ * (https://llvm.org/docs/InstrProfileFormat.html#raw-profile-format)
+ */
+static int llvm_cov_serialize_raw_profile(struct llvm_cov_private_data *p)
+{
+	int err = 0;
+	void *buffer;
+
+	p->size = llvm_cov_get_raw_profile_size();
+	p->buffer = vzalloc(p->size);
+
+	if (!p->buffer) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	buffer = p->buffer;
+
+	llvm_cov_fill_raw_profile_header(&buffer);
+	llvm_cov_copy_section_to_buffer(&buffer, __llvm_prf_data_start,
+					__llvm_prf_data_size());
+	llvm_cov_copy_section_to_buffer(&buffer, __llvm_prf_cnts_start,
+					__llvm_prf_cnts_size());
+	buffer += __llvm_prf_get_padding(__llvm_prf_cnts_size());
+	llvm_cov_copy_section_to_buffer(&buffer, __llvm_prf_bits_start,
+					__llvm_prf_bits_size());
+	buffer += __llvm_prf_get_padding(__llvm_prf_bits_size());
+	llvm_cov_copy_section_to_buffer(&buffer, __llvm_prf_names_start,
+					__llvm_prf_names_size());
+	buffer += __llvm_prf_get_padding(__llvm_prf_names_size());
+
+out:
+	return err;
+}
+
+/* open() implementation for llvm-cov data file. */
+static int llvm_cov_open(struct inode *inode, struct file *file)
+{
+	struct llvm_cov_private_data *data;
+	unsigned long flags;
+	int err;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	flags = llvm_cov_claim_lock();
+
+	err = llvm_cov_serialize_raw_profile(data);
+	if (unlikely(err)) {
+		kfree(data);
+		goto out_unlock;
+	}
+
+	file->private_data = data;
+
+out_unlock:
+	llvm_cov_release_lock(flags);
+out:
+	return err;
+}
+
+/* read() implementation for llvm-cov data file. */
+static ssize_t llvm_cov_read(struct file *file, char __user *buf, size_t count,
+			loff_t *ppos)
+{
+	struct llvm_cov_private_data *data = file->private_data;
+
+	if (!data)
+		return -EBADF;
+
+	return simple_read_from_buffer(buf, count, ppos, data->buffer,
+				       data->size);
+}
+
+/* release() implementation for llvm-cov data file. */
+static int llvm_cov_release(struct inode *inode, struct file *file)
+{
+	struct llvm_cov_private_data *data = file->private_data;
+
+	if (data) {
+		vfree(data->buffer);
+		kfree(data);
+	}
+
+	return 0;
+}
+
+static const struct file_operations llvm_cov_data_fops = {
+	.owner		= THIS_MODULE,
+	.open		= llvm_cov_open,
+	.read		= llvm_cov_read,
+	.llseek		= default_llseek,
+	.release	= llvm_cov_release
+};
+
+/* write() implementation for llvm-cov reset file */
+static ssize_t reset_write(struct file *file, const char __user *addr,
+			   size_t len, loff_t *pos)
+{
+	unsigned long flags;
+
+	flags = llvm_cov_claim_lock();
+	memset(__llvm_prf_cnts_start, 0, __llvm_prf_cnts_size());
+	memset(__llvm_prf_bits_start, 0, __llvm_prf_bits_size());
+	llvm_cov_release_lock(flags);
+
+	return len;
+}
+
+static const struct file_operations llvm_cov_reset_fops = {
+	.owner		= THIS_MODULE,
+	.write		= reset_write,
+	.llseek		= noop_llseek,
+};
+
+/* Create debugfs entries. */
+static int __init llvm_cov_init(void)
+{
+	directory = debugfs_create_dir("llvm-cov", NULL);
+	if (!directory)
+		goto err_remove;
+
+	if (!debugfs_create_file("profraw", 0400, directory, NULL,
+				 &llvm_cov_data_fops))
+		goto err_remove;
+
+	if (!debugfs_create_file("reset", 0200, directory, NULL,
+				 &llvm_cov_reset_fops))
+		goto err_remove;
+
+	return 0;
+
+err_remove:
+	debugfs_remove_recursive(directory);
+	pr_err("initialization failed\n");
+	return -EIO;
+}
+
+/* Remove debugfs entries. */
+static void __exit llvm_cov_exit(void)
+{
+	debugfs_remove_recursive(directory);
+}
+
+module_init(llvm_cov_init);
+module_exit(llvm_cov_exit);
diff --git a/kernel/llvm-cov/llvm-cov.h b/kernel/llvm-cov/llvm-cov.h
new file mode 100644
index 000000000..d9551a685
--- /dev/null
+++ b/kernel/llvm-cov/llvm-cov.h
@@ -0,0 +1,156 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019	Sami Tolvanen <samitolvanen@google.com>, Google, Inc.
+ * Copyright (C) 2024	Jinghao Jia   <jinghao7@illinois.edu>,   UIUC
+ * Copyright (C) 2024	Wentao Zhang  <wentaoz5@illinois.edu>,   UIUC
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef _LLVM_COV_H
+#define _LLVM_COV_H
+
+extern spinlock_t llvm_cov_lock;
+
+static __always_inline unsigned long llvm_cov_claim_lock(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&llvm_cov_lock, flags);
+
+	return flags;
+}
+
+static __always_inline void llvm_cov_release_lock(unsigned long flags)
+{
+	spin_unlock_irqrestore(&llvm_cov_lock, flags);
+}
+
+/*
+ * Note: These internal LLVM definitions must match the compiler version.
+ * See llvm/include/llvm/ProfileData/InstrProfData.inc in LLVM's source code.
+ */
+
+#define INSTR_PROF_RAW_MAGIC_64		\
+		((u64)255 << 56 |	\
+		 (u64)'l' << 48 |	\
+		 (u64)'p' << 40 |	\
+		 (u64)'r' << 32 |	\
+		 (u64)'o' << 24 |	\
+		 (u64)'f' << 16 |	\
+		 (u64)'r' << 8  |	\
+		 (u64)129)
+
+#if defined(CONFIG_CC_IS_CLANG) && CONFIG_CLANG_VERSION >= 190000
+#define INSTR_PROF_RAW_VERSION		10
+#define INSTR_PROF_DATA_ALIGNMENT	8
+#define IPVK_LAST			2
+#elif defined(CONFIG_CC_IS_CLANG) && CONFIG_CLANG_VERSION >= 180000
+#define INSTR_PROF_RAW_VERSION		9
+#define INSTR_PROF_DATA_ALIGNMENT	8
+#define IPVK_LAST			1
+#endif
+
+/**
+ * struct __llvm_profile_header - represents the raw profile header data
+ * structure. Description of each member can be found here:
+ * https://llvm.org/docs/InstrProfileFormat.html#header.
+ */
+struct __llvm_profile_header {
+	u64 magic;
+	u64 version;
+	u64 binary_ids_size;
+	u64 num_data;
+	u64 padding_bytes_before_counters;
+	u64 num_counters;
+	u64 padding_bytes_after_counters;
+	u64 num_bitmap_bytes;
+	u64 padding_bytes_after_bitmap_bytes;
+	u64 names_size;
+	u64 counters_delta;
+	u64 bitmap_delta;
+	u64 names_delta;
+#if defined(CONFIG_CC_IS_CLANG) && CONFIG_CLANG_VERSION >= 190000
+	u64 num_v_tables;
+	u64 v_names_size;
+#endif
+	u64 value_kind_last;
+};
+
+/**
+ * struct __llvm_profile_data - represents the per-function control structure.
+ * Description of each member can be found here:
+ * https://llvm.org/docs/InstrProfileFormat.html#profile-metadata. To measure
+ * Source-based Code Coverage, the internals of this struct don't matter at run
+ * time. The only purpose of the definition below is to run sizeof() against it
+ * so that we can calculate the "num_data" field in header.
+ */
+struct __llvm_profile_data {
+	const u64 name_ref;
+	const u64 func_hash;
+	const void *counter_ptr;
+	const void *bitmap_ptr;
+	const void *function_pointer;
+	void *values;
+	const u32 num_counters;
+	const u16 num_value_sites[IPVK_LAST + 1];
+	const u32 num_bitmap_bytes;
+} __aligned(INSTR_PROF_DATA_ALIGNMENT);
+
+/* Payload sections */
+
+extern struct __llvm_profile_data __llvm_prf_data_start[];
+extern struct __llvm_profile_data __llvm_prf_data_end[];
+
+extern u64 __llvm_prf_cnts_start[];
+extern u64 __llvm_prf_cnts_end[];
+
+extern char __llvm_prf_names_start[];
+extern char __llvm_prf_names_end[];
+
+extern char __llvm_prf_bits_start[];
+extern char __llvm_prf_bits_end[];
+
+#define __DEFINE_SECTION_SIZE(s)					\
+	static inline unsigned long __llvm_prf_ ## s ## _size(void)	\
+	{								\
+		unsigned long start =					\
+			(unsigned long)__llvm_prf_ ## s ## _start;	\
+		unsigned long end =					\
+			(unsigned long)__llvm_prf_ ## s ## _end;	\
+		return end - start;					\
+	}
+#define __DEFINE_SECTION_COUNT(s)					\
+	static inline unsigned long __llvm_prf_ ## s ## _count(void)	\
+	{								\
+		return __llvm_prf_ ## s ## _size() /			\
+			sizeof(__llvm_prf_ ## s ## _start[0]);		\
+	}
+
+__DEFINE_SECTION_SIZE(data)
+__DEFINE_SECTION_SIZE(cnts)
+__DEFINE_SECTION_SIZE(names)
+__DEFINE_SECTION_SIZE(bits)
+
+__DEFINE_SECTION_COUNT(data)
+__DEFINE_SECTION_COUNT(cnts)
+__DEFINE_SECTION_COUNT(names)
+__DEFINE_SECTION_COUNT(bits)
+
+#undef __DEFINE_SECTION_SIZE
+#undef __DEFINE_SECTION_COUNT
+
+static inline unsigned long __llvm_prf_get_padding(unsigned long size)
+{
+	return 7 & (sizeof(u64) - size % sizeof(u64));
+}
+
+#endif /* _LLVM_COV_H */
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 207325eaf..b468856b8 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -158,6 +158,17 @@ _c_flags += $(if $(patsubst n%,, \
 		$(CFLAGS_GCOV))
 endif
 
+#
+# Enable Clang's Source-based Code Coverage flags for a file or directory
+# depending on variables LLVM_COV_PROFILE_obj.o, LLVM_COV_PROFILE and
+# CONFIG_LLVM_COV_PROFILE_ALL.
+#
+ifeq ($(CONFIG_LLVM_COV_KERNEL),y)
+_c_flags += $(if $(patsubst n%,, \
+		$(LLVM_COV_PROFILE_$(target-stem).o)$(LLVM_COV_PROFILE)$(if $(is-kernel-object),$(CONFIG_LLVM_COV_PROFILE_ALL))), \
+		$(CFLAGS_LLVM_COV))
+endif
+
 #
 # Enable address sanitizer flags for kernel except some files or directories
 # we don't want to check (depends on variables KASAN_SANITIZE_obj.o, KASAN_SANITIZE)
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index d16d0ace2..836c2289b 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -743,6 +743,8 @@ static const char *const section_white_list[] =
 	".gnu.lto*",
 	".discard.*",
 	".llvm.call-graph-profile",	/* call graph */
+	"__llvm_covfun",
+	"__llvm_covmap",
 	NULL
 };
 
-- 
2.45.2


