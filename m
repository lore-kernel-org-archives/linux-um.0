Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A446CCD184
	for <linux-um@archiver.kernel.org>; Tue, 14 Oct 2025 23:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0dpK8XMcoxC99pMhPBerPq1hizL9jmTFBmsyKKCkkGs=; b=ModYQg3dDk/NTl0oy9s3LKSaOc
	5jHWgCE+ZPl+60Kyixy1YPfohr3BJ0p0Ia8F6gVomKYVfyDfcee9WHgL+xBOq2V7BVV30Y6S5uqwQ
	DcqfgyTV1Qx6/SrtRV8wDSwjbZ6RbsdQ3qohQLJbW7HSWXqJExktuCb5bJhiAPwyNejtW5ncl2pQx
	9kHj2vJ+x61wnIS8u5TroNQHYvQSrDRZlvPJrBe6duRDyBrursxpzLs5QqL5gm8e10xi4JLDZDWa7
	mv2PesmlqfKkVA8/z+vqY2/vTWrqKrN1fXxRZ7GXiOjWFVaahaV1Yx7yRaVxHIYN9ufTXoiwETplp
	UAg7JypQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8oQE-000000002MN-0WXR;
	Tue, 14 Oct 2025 23:27:14 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8oQC-000000002L3-3qdR
	for linux-um@lists.infradead.org;
	Tue, 14 Oct 2025 23:27:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B99C462443;
	Tue, 14 Oct 2025 23:27:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A17C116D0;
	Tue, 14 Oct 2025 23:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760484431;
	bh=Pz0bFnEJwTh+jLNd7bZ65oYKPx4sgNStsZUicUCGhu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vgix6Qv2akncebIeWksZk8+wFzdT3fdelNZIr/WgDzUE097XwR4y638CtN90vgs/+
	 22Anx9BqeTSFIJqpxBOtL1l5FNLPqVUW/+9PlNBxmUGj+V7He6XJqLQY/bKtaxTQYe
	 2PWW9IWyXh6VKmGw8oXo+mzqyIETsTSDoVMvEHBrPxhWfnM8nd4H+GkOw8azWw9QYy
	 Pcq0NSxWFNIcP4+dqQ4KmTVsxq6+rN1E4l8Bs17RbvN2pjjJLij9KDJoxtOzCZe8xs
	 1st0+cTBMY8gh6NCzQBI8swviadbniEcezWTI3z9KV2knVNgQzQIK3fzyk0Fq3UPm/
	 JOe9veEZtk91Q==
From: Sasha Levin <sashal@kernel.org>
To: nathan@kernel.org
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
	ndesaulniers@google.com,
	oberpar@linux.ibm.com,
	paulmck@kernel.org,
	peterz@infradead.org,
	richard@nod.at,
	rostedt@goodmis.org,
	samitolvanen@google.com,
	samuel.sarkisian@boeing.com,
	sashal@kernel.org,
	steven.h.vanderleest@boeing.com,
	tglx@linutronix.de,
	tingxur@illinois.edu,
	tyxu@illinois.edu,
	wentaoz5@illinois.edu,
	x86@kernel.org
Subject: [RFC PATCH 2/4] llvm-cov: add Clang's MC/DC support
Date: Tue, 14 Oct 2025 19:26:37 -0400
Message-ID: <20251014232639.673260-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014232639.673260-1-sashal@kernel.org>
References: <20250829181007.GA468030@ax162>
 <20251014232639.673260-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Wentao Zhang <wentaoz5@illinois.edu>

Add infrastructure to enable Clang's Modified Condition/Decision Coverage
(MC/DC) [1].

Clang has added MC/DC support as of its 18.1.0 release. MC/DC is a fine-
grained coverage metric required by many automotive and aviation industrial
standards for certifying mission-critical software [2].

In the following example from arch/x86/events/probe.c, llvm-cov gives the
MC/DC measurement for the compound logic decision at line 43.

   43|     12|			if (msr[bit].test && !msr[bit].test(bit, data))
  ------------------
  |---> MC/DC Decision Region (43:8) to (43:50)
  |
  |  Number of Conditions: 2
  |     Condition C1 --> (43:8)
  |     Condition C2 --> (43:25)
  |
  |  Executed MC/DC Test Vectors:
  |
  |     C1, C2    Result
  |  1 { T,  F  = F      }
  |  2 { T,  T  = T      }
  |
  |  C1-Pair: not covered
  |  C2-Pair: covered: (1,2)
  |  MC/DC Coverage for Decision: 50.00%
  |
  ------------------
   44|      5|				continue;

As the results suggest, during the span of measurement, only condition C2
(!msr[bit].test(bit, data)) is covered. That means C2 was evaluated to both
true and false, and in those test vectors C2 affected the decision outcome
independently. Therefore MC/DC for this decision is 1 out of 2 (50.00%).

As of Clang 19, users can determine the max number of conditions in a
decision to measure via option LLVM_COV_KERNEL_MCDC_MAX_CONDITIONS, which
controls -fmcdc-max-conditions flag of Clang cc1 [3]. Since MC/DC
implementation utilizes bitmaps to track the execution of test vectors,
more memory is consumed if larger decisions are getting counted. The
maximum value supported by Clang is 32767. According to local experiments,
the working maximum for Linux kernel is 46, with the largest decisions in
kernel codebase (with 47 conditions, as of v6.11) excluded, otherwise the
kernel image size limit will be exceeded. The largest decisions in kernel
are contributed for example by macros checking CPUID.

