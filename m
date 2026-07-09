Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B619C44506
	for <linux-um@archiver.kernel.org>; Thu,  9 Jul 2026 18:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0SnVDTLPnMBjkQSM4oCN+URozdUIH28ywJdKUrWn7bI=; b=5B1opbVqdqb9fH5RrigF+QCjtD
	GTn9N7avmwVlFf10jEgSkOO2O2glFIiUKC/UtjWES4j3PX1KgAJM6u34HTze9olbOAqU+gF1ANBCq
	pJYngNtXi9OEGIlv+CHB++37WFroN6Fn0jRz4pplzT+FkACtmwIu2BKkBR/akzThwuMcCoQA04uGH
	JmBpSEYjX/vW0HBW1pOxOBeV7SgVnocnETgO7NuzA9hQtAw90x6K4ipJsqowmNBeCjV2MQtXfI+mo
	8HBCYelNBJ7tafXVrVkVX8of1zdi6IoC6tcipaAIH0y2pKWcmYp+/z/AynZpxIZ5l4gruHMhIbjMY
	rXA4VpPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whtj0-00000003Ii5-3rIr;
	Thu, 09 Jul 2026 18:43:54 +0000
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whtiz-00000003IgC-0OuC
	for linux-um@lists.infradead.org;
	Thu, 09 Jul 2026 18:43:54 +0000
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-37ff8e0ad0fso248792a91.2
        for <linux-um@lists.infradead.org>; Thu, 09 Jul 2026 11:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783622632; x=1784227432; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0SnVDTLPnMBjkQSM4oCN+URozdUIH28ywJdKUrWn7bI=;
        b=bHWgjf5RFP/KZwvHAaeX8WBMDgJz4Ci/1STMPleQs4se5V+Oc2SgzTVmFw8JgLRpnF
         Xe56DEWEJQIy/v4H7DAz79MYgFzWXlp9uiPoOWrO6wWtx97+YSkcGoGzToDy9laEsyWV
         GMcxyodeSDoCXdXIrapHn2pqL7eB3VCnezFLJ2czQRKOITPseLkjD1CdY+7AycNdK4x4
         o/YGpHLorLvxAKlxUwIaPh2cDECjRH6iR1uBP+lG1TCr+mbsCpZc8Yz8uq7cab8KRiz/
         MiifIW8noiB3zneWq1nDHvNz2s4tXPU4pYCWvkWOra59PlvlbJlJ/yUpJdGtmGytP3us
         WChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783622632; x=1784227432;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0SnVDTLPnMBjkQSM4oCN+URozdUIH28ywJdKUrWn7bI=;
        b=WhXLYjMcjPYwDpf9AqP86C03+dcLNK4YOd8CYaqfkAvsaKvjMRwyKRK4ZW+rp+D9JV
         NIrXLY+XGHYbZ1rPdNv+y1X9bX4LvVSKFNh6GtY4lrMig2Qx0iHT6yA1PKgNod9Jk4s1
         48FND7lGDiLPJGclkiQOwaqqVoEUV2u3AcO/FINyqn6uFRlt+rzKYDRfJOS8vCYZON9K
         aSA+DSLHULNGsAUQba7Tejumdo3Ur0FX4gQ/XSUqPzdud9hQsNNNvaDMVPFMW5DoThRU
         LEMjJs0Q5rzotc3LGjC1hGIR4RV7HQemXPwbuBlKJe0Gk3hlzV12x428GKEOotCUSoE4
         WUqQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp9339cZOFAsg3a5u/AySGMEgENvVW4QQ3uirYLbobmSN3aed7l26h79gnzQ3DbNb7xvi+tpc+8GQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywumv/jutVt5nnWPTJX6z3JTBBa6AWHhtmDY5eXtF/hmZlOno87
	zDsfMiCeCEJ54Md6gx2VsOKoOEsPb0iCVEvw5R4tFe/F98QgLBUDuTKD
X-Gm-Gg: AfdE7ckdUypl4+jbGIBkkgO5gIriZCIZmts3trS2pyVdCGC5704aAX1CI7ifX3Ee1+6
	xI1k9toqnCt0CZ+hui/CxNg+/3pBEJVxTCqidg4Mz8dRDR6upMrUL4D5Fz5BxJhDo3PAmOpB2vV
	YHIdCtiWQQhsc2s5nKcpSyrVEo2TIQoRRL8rgp5ZRYCHzBWVfl/CH/UW6KlAREiT2ax2UK13d3x
	J6Avu7HwNzgid4ELdiY5eBI65s0T6S/O+4lPZ2olBhRep9TGu07qaFe80dmUAoJTBcakAdKG6cF
	orugSXeWewV1UKIAhG2XM+ifDXSgjcX5CCLDKpB8z7zxEKkuZ0eHigWO666gD2ZAEskrVrjW6wd
	SFqW9KnozJWmjLMrpdLB05+EPSprQ/dMS6L9Dv0VlZBB5feFbyEtigbW6oj9mc/BlMLmQlZD69P
	UoN1ZfAXCwT73IMA3lBJN03Ku/KAzFSDcUrAsxzhYfSsX9TBBNEURWxIBRdElX
X-Received: by 2002:a17:90b:564d:b0:387:e0db:3d90 with SMTP id 98e67ed59e1d1-38943d404dfmr8538131a91.43.1783622632431;
        Thu, 09 Jul 2026 11:43:52 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174accb0esm35673867eec.30.2026.07.09.11.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:43:52 -0700 (PDT)
Date: Fri, 10 Jul 2026 00:13:32 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, x86@kernel.org, 
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
Subject: Re: [patch 07/18] s390/syscall: Use
 enter_from_user_mode_randomize_stack()
Message-ID: <ak_rx2gFCLtG-Qpy@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.030598804@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707190254.030598804@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260709_114353_135786_F6FD691F 
X-CRM114-Status: GOOD (  15.25  )
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

On Tue, Jul 07, 2026 at 09:06:23PM +0200, Thomas Gleixner wrote:
> enter_from_user_mode_randomize_stack() replaces enter_from_user_mode() and
> the subsequent invocation of add_random_kstack_offset_irqsoff().
> 
> As a bonus this avoids the overhead of get/put_cpu_var() in
> add_random_kstack_offset().
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> ---
>  arch/s390/kernel/syscall.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/arch/s390/kernel/syscall.c
> +++ b/arch/s390/kernel/syscall.c
> @@ -97,8 +97,8 @@ void noinstr __do_syscall(struct pt_regs
>  {
>  	unsigned long nr;
>  
> -	enter_from_user_mode(regs);
> -	add_random_kstack_offset();
> +	enter_from_user_mode_randomize_stack(regs);
> +
>  	regs->psw = get_lowcore()->svc_old_psw;
>  	regs->int_code = get_lowcore()->svc_int_code;
>  	update_timer_sys();
> 
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

