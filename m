Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08072C52D6F
	for <linux-um@archiver.kernel.org>; Sat, 24 Aug 2024 23:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oPVQkYUkKgMfNB80VWVW+kjDfOxnjk6hugGJuqGctqE=; b=FueNe8f8LDAKjnauC1VuN5nxjk
	bFy4F9SWvUPF6K4PRM9a3ZUkD5pgSctbPFQNV4RcH0owjrHZjXSl09MIMGK1Z0T6T22FDbDfxgisn
	IAOoB6xjH5yJ6ryqdmvbpbDACh+yKGTi3Ee/6o2lVpUJehENGknQWEIJGyb04LUCXDd1JdABKviY/
	LemndVrqczIhDtwn+Q5cqjGvLCH/f2QSYS9Jf5+FEargcN3e+8GScJrkLXCy2qnffUbS6WWySsJeq
	XfZp4wIpFJ+SLwClVEBEgYxPotqAMsNdydc5Bq0DwNJjrKYZ0C38Kcz9bYb2UDC5b0aofhcZIa/r3
	BksIo49g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shzqU-000000034FX-0uKr;
	Sat, 24 Aug 2024 23:06:58 +0000
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shzqQ-000000034ER-23Lz
	for linux-um@lists.infradead.org;
	Sat, 24 Aug 2024 23:06:56 +0000
Received: by mail-io1-xd44.google.com with SMTP id ca18e2360f4ac-824ee14f7bfso121543839f.1
        for <linux-um@lists.infradead.org>; Sat, 24 Aug 2024 16:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=illinois-edu.20230601.gappssmtp.com; s=20230601; t=1724540812; x=1725145612; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oPVQkYUkKgMfNB80VWVW+kjDfOxnjk6hugGJuqGctqE=;
        b=Lzl5l/2h01v7zmTk4wS98/GpMQDvLxSQzK4JCRuujvypb2qg7eLV1JIzgJOYsfyai3
         9QwKgOCw57UVXYiDB7fSZ+Q+kzNVDEyEMvQ6KuEFm6m+qk3CcssOL7D8R8+Hz0EZolnu
         xj0f8vraNtJrVzRxYpDbDYWDE4By7ylyx9KcaQ+K8dAI4+M+e8TaQZTmIDoX2Q+CIOTK
         1DP8p4EPRNVmnLp0ed8cjsegfKZtMcyywdV5UJxrYt6Mw75iIsbWQ93g/JwAp+Z52XQ+
         JSJ6XUJLFRtT7SRU2+yJGrtGEt6fbt0XSphwpMH0I1hZy0UePKPWHARwXrB8E/YPo2nr
         GqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724540812; x=1725145612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oPVQkYUkKgMfNB80VWVW+kjDfOxnjk6hugGJuqGctqE=;
        b=v18D3qgSGvdCqu0i8XJqaA/PJyJM4sMe9DXUO582VfHQck+xsvg8ZZdeWb077oHR2w
         vXLVORivexIkFJ1jp5XW5XPpQW+lwMN9h3Icw9Z9ijg38vvOKzmO1EJq/J7kxiY8cZAo
         HQnbG2SLeYB39l/NM0pRpD/2APPU2fRdog0Z3/RVL30jwMUe8tRyJ6Yybh9qDBqOpBg2
         BarESy+g6ay4/RaMf4X+jwbCy0EmyUW8z9Asu6MwuxDtBKESLxvde6PVI+JnXbjfMdbI
         0g6OYbgRCj9SUzxd98X+F2uEwqCreONH9n5rwQIu2K40PVi1I2lBH7BeTp6zFoJZAjAC
         Iosw==
X-Forwarded-Encrypted: i=1; AJvYcCX+L4p1JJGNuQhUJGWkLeGPVOYvy+0oV4yFvjlv48ejJV9VGxkNKQk7wSZxqTh50NW7hjAc5jwcsg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwuCMIeDD9bZSSXGJE35tHU8YV1delLx3DDG4A+pdI1cIA/Kzrm
	YAi70MODfmm7SRdo1fHnkk6mnIeVd+Oj6fyuDcGA/+oPMJWCP16S6e0aawi4QA==
X-Google-Smtp-Source: AGHT+IGMQxhcJkQ6ziSI+v0WKfS2seyT6MqZHNFCU+FCXMcl3PQf88gW45DK9XBsKf3pVpegGFpChA==
X-Received: by 2002:a05:6602:13ce:b0:803:cc64:e0d4 with SMTP id ca18e2360f4ac-8278730b0f3mr812804539f.3.1724540812422;
        Sat, 24 Aug 2024 16:06:52 -0700 (PDT)
Received: from shizuku.. (mobile-130-126-255-62.near.illinois.edu. [130.126.255.62])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ce70f85671sm1563938173.80.2024.08.24.16.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 16:06:52 -0700 (PDT)
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
Subject: [RFC PATCH 0/3] Enable measuring the kernel's Source-based Code Coverage and MC/DC with Clang
Date: Sat, 24 Aug 2024 18:06:38 -0500
Message-Id: <20240824230641.385839-1-wentaoz5@illinois.edu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240824_160654_838055_93B88E6A 
X-CRM114-Status: GOOD (  23.80  )
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

This series adds support for building x86-64 kernels with Clang's Source-
based Code Coverage[1] in order to facilitate Modified Condition/Decision
Coverage (MC/DC)[2] that provably correlates to source code for all levels
of compiler optimization.

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

