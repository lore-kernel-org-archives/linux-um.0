Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49A0606A31D
	for <linux-um@archiver.kernel.org>; Fri, 23 Oct 2026 21:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UOuLVlAS;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uq2tmGaB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=z4qvQCN58U+JYqI9bDmfn/D5nhfh4S82nzs2P03LmsM=; b=UOuLVlASg4ExVz2KgSkRgUW13i
	EMh2c51tW6ka1S8ZEjft9UjHjpGebundojqCMzSXgyEb6v05P/A+PfUdlSMFFhpeT9ndHXBzWbRyJ
	WRVNUAx1PVi1domRBqb6zWxT4/ZZjQUShMu1Bzp6aHdLEC8GoSM8BN2V8ROFdsTEpbQTiczGYpcr8
	oNEXVsWKoKr1HxnZ+rBpi6v6JF5vnsKH4lJ5f9m7OuuxmpomTdC0/I+9mHV2Rw23moQJ9Cvx032BA
	ndsDjiMMAgFqnBtuMOJWctUFI6os3Swbouo57Sr5jdqwEvwANUyKXSaXLRvx4SRMDhAcXL3HVpJF9
	lpNCiuGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKMQ8-0000000Gy30-1scd;
	Fri, 23 Oct 2026 21:03:24 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKMQ7-0000000Gy2d-0JfH;
	Fri, 23 Oct 2026 21:03:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 65CAD41766;
	Fri, 23 Oct 2026 21:03:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F501F01828;
	Fri, 23 Oct 2026 21:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792789402;
	bh=z4qvQCN58U+JYqI9bDmfn/D5nhfh4S82nzs2P03LmsM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Uq2tmGaBxQvk3ht7HGTfPReMFqJyJBCqOBq0vIxhArHZHHeoamuJ6hketeNzAHwZ8
	 StcQA3xVSJUZdHusYqq87suQp54bO9TdiZ0Pr4Ze4Wu2fGh5HjQOT/CoRjmyJUuOT5
	 DQIFlkgiCw5uboeFrJN90fUZm+ihmGYUDBYalCT5RPVFLoqxwSKvqaI9hdOaScug8P
	 bsCdObO84vUQd+eimnQGnJ/jGAyvXaf1qnLPgmpV54ONY8AyHfNjtN36ieHAOum0Wt
	 WlnPPiOkJPBZadv8Dcg6YFnsEANfVbG9w4HaV+a+oZJwLVONF8+aKkQsdWKxbxEmfR
	 J7+cwITy6EDVA==
From: Thomas Gleixner <tglx@kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
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
 linux-csky@vger.kernel.org, linux-m68k@vger.kernel.org,
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
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [patch 16/18] x86/entry: Get rid of the sys_ni_syscall()
 indirection
In-Reply-To: <C6D7BF04-4CF7-48D1-93B5-E80D52C2617D@zytor.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.493733289@kernel.org>
 <20261022142425.3Wx-RrU5@linutronix.de> <87fqxx1r80.ffs@fw13>
 <87cxt11ktr.ffs@fw13> <1149A39E-BEBA-46EA-94F4-4DFFC4733EF5@zytor.com>
 <871p9g1s3w.ffs@fw13> <87y0boze95.ffs@fw13>
 <C6D7BF04-4CF7-48D1-93B5-E80D52C2617D@zytor.com>
Date: Fri, 23 Oct 2026 23:03:19 +0200
Message-ID: <87se1wyvs8.ffs@fw13>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23 2026 at 08:38, H. Peter Anvin wrote:
> On October 23, 2026 7:24:22 AM PDT, Thomas Gleixner <tglx@kernel.org> wrote:
>>The real question is how we ended up there. By design or as an
>>implementation detail which got later set in stone and the selftest was
>>written to test the implementation instead of testing against a
>>specification.
>>
>>I went back in history and in 2.6.12 the behavior was for both i386 and
>>x86_64:
>>
>>  regs->ax = -ENOSYS;
>>  syscall_trace_enter();
>>  if (syscall_nr < MAX)
>>  	do_syscall();
>>  ....
>>
>>IOW, a tracer modification of regs->ax is not overwritten when the
>>syscall number is out of range.
>>
>>Between 2.6.19-rc2 and -rc3 x86_64 was changed to _always_ overwrite
>>regs->ax when the syscall number is out of range.
>>
>>In the 3.8 merge window seccomp introduced the -1 == skip bogosity which
>>got fixed up and made "consistent" in several changes afterwards. Just
>>that it never reached a state of consistency due to the overloading.
>>
>>So are we stuck with this behavior or do we sit down and define what the
>>correct behavior should be?
>>
>
> Going back on something from 3.8 that is actively used seems unwise. I
> fear that that ship sailed a long time ago, even though I hate it just
> as much as you do.

Well, overwriting the tracer written value for invalid syscall numbers
is something we can't undo. Though the interesting question is whether
the -1 overloading needs to be preserved. The new code uses returns
false when the syscall has to be aborted and that leaves the return code
untouched. When syscall_enter_trace() returns true, the syscall is
invoked, so it would be consistent to overwrite the return code with
-ENOSYS even for -1. But yeah, some esoteric nonsense might rely on that
behaviour for the wrong reasons.

Fix below.

Thanks,

        tglx
---
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -77,6 +77,8 @@ static __always_inline void do_syscall_3
 	if (likely(nr < IA32_NR_syscalls)) {
 		nr = array_index_nospec(nr, IA32_NR_syscalls);
 		regs->ax = ia32_sys_call(regs, (unsigned int)nr);
+	} else {
+		regs->ax = -ENOSYS;
 	}
 }
 
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -64,15 +64,20 @@ static __always_inline bool do_syscall_x
 	return false;
 }
 
-static __always_inline void do_syscall_x32(struct pt_regs *regs, unsigned long nr)
+static __always_inline bool do_syscall_x32(struct pt_regs *regs, unsigned long nr)
 {
+	if (!IS_ENABLED(CONFIG_X86_X32_ABI))
+		return false;
+
 	/* Adjust the starting offset of the table */
 	nr -= __X32_SYSCALL_BIT;
 
-	if (IS_ENABLED(CONFIG_X86_X32_ABI) && likely(nr < X32_NR_syscalls)) {
+	if (likely(nr < X32_NR_syscalls)) {
 		nr = array_index_nospec(nr, X32_NR_syscalls);
 		regs->ax = x32_sys_call(regs, (unsigned int)nr);
+		return true;
 	}
+	return false;
 }
 
 /* Returns true to return using SYSRET, or false to use IRET */
@@ -81,8 +86,21 @@ static __always_inline void do_syscall_x
 	if (likely(syscall_enter_from_user_mode_randomize_stack(regs, &nr))) {
 		instrumentation_begin();
 
-		if (!do_syscall_x64(regs, nr))
-			do_syscall_x32(regs, nr);
+		if (unlikely(!do_syscall_x64(regs, nr))) {
+			/*
+			 * The special treatment of syscall number -1 is a
+			 * historical bogosity as the original code used -1 to
+			 * indicate syscall abort, which is not distinguishable
+			 * from a syscall which is invoked with syscall number
+			 * -1. The historic behavior is to keep the return value
+			 * in regs->ax unmodified in that case, which means it's
+			 * either the preset value -ENOSYS or a value which was
+			 * written by a tracer. If the syscall number is invalid
+			 * but not -1 then overwrite any tracer modification.
+			 */
+			if (!do_syscall_x32(regs, nr) && nr != -1L)
+				regs->ax = -ENOSYS;
+		}
 
 		instrumentation_end();
 	}



