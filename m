Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B59C5472C
	for <linux-um@archiver.kernel.org>; Sat, 24 Aug 2024 23:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pI1ahIsPt9dhXQGKmSRkAPO4yB+V9yLk9R0g7YeqYis=; b=IzU+dasFut/bjD3XaGJ/yjYWrj
	hAYI/jMpuOEp7/+bFofwGxjpHtLrMFwNrMXV9xryIenI+G9+U69wkWRNCGAJRthGy2B1kMefvLDlN
	udCBRAWOyN2oXa5FK7CLfm1RbxJ6AkyvbHmKqbHpunMjjdied+UikF/Mp4dJF+uHPPyiIF/JN3SPA
	66RJz3yLs1QvgH9r/E5D6gf0RA1bO9HL2JOspO+Y+Xd6TBOmXC+1m6KbvjnufYIZy/C322YVB6b5s
	tIq0XIjP6xHeXeynHlm/R8eznIvXturxLp24C22Q6SKQe46bzXvahaWKEV9BsYu/ym+wUTHURoFfw
	v8m2uQ3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shzr5-000000034TA-41EC;
	Sat, 24 Aug 2024 23:07:35 +0000
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shzr2-000000034Rt-3s5e
	for linux-um@lists.infradead.org;
	Sat, 24 Aug 2024 23:07:34 +0000
Received: by mail-io1-xd44.google.com with SMTP id ca18e2360f4ac-81fd520fee5so121646439f.2
        for <linux-um@lists.infradead.org>; Sat, 24 Aug 2024 16:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=illinois-edu.20230601.gappssmtp.com; s=20230601; t=1724540852; x=1725145652; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pI1ahIsPt9dhXQGKmSRkAPO4yB+V9yLk9R0g7YeqYis=;
        b=gDU6XcMUcinBc4bXjZGoJeqnFIggrF1FEEIp+W8LdFbi1xaeAZX+q85DQF/cP11x/p
         iCFw+EIRj4Rb+t6krKCdMfNQnywE8MoFEttLOIbz+2p5NxuDwKGd5UJoakhbikufwfE7
         6VQjXdwYbgmai5swda054BWpqhMiQRWmZI8YLgbYZYx9IF6QsAFLAQ6R2RvPOYWpr9R/
         waVLUBdiIOYrHj4bc61MwktYskHQl0a2fxfTtNkeM72a+meLquMvZx5+MQ4j9Sm47oDm
         NwHvmDGl+gKI2qwc+utSA3y4yXkMMQrTlkTU3JD5hCecBK5N40jgqlPGOiuHyR68gBXH
         ZmBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724540852; x=1725145652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pI1ahIsPt9dhXQGKmSRkAPO4yB+V9yLk9R0g7YeqYis=;
        b=IY/lRSg4OqVJPmAlFuL11d3Wqp2P1bRfitqR+IVQOWJdBnGq0ZVgGVLs0W4ULJK823
         fThWWhD5MeYGze/3dajmy++ivkZG+FgwPBlDSVk0EzdOvBfKwBuEiA5jW2nvt09wKP7d
         8RK+5HL6+oquWJUbBc6P/lJ3ZgdP3K/7yDCXJHqLmY1E3WZmqOvDhd7bmxqNywwkEmBk
         IVDFBbtwlFv0RyN8Dzz8n68S19d4VWHGPTY3qvRB529bwl0kySWMV+V4KAFCTupKk7Qp
         ullQWzpDtFZuYYTyH+hs6YMfaw/J4W0cYnnj3Qp3LLPEe40MpTFGdpeVycbjK5riCLGW
         snZg==
X-Forwarded-Encrypted: i=1; AJvYcCVtHo7uslnP4wi4cx01G6X3ZuPeRQD23MNLKRiLfN7jyP9FXs4l/58tQKW0g2YOAH+++4fImMQgvA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy8LMpIg5zt2vMMpiDwv5Bs5kGSWO2omV4pW+On8ZWyG2eVZw9z
	Iy+i6QESLAvW2zTw26F8dvYzOH//AtssLjs6OTE7zgQfBxYPiFXEwDepDyG5Og==
X-Google-Smtp-Source: AGHT+IFl2rO8s4tG2IK/76OuZILBkQM0bjWjC93REDF+iiyuiQbUEz5yxBnC5GLBkdA4N6JUhLkQxw==
X-Received: by 2002:a05:6602:6103:b0:825:2f0:9f74 with SMTP id ca18e2360f4ac-8278739c0famr756294039f.16.1724540852172;
        Sat, 24 Aug 2024 16:07:32 -0700 (PDT)
