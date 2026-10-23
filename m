Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47911606A31D
	for <linux-um@archiver.kernel.org>; Fri, 23 Oct 2026 21:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UX0CaWlJ;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=hwASE/IL;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=z943ERBm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=rBYqzhjRmnws8Rm/5IL7e+PRpdOctdJtXb4xboAMWSA=; b=UX0CaWlJ7r6Ms8hMLW11hkZja+
	I0k7WHocIcjYIBmSqo5mo3N00zIZ0s/ZkTW9XphLwxqrhfTlqGTmntl1ExkAW2IrSUB/jSDbODicI
	Xh+maplA0Lqx7nuugc8g7vE1H4aaR6dHzPVGszgJjPMsr7HYc8N+rJFLGCsRLnLq1/4yEe7QIpgii
	szH5HXZoMbbEoXa8FCVS0g8xm2QCvNVNjwVsFDzUN7TPisXzInWhT5XW7e4xaXK1u9uKl8sJscBkV
	GN/DAjqQyzipBi5sZDSBSZSz6VGD2SuxbTWpVL+CfRktpzUO1wCya4DeiwmeRW7Tl8fL4L/lx5K9a
	mJzQxIwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKN3U-0000000H0OR-2UJd;
	Fri, 23 Oct 2026 21:44:04 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKN3R-0000000H0Nm-0T88;
	Fri, 23 Oct 2026 21:44:02 +0000
Date: Fri, 23 Oct 2026 23:43:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792791835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rBYqzhjRmnws8Rm/5IL7e+PRpdOctdJtXb4xboAMWSA=;
	b=hwASE/ILIfvsagU4ja9zJyp6NCW7nhDXBrLgESHYvZc9OlC/GQdmV72Hfw8lCHeCcJDiIT
	xFBb+eSpeLzJx+wG16eGrTDnCizzsAb6w+YXHutGNF3HFzHQkD8tsZ70QSbXCrE553aTtc
	FyBITEp8ynQwIVKmsTH4edb2ELcKOcjRqPKGeu5zad/jr9HszyeKdSGpYIGAdGmjIg04RH
	fcQJvL7izNOg661T28mb7TFw7IIiiiTlruIEDWxOW6votoei6lPtMgLjCAwFAfW1s9CXqg
	i8k5N81Ek/SnmSCRgWHVGbIsWAsCZb3iRBPHtLu5gtarfP+kYufKyE0FptRrgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792791835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rBYqzhjRmnws8Rm/5IL7e+PRpdOctdJtXb4xboAMWSA=;
	b=z943ERBmz9863Xr+14sVUMFBonUecgHEkMzxOZxtguvVf4IgWnapYNfN7FD67wKQCXc4NS
	csUXXgLT71khc6BQ==
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
Subject: Re: [patch 16/18] x86/entry: Get rid of the sys_ni_syscall()
 indirection
Message-ID: <20261023214353.Q3pZID23@linutronix.de>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.493733289@kernel.org>
 <20261022142425.3Wx-RrU5@linutronix.de>
 <87fqxx1r80.ffs@fw13>
 <87cxt11ktr.ffs@fw13>
 <1149A39E-BEBA-46EA-94F4-4DFFC4733EF5@zytor.com>
 <871p9g1s3w.ffs@fw13>
 <87y0boze95.ffs@fw13>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y0boze95.ffs@fw13>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261023_144401_319127_B71BDEDE 
X-CRM114-Status: GOOD (  12.95  )
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
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-23 16:24:22 [+0200], Thomas Gleixner wrote:
> IOW, a tracer modification of regs->ax is not overwritten when the
> syscall number is out of range.
> 
> Between 2.6.19-rc2 and -rc3 x86_64 was changed to _always_ overwrite
> regs->ax when the syscall number is out of range.
> 
> In the 3.8 merge window seccomp introduced the -1 == skip bogosity which
> got fixed up and made "consistent" in several changes afterwards. Just
> that it never reached a state of consistency due to the overloading.
> 
> So are we stuck with this behavior or do we sit down and define what the
> correct behavior should be?

I wouldn't say we are stuck. The test did reassemble the status we had
at the moment. As you wrote yourself the behaviour changed a few times
and not on purpose.
I would say we define what correct behaviour should be and make sure it
is consistent across all the architectures.

> Thanks,
> 
>         tglx

Sebastian