Clang has added MC/DC support as of its 18.1.0 release. MC/DC is a fine-
grained coverage metric required by many automotive and aviation industrial
standards for certifying mission-critical software [3].

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

To do a full kernel measurement, instrument the kernel with
LLVM_COV_KERNEL_MCDC enabled, and optionally set a
LLVM_COV_KERNEL_MCDC_MAX_CONDITIONS value (the default is six). Run the
testsuites, and collect the raw profile data under
/sys/kernel/debug/llvm-cov/profraw. Such raw profile data can be merged and
indexed, and used for generating coverage reports in various formats.

  $ cp /sys/kernel/debug/llvm-cov/profraw vmlinux.profraw
  $ llvm-profdata merge vmlinux.profraw -o vmlinux.profdata
  $ llvm-cov show --show-mcdc --show-mcdc-summary                         \
             --format=text --use-color=false -output-dir=coverage_reports \
             -instr-profile vmlinux.profdata vmlinux

The first patch in this series enables Clang's Source-based Code Coverage
in the kernel. The second patch disables instrumentation in the same areas
that were disabled for kernel/gcov/. The third patch adds kernel
configuration directives to enable MC/DC instrumentation.

This work reuses code from a previous effort by Sami Tolvanen et al. [4].
Our aim is for source-based *code coverage* required for high assurance
(MC/DC) while [4] focused more on performance optimization.

This initial submission is restricted to x86-64. Support for other
architectures would need a bit more Makefile & linker script modification.
Informally we've confirmed that arm64 works and more are being tested.

Note that Source-based Code Coverage is Clang-specific and isn't compatible
with Clang's gcov support in kernel/gcov/. Currently, kernel/gcov/ is not
able to measure MC/DC without modifying CFLAGS_GCOV and it would face the
same issues in terms of source correlation as gcov in general does.

Some demo and results can be found in [5]. We will talk about this patch
series in the Refereed Track at LPC 2024 [6] and would appreciate the
community's feedback.

Known Limitations:

Kernel code with logical expressions exceeding
LVM_COV_KERNEL_MCDC_MAX_CONDITIONS will produce a compiler warning.
Expressions with up to 45 conditions are found in the Linux kernel source
tree, but 44 seems to be the max value before the build fails due to kernel
size. As of LLVM 19 the max number of conditions possible is 32767.

As of LLVM 19, certain expressions are still not covered, and will produce
build warnings when they are encountered:

"[...] if a boolean expression is embedded in the nest of another boolean
 expression but separated by a non-logical operator, this is also not
 supported. For example, in x = (a && b && c && func(d && f)), the d && f
 case starts a new boolean expression that is separated from the other
 conditions by the operator func(). When this is encountered, a warning
 will be generated and the boolean expression will not be
 instrumented." [7]


[1] https://clang.llvm.org/docs/SourceBasedCodeCoverage.html
[2] https://en.wikipedia.org/wiki/Modified_condition%2Fdecision_coverage
[3] https://digital-library.theiet.org/content/journals/10.1049/sej.1994.0025
[4] https://lore.kernel.org/lkml/20210407211704.367039-1-morbo@google.com/
[5] https://github.com/xlab-uiuc/linux-mcdc
[6] https://lpc.events/event/18/contributions/1718/
[7] https://clang.llvm.org/docs/SourceBasedCodeCoverage.html#mc-dc-instrumentation

Wentao Zhang (3):
  [RFC PATCH 1/3] llvm-cov: add Clang's Source-based Code Coverage
    support
  [RFC PATCH 2/3] kbuild, llvm-cov: disable instrumentation in odd or
    sensitive code
  [RFC PATCH 3/3] llvm-cov: add Clang's MC/DC support

 Makefile                              |   9 +
 arch/Kconfig                          |   1 +
 arch/x86/Kconfig                      |   1 +
 arch/x86/boot/Makefile                |   1 +
 arch/x86/boot/compressed/Makefile     |   1 +
 arch/x86/entry/vdso/Makefile          |   1 +
 arch/x86/kernel/vmlinux.lds.S         |   2 +
 arch/x86/platform/efi/Makefile        |   1 +
 arch/x86/purgatory/Makefile           |   1 +
 arch/x86/realmode/rm/Makefile         |   1 +
 arch/x86/um/vdso/Makefile             |   1 +
 drivers/firmware/efi/libstub/Makefile |   2 +
 include/asm-generic/vmlinux.lds.h     |  38 ++++
 kernel/Makefile                       |   1 +
 kernel/llvm-cov/Kconfig               |  65 +++++++
 kernel/llvm-cov/Makefile              |   5 +
 kernel/llvm-cov/fs.c                  | 253 ++++++++++++++++++++++++++
 kernel/llvm-cov/llvm-cov.h            | 156 ++++++++++++++++
 kernel/trace/Makefile                 |   1 +
 scripts/Makefile.lib                  |  21 +++
 scripts/Makefile.modfinal             |   1 +
 scripts/mod/modpost.c                 |   2 +
 22 files changed, 565 insertions(+)
 create mode 100644 kernel/llvm-cov/Kconfig
 create mode 100644 kernel/llvm-cov/Makefile
 create mode 100644 kernel/llvm-cov/fs.c
 create mode 100644 kernel/llvm-cov/llvm-cov.h

-- 
2.45.2


