Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 151A0C44507
	for <linux-um@archiver.kernel.org>; Thu,  9 Jul 2026 18:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+EsurZOWBA/vTxJ4VlwckFkTmsLoBwFFgPdTWboTXPw=; b=LXyHcD8EQVQ3KoDAxBSMV+m+yW
	936Q1INKnjV/5JOHhGPQ4HE4FM5D7GSmBUQ+jr0f6QsL3RLfsWqWPe88eJjsszoMLelAzf2sOlQaZ
	ZG1mS98ptqg0p6PQeGr2p8BsU6DQe2fhBOoRcqu2CeNvOd534rn5cFM2KCNrk87ywIkQfo4bBrogQ
	TzsvodiepR0HsuGxqSPxFuMOAKAw1+C3GA+r1pLqscLesbjDIj1Kq3zBQG2YaxgQ7BIocK1D80HFb
	9WrJ6o32ebGRm1r9B6iekjRUjf3vyPz6NkSx1idI2MOOst5/QINoAEv3GYLFfkMhkT+3sKcDPuMPE
	dETCwN9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whtq3-00000003K33-13QF;
	Thu, 09 Jul 2026 18:51:11 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whtpz-00000003K1h-2jRY
	for linux-um@lists.infradead.org;
	Thu, 09 Jul 2026 18:51:09 +0000
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-388b404ea89so195439a91.0
        for <linux-um@lists.infradead.org>; Thu, 09 Jul 2026 11:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783623067; x=1784227867; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+EsurZOWBA/vTxJ4VlwckFkTmsLoBwFFgPdTWboTXPw=;
        b=q9yNvxRtFzaUbI6BlxC71WBs2h6nncI7vkEWjE0WzhJolBOIaV1oxfv6+XWO081Xd1
         K8nETI5ll4E6P3kXTvyTsJ5VpWftUziKChRDFCWqv0W9eWux/iBz79MJw/vNVcl17CKK
         gJN8FZaS6mZ/RTLh3T7uXCI6RUMQ+dLqYml3NUNs1pVbfw+7zQSNSh/vqTwqG+uGgu7S
         s11rE+0JOCkJm9PY8En0BXpV6eBL58WgWki9ygj+6ams0nyJr6CvkHXuLeA6VymbJd9U
         iUGDbXHuvSY4E5K6t6hNbPrJdkobLElLZv6pwor7RTD2UDBaSKsOLYNd92Z4YNaHhXEB
         Uunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783623067; x=1784227867;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+EsurZOWBA/vTxJ4VlwckFkTmsLoBwFFgPdTWboTXPw=;
        b=DXwCx4kvLais/OnHmTSb9cVLCJwb8RallD6R1RBKE/a4NfFgfjyhsAo7ZuFzxrvq6Z
         0PHqx3dmqPHIz6UKcas6GZMcK0syzgbeOak9/68kdrf/CWwN+r7fXfzZVd1ODP+LtKQu
         3h02w8tAzc7PrJx4kDlNj6fgszvDM1alzNdTi780vLXDkQpQ82ZaNYU1qO3ngT1qJDMh
         eFe2EzIsWAW17OVdGCJbCY8XPKTCLc88mDk8h9OujnpYz2AYH+FUuQxQb7G+GUDR/nMv
         /xx7ILIe0/Dqzgi0egP+hBFYTGmBczueiUstRctRjaoD/iQn8dM3IaTMpUu5Ry8EYInv
         /29w==
X-Forwarded-Encrypted: i=1; AHgh+Rq0hunJQTOsJk9Ms5WHePNM8rSOx/LI9Wc4cYCG3N22hifjW+D1vCcBFuSCeFa5Kz48+VDqh8nQeA==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywg3Vloi+4zmSBiMu5QZhBP0hjZ22Rr/yWW2dAFvh/K7khUiGf0
	v/uxAIwnKaTAeAZ+RKvFpqEqYM3H+eKroYEzfx6AHd8Xix5JsysMIBx6
X-Gm-Gg: AfdE7cmSN32tDGy6sgRTiD0usKrRQ/JyLjvwPtrw+PM+ozjmi+ib1YqNkA2nE5Zy9xf
	KZL3KWkQxqn2g9aYLjnN24K4UGkLlCHjV9Q2hGSCEd5XN/u0DIsJg666ZqrMv80xuGIOR4ZmtZh
	QIIG/WjDxxJvYuFvlS7+2xmQq8FVXSdcbm/uQId8FG/mSdNA5eGvuT1+3Sy2v8KmxUM8lXVWipy
	Jd/mXnbA0EQ0tgVKjO/1U3dXi33b01sY75bxq0SFI6c970/v2N8ByTDpQQx2lTPvk/mEtk4OKi0
	IjqBecDWBIxHQG0GJlKNNeNUUdNsByux5q4bI1D/tJL5Ios2A5ReaHXsKm3pBBMwEpkCGdMdVxn
	zznqLTSQ7yCPeTlLzZq1/fjnfTa0g1WZXo/AVO6ZUkEKObwSadrJE1Gs9kSWYRXsy3EWME1pvv3
	k5lSTGpjydng0i4Y9jebDvJlOPviQwn6wceiBeljsEWGJ+tZg05W9asjLXrj4x
X-Received: by 2002:a17:90b:3d86:b0:36a:caf2:3815 with SMTP id 98e67ed59e1d1-38d15876f4amr425299a91.15.1783623066680;
        Thu, 09 Jul 2026 11:51:06 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f596asm33415688eec.2.2026.07.09.11.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:51:05 -0700 (PDT)
Date: Fri, 10 Jul 2026 00:20:46 +0530
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
Subject: Re: [patch 10/18] entry: Use syscall number instead of rereading it
Message-ID: <ak_tgBEhNxX5m700@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.181086755@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707190254.181086755@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260709_115107_687791_A7BDB50D 
X-CRM114-Status: GOOD (  16.72  )
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

On Tue, Jul 07, 2026 at 09:06:36PM +0200, Thomas Gleixner wrote:
> rseq_syscall_enter_work() is invoked before the syscall number can be
> modified. So there is no point in rereading it from pt_regs.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> ---
>  include/linux/entry-common.h |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -70,9 +70,10 @@ static inline void syscall_enter_audit(s
>  	}
>  }
>  
> -static __always_inline long syscall_trace_enter(struct pt_regs *regs, unsigned long work)
> +static __always_inline long syscall_trace_enter(struct pt_regs *regs, unsigned long work,
> +						long syscall)
>  {
> -	long syscall, ret = 0;
> +	long ret = 0;
>  
>  	/*
>  	 * Handle Syscall User Dispatch.  This must comes first, since
> @@ -90,7 +91,7 @@ static __always_inline long syscall_trac
>  	 * through hrtimer_interrupt().
>  	 */
>  	if (work & SYSCALL_WORK_SYSCALL_RSEQ_SLICE)
> -		rseq_syscall_enter_work(syscall_get_nr(current, regs));
> +		rseq_syscall_enter_work(syscall);
>  
>  	/* Handle ptrace */
>  	if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)) {
> @@ -145,7 +146,7 @@ static __always_inline long syscall_ente
>  	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
>  
>  	if (work & SYSCALL_WORK_ENTER)
> -		syscall = syscall_trace_enter(regs, work);
> +		syscall = syscall_trace_enter(regs, work, syscall);
>  
>  	return syscall;
>  }
> 
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

