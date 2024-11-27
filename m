Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EABCAD609D1
	for <linux-um@archiver.kernel.org>; Wed, 27 Nov 2024 10:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qk22VQ1BwFkDmGYrc5CmjtDx54y8gBRvSAPGZDT4eo8=; b=L1y35oILXbaitOyv8s5+kd7cT+
	vk6PamtBo1Pq9AB43sg7DWgjSl+98/wDFdF3kKlh1c5qsRlLXcxWVelCN730f9z2Sm0iOCxHy/X81
	fDXHXJJQQZXQx9njnhfZLiuZb443zISmgqNZ8ZUazh+1P1jW7vQs81ytmHSst3CCZZQ+o9cun1Ztp
	X/XgtF2G9FTRz8l/+zg3JC1/YsQwuqi8DbgYiLbUFDJoe+BlDH9p9sp3bQtWzUuHKNHXouXYX5qub
	I1ujCNpsLbjtdw6EIZ8Ic4lq0cWpWF80otSDAXU5ISzQx3tOxbKHczvLvouj5TRdlwuJZTuujHtjj
	/SU4b6Ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGFUG-0000000Ct1u-2Oam;
	Wed, 27 Nov 2024 10:41:36 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGFPf-0000000CsEX-1puu
	for linux-um@lists.infradead.org;
	Wed, 27 Nov 2024 10:36:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=qk22VQ1BwFkDmGYrc5CmjtDx54y8gBRvSAPGZDT4eo8=;
	t=1732703811; x=1733913411; b=K2qaW04eHhbCvuDByn0+6ezKuDtKzA/o+RuN3nESCl/lfAR
	W0awYuQMnBM59LGHNq6gNg0xOS2Z+150sS0oQ56oCrz5nN567PT9RlAy2VRsZE8/7t/T48TrcvVNa
	i0WiG9VSn90xmwAOGsyR3lvE6bxMXWD0Sfj3oi2j4GxqFwQGNA5Fy9CcBNfT6H/RwSJ7twxkttang
	R0fcMJ5MQ7oghvvZ2gL6XHOgJWyPfBt3QNVnIIvrQKU9NiXHiShpL8r+hP6KhYYlrMnR3EB+jYADX
	Ph/tyDT0f7N+oTYjpRkEXJrqIBU+fp6V8pR7B5ZOCyxl42kPDU/HHzRg0Ibu6QNA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1tGFPc-0000000GYwR-3rcU;
	Wed, 27 Nov 2024 11:36:49 +0100
Message-ID: <1b825acd305578af2e2ad6c01ce5ef63482da68d.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v2 09/13] x86/um/vdso: nommu: vdso memory update
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org
Cc: ricarkol@google.com, Liam.Howlett@oracle.com
Date: Wed, 27 Nov 2024 11:36:44 +0100
In-Reply-To: <a00a498ea9803ac3c6f2b933203a2675d1785208.1731290567.git.thehajime@gmail.com>
References: <cover.1731290567.git.thehajime@gmail.com>
	 <a00a498ea9803ac3c6f2b933203a2675d1785208.1731290567.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241127_023651_479217_4D01C327 
X-CRM114-Status: GOOD (  17.29  )
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

Hi,

