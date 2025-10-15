Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139BCCCD195
	for <linux-um@archiver.kernel.org>; Wed, 15 Oct 2025 09:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RzAJqImAFXPtQRa+izbRdXNFcNgNneDg6snhyJLARfw=; b=3gFQhR+aDVq/02Y6RLlKyJA1SE
	ug6iT6cdqEnSPJgBcN7QqMYhqiXD05a+oG8lTJgnQPcYDfX95c51eAhONKLMC2nC+zJc4sPmijyMI
	vstyi/wHTPcXLIIW5MaX39ogXvaBe2QhsZTcFJBCx299XXzQXMoXTrwebhwfUCBkCmpwRQttBSusn
	K/oENGb2iAvEhuV00LpsS8dJSaOAtlx0kbLEcIJ5Bzkarvbg3Qp8I3x1u9klosaqWUGfQUy5JXISa
	FzZQNI7uloc2xj9ns559bVTJTTNWZywZ7wVtNyWaq56NZCcHCOmhGhQveEzJW1r88/TDXahDq9PrE
	WO+KrWgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8xhv-000000018Ek-2nSm;
	Wed, 15 Oct 2025 09:22:07 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8xhu-000000018EZ-3FHb
	for linux-um@bombadil.infradead.org;
	Wed, 15 Oct 2025 09:22:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RzAJqImAFXPtQRa+izbRdXNFcNgNneDg6snhyJLARfw=; b=gQ7f+QQEXR9jwM/d7euARKANnR
	Pl7HGvQ+PjKR+DKxcXVQ8jytXdadLRhoUnRTlgSN4/K9dxCX62Fl3/NMSRhDRQk/HYzo40c/lMxEj
	KqqakksiWddbk34tYahH07XUwoHNm/HXghjo9pRqTiU+VCM7TvkHN1bwreXXHyfFKSmnrPMeAIISD
	EggtC7w4olWcIPtbJoUGx7ov9ZeuIHu1yT8PioDggiYxXQox92oHXzIdYGA9mG5OMppjdwSS7QPPk
	x3DROZahohXxPYEnFK2U3AvTMmRGI5jUE9Ratv+s1inESd9fj7C7lM7Darvvzl8HHL0Mr6gAn6pOw
	pG3rie1A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8xha-00000005py6-3tkW;
	Wed, 15 Oct 2025 09:21:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DFB4630023C; Wed, 15 Oct 2025 11:21:45 +0200 (CEST)
Date: Wed, 15 Oct 2025 11:21:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Chuck Wolber <chuck@wolber.net>
Cc: Sasha Levin <sashal@kernel.org>, nathan@kernel.org,
	Matt.Kelly2@boeing.com, akpm@linux-foundation.org,
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
Message-ID: <20251015092145.GB3419281@noisy.programming.kicks-ass.net>
References: <20250829181007.GA468030@ax162>
 <20251014232639.673260-1-sashal@kernel.org>
 <20251015073701.GZ3419281@noisy.programming.kicks-ass.net>
 <DDIR4HE5C74G.1U5TA0KDN9O5J@wolber.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DDIR4HE5C74G.1U5TA0KDN9O5J@wolber.net>
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

On Wed, Oct 15, 2025 at 08:26:50AM +0000, Chuck Wolber wrote:

> > I'm thinking I'm going to NAK this based on the fact that I'm not
> > interested in playing file based games. As long as this thing doesn't
> > honour noinstr I don't want this near x86.
> 
> I am working on a noinstr patchset that will precede this pachset. As it turns
> out there are several areas of the kernel (128 that I have found so far) that
> are missing the noinstr attribute macro.
> 
> Example:
> 
> kernel/locking/lockdep.c:
> 	void noinstr lockdep_hardirqs_off(unsigned long ip)
> include/linux/irqflags.h:
> 	static inline void lockdep_hardirqs_off(unsigned long ip) { }
> 
> The latter version is intended to be optimized out if the kernel is not
> configured to use this feature. However when the kernel is instrumented for
> profiling, the stub is not optimized out and ends up in the .text section
> rather than the .noinstr.text section.

Typically we switch to __always_inline when this happens. Ideally
though, compilers should strive to not be stupid and instrument dead
code to the point where DCE will fail.

> > And we have kcov support, and gcov and now llvm-cov, surely 3 coverage
> > solutions is like 2 too many?
> 
> Optimization makes it nearly impossible to correlate GCov results back to
> actual lines of source. llvm-cov instruments at the AST level which enables
> precise mapping back to source code regardless of optimization level.
> 
> 
> A detailed rundown on this issue can be found here[1], with the most relevant
> excerpt reproduced here:

Yes read and understand this, but that doesn't mean you have to have 3
different kernel interfaces for all of this, right?

