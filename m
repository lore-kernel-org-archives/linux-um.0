Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCEDC44501
	for <linux-um@archiver.kernel.org>; Wed,  8 Jul 2026 21:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vh8LzxdSEB6LZ5YWToq98HafI55oS8+SMbKFy7UAtCc=; b=IWXp1/uVtJoKiHDYt+WuEM+vxA
	fp8k+0SEBxjQSRfdgzaFViCKhQ2tDth16G2Oc3xbTvLXld8EurRGJel3QuUDUNw/nGJBdLr0dW6G6
	kMta6hecgdht0kCx/XJG2tNikk6CbJUlBcdyQYucUDbMlr6/a2MomCkMx5ORByFXNX4TWZPTvbJ1E
	vVcwVIRLC13FT1HlA4m1UgQE8fojyYsH9KMgpI7Bjtdlr1ULa0ZCFmKfOuskt6SFARWXWCLMCVfTC
	DVT/P2K44P9nVCrZTGF8dVO1E4zvO5w+64FRxITRsJvWxY7b8cp5sH3YltVK2rPFdYJ1ZiD0hrj6h
	AoGGSb1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wha0I-00000000SWo-0lXT;
	Wed, 08 Jul 2026 21:40:26 +0000
Received: from xs1.mindbit.ro ([80.86.107.70] helo=mail.mindbit.ro)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wha0E-00000000SVt-10mJ;
	Wed, 08 Jul 2026 21:40:23 +0000
Received: from bat.kanata.rendec.net (unknown [24.114.111.125])
	by mail.mindbit.ro (Postfix) with ESMTPSA id 362D5C2A88;
	Thu,  9 Jul 2026 00:39:55 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.mindbit.ro 362D5C2A88
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rendec.net;
	s=default; t=1783546818;
	bh=vh8LzxdSEB6LZ5YWToq98HafI55oS8+SMbKFy7UAtCc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Vxaj5QTrZmnMb8kgo0DAnYKLpgF1VNrrEnZhf9ONVOiUDzl0XehMr6So/mzP7wSyL
	 f/bqBaPzsa1UU5XOryNPd/7wb5rGQ7IwzXh6waI3HHJA4HLb35t2X+7MMwejCU49/V
	 wyf2N0EPqZ3qOvz85kyJv8Z4VVG4eamp/AsyfiC+iferCPdwrWRhhI2Gihi8EYWMG6
	 w9oTc7WxIT/1nxUO9bTb5BDnYHc4NJdQoeD9M4hXia3YTHnUvNPgR3MY/vwUlZnDJN
	 KsGLwDIHTElRb68oeRo724l+p50zYouaHMInNxEVvF4Rx2YclHGHsHkUSx9MW9gMJA
	 BLbx/jCYTxmsw==
Message-ID: <0f3a6ccaadc1d330215416d9cec13263d71b685e.camel@rendec.net>
Subject: Re: [patch 10/18] entry: Use syscall number instead of rereading it
From: Radu Rendec <radu@rendec.net>
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Michael Ellerman
 <mpe@ellerman.id.au>,  Shrikanth Hegde <sshegde@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, Huacai Chen	
 <chenhuacai@kernel.org>, loongarch@lists.linux.dev, Paul Walmsley
 <pjw@kernel.org>,  Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org, Sven Schnelle <svens@linux.ibm.com>, 
	linux-s390@vger.kernel.org, x86@kernel.org, Mark Rutland
 <mark.rutland@arm.com>,  Jinjie Ruan <ruanjinjie@huawei.com>, Andy
 Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>, Russell King
 <linux@armlinux.org.uk>, Catalin Marinas	 <catalin.marinas@arm.com>, Guo
 Ren <guoren@kernel.org>, Geert Uytterhoeven	 <geert@linux-m68k.org>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>,  Helge Deller	 <deller@gmx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Weinberger
 <richard@nod.at>, Chris Zankel <chris@zankel.net>,
 linux-arm-kernel@lists.infradead.org, 	linux-alpha@vger.kernel.org,
 linux-csky@vger.kernel.org, 	linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, 	linux-parisc@vger.kernel.org,
 linux-sh@vger.kernel.org, 	linux-um@lists.infradead.org, Arnd Bergmann
 <arnd@arndb.de>, Vineet Gupta	 <vgupta@kernel.org>, Will Deacon
 <will@kernel.org>, Brian Cain <bcain@kernel.org>,  Michal Simek
 <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, "David S. Miller"
 <davem@davemloft.net>,  Andreas Larsson <andreas@gaisler.com>,
 linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-arch@vger.kernel.org, Michal =?ISO-8859-1?Q?Such=E1nek?=	
 <msuchanek@suse.de>, Jonathan Corbet <corbet@lwn.net>, 
	linux-doc@vger.kernel.org
Date: Wed, 08 Jul 2026 17:39:50 -0400
In-Reply-To: <20260707190254.181086755@kernel.org>
References: <20260707181957.433213175@kernel.org>
	 <20260707190254.181086755@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_144022_458680_F1CFFA97 
X-CRM114-Status: GOOD (  13.24  )
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

On Tue, 2026-07-07 at 21:06 +0200, Thomas Gleixner wrote:
> rseq_syscall_enter_work() is invoked before the syscall number can be
> modified. So there is no point in rereading it from pt_regs.
>=20
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> ---
> =C2=A0include/linux/entry-common.h |=C2=A0=C2=A0=C2=A0 9 +++++----
> =C2=A01 file changed, 5 insertions(+), 4 deletions(-)
>=20
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -70,9 +70,10 @@ static inline void syscall_enter_audit(s
> =C2=A0	}
> =C2=A0}
> =C2=A0
> -static __always_inline long syscall_trace_enter(struct pt_regs *regs, un=
signed long work)
> +static __always_inline long syscall_trace_enter(struct pt_regs *regs, un=
signed long work,
> +						long syscall)
> =C2=A0{
> -	long syscall, ret =3D 0;
> +	long ret =3D 0;
> =C2=A0
> =C2=A0	/*
> =C2=A0	 * Handle Syscall User Dispatch.=C2=A0 This must comes first, sinc=
e
> @@ -90,7 +91,7 @@ static __always_inline long syscall_trac
> =C2=A0	 * through hrtimer_interrupt().
> =C2=A0	 */
> =C2=A0	if (work & SYSCALL_WORK_SYSCALL_RSEQ_SLICE)
> -		rseq_syscall_enter_work(syscall_get_nr(current, regs));
> +		rseq_syscall_enter_work(syscall);
> =C2=A0
> =C2=A0	/* Handle ptrace */
> =C2=A0	if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)=
) {
> @@ -145,7 +146,7 @@ static __always_inline long syscall_ente
> =C2=A0	unsigned long work =3D READ_ONCE(current_thread_info()->syscall_wo=
rk);
> =C2=A0
> =C2=A0	if (work & SYSCALL_WORK_ENTER)
> -		syscall =3D syscall_trace_enter(regs, work);
> +		syscall =3D syscall_trace_enter(regs, work, syscall);
> =C2=A0
> =C2=A0	return syscall;
> =C2=A0}

Reviewed-by: Radu Rendec <radu@rendec.net>

