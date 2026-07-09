Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9FC7C44507
	for <linux-um@archiver.kernel.org>; Thu,  9 Jul 2026 18:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yghYN6q10g6FdWlsVt4/TtDo8QYt/j/TS6a9b2++LOM=; b=QI2y2sJLZ2vdXU7gv+tuJCoe2b
	70ISMNh2R2TJ/pfE+7zym8BNoZxswbeLfndIr32/HUgE8VWCgs1J6jEayvA/f61iuLaIgwK+rBY0M
	uqbQukPSONDgmZrGWN7RMlHszNOiexIQagdsbesT2US0cDFjMpJbAy2jE4EaNGmWr5r61UmqMBTXx
	yqUxPStoxwtQypHccy3NWTH2+mvoU+XtRCWyzFuwSgwNwxkTOSsehw/zMLCtq2GIMNqYGtNk2F+QL
	gtVLszh1U3AbFzUFofCZ/tpz3izkwB2/qFrqud/qy3sKLe2TvSEBwQzyShObULp+QDk3mLQ1s3x+u
	CgnTT3hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whta9-00000003ELh-40WU;
	Thu, 09 Jul 2026 18:34:45 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whta5-00000003EJe-4C2P
	for linux-um@lists.infradead.org;
	Thu, 09 Jul 2026 18:34:44 +0000
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-380cda7f00cso245904a91.0
        for <linux-um@lists.infradead.org>; Thu, 09 Jul 2026 11:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783622081; x=1784226881; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yghYN6q10g6FdWlsVt4/TtDo8QYt/j/TS6a9b2++LOM=;
        b=pNEVjQZ6RAMv6XHtR22T+oX3hwvxlHEpKcDTeF6Oj0VrYICFKteR3OCeo9yqVMvQ01
         wsjOni2cRpwfdZWGngVQ3ymiX+QIFmbGtR5C7lofDBeY9khs40+t/de+E8k2/GSnosWq
         jyLZ4pphXSW9nzEgSY8uR8WSQzGoFnYSHKy6GZ3pcmu+JwihystTZLR3oX0HhfiBMiKQ
         kzGwWMUDuysx8YF27mqs3gDEqkoNJ54norBulQ53EVem3dvQYAciuO81E8ldjJ4QHC0G
         YuU7NqcaPANxRZGgHMv79CMKT7Zf7RzfdJNe/B1J3oNClmxB01wx43+lTHhj9Furnkfd
         avMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783622081; x=1784226881;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yghYN6q10g6FdWlsVt4/TtDo8QYt/j/TS6a9b2++LOM=;
        b=q2N88NEqxYmgrayMs3m+16laz8rLT87jZNOJobDfR/xZw7UbVWfUXRX6GUnOqm1OT3
         qYkK0Du0QguEt7a0Y1ULppCogmCSb2Xila3Ph3gz3nQpdwz4GZoAU6tnufhAcuuEFIjV
         c4EDgX3tKaUpcjGa+M/8qQYDvx41kA2DuZdVcmeFcotjcCBzAa1XkyAdH+Xf2s26MZV7
         N3/UGvJnfq5+Uo9jtSrilgjkRMk1NDo9P+KMorlLAMTYrpLqeF0Ey9NGfCCnZBDll916
         bAFEeXpWBgla1t55WfxWgkLvUgzSgjuM8VrZxoy1Z7bWw+KhdyXgEtpyAFcJaN2WBGx6
         2Q0Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro3xmNA676YxlTr4Vd4E619wUsEMUa5u9KtpPJF4idw0ZfhqDjF4AAX+rj40JUgkVdEW3rtexoN6Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YzhTKLzljz4Qdr+VBccVh8fOVE7EYDk9H0Rx9YHpjAwFm1+0nj4
	27mZLV4k7GkM9KtziD3vXKt7UfzcSrzcE7uMFadP6bZvRUBrt3H+1jlf
