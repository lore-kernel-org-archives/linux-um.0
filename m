Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD69C44501
	for <linux-um@archiver.kernel.org>; Thu,  9 Jul 2026 18:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SzGAEyDF8npliwHJTsZ1x6gPZlMpJ+A+8igDYDtce2g=; b=sxRd6bXTRsZIw5Fle7ce82CjRj
	N82y+q5u3bSM90SPiIB9zJC6h3yMjg+3Y85vuc8gIZRJyA/OQRtSxweHqGzcY+Kd1KeBsr+clN6Ew
	KT44DL6F58qXBdC5fYm6cIu8TjXaR0YKwFlVxAYyjS6H3EvKMr4C5/eWVWkv87nEv7G2vxND8ecY1
	NgBHdxGyd0EW0zwg62iHZJQEd5Or7bJGK5t4W6tNDgKsWiHbISa0UBdiFAtuGyRxsxzIIz0isgE4S
	y328eD1xU6pLpIsbCb8P05QQOYOnPP68avgQLgrKZPmdve9pkElOp29tXLNaaUAgCjHyxD1PDy41c
	JHpzOJqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whti0-00000003HsP-0o4q;
	Thu, 09 Jul 2026 18:42:52 +0000
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whths-00000003His-14Eu
	for linux-um@lists.infradead.org;
	Thu, 09 Jul 2026 18:42:50 +0000
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-c95d0a54ea5so140328a12.0
        for <linux-um@lists.infradead.org>; Thu, 09 Jul 2026 11:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783622563; x=1784227363; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SzGAEyDF8npliwHJTsZ1x6gPZlMpJ+A+8igDYDtce2g=;
        b=afA02kkw5UnVrTwZBdE7oefxSuC19cUxjXlWYdTxtrGdDrl7VweCnAAvFMOdTsYw2a
         +Shpkaqs7HyKqWULZUHdJrjJS7db6RSCOHANcXVCHkvi3zmFgeSCX4ggAIo7o9ILgCLV
         QaBYmy1cqRLBJOGka833C/PJyVEyFiIoza35VQiQRaSsra/quUP8GarsSFqjIGEfdviY
         g/lWOYQ7EWpL7aIa7Eqx1bLiiahbjDLnQaJ99iXa1bpA/vZ5ivULesCNuEJqSktWakVv
         V6pfbsXrEyfE4M/kQm2qLEvX+hWrF4E43hlcr/G7Ykb7l3XY+wBZg3e4efeYqw9FR70B
         m4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783622563; x=1784227363;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SzGAEyDF8npliwHJTsZ1x6gPZlMpJ+A+8igDYDtce2g=;
        b=sMuUZZnHIn4b9ZeuZlmrOFfcW5hiHJkVf1r3w1lX1fYFFxXS2MmW62TIbakVAXqwvV
         b0MFstMPaXrhlTorEtDadLSNFJo0eA4uQxZoZsqlr5ueVUOm9RDxaeufR4yNXDySjtvP
         NoMpAJGwHvYpnSvOfRcr850UK6/T63K0Mn1tSSsvMmceikqZ15HQawn9UEv6PjOzUotr
         XUdQjKR/Okowg/kBhQG5+u6R1La6SLd/+8MLMiQIp69iSeThM4NSXNr4acBfNP2B5GaE
         NP16MfPSBY5oyZhJYfbN5jGhlSn4505mFl/zcihKvqdUkUNhxDc9O17Oap8dv4e1f3Ne
         Xagg==
X-Forwarded-Encrypted: i=1; AHgh+RrGxg+XA7Q/LPPGrduNo3oAJLb4B7+57QToaPuPr7+1ng13+JJ6fRFDppyAui38TqWadG7S1Rj/OA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwB1QJQDwwpFeejzWjCGixwmkj44pUu6sH5rhcDP61SY1/2OXwp
	H9O9dTifPbq0U9NyCxvA0mUbbWLyYl68h59rypkhsw2Vgt70PlY0k0CG
X-Gm-Gg: AfdE7clrAnzU8QdJrl7QzLmAGx5zf5lj8iWjCB9wi06hlNgBGIOIqvLp5sFzlgx0jDx
	81WdGsGEIUD2o7Hd/yfOG/pyYTXbdDOZ843KpV0qmep6HqjaAOwypITynctUPnJ/tA+gpwy3KFB
	3fWgd/x7H0sVUpmO1pr9jeLoutndi3eNDjCxlyeuGmJuxDcqraOeptL9iPXWXfR/VbBkxNJ1gol
	FHm5PaoiFVo+yGrUhqcd+PDFjM4Os4FtTttmBge4ctaw0KY6jwY66O1m4uNfX1BQD2SHL0GX607
	H9BBl5OpkacP0phZDag6qgz8+Lcx+ZrSfIVPa9h9tYTPpxshwN7ojgz0ZOb/EbHCbpSVUVK6EVO
	I8ausqcnixEuxwujxKPuMBoAqCcPHhY1aJGmjyCfoLidS9Ziu2qMG/17SiphtUWp6kbz+rsvciA
	nkjp7ARc36bFziL/WHhfkGXPtehooBWiImUb9Xed/WXevqQ95/1c10fKBALdoC
X-Received: by 2002:a05:6a21:682:b0:3bf:b50f:71bb with SMTP id adf61e73a8af0-3c0bc9acb33mr9806931637.27.1783622563297;
        Thu, 09 Jul 2026 11:42:43 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3118ee6080dsm19491362eec.17.2026.07.09.11.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:42:42 -0700 (PDT)
Date: Fri, 10 Jul 2026 00:12:23 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, 
	x86@kernel.org, Mark Rutland <mark.rutland@arm.com>, 
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
Subject: Re: [patch 06/18] riscv/syscall: Use
 syscall_enter_from_user_mode_randomize_stack()
Message-ID: <ak_rfwwd1OtaQxka@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190253.974626922@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707190253.974626922@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260709_114244_341768_60E7A732 
X-CRM114-Status: GOOD (  16.55  )
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

On Tue, Jul 07, 2026 at 09:06:19PM +0200, Thomas Gleixner wrote:
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
> Cc: Paul Walmsley <pjw@kernel.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: linux-riscv@lists.infradead.org
> ---
>  arch/riscv/kernel/traps.c |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -7,7 +7,6 @@
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/irqflags.h>
> -#include <linux/randomize_kstack.h>
>  #include <linux/sched.h>
>  #include <linux/sched/debug.h>
>  #include <linux/sched/signal.h>
> @@ -333,9 +332,7 @@ void do_trap_ecall_u(struct pt_regs *reg
>  
>  		riscv_v_vstate_discard(regs);
>  
> -		syscall = syscall_enter_from_user_mode(regs, syscall);
> -
> -		add_random_kstack_offset();
> +		syscall = syscall_enter_from_user_mode_randomize_stack(regs, syscall);
>  
>  		if (syscall >= 0 && syscall < NR_syscalls) {
>  			syscall = array_index_nospec(syscall, NR_syscalls);
> 
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

