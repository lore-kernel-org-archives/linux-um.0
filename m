Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12477CF8552
	for <linux-um@archiver.kernel.org>; Thu,  3 Oct 2024 03:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bVmdUELTDUmyOs2T634ZSBxOSroRBta42gzygmF21tA=; b=RB2MdZ8MU8yEqCyj3rePK2kLVi
	tgSOHFPsrXKU4tFIm8wHf02ys+pX7BDsrZOGIYYC0emEbhjudPc95b3wyjEP/XyUb1bCMom92aL7A
	9UuUUdJONAyTv3PwmZwl/j18NSYmzff/jioSK4vQkcCzoU45Yze9PX9Ws0omOPInmk6ZK5BW0Xxea
	SdL/CjYdFayoPNlharRmB66n3p2K5vRz5xjNVwMkBtEzwOtHESiX3kuAGNMGnbv8cwnpUOyZ0w/EA
	DHzrOTW0a9S++847UceBo1kPUOHDKOcmcBG39/bPxyxWZzJbE/hKW/Bjm0+BzE9K+yblBh0hCuFts
	x5h/gzBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1swCIa-000000083rl-3ooi;
	Thu, 03 Oct 2024 03:14:40 +0000
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1swCIU-000000083qN-3haa
	for linux-um@lists.infradead.org;
	Thu, 03 Oct 2024 03:14:36 +0000
Received: by mail-qk1-x741.google.com with SMTP id af79cd13be357-7a9ae8fc076so52473585a.2
        for <linux-um@lists.infradead.org>; Wed, 02 Oct 2024 20:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=illinois-edu.20230601.gappssmtp.com; s=20230601; t=1727925273; x=1728530073; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVmdUELTDUmyOs2T634ZSBxOSroRBta42gzygmF21tA=;
        b=Vh2M1/IQeTArfPjHssn/Z+PVw4IPvE8S4PknoJ5k16TLgJvTfvU1wU45NwihfWtaDP
         5M9lspFMCJIWXeljdSu7zSCro99uUJVZZwYU9r0kXyxFEwZUMAK3bA70D/iayT4C8JoW
         xsG5HSlWHS+hP1R91FAO/nlfqSpX9mrWFx128xCmDc4g3EhH/ftUZvKwGe3OhLLJhkEq
         2sjqS+VnL531fBXY985+fuemd3gbSakPqqMzrbInWq/QFv5theCRulT0gW6uYZ5g7zhR
         bOZAgx7D4DjM9AQx6KPW+64WTXYJtnw3SMmMKERudHvVu9YBNMqD8LyeJWQjzuLZ0WLn
         rCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727925273; x=1728530073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bVmdUELTDUmyOs2T634ZSBxOSroRBta42gzygmF21tA=;
        b=M4zzJm4/rBZ5zAaABZiYYzrLla40pz1ipvXTVUhAeXfFiE20ggMwqF+gWcREuQqCvW
         kyOL5DWnHcjR8Fr2kJXtKYP505nkEPfUZilmvDCq5Tfrbc7RrCQY0mWuo4VucX1o8CQS
         mls6UIRGQFJob31AfqfMjCIR4ebzECONKUwoWmurdaV37yT3WK/wJ127uuytHTUl1hdr
         HrCBQs5AxZ7O5BzdsN6/iRquNlL5Z5SpJs61RRsNgZcTBE6z/Y+YsyrkXzrUCCibITeG
         3ilddUhLhd0rGJWteYfDyX3bn+MEBA6KTI4p2YpwACuyak93VIEv3X1MKgYC/PbdzlKc
         PasQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfc1uX0EmVmVYm4G5OwcYIutVkswONiar9R8n0HFs4tyIQ0K24PtaSyfewumB2aZpLfH6OU06zpA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwZVO460a2kqFj5M4QfP8xR/VGc8j/dLzob3Yxq5hSfn3SC0zHA
	njjbCj2GJ+lg7BPrVLZQ2H2yaFbshLl9qqQErXvtXRXNs3O4q879jey2X+loUw==
X-Google-Smtp-Source: AGHT+IHyjSRkhjgcIpyEOBBu1F4Ot9eDMUivzJG0kRwm+KN8Ac30ciJk502QH5kn26uBubpxXFT/Wg==
X-Received: by 2002:a05:620a:1923:b0:7a9:a63a:9f48 with SMTP id af79cd13be357-7ae626ac34dmr793486485a.11.1727925273322;
        Wed, 02 Oct 2024 20:14:33 -0700 (PDT)
