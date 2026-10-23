Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00854606A326
	for <linux-um@archiver.kernel.org>; Fri, 23 Oct 2026 13:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=sXMdCbIx;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m7RG/5lG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=nlznPFw9V2Gc6GAfgQKy3QilQuYPxjyao4Hf2pcvcDM=; b=sXMdCbIxe6BE0rCSJJTBgG47L9
	1RGiwMfazLqUDTtGqkHL2IwrCY1VzpfPZQ1YDV/33JYBgvgTxO2lEh+BdLgbp+U/NVoD0a93eENAv
	TFnAjc5j78cdtpdvsAdoc3XXww91roH5GrLC85nsr9HYt+2Cwavn/Dl562vB9tgE7z3Qwb9smvzNJ
	CI/4m5GUZo+KjynZUvEYW86lZX9fNhGrEBrvas4vs7FG8b5MTB475iaQ2wchbqwiY1AzHznb1qfJE
	OyiLFquUfVssZkXoBnqzOKJQn2m8S0QrQaaP91kiDE8gOzeVQlxnFPVpUcNi1XG3sK9NnlXewquBn
	I7dELzhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKF1G-0000000GLgq-2APM;
	Fri, 23 Oct 2026 13:09:14 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKF1E-0000000GLgR-0alb;
	Fri, 23 Oct 2026 13:09:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BCED242AF7;
	Fri, 23 Oct 2026 13:09:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEFE51F01825;
	Fri, 23 Oct 2026 13:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792760950;
	bh=nlznPFw9V2Gc6GAfgQKy3QilQuYPxjyao4Hf2pcvcDM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=m7RG/5lGWSbIc838b0jmvSS290uWfurhu3YNfo5bVNzSTvTPTC7ghSWC8leVP3nQ+
	 b1I3jDHg/InxLf552w5eGHsTrs/J6pcIRU/3j2o4lXMu8kdY2pE31lXQZ6mDuOD9a9
	 /bZSvE9+INNA1eyAemAPUHtpahZxa52CO1uiN/pTg/xq6n5EpQE55LyKwMgvscOovl
	 vpke1gUvPTZai31N3aWvQD3q3fnksvGf8uxqyvKnNdAccPdM5DjsmOgJhH0dNQrOqX
	 DgjQebBUKnbd01GrrL7MPL69Sel1P4/LLNB/kJOWZzm+JYUNtbLukoPTq27kTGyxJT
	 /kgHrVGsqnwng==
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
In-Reply-To: <1149A39E-BEBA-46EA-94F4-4DFFC4733EF5@zytor.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.493733289@kernel.org>
 <20261022142425.3Wx-RrU5@linutronix.de> <87fqxx1r80.ffs@fw13>
 <87cxt11ktr.ffs@fw13> <1149A39E-BEBA-46EA-94F4-4DFFC4733EF5@zytor.com>
Date: Fri, 23 Oct 2026 15:09:07 +0200
Message-ID: <871p9g1s3w.ffs@fw13>
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
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22 2026 at 17:22, H. Peter Anvin wrote:
> On October 22, 2026 2:34:08 PM PDT, Thomas Gleixner <tglx@kernel.org> wrote:
>>-static __always_inline void do_syscall_x32(struct pt_regs *regs, unsigned long nr)
>>+static __always_inline bool do_syscall_x32(struct pt_regs *regs, unsigned long nr)
>> {
>>+	if (!IS_ENABLED(CONFIG_X86_X32_ABI))
>>+		return false;
>>+
>>+	/* Preserve the historic insanity of treating -1 special on x32 */
>>+	if (nr == ULONG_MAX)
>>+		return true;
>
> It was never limited to x32...

Tired brain misread the test output:

[RUN]   Running tests under ptrace: modifying the default return
[RUN]       Checking system calls with msb = 0 (0x0)
[OK]                x32 syscalls 0:-64..-2 returned -ENOSYS as expected
[OK]                x32 syscall 0:-1 returned MODIFIED_BY_PTRACE as expected
[OK]                x64 syscalls 0:-64..-1 returned -ENOSYS as expected

But that's because the "-1" on x32 is actually 0xFFFFFFFF while on x64
it's 0x7FFFFFFF.

The whole mess comes from using -1 as indicator for syscall abort which
is undistinguishable from a syscall(nr=-1).

Bah. Let me restore this nonsense.

Thanks,

        tglx




