Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C5FC44507
	for <linux-um@archiver.kernel.org>; Thu,  9 Jul 2026 18:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aq4oHRjffhbqNLpraCJHXQbfXmiONMD/vVc6qcgWJtk=; b=lkYKA3TnIQkaQFL+4AsPXTAPXD
	U3QeihRs+o+8LRrGjL3s54/3l+CxKOnmv4I5M9DGtXwZezQMyDYA+gnEIaoIR+uwC5pTUPMNdzJBh
	wjfqQ1dbQf881ONK2eKANCD59e/Vd99oqg7OA4QJPJ7URPCb1L4dMPusLbVMFvRY9ut6VI6RhVB/N
	f0f6E7xBtCgL2KjduG5Ej0uIATydL3qpppD9dyP27SZYIiCjyZQ9jmIpgLMaRm5VTm3bAeCB3gTkh
	wpuqMEa2FClRQpm+C5BSMu7mVfyTQNrhFOJpASFjfKEzZyxxyRsNc5aiKT5woAC/yxU/CSP+JoRol
	rZk5+/uQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whtgf-00000003GGK-2pM3;
	Thu, 09 Jul 2026 18:41:29 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whtgc-00000003G9f-0IDx
	for linux-um@lists.infradead.org;
	Thu, 09 Jul 2026 18:41:28 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2cc6dd436c6so956495ad.2
        for <linux-um@lists.infradead.org>; Thu, 09 Jul 2026 11:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783622485; x=1784227285; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aq4oHRjffhbqNLpraCJHXQbfXmiONMD/vVc6qcgWJtk=;
        b=pgu9KFgfGTA2cA2ZA2fpXnnCJmC+78Wb5Oy2T4Uxqa47V3MGKckwckNrQHjYwxBa5G
         j4F9aD/ttkQ64tDpqH1KQIBBkAJOaN4uGHN3Ye0PkWuEfaHS6zDvV0WtNaQI4FQ2zO+N
         Dqoqjn22uf8hrrlLF8iVgQ+pMF0+QieEZ5o9nacQN6D6y1EuWX2zeAJTZQMINS1RUmAn
         E6ApyHZvjqJ5bRoa565kgd9iAOczg9HwkyQ7bHu9hgKxvq0+1q5XzyWApW8/FWAy+yxg
         KNM2f2hESX9NHHJEDMj+Zd1hOmw/3j772BAS02mIZXVCtt/DZuCL9KYFyZpuvKE7mbnN
         lyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783622485; x=1784227285;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aq4oHRjffhbqNLpraCJHXQbfXmiONMD/vVc6qcgWJtk=;
        b=DgHo48EAurzWS2CR8gkRIXxcFHBVccK/niIGdRgHcC8gRcTY5wdcu3JeKJDp03s7wi
         9gKZUDhKdeI9F6IIff8EJorLJfzoqwwjm8CsjoOWpiz2pa+vUL+EBpzZFOGFRnG3DE/X
         8oK+mPF9IKlEjWFbqjD6aDAEhNx5DTp0rPdPg7PItj42b/R1MOctH0uMWLMbyuxQ9R1U
         Mclca92eEBodNnPm1QAgNsqDLHUtKfJxVuvdaMGFf2RdurmKbfax5lAEcQjNQMeLWo42
         FT5ZUW45wCwjhYDvH7DDdWhpishHinEIj+CJ4Df0z0DCBEvzeGdVCjd7rllO4TVOzR4x
         aDqA==
X-Forwarded-Encrypted: i=1; AHgh+RqsZgc95aiVqOSCNOq8zXQ5hkJOFnZhyqmOflX1BjPFHMjR55x+GP9uFvmCTHjIL9sMl36RVg7TAA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw2RfohNuJ6xxLjg6rXJwbAoEmLVkbAAD2zRqdMP1rlgMkyocYM
	BPtN61lRBjtM8qSOKzlV3BuOP8LCs5zqVJPrTdjsnB1DthLZ66Fh/qlN
X-Gm-Gg: AfdE7cl9DkgLA2qZaDvZ+8bpUuSu9ldV7hDKm0QmvLoiHBjAnmXiTTYTkUqCKRq2CKQ
	HvMyiXnNxmasHyQoS283mrEry30xLHArefF31nFHUsbF9t5iv69DAHLv9C/aQIhG25dRp+VkNJ6
	EftQIomB5zh0yFoE9BeF78SAUQFHkfKuR/c+7eXLv7datERg3BZn1QMimL1TsHNTcnEdljpSgx+
	GEWHxaoKe2C5viWsmQrXexEFK52hoP41XCc3t723Kx0e8AnCc3ugcMU5ftoY8qHkjnB8MYLvjav
	Jlb6hQ+DGqkG9rlPO4e4byaKYF/b23xhJ+SVVkLtShpoErLPeAQNhcF9l/b7JfXNmkrcci+Ar9M
	Zc/x6xOGzc3LOdAkeryc48VZCV/wZGq3hGpZ9EWNiJEeIgYv5JaZWePkhfHYrDNbwmfDscqvytZ
	zecRGHWw69W9qqWuCULcRThk+/NtN8KX8WD8QkmQTHTRj6JxV4jojzOAThBv81
X-Received: by 2002:a05:6a20:3d0c:b0:3bf:80b8:9c8a with SMTP id adf61e73a8af0-3c0bcead1e2mr9967332637.6.1783622485265;
        Thu, 09 Jul 2026 11:41:25 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d7c8bsm35321002c88.12.2026.07.09.11.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:41:24 -0700 (PDT)
Date: Fri, 10 Jul 2026 00:11:04 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Helge Deller <deller@gmx.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>, 
	linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-um@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, 
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, 
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [patch 05/18] powerpc/syscall: Use
 syscall_enter_from_user_mode_randomize_stack()
Message-ID: <ak_rL1RfdQVJ6zeq@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190253.918861529@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707190253.918861529@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260709_114126_151652_96CC9017 
X-CRM114-Status: GOOD (  16.56  )
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

On Tue, Jul 07, 2026 at 09:06:15PM +0200, Thomas Gleixner wrote:
> syscall_enter_from_user_mode_randomize_stack() replaces
> syscall_enter_from_user_mode() and the subsequent invocation of
> add_random_kstack_offset().
> 
> The advantage is that it applies the stack randomization right after
> enter_from_user_mode() and thereby avoids the overhead of get/put_cpu_var()
> as that code is invoked with interrupts disabled.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  arch/powerpc/kernel/syscall.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> --- a/arch/powerpc/kernel/syscall.c
> +++ b/arch/powerpc/kernel/syscall.c
> @@ -2,7 +2,6 @@
>  
>  #include <linux/compat.h>
>  #include <linux/context_tracking.h>
> -#include <linux/randomize_kstack.h>
>  #include <linux/entry-common.h>
>  
>  #include <asm/interrupt.h>
> @@ -19,8 +18,7 @@ notrace long system_call_exception(struc
>  	long ret;
>  	syscall_fn f;
>  
> -	r0 = syscall_enter_from_user_mode(regs, r0);
> -	add_random_kstack_offset();
> +	r0 = syscall_enter_from_user_mode_randomize_stack(regs, r0);
>  
>  	if (unlikely(r0 >= NR_syscalls)) {
>  		if (unlikely(trap_is_unsupported_scv(regs))) {
> 
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