Received: from shizuku.. ([2620:0:e00:550a:6782:866c:334a:d5e9])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae6b29e2c9sm6901385a.15.2024.10.02.20.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 20:14:33 -0700 (PDT)
From: Wentao Zhang <wentaoz5@illinois.edu>
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
	steven.h.vanderleest@boeing.com,
	tglx@linutronix.de,
	tingxur@illinois.edu,
	tyxu@illinois.edu,
	wentaoz5@illinois.edu,
	x86@kernel.org
Subject: Re: [PATCH v2 2/4] llvm-cov: add Clang's MC/DC support
Date: Wed,  2 Oct 2024 22:14:29 -0500
Message-Id: <20241003031429.46276-1-wentaoz5@illinois.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002011030.GB555609@thelio-3990X>
References: <20241002011030.GB555609@thelio-3990X>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241002_201435_214577_16A730E8 
X-CRM114-Status: GOOD (  34.86  )
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

Hi Nathan,

Thanks for your review! See some of my responses below inline. Other
comments, including those to [1/4] and [4/4], are acknowledged and will be
updated in v3.

On 2024-10-01 20:10, Nathan Chancellor wrote:
> ...
> > maximum value supported by Clang is 32767. According to local experiments,
> > the working maximum for Linux kernel is 46, with the largest decisions in
> > kernel codebase (with 47 conditions, as of v6.11) excluded, otherwise the
> > kernel image size limit will be exceeded. The largest decisions in kernel
> > are contributed for example by macros checking CPUID.
> > 
> > Code exceeding LLVM_COV_KERNEL_MCDC_MAX_CONDITIONS will produce compiler
> > warnings.
> > 
> > As of LLVM 19, certain expressions are still not covered, and will produce
> > build warnings when they are encountered:
> > 
> > "[...] if a boolean expression is embedded in the nest of another boolean
> >  expression but separated by a non-logical operator, this is also not
> >  supported. For example, in x = (a && b && c && func(d && f)), the d && f
> >  case starts a new boolean expression that is separated from the other
> >  conditions by the operator func(). When this is encountered, a warning
> >  will be generated and the boolean expression will not be
> >  instrumented." [4]
> 
> These two sets of warnings appear to be pretty noisy in my build
> testing... Is there any way to shut them up? Perhaps it is good for

These two warnings are currently implemented as custom diagnostic in
clang/lib/CodeGen/CodeGenPGO.cpp:dataTraverseStmtPost. So I'm afraid there
is no corresponding "-W[no-]xxx" flag at this moment. I agree such switches
would be desirable but we might have to nudge this in LLVM community.

> users to see these limitations but it basically makes the build output
> useless. If there were switches, then they could be disabled in the
> default case with a Kconfig option to turn them on if the user is
> concerned with seeing which parts of their code are not instrumented. I
> could see developers wanting to run this for writing tests and they
> might not care about this as much as someone else might.
> 
> I did leave LLVM_COV_KERNEL_MCDC_MAX_CONDITIONS at its default value.
> Perhaps there is a more reasonable default that would result in less
> noisy build output but not run afoul of potential memory usage concerns?
> I assume that mention means that memory usage may be a concern for the
> type of deployments this technology would commonly be used with?

To my own experiences, enlarging this threshold won't really help with the
issue, because the other type of warning ("nested boolean") is even more
prevalent in kernel codebase. I once built the kernel serially and counted
the number of instances from the gigantic log:

  unsupported number of conditions (>6): 837
  unsupported nested boolean:            8029

So again we should probably improve this on the tool side. I can talk to
developers there separately.

> ...
> > diff --git a/Makefile b/Makefile
> > index 51498134c..1185b38d6 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -740,6 +740,12 @@ all: vmlinux
> >  CFLAGS_LLVM_COV := -fprofile-instr-generate -fcoverage-mapping
> >  export CFLAGS_LLVM_COV
> >  
> > +CFLAGS_LLVM_COV_MCDC := -fcoverage-mcdc
> > +ifdef CONFIG_LLVM_COV_KERNEL_MCDC_MAX_CONDITIONS
> > +CFLAGS_LLVM_COV_MCDC += -Xclang -fmcdc-max-conditions=$(CONFIG_LLVM_COV_KERNEL_MCDC_MAX_CONDITIONS)
> 
> Why is -Xclang needed here? Is this not a full frontend flag?

"-fmcdc-max-conditions" is a cc1 option only, while "-fcoverage-mcdc" is
both a cc1 option and a clang option. See llvm/llvm-project#82448 and their
changes to clang/include/clang/Driver/Options.td.

Thanks,
Wentao

> 
> > +endif
> > +export CFLAGS_LLVM_COV_MCDC
> > +
> >  CFLAGS_GCOV	:= -fprofile-arcs -ftest-coverage
> >  ifdef CONFIG_CC_IS_GCC
> >  CFLAGS_GCOV	+= -fno-tree-loop-im