X-Gm-Gg: AfdE7cnMF5tFC+NqWOAuWTmu+6kyMdE/uOg5npBnq7Iy/C8gGHjAmVMo49Ii+HGdQaw
	RJpHR5GYIOwPMcTbx/Mkf/g24fjN2ROBZ1Zi1VQgMlUAXgGQ+KEMvfb2jDIM19bsm3cHGeO2E2W
	IWKFQ7nrUQ79V/qNaVuXYIPreinzRcNluElIyZBF1RkdXQtMwnFRTMd/dpwZS3PniI/N3WPTbfo
	8SMQybNMgEpXMzuSjgI+2W555LCOccWuwUBem4OxynVo+RjZq6LezYnYGacIHpZbqRudqNZp0m/
	mo91KI5mpyee62tuRwCqvzj0OwY1e54ORMpbXBRXmq0o3Rhh/NRjgTV1jwwKmkGFyA+ieFjf7Kl
	x0VihkBJpx/4vU510rbJ4lfyApzh6HSKVJFfhMXj6kgLIRkUTp2eURauoAKZ47DIcQ/p8Vmxukn
	xRKviooFMsRE8SRnhuTYbWkMO0P8lqz8/41eHXPdLsCTmt+B7RRjyPEjqE6rL4
X-Received: by 2002:a17:90b:2752:b0:37e:10d1:c05b with SMTP id 98e67ed59e1d1-389417e4858mr8140301a91.22.1783622081049;
        Thu, 09 Jul 2026 11:34:41 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311a6115e61sm11123455eec.22.2026.07.09.11.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:34:40 -0700 (PDT)
Date: Fri, 10 Jul 2026 00:04:21 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	linux-riscv@lists.infradead.org, Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, 
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
Subject: Re: [patch 02/18] randomize_kstack: Provide
 add_random_kstack_offset_irqsoff()
Message-ID: <ak_piRRvfiMc9m7N@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190253.768842729@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707190253.768842729@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260709_113442_078236_F5408464 
X-CRM114-Status: GOOD (  19.46  )
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

On Tue, Jul 07, 2026 at 09:06:02PM +0200, Thomas Gleixner wrote:
> add_random_kstack_offset() uses get/put_cpu_var() which is pointless
> overhead when it is invoked from low level entry code with interrupts
> disabled.
> 
> Provide a irqsoff() variant, which avoids that.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Kees Cook <kees@kernel.org>
> ---
>  include/linux/randomize_kstack.h |   19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> --- a/include/linux/randomize_kstack.h
> +++ b/include/linux/randomize_kstack.h
> @@ -77,8 +77,27 @@ static __always_inline u32 get_kstack_of
>  	}								\
>  } while (0)
>  
> +/**
> + * add_random_kstack_offset_irqsoff - Increase stack utilization by a random offset.
> + *
> + * This should be used in the syscall entry path after user registers have been
> + * stored to the stack. Interrupts must be still disabled.
> + */
> +#define add_random_kstack_offset_irqsoff()					\
> +do {										\
> +	lockdep_assert_irqs_disabled();						\
> +	if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,		\
> +				&randomize_kstack_offset)) {			\
> +		u32 offset = prandom_u32_state(raw_cpu_ptr(&kstack_rnd_state));	\
> +		u8 *ptr = __kstack_alloca(KSTACK_OFFSET_MAX(offset));		\
> +		/* Keep allocation even after "ptr" loses scope. */		\
> +		asm volatile("" :: "r"(ptr) : "memory");			\
> +	}									\
> +} while (0)
> +
>  #else /* CONFIG_RANDOMIZE_KSTACK_OFFSET */
>  #define add_random_kstack_offset()		do { } while (0)
> +#define add_random_kstack_offset_irqsoff()	do { } while (0)
>  #endif /* CONFIG_RANDOMIZE_KSTACK_OFFSET */
>  
>  #endif
> 
LGTM.

Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> 
> _______________________________________________
> linux-snps-arc mailing list
> linux-snps-arc@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-snps-arc

