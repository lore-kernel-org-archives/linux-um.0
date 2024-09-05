Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84024CD4F53
	for <linux-um@archiver.kernel.org>; Thu,  5 Sep 2024 04:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=obcWco4ikFJSTlkhy0IQ4mjUM63DXv3cAaXjW5+XdMg=; b=paLOauq3Gz3WBO62RT3/BFo2lV
	WlphU2tX/Bc9v3olxtOIqPksdS8+TCkM2pq32A5yDaWpZkV268UKsJo36DCNiLLe1bTD5KDWiwKNp
	e9C1ddIzhQObq/fcPUIP0dtg28uMH7MztkLboI/u9uTuUdmAR/ZPa1Uxk4ImniUkJuwkd3vQipswY
	zeoNpvUJi0Nqr+Ra71dOuqHMgswznjylD2o4WtSM3/bfcsVEhZDJukjxihXlX5LJrYyTjjSXs7+8r
	pWm7lU+C+9Ol/8mnpTvBPzowLD7hjGyEzcBtLuSTE7zO/H+w6fS3qBDKPBoQghmk7nm+Qyrjgha6O
	fbepNmdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sm4LB-00000006yKS-0jmo;
	Thu, 05 Sep 2024 04:43:29 +0000
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sm4Bb-00000006wVm-03FY
	for linux-um@lists.infradead.org;
	Thu, 05 Sep 2024 04:33:37 +0000
Received: by mail-qt1-x844.google.com with SMTP id d75a77b69052e-4568acc1ca8so2153951cf.0
        for <linux-um@lists.infradead.org>; Wed, 04 Sep 2024 21:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=illinois-edu.20230601.gappssmtp.com; s=20230601; t=1725510813; x=1726115613; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obcWco4ikFJSTlkhy0IQ4mjUM63DXv3cAaXjW5+XdMg=;
        b=NBgW0iFCf5Icya9YChlgY+9PME/dE9bCDqT+cmuIPRGBUMEspM8kd2ndqKSkyRMQ/J
         GZOBnEzKk4vu6FdISmMl4HuqgvMOAF2Ik5+EnDt7JzdhJxs6m8iBNDM7uSYOYEtTmoDU
         NB+EqpzoL8+QxmEI7G3J05FzQ5tBp2nMsfPWSIi/cwNXRgGJmerH3wY/a2vYtANrvLbF
         R1W/g0MhY7FJCTtBdzaEgzEOomDy2+huVhD9J2kGVP1BFuAMFvOpab7KqhkY1QnUxJz9
         MavXx7rFAJP0NvDfnyyIx+tNVCYccovGxyWKgdqODejG0LTFthS9kGWiN/bSWJbHewuW
         vjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725510813; x=1726115613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=obcWco4ikFJSTlkhy0IQ4mjUM63DXv3cAaXjW5+XdMg=;
        b=BX9OpnYN4KGU3jGyJI/UUGlRjTgDpjzTXKEkMMrjCN8WVaFlUOEdjOMMeyYUmsKTQl
         XyDnKKuRqQVycaYZpES2/Wu1xK+b3PZKb2AxxXgk86hpEW02Lrhut/lw+HxZLLVLu/yJ
         i6vvyDUj7nofEWkeuIhnyCysLhnHuLpCpU19SsCa/VRCVeiEeViP3fqTdlqSc4FUi5yq
         bcReHpxlPxdQ3lN3mPTmHOtc/DbzxlDNfXTZnFvHkXRvUvhrX6B8KotN/eIy8pQ8ZTeI
         aAM2Xk/2sbr+vZ6W7ok1mQX5tytPVhybgLtoab7DspNTEKxosjWGx5ZjwnmE5n3ZjqU7
         wGMA==
X-Forwarded-Encrypted: i=1; AJvYcCUx4GsZpjDdGOMqM1fOqMHjSmTU5YLKcA5P4rQ5ACiX5mLz5jHZYKGlJJXlPRJJkTmM5DDchptpwQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwpeyLG2pfWakqXx1UC0Sn3bCG23aevSXT8fB3LFGMWBA6iRUhS
	QLqlmbcsoduGVGEmTmCyd/CCs+QChi2EJElkPvPHqAHT3c1i3F50XTsZB7FWOA==
X-Google-Smtp-Source: AGHT+IFlBcGh8g7t8G9K6kuCjpUHKIh84kU9lXf7wnm4qwLFe556OWmHU2Mio8zoqZGEAao8w7SmVw==
X-Received: by 2002:a05:622a:550f:b0:456:88fd:db2f with SMTP id d75a77b69052e-45705433513mr191676361cf.60.1725510812842;
        Wed, 04 Sep 2024 21:33:32 -0700 (PDT)
