Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C00C44501
	for <linux-um@archiver.kernel.org>; Thu,  9 Jul 2026 18:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v3NWG3nzWzn0lD5brSEphHHDIxNRitNNFv0e1po41sA=; b=jwbR8vQN+D7/tcQDol6vgkMvZ6
	26yeUG6pzBR83LMbnqe8YywzTGGspVxzI+J6oj0sRvPRIO6DJdaQ2/xniIIZt26izr6UrN45aHcev
	9fNiIu23+DdQMC8eHqNsJNiItFuoJcV5Ab7hjGWRxwTPsG2tYPlN7jdba2CArBg0cZRmw0GmNKRQK
	sSOf2xzwkWCGW28Qll2rFldTzRGc30MT3Hnr7M6xrUhX/CcVLthcVY9YpKeVwG/nx1xD48mNw+qgk
	yEVwXxI62Whnyq/HQCjgYKSYsHzGanzjM//v59O/1fjWLtiyVkBFnK90aPxWjLV+F/I7Hd+ufdG/B
	giZ4+LtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whtfd-00000003Eyp-0sh7;
	Thu, 09 Jul 2026 18:40:25 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whtfX-00000003EtV-3noK
	for linux-um@lists.infradead.org;
	Thu, 09 Jul 2026 18:40:21 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2ccdb73f0e1so717445ad.3
        for <linux-um@lists.infradead.org>; Thu, 09 Jul 2026 11:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783622419; x=1784227219; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v3NWG3nzWzn0lD5brSEphHHDIxNRitNNFv0e1po41sA=;
        b=p5kKHYrpdQSLL+MYP0Z8dH3RCa/j+KeV/Syj9MXwevDvyVsgM1iJiz5kIdM0Q45TXj
         ukWeWczEwy7/pNfhTk0j8Thv3UeORc+Dvql09cRJetiOCcFkjbNXxSK8zs1a6xSZ/uNf
         gahoLjki7veMMuI8SVoU3Iuk3JKA6ekCPIHwbCtPFuwby1N9b5e9c6XusMms0N5NeFI6
         BFluYhpwszGrLBYUICvvE3iHroskakHIzNL1fw68xJyH0qcp4vcSzbWz2Goco9DnTbUp
         3aqvhU0Z1JEeArwobKQfQLdOOAhI/M1A8KHC61505LpK/D+LHcOzcqUS2G0Jiun/C95E
         GeTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783622419; x=1784227219;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v3NWG3nzWzn0lD5brSEphHHDIxNRitNNFv0e1po41sA=;
        b=kT2fnC6oWiqD+HYjF8GzoL2UHUS622F4tnYvdt2bV9+HiXe673iqdKEodgV8ezVolH
         X7EDSAajG5fiMVw3xZtD/muS+glqYPmTlUI1XDosi9w/TreJDiqBBQ98AMWezdhCK2MU
         /BIVmtrHHCsbbF+EdWgZ8ZVZYKJ4Zu4oGVoB3Xk+pGCq9Gzk99vUEizvhyEyAvr9xv+H
         Q/4Og0M5Io3tqIaX8gtBVPbrPE/xRn2EixYiCqndkII++bY/zIpGAqudj8NCx6WtT7l0
         RhQ+n/PCFUexYC9SFtkPkJDCRkZNTjCSfRBfdjX/ijr8mfXpDzKz/ZADxH65FpWru5XZ
         IINA==
X-Forwarded-Encrypted: i=1; AHgh+RosYTUYpnsNN7pYiknE1j/PscjM8tpgoXZh/Q35fHGGXg3E/SYEJCZO8za0TGvm7DWWMoynkb1jaA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy/KztSzTPytRx1DB6KHffPL42fS12JRe9/+648/juGchTlQMlG
	CzhDwGulgDR1bVcnukrsfi1T+6N+nH7Ib4FXFqEQjS0tPV72rbCnzdb4
X-Gm-Gg: AfdE7cnd8YsSRYl2iW0hjHrAHpU2Zdy0SpMAjQCNXAHQpr60iwDl4+mfhesIbYxRAo3
	+HqzLUr2kozmx4pZJY+drvnUdXdgkzlKwx89YYBZ9NZNs0iLB8U49bcQm+ly7TAoRtDOVDO+XAl
	M9wSWY5DwtFZ3r1A33cx/Y7FEGE4BNpYSYtP7s5eDAZF0+Ul7tvNvftAx5dI5jUDVTQX2ooMfV5
	FDqgJisAbPqcmuRfO0yIWFAdZeRN4wiVtHMbUsEOYrgnWZ097wSm5fdSNjMNWmVyKVSd2QY3JQA
	uRcSOnbCIvOjbnlK0wk6sZmDd/qnC+QmKSufzbzbCL/PiI8K3yNyxcjYZMuDKPmW75cH2lQg8Ia
	geJkRoDWLW8zjf27Fb3elbg3pd/PCD4UETwTz2VcsFwqFVxd4GqlPx4hAETAnh9CjRfVfJ9ry5P
	yk0V2+/zpi78soU5abONLz8fqptmo0vpMffUXGu8fCCj5LzLxxPRkGj4NET/ER
X-Received: by 2002:a05:6a21:4902:b0:3b4:8300:7019 with SMTP id adf61e73a8af0-3c0bcf656a1mr10343651637.18.1783622418932;
        Thu, 09 Jul 2026 11:40:18 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3118ee6091dsm28653518eec.14.2026.07.09.11.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:40:18 -0700 (PDT)
Date: Fri, 10 Jul 2026 00:10:01 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
	Michael Ellerman <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
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
Subject: Re: [patch 04/18] loongarch/syscall: Use
 syscall_enter_from_user_mode_randomize_stack()
Message-ID: <ak_q9qWuifFdo_9S@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190253.865955911@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707190253.865955911@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260709_114019_961675_0BA8BD80 
X-CRM114-Status: GOOD (  17.16  )
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

On Tue, Jul 07, 2026 at 09:06:11PM +0200, Thomas Gleixner wrote:
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
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: loongarch@lists.linux.dev
> ---
>  arch/loongarch/kernel/syscall.c |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> --- a/arch/loongarch/kernel/syscall.c
> +++ b/arch/loongarch/kernel/syscall.c
> @@ -11,7 +11,6 @@
>  #include <linux/linkage.h>
>  #include <linux/nospec.h>
>  #include <linux/objtool.h>
> -#include <linux/randomize_kstack.h>
>  #include <linux/syscalls.h>
>  #include <linux/unistd.h>
>  
> @@ -70,9 +69,7 @@ void noinstr __no_stack_protector do_sys
>  	regs->orig_a0 = regs->regs[4];
>  	regs->regs[4] = -ENOSYS;
>  
> -	nr = syscall_enter_from_user_mode(regs, nr);
> -
> -	add_random_kstack_offset();
> +	nr = syscall_enter_from_user_mode_randomize_stack(regs, nr);
>  
>  	if (nr < NR_syscalls) {
>  		syscall_fn = sys_call_table[array_index_nospec(nr, NR_syscalls)];
> 
> 
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> _______________________________________________
> linux-snps-arc mailing list
> linux-snps-arc@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-snps-arc

