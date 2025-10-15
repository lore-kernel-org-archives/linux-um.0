Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C133CCD190
	for <linux-um@archiver.kernel.org>; Wed, 15 Oct 2025 07:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K0Byfm25HAm+hkuPU/+MWl6Aww3n7DOCSkjI/zRPF4w=; b=eJ6OkHvmzch5OnRVAkjOH1Au+v
	DJjjCuJbkhKdpbm7UttbtB7bAqk6ynkEF3Pxw4hngWt1i5ZEMVySbAnMQhTU09jzyAnKsKakvrToQ
	S3Gb36O93IRKr79e+4a8afTu4eDBKSgTLdTNDHKCtkAePDJmLCDKY2MF3helOucVptsAX9yznzS2Q
	8tABss2mXDijDUWQGf81dX3+dp7hQ4dN+kfcAKbo2TbkLmx+cu5yqErJfBySb9CY0D8DRc/TCVJRT
	lTh7BCVgvtlu01So3A9o86JKdtkDi3nn85LDGiKoz3gzfJzE10Q98B5YMnv+H+cN3G9udRCM3DZEe
	OTbNLqBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8w4O-00000000m2z-20pO;
	Wed, 15 Oct 2025 07:37:12 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8w4N-00000000m2M-0xuB
	for linux-um@bombadil.infradead.org;
	Wed, 15 Oct 2025 07:37:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=K0Byfm25HAm+hkuPU/+MWl6Aww3n7DOCSkjI/zRPF4w=; b=MqmgDj7SwmG2m7iemtBBl9O0WI
	ICtTPOLnsUcUEE4QyBZjiakIuKfaL+DI/SdBoajINUi8s4JFhUj8jouZ2qRnSmxvH8zv4QrAgQwJz
	sOml5c8u2hWLB+BaJgIfH8xYKmDE847NLIBewcea/0pgau3GjKmrVc+9OzvXNxsSM/XoMk/dz3nRg
	exDTpN2rGq5/7FPem/jALj6GOaYzvaUXXbxh0DYGbV0COAW1BETkq/VNK9VRhQESH23SGL/Im0QA3
	aGidDeS4PVbzj8jqZEoaUBqx0iYkA5zpd+f52FuSEaKjF7v6HxMkp56PwgFA/7wBrC3VGjf5uXwY9
	VQcd+Z4g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8w4D-0000000A8y5-3wOB;
	Wed, 15 Oct 2025 07:37:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A4D59300325; Wed, 15 Oct 2025 09:37:01 +0200 (CEST)
Date: Wed, 15 Oct 2025 09:37:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sasha Levin <sashal@kernel.org>
Cc: nathan@kernel.org, Matt.Kelly2@boeing.com, akpm@linux-foundation.org,
	andrew.j.oppelt@boeing.com, anton.ivanov@cambridgegreys.com,
	ardb@kernel.org, arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
	chuck.wolber@boeing.com, dave.hansen@linux.intel.com,
	dvyukov@google.com, hpa@zytor.com, jinghao7@illinois.edu,
	johannes@sipsolutions.net, jpoimboe@kernel.org,
	justinstitt@google.com, kees@kernel.org, kent.overstreet@linux.dev,
	linux-arch@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org,
	llvm@lists.linux.dev, luto@kernel.org, marinov@illinois.edu,
	masahiroy@kernel.org, maskray@google.com,
	mathieu.desnoyers@efficios.com, matthew.l.weber3@boeing.com,
	mhiramat@kernel.org, mingo@redhat.com, morbo@google.com,
	ndesaulniers@google.com, oberpar@linux.ibm.com, paulmck@kernel.org,
	richard@nod.at, rostedt@goodmis.org, samitolvanen@google.com,
	samuel.sarkisian@boeing.com, steven.h.vanderleest@boeing.com,
	tglx@linutronix.de, tingxur@illinois.edu, tyxu@illinois.edu,
	wentaoz5@illinois.edu, x86@kernel.org
Subject: Re: [RFC PATCH 0/4] Enable Clang's Source-based Code Coverage and
 MC/DC for x86-64
Message-ID: <20251015073701.GZ3419281@noisy.programming.kicks-ass.net>
References: <20250829181007.GA468030@ax162>
 <20251014232639.673260-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014232639.673260-1-sashal@kernel.org>
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

On Tue, Oct 14, 2025 at 07:26:35PM -0400, Sasha Levin wrote:
> This series adds support for Clang's Source-based Code Coverage to the
> Linux kernel, enabling more accurate coverage measurement at the source
> level compared to gcov. This is particularly valuable for safety-critical
> use cases (automotive, medical, aerospace) where MC/DC coverage is required
> for certification.
> 
> Changes since previous patchset [1]:
> - Rebased on v6.18-rc1
> - Adapted to lib/crypto reorganization (curve25519 exclusion moved to
>   lib/crypto/Makefile)
> - Minor correctness fixes throughout the codebase
> 
> The implementation has been tested with a kernel build using Clang 18+ and
> boots successfully in a KVM environment with instrumentation enabled.
> 
> [1] https://lore.kernel.org/all/20240905043245.1389509-1-wentaoz5@illinois.edu/
> 
> Wentao Zhang (4):
>   llvm-cov: add Clang's Source-based Code Coverage support
>   llvm-cov: add Clang's MC/DC support
>   x86: disable llvm-cov instrumentation
>   x86: enable llvm-cov support
> 
>  Makefile                          |   9 ++
>  arch/Kconfig                      |   1 +
>  arch/x86/Kconfig                  |   2 +
>  arch/x86/crypto/Makefile          |   1 +
>  arch/x86/kernel/vmlinux.lds.S     |   2 +
>  include/asm-generic/vmlinux.lds.h |  36 +++++
>  kernel/Makefile                   |   1 +
>  kernel/llvm-cov/Kconfig           | 121 ++++++++++++++
>  kernel/llvm-cov/Makefile          |   8 +
>  kernel/llvm-cov/fs.c              | 253 ++++++++++++++++++++++++++++++
>  kernel/llvm-cov/llvm-cov.h        | 157 ++++++++++++++++++
>  lib/crypto/Makefile               |   3 +-
>  scripts/Makefile.lib              |  23 +++
>  scripts/mod/modpost.c             |   2 +

I'm thinking I'm going to NAK this based on the fact that I'm not
interested in playing file based games. As long as this thing doesn't
honour noinstr I don't want this near x86.

And we have kcov support, and gcov and now llvm-cov, surely 3 coverage
solutions is like 2 too many?