Received: from node0.kernel3.linux-mcdc-pg0.utah.cloudlab.us ([128.110.218.246])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801b4cf4csm4182341cf.48.2024.09.04.21.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 21:33:32 -0700 (PDT)
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
Subject: [PATCH v2 0/4] Enable measuring the kernel's Source-based Code Coverage and MC/DC with Clang
Date: Wed,  4 Sep 2024 23:32:41 -0500
Message-ID: <20240905043245.1389509-1-wentaoz5@illinois.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240824230641.385839-1-wentaoz5@illinois.edu>
References: <20240824230641.385839-1-wentaoz5@illinois.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_213335_313193_5101380E 
X-CRM114-Status: GOOD (  27.83  )
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

From: Wentao Zhang <zhangwt1997@gmail.com>

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

The first two patches enable the llvm-cov infrastructure, where the first
enables source based code coverage and the second adds MC/DC support. The
next patch disables instrumentation for curve25519-x86_64.c for the same
reason as gcov. The final patch enables coverage for x86-64.

The choice to use a new Makefile variable LLVM_COV_PROFILE, instead of
reusing GCOV_PROFILE, was deliberate. More work needs to be done to
determine if it is appropriate to reuse the same flag. In addition, given
the fundamentally different approaches to instrumentation and the resulting
variation in coverage reports, there is a strong likelihood that coverage
type will need to be managed separately.

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
series in the Refereed Track at LPC 2024 [6].

Known Limitations:

Kernel code with logical expressions exceeding
LVM_COV_KERNEL_MCDC_MAX_CONDITIONS will produce a compiler warning.
Expressions with up to 47 conditions are found in the Linux kernel source
tree (as of v6.11), but 46 seems to be the max value before the build fails
due to kernel size. As of LLVM 19 the max number of conditions possible is
32767.

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

---
v1 -> v2:

* Rebased onto v6.11-rc6 from v6.11-rc4.
* llvm-cov/Kconfig: add CONFIG_LLVM_COV_PROFILE_ALL and be consistent with
  GCOV conventions.
* Makefile.lib: let the default of LLVM_COV_PROFILE depend on
  CONFIG_LLVM_COV_PROFILE_ALL instead of always being "y", and use
  $(is-kernel-object) following 9c2d1328f88a "kbuild: provide reasonable
  defaults for tool coverage".
* asm-generic/vmlinux.lds.h: use macro BOUNDED_SECTION_POST_LABEL following
  9b351be25360 "vmlinux.lds.h: add BOUNDED_SECTION* macros".
* Makefile.lib: "basetarget" -> "target-stem" following bf48d9b756b9
  "kbuild: change tool coverage variables to take the path relative to
  $(obj)".
* kernel/trace: remove "LLVM_COV_PROFILE = :n" and let user manually enable
  it with LLVM_COV_PROFILE_ALL, if they are sure of the performance impact.
* x86, kbuild: remove "LLVM_COV_PROFILE = :n" instances that have been
  taken care of by $is-kernel-object. Also remove the one in
  arch/x86/platform/efi/ as llvm-cov doesn't have const propagation issues
  as gcov did (ac6119e7f25b "efi/x86: Disable instrumentation in the EFI
  runtime handling code").
* modfinal, kbuild: remove "LLVM_COV_PROFILE = :n" as llvm-cov doesn't use
  function pointers so it doesn't have CFI-related issues like gcov did
  (25a21fbb934a "kbuild: Disable GCOV for *.mod.o").

---

Wentao Zhang (4):
  llvm-cov: add Clang's Source-based Code Coverage support
  llvm-cov: add Clang's MC/DC support
  x86: disable llvm-cov instrumentation
  x86: enable llvm-cov support

 Makefile                          |   9 ++
 arch/Kconfig                      |   1 +
 arch/x86/Kconfig                  |   2 +
 arch/x86/crypto/Makefile          |   3 +-
 arch/x86/kernel/vmlinux.lds.S     |   2 +
 include/asm-generic/vmlinux.lds.h |  36 +++++
 kernel/Makefile                   |   1 +
 kernel/llvm-cov/Kconfig           | 100 ++++++++++++
 kernel/llvm-cov/Makefile          |   5 +
 kernel/llvm-cov/fs.c              | 253 ++++++++++++++++++++++++++++++
 kernel/llvm-cov/llvm-cov.h        | 156 ++++++++++++++++++
 scripts/Makefile.lib              |  23 +++
 scripts/mod/modpost.c             |   2 +
 13 files changed, 592 insertions(+), 1 deletion(-)
 create mode 100644 kernel/llvm-cov/Kconfig
 create mode 100644 kernel/llvm-cov/Makefile
 create mode 100644 kernel/llvm-cov/fs.c
 create mode 100644 kernel/llvm-cov/llvm-cov.h

-- 
2.45.2


