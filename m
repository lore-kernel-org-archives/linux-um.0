Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE015C43458
	for <linux-um@archiver.kernel.org>; Wed,  8 Jul 2026 18:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HOFoesOyB88RJQpCsNVT6CnljJeq85zHo9ievtK6il8=; b=jrRJwx9+WPIgRXSf4u8pxIsxDY
	EjXQhtAZY94qHM/jCOiYaIO4/H40aLmLl3ecsbvx0Yu17olNXx6t3aMuAQGpRjfuswxBw/i9ldH/E
	0LLOhZ9k5eqcALQEUIAZMJE3L7bidgCkrETHq42qwQOC5nIASMVMQjUvaM62VXWp5SC3sFbRF9xMA
	gbSjqkp6bhNzlYFyAk9AxITDA5c8m3yA433Nwy4L7UouayDpBnWeuI5WlaNEsy0LY6e9+k1l3oRCe
	XmQ69sTFdgBn2OsEH6tcvyEIdUnrOVB8QRXiMXHYVhX+06lT+YXrb7RPCWB0oLyqy3bF+ppwou+cd
	6jEwe2Nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whX8F-00000000C37-3AZz;
	Wed, 08 Jul 2026 18:36:27 +0000
Received: from xs1.mindbit.ro ([80.86.107.70] helo=mail.mindbit.ro)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whX88-00000000BwI-3RVs;
	Wed, 08 Jul 2026 18:36:26 +0000
Received: from bat.kanata.rendec.net (unknown [24.114.111.125])
	by mail.mindbit.ro (Postfix) with ESMTPSA id A4061C3435;
	Wed,  8 Jul 2026 21:35:54 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.mindbit.ro A4061C3435
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rendec.net;
	s=default; t=1783535777;
	bh=HOFoesOyB88RJQpCsNVT6CnljJeq85zHo9ievtK6il8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=R0pckaM7uzKJhnfLsd+EasA5iL0B7ZA4xUo2QedrlgePDqSCeceDdoKrCaUXSgH75
	 15MPZ33HpRCU30hqcMI0PUJAA4ul+9XUwxAhJeXTpBoywEuKewGCk7m21xK7GBO94b
	 NpDa7pro6OWmXqh5IS/WT+qx6ABBrkCA+Kv5g9jMDrLVH+mh9k+/398rw04b/Uiitl
	 a9blgckrqg3HTXMb7xcAzYPWQFRHvTBk4ekkJmwrZessc3xf9tFXhmpN0qrpZBt8yq
	 5Qao1qyCtvtsSHKBGAM0cGKH+LVrTaTCbKcejqQuUrZPKj01pL+BpzMYflQ9YS3rRx
	 JbQnyYBWoKGdQ==
Message-ID: <a8c5cc7d9296d59bf3d5851a3a2ba5f3a271bb9a.camel@rendec.net>
Subject: Re: [patch 05/18] powerpc/syscall: Use
 syscall_enter_from_user_mode_randomize_stack()
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
Date: Wed, 08 Jul 2026 14:35:48 -0400
In-Reply-To: <20260707190253.918861529@kernel.org>
References: <20260707181957.433213175@kernel.org>
	 <20260707190253.918861529@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_113621_033130_E2C0E179 
X-CRM114-Status: GOOD (  12.77  )
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
> syscall_enter_from_user_mode_randomize_stack() replaces
> syscall_enter_from_user_mode() and the subsequent invocation of
> add_random_kstack_offset().
>=20
> The advantage is that it applies the stack randomization right after
> enter_from_user_mode() and thereby avoids the overhead of get/put_cpu_var=
()
> as that code is invoked with interrupts disabled.
>=20
> No functional change.
>=20
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
> =C2=A0arch/powerpc/kernel/syscall.c |=C2=A0=C2=A0=C2=A0 4 +---
> =C2=A01 file changed, 1 insertion(+), 3 deletions(-)
>=20
> --- a/arch/powerpc/kernel/syscall.c
> +++ b/arch/powerpc/kernel/syscall.c
> @@ -2,7 +2,6 @@
> =C2=A0
> =C2=A0#include <linux/compat.h>
> =C2=A0#include <linux/context_tracking.h>
> -#include <linux/randomize_kstack.h>
> =C2=A0#include <linux/entry-common.h>
> =C2=A0
> =C2=A0#include <asm/interrupt.h>
> @@ -19,8 +18,7 @@ notrace long system_call_exception(struc
> =C2=A0	long ret;
> =C2=A0	syscall_fn f;
> =C2=A0
> -	r0 =3D syscall_enter_from_user_mode(regs, r0);
> -	add_random_kstack_offset();
> +	r0 =3D syscall_enter_from_user_mode_randomize_stack(regs, r0);
> =C2=A0
> =C2=A0	if (unlikely(r0 >=3D NR_syscalls)) {
> =C2=A0		if (unlikely(trap_is_unsupported_scv(regs))) {

Reviewed-by: Radu Rendec <radu@rendec.net>

