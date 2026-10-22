Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21113606A338
	for <linux-um@archiver.kernel.org>; Thu, 22 Oct 2026 19:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jGPIOaWo;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N5BvSZtD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=zfF/h5yN+JN0JXoERjM1UOmD6YL51qlegqbjQ5IjJaw=; b=jGPIOaWo4PbO6b
	ADeUAk4LzA+mloL+YMgqmWPGyOsdpZMhXJB7nlStEGH4DfVufsFV20/FXUziwiwiRFkQrR4z6zPwy
	k/2SD6Utf/Jj8rvlGDrPRhOXaY9Azl2DALNvIfOrMzy+45CNlClNUp3iJ4f/OpnC0wqLhcYOeMff3
	D9E0BePMpLvo+EdDmOSuNiK+mmn3P5LAWpGPwVksZvLng1vbPa/O0FB+Y5ZFGsIOHBrItoGCj1fwV
	zedw+BTvbAR6E/1K/QczJkBBWsUN9uvmozHGzLI2u1TEQaHeViwwCbLWuZiL5FpRJTx7H2NlMjTR0
	iOAY4E/w1zfANuKRpEHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJyGl-0000000Enq9-1J0x;
	Thu, 22 Oct 2026 19:16:07 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJyGi-0000000EnpX-2HY4;
	Thu, 22 Oct 2026 19:16:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 68628601F8;
	Thu, 22 Oct 2026 19:16:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE1F1F01825;
	Thu, 22 Oct 2026 19:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792696563;
	bh=zfF/h5yN+JN0JXoERjM1UOmD6YL51qlegqbjQ5IjJaw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=N5BvSZtDsOnevI6N7z+hpnuDFwgb+Za20bBfcyPl1zdZ/RUM/vhVGgooCl8EukmyB
	 v951DfxEQIGKmPlqDa47vEV9oOJpjd3jTdFHzFJ8cGbv5Ec+77S428dvBazQLk752d
	 8oijRTx04uvdE5t0WJ3hFRzAydPhPUU1uC5jEb9/jBb3UCG/5+2vXEPMQ0qv3aaJy/
	 fDrmEd5ydsQk2Juig/QI4K6qM7Xm060UN2bTZPYYJFIjTdDkBvnz/aEeUGpDN6dDMG
	 QYnQUY/lk7t3H2ZOK5q9Ex67PolYwOb50JpOTpWf5Zn6NIH8OuYBLaiHmJRlGX+jMg
	 L4eC2BtuFHQ4g==
From: Thomas Gleixner <tglx@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Shrikanth
 Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Kees Cook
 <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, Sven Schnelle
 <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, Andy
 Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Russell King
 <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Guo
 Ren <guoren@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Helge Deller <deller@gmx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Weinberger
 <richard@nod.at>, Chris Zankel <chris@zankel.net>,
 linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org, Arnd Bergmann
 <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Will Deacon
 <will@kernel.org>, Brian Cain <bcain@kernel.org>, Michal Simek
 <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
 linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, Michal =?utf-8?Q?Such=C3=A1nek?=
 <msuchanek@suse.de>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>
Subject: Re: [patch 16/18] x86/entry: Get rid of the sys_ni_syscall()
 indirection
In-Reply-To: <20261022142425.3Wx-RrU5@linutronix.de>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.493733289@kernel.org>
 <20261022142425.3Wx-RrU5@linutronix.de>
Date: Thu, 22 Oct 2026 21:15:59 +0200
Message-ID: <87fqxx1r80.ffs@fw13>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22 2026 at 16:24, Sebastian Andrzej Siewior wrote:
> On 2026-07-07 21:07:01 [+0200], Thomas Gleixner wrote:
>> Invoking sys_ni_syscall() from a code path, which already knows that the
>> syscall number is invalid just to assign -ENOSYS to regs->ax is a pointl=
ess
>> exercise. It's even redundant as the low level entry code already has set
>> regs->ax to -ENOSYS on entry.
>>=20
>> Remove the extra conditionals and the function calls.
>
> Since this patch, tools/testing/selftests/x86/syscall_numbering_64
> throws in this:
> |[RUN]   Running tests under ptrace: modifying the default return
> |[RUN]       Checking system calls with msb =3D 0 (0x0)
> |[RUN]           Checking some common syscalls as 64 bit
> |[OK]                x64 syscall 0:0 returned 0 as expected
> |[OK]                x64 syscall 0:1 returned 0 as expected
> |[RUN]           Checking some 64-bit only syscalls as 64 bit
> |[OK]                x64 syscall 0:19 returned 0 as expected
> |[OK]                x64 syscall 0:20 returned 0 as expected
> |[RUN]           Checking out of range system calls
> |[FAIL]                  x32 syscall 0:-64 returned -9999, but it should =
have returned -ENOSYS
> =E2=80=A6
> |[FAIL]                  x32 syscall 0:-2 returned -9999, but it should h=
ave returned -ENOSYS
> |[FAIL]              x32 syscalls 0:-64..-2 had 63 failure
> |[OK]                x32 syscall 0:-1 returned MODIFIED_BY_PTRACE as expe=
cted
> |[FAIL]                  x64 syscall 0:1073741760 returned -9999, but it =
should have returned -ENOSYS
> =E2=80=A6
> |[FAIL]                  x64 syscall 0:1073741823 returned -9999, but it =
should have returned -ENOSYS
> |[FAIL]              x64 syscalls 0:1073741760..1073741823 had 64 failure
> |[FAIL]                  x64 syscall 0:-64 returned -9999, but it should =
have returned -ENOSYS
> =E2=80=A6
> |[FAIL]                  x64 syscall 0:547 returned -9999, but it should =
have returned -ENOSYS
> |[FAIL]              x64 syscalls 0:512..547 had 36 failure
> |[RUN]           Checking some common syscalls as x32
> |[OK]                x32 syscall 0:0 returned 0 as expected
> =E2=80=A6
> |[RUN]           Checking out of range system calls
> |[FAIL]                  x32 syscall 1:-64 returned -9999, but it should =
have returned -ENOSYS
> |[FAIL]              x32 syscalls 1:-64..-2 had 63 failure
> |[OK]                x32 syscall 1:-1 returned MODIFIED_BY_PTRACE as expe=
cted
> |[FAIL]                  x64 syscall 1:1073741760 returned -9999, but it =
should have returned -ENOSYS
> =E2=80=A6
>
> and so on=E2=80=A6 The test has
>
> | #define MODIFIED_BY_PTRACE      -9999
>
> and the ptracer modifies the return code. However not always. Not sure
> if this was indeed a pointless exercise or not.

Hrmm. That's weird. Let me have a look.