On Mon, 2024-11-11 at 15:27 +0900, Hajime Tazaki wrote:
> On !MMU mode, the address of vdso is accessible from userspace.=C2=A0 Thi=
s
> commit implements the entry point by pointing a block of page address.
>=20
> This commit also add memory permission configuration of vdso page to be
> executable.
>=20
> Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
> Signed-off-by: Ricardo Koller <ricarkol@google.com>
> ---
> =C2=A0arch/x86/um/vdso/um_vdso.c | 20 ++++++++++++++++++++
> =C2=A0arch/x86/um/vdso/vma.c=C2=A0=C2=A0=C2=A0=C2=A0 | 14 ++++++++++++++
> =C2=A02 files changed, 34 insertions(+)
>=20
> diff --git a/arch/x86/um/vdso/um_vdso.c b/arch/x86/um/vdso/um_vdso.c
> index cbae2584124f..eff3e6641a0e 100644
> --- a/arch/x86/um/vdso/um_vdso.c
> +++ b/arch/x86/um/vdso/um_vdso.c
> @@ -23,10 +23,17 @@ int __vdso_clock_gettime(clockid_t clock, struct
> __kernel_old_timespec *ts)
> =C2=A0{
> =C2=A0	long ret;
> =C2=A0
> +#ifdef CONFIG_MMU
> =C2=A0	asm("syscall"
> =C2=A0		: "=3Da" (ret)
> =C2=A0		: "0" (__NR_clock_gettime), "D" (clock), "S" (ts)
> =C2=A0		: "rcx", "r11", "memory");
> +#else
> +	asm("call *%1"
> +		: "=3Da" (ret)
> +		: "0" ((unsigned long)__NR_clock_gettime), "D"
> (clock), "S" (ts)
> +		: "rcx", "r11", "memory");
> +#endif
> =C2=A0
> =C2=A0	return ret;
> =C2=A0}
> @@ -37,10 +44,17 @@ int __vdso_gettimeofday(struct
> __kernel_old_timeval *tv, struct timezone *tz)
> =C2=A0{
> =C2=A0	long ret;
> =C2=A0
> +#ifdef CONFIG_MMU
> =C2=A0	asm("syscall"
> =C2=A0		: "=3Da" (ret)
> =C2=A0		: "0" (__NR_gettimeofday), "D" (tv), "S" (tz)
> =C2=A0		: "rcx", "r11", "memory");
> +#else
> +	asm("call *%1"
> +		: "=3Da" (ret)
> +		: "0" ((unsigned long)__NR_gettimeofday), "D" (tv),
> "S" (tz)
> +		: "rcx", "r11", "memory");
> +#endif
> =C2=A0
> =C2=A0	return ret;
> =C2=A0}
> @@ -51,9 +65,15 @@ __kernel_old_time_t
> __vdso_time(__kernel_old_time_t *t)
> =C2=A0{
> =C2=A0	long secs;
> =C2=A0
> +#ifdef CONFIG_MMU
> =C2=A0	asm volatile("syscall"
> =C2=A0		: "=3Da" (secs)
> =C2=A0		: "0" (__NR_time), "D" (t) : "cc", "r11", "cx",
> "memory");
> +#else
> +	asm("call *%1"
> +		: "=3Da" (secs)
> +		: "0" ((unsigned long)__NR_time), "D" (t) : "cc",
> "r11", "cx", "memory");
> +#endif

Maybe introduce a macro for "syscall" vs. "call *%1"? The parameters
should be identical in both cases. The "call" could probably even jump
to the end of the NOP ramp directly in this case.

Though maybe I am missing something with the "(unsigned long)" cast?

> =C2=A0	return secs;
> =C2=A0}
> diff --git a/arch/x86/um/vdso/vma.c b/arch/x86/um/vdso/vma.c
> index f238f7b33cdd..83c861e2a815 100644
> --- a/arch/x86/um/vdso/vma.c
> +++ b/arch/x86/um/vdso/vma.c
> @@ -9,6 +9,7 @@
> =C2=A0#include <asm/page.h>
> =C2=A0#include <asm/elf.h>
> =C2=A0#include <linux/init.h>
> +#include <os.h>
> =C2=A0
> =C2=A0static unsigned int __read_mostly vdso_enabled =3D 1;
> =C2=A0unsigned long um_vdso_addr;
> @@ -24,7 +25,9 @@ static int __init init_vdso(void)
> =C2=A0
> =C2=A0	BUG_ON(vdso_end - vdso_start > PAGE_SIZE);
> =C2=A0
> +#ifdef CONFIG_MMU
> =C2=A0	um_vdso_addr =3D task_size - PAGE_SIZE;
> +#endif
> =C2=A0
> =C2=A0	vdsop =3D kmalloc(sizeof(struct page *), GFP_KERNEL);
> =C2=A0	if (!vdsop)
> @@ -40,6 +43,15 @@ static int __init init_vdso(void)
> =C2=A0	copy_page(page_address(um_vdso), vdso_start);
> =C2=A0	*vdsop =3D um_vdso;
> =C2=A0
> +#ifndef CONFIG_MMU
> +	/* this is fine with NOMMU as everything is accessible */
> +	um_vdso_addr =3D (unsigned long)page_address(um_vdso);
> +	os_protect_memory((void *)um_vdso_addr, vdso_end -
> vdso_start, 1, 1, 1);

I think this should be "1, 0, 1", i.e. we shouldn't enable write
access.

> +	pr_debug("vdso_start=3D%lx um_vdso_addr=3D%lx pg_um_vdso=3D%lx",
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (unsigned long)vdso_start, um_vdso=
_addr,
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (unsigned long)page_address(um_vds=
o));
> +#endif
> +
> =C2=A0	return 0;
> =C2=A0
> =C2=A0oom:
> @@ -50,6 +62,7 @@ static int __init init_vdso(void)
> =C2=A0}
> =C2=A0subsys_initcall(init_vdso);
> =C2=A0
> +#ifdef CONFIG_MMU
> =C2=A0int arch_setup_additional_pages(struct linux_binprm *bprm, int
> uses_interp)
> =C2=A0{
> =C2=A0	struct vm_area_struct *vma;
> @@ -74,3 +87,4 @@ int arch_setup_additional_pages(struct linux_binprm
> *bprm, int uses_interp)
> =C2=A0
> =C2=A0	return IS_ERR(vma) ? PTR_ERR(vma) : 0;
> =C2=A0}
> +#endif


