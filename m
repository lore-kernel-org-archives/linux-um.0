Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA28C44501
	for <linux-um@archiver.kernel.org>; Thu,  9 Jul 2026 18:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QPf+9G20chtvWfhmlbsBAcrLn3a4nXZU9b8fTPixMo0=; b=eoLgpEWnqB+m+s13YjRDqtb2TQ
	JXCAEXTtJrX2RBbUaODDgBUHcWcd7cCG0CYpQJSm1e4OAAKDqOpDOeEiZtiRow7whiE8cxjsk0XXY
	LHrSVXVZsFOS65y+G/FUthXKxqdaDZy2/NAyyJyRhw0q0ocZYcKRkoMFeNRCt/hA5nrGeuK1SFbS6
	K7b2kqj63+B7LtqUlDIsOJr8wED4WFr2JwLbjsaJpM3Mm6vxsLuf9nc1FgLh1kY4goSSBtB6CI3nt
	fAQtkDl+AXU6oMCPDqNd6ammylfRSGQLtH5hH2fYYC+y93A+oBhLoGB78CnoAn/G3YCadeNV/GAtF
	rAkmtlCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whtl6-00000003JE4-2gdn;
	Thu, 09 Jul 2026 18:46:04 +0000
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whtl2-00000003JBv-3bIy
	for linux-um@lists.infradead.org;
	Thu, 09 Jul 2026 18:46:02 +0000
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-382ef647e20so264899a91.1
        for <linux-um@lists.infradead.org>; Thu, 09 Jul 2026 11:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783622760; x=1784227560; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QPf+9G20chtvWfhmlbsBAcrLn3a4nXZU9b8fTPixMo0=;
        b=ohutmatX3xgDw8P797LqMgg7heIW+K8L4EnxNIpyVqoBr+LuAmLxsGSeeFr1ycmtc7
         EHx6vwvKIcoKdcxqMMST3C2N5NHMkVPjurlal97gR8TVOd50wCnN0Di0f+ylUWjBZRwh
         P+6iHnei8eUMYM/CMo4d8+iRaEN7BYQ+nY4NV2WaUnHkGnAht5y7goP7aPJAlwWN2WSS
         Oy/mAMMiBKW43tM010n5keho6g6hBcpOaeJH8XNGJA1hYJanoGSbrQ70NgTbRAIPVrbA
         VZWG/n+n4mp8ZlTXmLl/RaCNL2fmIAUk/uxa5ijJSPRfd56M6Mq7vtZF9wSP1wKqid0b
         we6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783622760; x=1784227560;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QPf+9G20chtvWfhmlbsBAcrLn3a4nXZU9b8fTPixMo0=;
        b=CaTrhRf8lVIzoZDZSQl7hrX9EudiupgYxj3IvE11BLw4tbwL7ZfFmPwhxPOjh6KNMo
         n3Wb0XjEH4TKl5kyKFCOu75UEXgNZCgaOdJ9Xqt1tjtAWVLM/zOd6k1IeDfeZ5sfhwFQ
         Rs/SYX9HscHiQYxFZC/WV8Xc0PdwQFSc6LDjjFsCa8LuWNKDfN3RlMOwKTFAcVOB8pOF
         L+464H2tGygco3GZSJyySqmhCiE2zbV+j3Yh+gsi069UFcGn1zxCZeHYLLp0VvTBlw09
         v/E4UIewBbJXWdvb57rYgTyVe0rqJQ6I4Ew256Jv+U6kioUSd253K/1t2dznTQYuoTik
         H6/A==
X-Forwarded-Encrypted: i=1; AHgh+Rqd+hDlLUylEAwCGOXl2rwV9vZdR8scPgld63J0cellYI71/KgTiRCvzYVSjWWTn0E105XP5nw2TQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxSMqfeZYwS1SOciNQedOEDZ574a6md5UZdToci/6fRpwb8vkjV
	PmKtj+4NpKqM1uMZzccrnfK2EoP4uq32LHNgL5ytzw8VXsf7d2B12OsI
X-Gm-Gg: AfdE7cn51/QHDM9IwfsevLqfHga7bpLJV/2FqQ12x+/fIqtHtSbnKzjAZea/1OswbGj
	MeyZkb2iM/1CEX4YgveZhJJIlmapXYrKKDV7y3o3YUsg5mfuO3flkg/UMuPe14wie1UD2nPpMu6
	g+hWauNv0sx/IZAy6bRwm23DeO1ss06R6r2Cf4GCxYxnbwEeyMEORvLLMn6ORl7bjd154FBZj9j
	IxLZIMDdhsumAiUavYJXCxcdoutpSoayTqi/Ngd41mZQMloqHy+Wx28uq82YCoYsmhLwyQk1Wh+
	eyTJo8dQ5H1vwEBPvN+1kQlKjHvaTm/eIjk/JEe2LWEK0qxD7pbeFaizYn9Vyw70qTwwei+MhM8
	wu5hZbPrtTYui9N86u1gtnDLsPFtlB0MNnoHhXk/mEE97SpyMJqXpSs4oTctOv9cg6aIsf6XKWj
	XfCMZ2Uo1frg2zvYrIN3QnE4AXPz1LzwXulD4QdOjwsJXjaCveeyI/JZ1zZxAt
X-Received: by 2002:a05:6a20:430b:b0:3bf:ae43:4d26 with SMTP id adf61e73a8af0-3c0bcf49cacmr9958974637.5.1783622760038;
        Thu, 09 Jul 2026 11:46:00 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f596asm33384231eec.2.2026.07.09.11.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:45:59 -0700 (PDT)