Code exceeding LLVM_COV_KERNEL_MCDC_MAX_CONDITIONS will produce compiler
warnings.

As of LLVM 19, certain expressions are still not covered, and will produce
build warnings when they are encountered:

"[...] if a boolean expression is embedded in the nest of another boolean
 expression but separated by a non-logical operator, this is also not
 supported. For example, in x = (a && b && c && func(d && f)), the d && f
 case starts a new boolean expression that is separated from the other
 conditions by the operator func(). When this is encountered, a warning
 will be generated and the boolean expression will not be
 instrumented." [4]

Link: https://en.wikipedia.org/wiki/Modified_condition%2Fdecision_coverage [1]
Link: https://digital-library.theiet.org/content/journals/10.1049/sej.1994.0025 [2]
Link: https://discourse.llvm.org/t/rfc-coverage-new-algorithm-and-file-format-for-mc-dc/76798 [3]
Link: https://clang.llvm.org/docs/SourceBasedCodeCoverage.html#mc-dc-instrumentation [4]
Signed-off-by: Wentao Zhang <wentaoz5@illinois.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Makefile                |  6 ++++++
 kernel/llvm-cov/Kconfig | 36 ++++++++++++++++++++++++++++++++++++
 scripts/Makefile.lib    | 12 ++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/Makefile b/Makefile
index 621a27ed148bb..3cfa49280d504 100644
--- a/Makefile
+++ b/Makefile
@@ -802,6 +802,12 @@ all: vmlinux
 CFLAGS_LLVM_COV := -fprofile-instr-generate -fcoverage-mapping
 export CFLAGS_LLVM_COV
 
+CFLAGS_LLVM_COV_MCDC := -fcoverage-mcdc
+ifdef CONFIG_LLVM_COV_KERNEL_MCDC_MAX_CONDITIONS
+CFLAGS_LLVM_COV_MCDC += -Xclang -fmcdc-max-conditions=$(CONFIG_LLVM_COV_KERNEL_MCDC_MAX_CONDITIONS)
+endif
+export CFLAGS_LLVM_COV_MCDC
+
 CFLAGS_GCOV	:= -fprofile-arcs -ftest-coverage
 ifdef CONFIG_CC_IS_GCC
 CFLAGS_GCOV	+= -fno-tree-loop-im
diff --git a/kernel/llvm-cov/Kconfig b/kernel/llvm-cov/Kconfig
index 45ae5a579743d..d7b7272a2e75c 100644
--- a/kernel/llvm-cov/Kconfig
+++ b/kernel/llvm-cov/Kconfig
@@ -82,4 +82,40 @@ config LLVM_COV_PROFILE_ALL
 	  Note that a kernel compiled with profiling flags will be significantly
 	  larger and run slower.
 
+config LLVM_COV_KERNEL_MCDC
+	bool "Enable measuring modified condition/decision coverage (MC/DC)"
+	depends on LLVM_COV_KERNEL
+	depends on CLANG_VERSION >= 180000
+	help
+	  This option enables modified condition/decision coverage (MC/DC)
+	  code coverage instrumentation.
+
+	  If unsure, say N.
+
+	  This will add Clang's Source-based Code Coverage MC/DC
+	  instrumentation to your kernel. As of LLVM 19, certain expressions
+	  are still not covered, and will produce build warnings when they are
+	  encountered.
+
+	  "[...] if a boolean expression is embedded in the nest of another
+	   boolean expression but separated by a non-logical operator, this is
+	   also not supported. For example, in
+	   x = (a && b && c && func(d && f)), the d && f case starts a new
+	   boolean expression that is separated from the other conditions by the
+	   operator func(). When this is encountered, a warning will be
+	   generated and the boolean expression will not be instrumented."
+
+	   https://clang.llvm.org/docs/SourceBasedCodeCoverage.html#mc-dc-instrumentation
+
+config LLVM_COV_KERNEL_MCDC_MAX_CONDITIONS
+	int "Maximum number of conditions in a decision to instrument"
+	range 6 32767
+	depends on LLVM_COV_KERNEL_MCDC
+	depends on CLANG_VERSION >= 190000
+	default "6"
+	help
+	  This value is passed to "-fmcdc-max-conditions" flag of Clang cc1.
+	  Expressions whose number of conditions is greater than this value will
+	  produce warnings and will not be instrumented.
+
 endmenu
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 66c10893077d4..61fad6dff79cc 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -59,6 +59,18 @@ _c_flags += $(if $(patsubst n%,, \
 		$(CFLAGS_LLVM_COV))
 endif
 
+#
+# Flag that turns on modified condition/decision coverage (MC/DC) measurement
+# with Clang's Source-based Code Coverage. Enable the flag for a file or
+# directory depending on variables LLVM_COV_PROFILE_obj.o, LLVM_COV_PROFILE and
+# CONFIG_LLVM_COV_PROFILE_ALL.
+#
+ifeq ($(CONFIG_LLVM_COV_KERNEL_MCDC),y)
+_c_flags += $(if $(patsubst n%,, \
+		$(LLVM_COV_PROFILE_$(target-stem).o)$(LLVM_COV_PROFILE)$(if $(is-kernel-object),$(CONFIG_LLVM_COV_PROFILE_ALL))), \
+		$(CFLAGS_LLVM_COV_MCDC))
+endif
+
 #
 # Enable address sanitizer flags for kernel except some files or directories
 # we don't want to check (depends on variables KASAN_SANITIZE_obj.o, KASAN_SANITIZE)
-- 
2.51.0


