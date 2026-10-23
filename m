Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38315606A31D
	for <linux-um@archiver.kernel.org>; Fri, 23 Oct 2026 00:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qQtlciWJ;
	dkim=pass (2048-bit key, unprotected) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026092801 header.b=B0iR0guj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=sewWTjP+M6E94TwmQI+LvxiP3Dgk+UiInUJ1sYqPvjE=; b=qQtlciWJZhJkGe
	6K6TYicGFnWIbXW/algUK2hwsaZlmf9fguq7l/MsDJSEuUCv3snhrn9niRCq99kwbmvfwwNxdRQiT
	Tdk8mG6ZrywgAZpMyWAc3+nWnnxBx4eBtlNZOJ6pRHkf3XOeW33r5LE7q3laNUsH/ZavHhXjSB6J6
	FuZdGLWenth8CsMzv+wp5UqIhwNHqxCUtnONWp4sYunwRdLUsdUHRb8KcCxH4eTveZlvjUY1qVEx/
	oloUGbdWYCFQhiXsO7cEijsFuVcgi26iy78RVIQvYaLNypVrqVb1VNE9CDcZptyUvhl4k3LZFrZjn
	/bbQMDNB1uOjpNvC8gFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xK34K-0000000FDWj-2ZAZ;
	Fri, 23 Oct 2026 00:23:36 +0000