Date: Fri, 10 Jul 2026 00:15:39 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
	Jinjie Ruan <ruanjinjie@huawei.com>, Andy Lutomirski <luto@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Guo Ren <guoren@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Helge Deller <deller@gmx.de>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Weinberger <richard@nod.at>, 
	Chris Zankel <chris@zankel.net>, linux-arm-kernel@lists.infradead.org, 
	linux-alpha@vger.kernel.org, linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-um@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, 
	Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>, Michal Simek <monstr@monstr.eu>, 
	Dinh Nguyen <dinguyen@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, linux-snps-arc@lists.infradead.org, 
	linux-hexagon@vger.kernel.org, linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-arch@vger.kernel.org, Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [patch 08/18] x86/syscall: Use
 [syscall_]enter_from_user_mode_randomize_stack()
Message-ID: <ak_sOt1kr8nrVCju@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.079478122@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707190254.079478122@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260709_114600_908498_A9EC2622 
X-CRM114-Status: GOOD (  23.90  )
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

On Tue, Jul 07, 2026 at 09:06:27PM +0200, Thomas Gleixner wrote:
> These functions integrate the stack randomization.
> 
> syscall_enter_from_user_mode_randomize_stack() has the advantage that the
> randomization happens early right after enter_from_user_mode().
> 
> In both cases also the overhead of get/put_cpu_var() in
> add_random_kstack_offset() is avoided.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: x86@kernel.org
> ---
>  arch/x86/entry/syscall_32.c         |   19 +++++--------------
>  arch/x86/entry/syscall_64.c         |    3 +--
>  arch/x86/include/asm/entry-common.h |    1 -
>  3 files changed, 6 insertions(+), 17 deletions(-)
> 
> --- a/arch/x86/entry/syscall_32.c
> +++ b/arch/x86/entry/syscall_32.c
> @@ -142,10 +142,9 @@ static __always_inline bool int80_is_ext
>  	 * int80_is_external() below which calls into the APIC driver.
>  	 * Identical for soft and external interrupts.
>  	 */
> -	enter_from_user_mode(regs);
> +	enter_from_user_mode_randomize_stack(regs);
>  
>  	instrumentation_begin();
> -	add_random_kstack_offset();
>  
>  	/* Validate that this is a soft interrupt to the extent possible */
>  	if (unlikely(int80_is_external()))
> @@ -210,11 +209,9 @@ DEFINE_FREDENTRY_RAW(int80_emulation)
>  {
>  	int nr;
>  
> -	enter_from_user_mode(regs);
> +	enter_from_user_mode_randomize_stack(regs);
>  
>  	instrumentation_begin();
> -	add_random_kstack_offset();
> -
>  	/*
>  	 * FRED pushed 0 into regs::orig_ax and regs::ax contains the
>  	 * syscall number.
> @@ -252,10 +249,10 @@ DEFINE_FREDENTRY_RAW(int80_emulation)
>  	 * orig_ax, the int return value truncates it. This matches
>  	 * the semantics of syscall_get_nr().
>  	 */
> -	nr = syscall_enter_from_user_mode(regs, nr);
> +	nr = syscall_enter_from_user_mode_randomize_stack(regs, nr);
> +
>  	instrumentation_begin();
>  
> -	add_random_kstack_offset();
>  	do_syscall_32_irqs_on(regs, nr);
>  
>  	instrumentation_end();
> @@ -268,15 +265,9 @@ static noinstr bool __do_fast_syscall_32
>  	int nr = syscall_32_enter(regs);
>  	int res;
>  
> -	/*
> -	 * This cannot use syscall_enter_from_user_mode() as it has to
> -	 * fetch EBP before invoking any of the syscall entry work
> -	 * functions.
> -	 */
> -	enter_from_user_mode(regs);
> +	enter_from_user_mode_randomize_stack(regs);
>  
>  	instrumentation_begin();
> -	add_random_kstack_offset();
>  	local_irq_enable();
>  	/* Fetch EBP from where the vDSO stashed it. */
>  	if (IS_ENABLED(CONFIG_X86_64)) {
> --- a/arch/x86/entry/syscall_64.c
> +++ b/arch/x86/entry/syscall_64.c
> @@ -86,10 +86,9 @@ static __always_inline bool do_syscall_x
>  /* Returns true to return using SYSRET, or false to use IRET */
>  __visible noinstr bool do_syscall_64(struct pt_regs *regs, int nr)
>  {
> -	nr = syscall_enter_from_user_mode(regs, nr);
> +	nr = syscall_enter_from_user_mode_randomize_stack(regs, nr);
>  
>  	instrumentation_begin();
> -	add_random_kstack_offset();
>  
>  	if (!do_syscall_x64(regs, nr) && !do_syscall_x32(regs, nr) && nr != -1) {
>  		/* Invalid system call, but still a system call. */
> --- a/arch/x86/include/asm/entry-common.h
> +++ b/arch/x86/include/asm/entry-common.h
> @@ -2,7 +2,6 @@
>  #ifndef _ASM_X86_ENTRY_COMMON_H
>  #define _ASM_X86_ENTRY_COMMON_H
>  
> -#include <linux/randomize_kstack.h>
>  #include <linux/user-return-notifier.h>
>  
>  #include <asm/nospec-branch.h>
> 
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