Received: from shizuku.. (mobile-130-126-255-62.near.illinois.edu. [130.126.255.62])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ce70f85671sm1563938173.80.2024.08.24.16.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 16:07:31 -0700 (PDT)
From: Wentao Zhang <wentaoz5@illinois.edu>
To: linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	x86@kernel.org
Cc: wentaoz5@illinois.edu,
	marinov@illinois.edu,
	tyxu@illinois.edu,
	jinghao7@illinois.edu,
	tingxur@illinois.edu,
	steven.h.vanderleest@boeing.com,
	chuck.wolber@boeing.com,
	matthew.l.weber3@boeing.com,
	Matt.Kelly2@boeing.com,
	andrew.j.oppelt@boeing.com,
	samuel.sarkisian@boeing.com,
	morbo@google.com,
	samitolvanen@google.com,
	masahiroy@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	ardb@kernel.org,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	arnd@arndb.de,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	oberpar@linux.ibm.com,
	akpm@linux-foundation.org,
	paulmck@kernel.org,
	bhelgaas@google.com,
	kees@kernel.org,
	jpoimboe@kernel.org,
	peterz@infradead.org,
	kent.overstreet@linux.dev,
	nathan@kernel.org,
	hpa@zytor.com,
	mathieu.desnoyers@efficios.com,
	ndesaulniers@google.com,
	justinstitt@google.com,
	maskray@google.com,
	dvyukov@google.com
Subject: [RFC PATCH 3/3] llvm-cov: add Clang's MC/DC support
Date: Sat, 24 Aug 2024 18:06:41 -0500
Message-Id: <20240824230641.385839-4-wentaoz5@illinois.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240824230641.385839-1-wentaoz5@illinois.edu>
References: <20240824230641.385839-1-wentaoz5@illinois.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240824_160733_008040_8C466387 
X-CRM114-Status: GOOD (  16.59  )
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

Add Clang flags and kconfig options for measuring the kernel's modified
condition/decision coverage (MC/DC).

As of Clang 19, users can determine the max number of conditions in a
decision to measure via option LLVM_COV_KERNEL_MCDC_MAX_CONDITIONS,
which controls -fmcdc-max-conditions flag of Clang cc1 [1]. Since MC/DC
implementation utilizes bitmaps to track the execution of test vectors,
more memory is consumed if larger decisions are getting counted. The
maximum value supported by Clang is 32767. According to local
experiments, the working maximum for Linux kernel is 44, with the
largest decisions in kernel codebase (with 45 conditions) excluded,
otherwise the kernel image size limit will be exceeded. The largest
decisions in kernel are contributed for example by macros checking
CPUID.

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
 instrumented." [2]

[1] https://discourse.llvm.org/t/rfc-coverage-new-algorithm-and-file-format-for-mc-dc/76798
[2] https://clang.llvm.org/docs/SourceBasedCodeCoverage.html#mc-dc-instrumentation

Signed-off-by: Wentao Zhang <wentaoz5@illinois.edu>
Signed-off-by: Chuck Wolber <chuck.wolber@boeing.com>
---
 Makefile                |  6 ++++++
 kernel/llvm-cov/Kconfig | 36 ++++++++++++++++++++++++++++++++++++
 scripts/Makefile.lib    | 11 +++++++++++
 3 files changed, 53 insertions(+)

diff --git a/Makefile b/Makefile
index 1750a2b7dfe8..4aa263e5f67f 100644
--- a/Makefile
+++ b/Makefile
@@ -740,6 +740,12 @@ all: vmlinux
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
index 505eba5bd23c..40b6a4fd590e 100644
--- a/kernel/llvm-cov/Kconfig
+++ b/kernel/llvm-cov/Kconfig
@@ -26,4 +26,40 @@ config LLVM_COV_KERNEL
 	  Note that the debugfs filesystem has to be mounted to access the raw
 	  profile.
 
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
index b9ceaee34b28..b8dfad01cb52 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -168,6 +168,17 @@ _c_flags += $(if $(patsubst n%,, \
 		$(CFLAGS_LLVM_COV))
 endif
 
+#
+# Flag that turns on modified condition/decision coverage (MC/DC) measurement
+# with Clang's Source-based Code Coverage. Enable the flag for a file or
+# directory depending on variables LLVM_COV_PROFILE_obj.o and LLVM_COV_PROFILE.
+#
+ifeq ($(CONFIG_LLVM_COV_KERNEL_MCDC),y)
+_c_flags += $(if $(patsubst n%,, \
+		$(LLVM_COV_PROFILE_$(basetarget).o)$(LLVM_COV_PROFILE)y), \
+		$(CFLAGS_LLVM_COV_MCDC))
+endif
+
 #
 # Enable address sanitizer flags for kernel except some files or directories
 # we don't want to check (depends on variables KASAN_SANITIZE_obj.o, KASAN_SANITIZE)
-- 
2.45.2