Received: from terminus.zytor.com ([2607:7c80:54:3::136] helo=mail.zytor.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xK34H-0000000FDW5-3mrs;
	Fri, 23 Oct 2026 00:23:35 +0000
Received: from ehlo.thunderbird.net (ENVISION-AE.edge1.SanJose1.Level3.net [4.79.220.182])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 69N0MTYe1497671
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 22 Oct 2026 17:22:30 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 69N0MTYe1497671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026092801; t=1792714955;
	bh=sewWTjP+M6E94TwmQI+LvxiP3Dgk+UiInUJ1sYqPvjE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=B0iR0gujNC7PBahAQGPELPfOvA7wFnm4aVgauSDh6Mr2eGjg9f2sjLSQ7t78E+yy1
	 f8bIVvq6KYitlu1MNVZc3rKXjku7b5th05mhKR3968auNM3tY5s5Ser+GgoQNITSum
	 ZADmFoGGs0IzvcRHHbEEE6rPcUpxXrq+3jB2dvktUZRlLHRQfdXJNzBfWoR9LWTL/0
	 Vfr9nrAF6Af+MSU3LPirKQDCQPLvyBm4AXAwcmc36BGcccEuO+/ctQAGEZb2pFmtOB
	 9hRTTHAao28lytaVTDSTMgSi2sQxwQH+82H9bDetNn7xdIGgwxNjxXV+Ny1OiYpDe8
	 //k9lsYxpZvPw==
Date: Thu, 22 Oct 2026 17:22:24 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Thomas Gleixner <tglx@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Kees Cook <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Jinjie Ruan <ruanjinjie@huawei.com>, Andy Lutomirski <luto@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller <deller@gmx.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>,
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
        =?ISO-8859-1?Q?Michal_Such=E1nek?= <msuchanek@suse.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5Bpatch_16/18=5D_x86/entry=3A_Get_rid?=
 =?US-ASCII?Q?_of_the_sys=5Fni=5Fsyscall=28=29_indirection?=
User-Agent: K-9 Mail for Android
In-Reply-To: <87cxt11ktr.ffs@fw13>
References: <20260707181957.433213175@kernel.org> <20260707190254.493733289@kernel.org> <20261022142425.3Wx-RrU5@linutronix.de> <87fqxx1r80.ffs@fw13> <87cxt11ktr.ffs@fw13>
Message-ID: <1149A39E-BEBA-46EA-94F4-4DFFC4733EF5@zytor.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261022_172333_968099_EB6E124A 
X-CRM114-Status: GOOD (  28.37  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On October 22, 2026 2:34:08 PM PDT, Thomas Gleixner <tglx@kernel=2Eorg> wro=
te:
>On Thu, Oct 22 2026 at 21:15, Thomas Gleixner wrote:
>> On Thu, Oct 22 2026 at 16:24, Sebastian Andrzej Siewior wrote:
>>> On 2026-07-07 21:07:01 [+0200], Thomas Gleixner wrote:
>>> |[RUN]           Checking out of range system calls
>>> |[FAIL]                  x32 syscall 1:-64 returned -9999, but it shou=
ld have returned -ENOSYS
>>> |[FAIL]              x32 syscalls 1:-64=2E=2E-2 had 63 failure
>>> |[OK]                x32 syscall 1:-1 returned MODIFIED_BY_PTRACE as e=
xpected
>>> |[FAIL]                  x64 syscall 1:1073741760 returned -9999, but =
it should have returned -ENOSYS
>>> =E2=80=A6
>>>
>>> and so on=E2=80=A6 The test has
>>>
>>> | #define MODIFIED_BY_PTRACE      -9999
>>>
>>> and the ptracer modifies the return code=2E However not always=2E Not =
sure
>>> if this was indeed a pointless exercise or not=2E
>>
>> Hrmm=2E That's weird=2E Let me have a look=2E
>
>So I clearly failed to decode the overloading of the -1L return value
>correctly and then failed to run the stupid test=2E
>
>TBH, this whole thing was a horrid and inconsistent mess=2E
>
>The logic in the original code was:
>
>    When the entry work code returned an invalid syscall number then the
>    return value in regs->ax was set to -ENOSYS, except when the
>    returned syscall number was -1=2E Syscall number "-1" indicated that
>    the syscall has to be aborted=2E
>
>     regs->ax =3D -ENOSYS;
>     syscall =3D enter_work(regs, syscall);
>     if (syscall_in_range(syscall))
>        regs->ax =3D do_syscall(syscall);
>     else if (syscall !=3D -1)
>        regs->ax =3D -ENOSYS;
>
>So if the ptrace check in enter_work() overwrote regs->ax and the
>syscall number (either as supplied by user space or rewritten) was out
>of range and not -1 then the x86 entry code overwrote regs->ax to
>-ENOSYS again=2E IOW, there is no distinction between a check induced
>abort and a syscall with syscall number -1=2E
>
>The rework changed the return value to boolean, which is true when the
>syscall should be invoked and false when one of the checks requests to
>abort the syscall=2E In that case the return code does not touch the
>return value in regs->ax=2E
>
>If the eventually modified syscall number is out of range then the code
>relies on the fact that regs->ax was preset with -ENOSYS, i=2Ee=2E:
>
>     regs->ax =3D -ENOSYS;
>     // True indicates to proceed
>     if (enter_work(regs, &syscall)) {
>         if (syscall_in_range(syscall))
>            regs->ax =3D do_syscall(syscall);
>     }
>
>That seems to be equivalent, but it is not when ptrace() modifies
>the return value in regs->ax and also rewrites the syscall number to an
>invalid value or leaves the user supplied invalid value intact and does
>_NOT_ abort the syscall=2E
>
>So the reworked code does not overwrite the tracer modified return value
>with -ENOSYS in that case and returns whatever the tracer decided to put
>into it=2E
>
>TBH, that makes a lot more sense than the original behavior=2E If the
>tracer decides to fiddle with the default return value then that's what
>the tracer intended=2E
>
>That makes the behavior consistent vs=2E other abort scenarios:
>
>    ptrace()
>      regs->ax =3D MAGIC;
>      return true;            // Allow syscall
>
>    seccomp()
>      return false;          // Abort syscall
>
>So when the tracer modified the return value and seccomp aborts the
>syscall then the tracer induced value is preserved=2E That was the case i=
n
>the original code as well because seccomp() indicated the abort by
>returning -1 as the modified syscall number=2E Similar effects when ftrac=
e
>(BPF, kprobe) decided to overwrite the syscall number)=2E
>
>Bringing the original behaviour back is trivial enough, but I'm not
>convinced that it makes any sense and is worth it=2E At least this
>confines the x32 specific insanity of treating -1 special to x32=2E=2E=2E
>
>Thanks,
>
>        tglx
>---
>--- a/arch/x86/entry/syscall_32=2Ec
>+++ b/arch/x86/entry/syscall_32=2Ec
>@@ -77,6 +77,8 @@ static __always_inline void do_syscall_3
> 	if (likely(nr < IA32_NR_syscalls)) {
> 		nr =3D array_index_nospec(nr, IA32_NR_syscalls);
> 		regs->ax =3D ia32_sys_call(regs, (unsigned int)nr);
>+	} else {
>+		regs->ax =3D -ENOSYS;
> 	}
> }
>=20
>--- a/arch/x86/entry/syscall_64=2Ec
>+++ b/arch/x86/entry/syscall_64=2Ec
>@@ -64,15 +64,24 @@ static __always_inline bool do_syscall_x
> 	return false;
> }
>=20
>-static __always_inline void do_syscall_x32(struct pt_regs *regs, unsigne=
d long nr)
>+static __always_inline bool do_syscall_x32(struct pt_regs *regs, unsigne=
d long nr)
> {
>+	if (!IS_ENABLED(CONFIG_X86_X32_ABI))
>+		return false;
>+
>+	/* Preserve the historic insanity of treating -1 special on x32 */
>+	if (nr =3D=3D ULONG_MAX)
>+		return true;
>+
> 	/* Adjust the starting offset of the table */
> 	nr -=3D __X32_SYSCALL_BIT;
>=20
>-	if (IS_ENABLED(CONFIG_X86_X32_ABI) && likely(nr < X32_NR_syscalls)) {
>+	if (likely(nr < X32_NR_syscalls)) {
> 		nr =3D array_index_nospec(nr, X32_NR_syscalls);
> 		regs->ax =3D x32_sys_call(regs, (unsigned int)nr);
>+		return true;
> 	}
>+	return false;
> }
>=20
> /* Returns true to return using SYSRET, or false to use IRET */
>@@ -81,8 +90,10 @@ static __always_inline void do_syscall_x
> 	if (likely(syscall_enter_from_user_mode_randomize_stack(regs, &nr))) {
> 		instrumentation_begin();
>=20
>-		if (!do_syscall_x64(regs, nr))
>-			do_syscall_x32(regs, nr);
>+		if (unlikely(!do_syscall_x64(regs, nr))) {
>+			if (!do_syscall_x32(regs, nr))
>+				regs->ax =3D -ENOSYS;
>+		}
>=20
> 		instrumentation_end();
> 	}
>
>
>
>
>
>
>
>
>
>
>

It was never limited to x32=2E=2E=2E

