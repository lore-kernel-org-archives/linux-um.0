Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF68606ABA3
	for <linux-um@archiver.kernel.org>; Mon,  2 Nov 2026 16:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=R/+S+vKr;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Bkvlc9Uh;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=no3DkXB1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=CAbnxO0/qUW9BHgq0s5afN/fwZolzjrBJaRnSuaEmAo=; b=R/+S+vKrwrxOF2un5NCfVYj0Cl
	8/DT390HYWkTj9A75PDc/pYAKIiVP260snHC12Y0jwHjc024XXluFMh1senLis4mLWmrFGLEgtAjP
	83SghMO0Zn3V9FyKB7tqgB9PltYI7xk0hAuuaCNLXH0LxM/ssqazbSTyIGcWrJTd0CuEzh2aGVSth
	ynCDDlyxPwbhoWGhia4YYvqPfw90LdSVR1PNILgnKbarnbcwqikM7vqx8UPekSvfzmGqCXNcz4cWI
	FmtAr6gFvr26lP03TK5SInjZM3ccD0VdT4fgEadg2WSNewBnj91+w13k6L7JpX2Z88z7zruZWhosy
	Ep2HZDaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNumk-0000000HHLe-36BF;
	Mon, 02 Nov 2026 16:21:26 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNumd-0000000HHKS-19IQ;
	Mon, 02 Nov 2026 16:21:20 +0000
Date: Mon, 2 Nov 2026 17:21:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793636476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CAbnxO0/qUW9BHgq0s5afN/fwZolzjrBJaRnSuaEmAo=;
	b=Bkvlc9UhhyCv5ZdWUMU6G9Li+R2BVAADYWwZuoqUAyqvUjCoGYGxXIn4ALH8UCKwa4wXF8
	oraU/gZ8eujvwMvYkEcPGl9LoaQ4y8L5gTwgvEqTaLIOKyYpw0Vt21vSoLNR9nGu5XUZGy
	Ei+jDbIPpRtvYxUN3n40OXfMZKwhjOcptRjzclaFhqfaMjZ4DnPJp2kIUEARXrDA2lfCj7
	Xc9td9/O5azqjpJ09IA+6VHzOt3kgO7Q3tW3z+AQm8NXUA0NJY3SKFbPnSH3MoCGBJlCpq
	9SKkxdgYMHfQI6T9cHJ58WWsIb3edmk7YJmf4hhOdiwEorZM3Pu5QhcHBVRk7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793636476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CAbnxO0/qUW9BHgq0s5afN/fwZolzjrBJaRnSuaEmAo=;
	b=no3DkXB1ZRbLOBdX8Sfg5H+HK/netv5lLDsnHm2NNe1d6SMQE1Lawcr4U1D9QbHBAGIkXh
	QAa36tqetUjJ21Dw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
	x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Guo Ren <guoren@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Helge Deller <deller@gmx.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Richard Weinberger <richard@nod.at>,
	Chris Zankel <chris@zankel.net>,
	linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
	linux-csky@vger.kernel.org, linux-m68k@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>,
	Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>,
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
	linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH V2] x86/entry: Fix ptrace regression
Message-ID: <20261102162113.LEAhpzer@linutronix.de>
References: <20261022142425.3Wx-RrU5@linutronix.de>
 <87fqxx1r80.ffs@fw13>
 <87cxt11ktr.ffs@fw13>
 <1149A39E-BEBA-46EA-94F4-4DFFC4733EF5@zytor.com>
 <871p9g1s3w.ffs@fw13>
 <87y0boze95.ffs@fw13>
 <C6D7BF04-4CF7-48D1-93B5-E80D52C2617D@zytor.com>
 <87se1wyvs8.ffs@fw13>
 <87mrrvxaty.ffs@fw13>
 <87ecd4xwlr.ffs@fw13>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ecd4xwlr.ffs@fw13>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_082119_484951_3F632EDA 
X-CRM114-Status: GOOD (  10.63  )
X-Spam-Score: -4.4 (----)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-01 18:58:08 [+0100], Thomas Gleixner wrote:
> --- a/arch/x86/entry/syscall_32.c
> +++ b/arch/x86/entry/syscall_32.c
> @@ -77,6 +77,10 @@ static __always_inline void do_syscall_3
>  	if (likely(nr < IA32_NR_syscalls)) {
>  		nr = array_index_nospec(nr, IA32_NR_syscalls);
>  		regs->ax = ia32_sys_call(regs, (unsigned int)nr);
> +	} else {
> +		/* See comment in do_syscall_64() */
> +		if (nr != -1UL) {
> +			regs->ax = -ENOSYS;

A curly closing bracket here and then it compiles for me. Or remove the
one in the "if" line.

>  	}
>  }

With either of the suggested changes:
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

