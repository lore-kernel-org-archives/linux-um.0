Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA277E7716D
	for <linux-um@archiver.kernel.org>; Thu,  5 Dec 2024 14:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l/cJmWwzgzKQGtfhq9nilJ6NLcmrJ45MxDHb9kRPQBs=; b=YfZTexnu+R6VcTwX5pTEpVhkX6
	BLSg8duAbmyW1thWitSfnpxSBu65gxdRKI+yRk4FWF5WmSJjboj2ZacF+tpEk6a1m1SiXtfRVuN4i
	IIhKfFO7k0d9KiLzaj1FLZCBSWiC7ncfVeXnEmiI2aChg0FR8uDil5q4CNCReArctFEJo9cgbQT7P
	yAAgqwr6ARRc41LhHD4oemv4o1S/eBCdBIr7abTNjzycbRY3ySyRSHhaEXIyvWXQqgfRblKnKCNhF
	ZNzLnTWDlFbSDWNO0StwrwcTwuD/SzEvih8ZtLK0cp+ArdHwfq4zC+8xXJo6j6zGVIIbLmPtF+PpW
	3bFDoEPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJCRO-0000000GGmL-0cJs;
	Thu, 05 Dec 2024 14:02:50 +0000
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJCLU-0000000GFS0-054y
	for linux-um@lists.infradead.org;
	Thu, 05 Dec 2024 13:56:45 +0000
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-724f41d550cso679061b3a.2
        for <linux-um@lists.infradead.org>; Thu, 05 Dec 2024 05:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733407003; x=1734011803; darn=lists.infradead.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l/cJmWwzgzKQGtfhq9nilJ6NLcmrJ45MxDHb9kRPQBs=;
        b=bdbO/OhcrQcb9VU1jaGod+4YH6raJsjR5mOoyxYhbB4td9IVzIRjkkoWg4VpK/VLOS
         e/0L3XjoLDl6RH306hbnOLcSyMzizqCuVdLo98oWITExGiT8AOaN+7gLTgCnRg/1KCXh
         ihrjfT/25fL/WLvUo91JnLQj8iKjKEdcAGVjYzOQd68NRGIm8SmvOpQEgNIwL67feD4+
         MZ5LlxfYOf2M8zF9mXeEmjmWF6cUHDQccPbWiRWJz5Chn3DMEcKng0Ut4l6DJCJvM4ZG
         jxC2wYp9dcwFsNi/7hr7MMeQB8NYijgA6KxCVhvLxQD/004fEn0LN0OYAOa3R/0Uvh9O
         5mzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733407003; x=1734011803;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/cJmWwzgzKQGtfhq9nilJ6NLcmrJ45MxDHb9kRPQBs=;
        b=dyzWwt2ljmnWvc0o6qMai1dk0+4ndAKc1ZAf0gh9BYma6fCJk6ysaDAlNomFkyzj8B
         sVjyAMy1s7RojKqMHeEx421SWrWr3D4ZiCWHR9lMm/1THl7R8QXFbFWD4/aieO8FFqbW
         DEkFbQSvl/sgExOVsrEVlPq3NwLJK9sqeTnMTYyC/WAdDgstyej8dJyHeEd2vlMqi6nn
         HuIEdkK0T6H1W+Cw3wGHEfmtfNAN9B+mXX7TU2vzUaz67gZVeScBjSmYcG2MhBHtKeBQ
         HwYwDgggrPag6XBgYMU822kyRNMDbg0XgyRqPBjLDd96vdCyMn0Om5vB4WIVdFepWRCb
         sXSA==
X-Gm-Message-State: AOJu0YzbWpSb/6nzO8QwuRwUN1UynCtWFxHCJGHtqDOSRex07xbWK0C2
	0qoiYFV4Z2GXWRn0v0Q09GEFrp6FB+gRAufI2SchlZ5a084DMJlhYrdcaA==
X-Gm-Gg: ASbGncuuquZV3ROji166c+09KkmTRfcY9Od3AEt2ZNajgkpRM30DbN9VrDsyzMphKRy
	XEd36swQot40V/t7VzfO2n8orc5xnrEVCPlu/39YHmbmnn9iM4Q2FI9yng3t9IdzCo2fvWyA4wT
	whUV/wv72kXezG9oyBHmE+0wzUPxlV9/clxJOMsvjXuuRk1zi7x2e5EIrt4bfkSm++x6VbfWwak
	AJUN1G2NvnRLDf1sQGw0YnzKo8AA3tzadhL+fd52I+HILawsy3uxQ0fqXYztEeZlIsmuOsyrrbP
	tGOhMlY2Q0vDiREv6mmGRuSWBuyHBnKkRbtO
X-Google-Smtp-Source: AGHT+IGG8X7t4oPLPzrsoxP+rCvnt8txq0w5nC6aWURf3oCECgy8pCjN85+bwpYqVN8R5cJbvv5K3A==
X-Received: by 2002:a05:6a00:1703:b0:724:62b3:58da with SMTP id d2e1a72fcca58-7257fa59b65mr13031849b3a.6.1733407002901;
        Thu, 05 Dec 2024 05:56:42 -0800 (PST)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a2cc6b99sm1245819b3a.176.2024.12.05.05.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 05:56:41 -0800 (PST)
Date: Thu, 05 Dec 2024 22:56:39 +0900
Message-ID: <m21pymw7vs.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: Re: [PATCH v3 07/13] x86/um: nommu: process/thread handling
In-Reply-To: <2085ffbd1d5b0a908f26d0ec38a6d8719db5111c.camel@sipsolutions.net>
References: <cover.1733199769.git.thehajime@gmail.com>
	<7e909114324f92d37dbe0a2f58443cf5ba606c6d.1733199769.git.thehajime@gmail.com>
	<2085ffbd1d5b0a908f26d0ec38a6d8719db5111c.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241205_055644_093195_F5676D44 
X-CRM114-Status: GOOD (  35.17  )
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


On Thu, 05 Dec 2024 01:50:07 +0900,
Johannes Berg wrote:
> 
> On Tue, 2024-12-03 at 13:23 +0900, Hajime Tazaki wrote:
> > 
> > +++ b/arch/um/kernel/process.c
> > @@ -117,13 +117,17 @@ void new_thread_handler(void)
> >  	 * callback returns only if the kernel thread execs a process
> >  	 */
> >  	fn(arg);
> > +#ifndef CONFIG_MMU
> > +	arch_switch_to(current);
> > +#endif
> >  	userspace(&current->thread.regs.regs);
> 
> that doesn't make sense, arch_switch_to() does nothing anyway on 64-bit

makes sense.  will fix it.

I added fs register record code to arch_switch_to() for nommu as we
don't use ptrace so, arch_switch_to() does the job in 64bit, but for
the kernel thread, we don't have to so, will remove it.

> >  /* Called magically, see new_thread_handler above */
> >  static void fork_handler(void)
> >  {
> > -	schedule_tail(current->thread.prev_sched);
> > +	if (current->thread.prev_sched)
> > +		schedule_tail(current->thread.prev_sched);
> 
> Why is that NULL on nommu?

During the past series, the pointer was sometimes NULL on random
conditions, but I couldn't reproduce it anymore..

I'll revert it until I could reproduce it.

> > @@ -134,6 +138,33 @@ static void fork_handler(void)
> >  
> >  	current->thread.prev_sched = NULL;
> >  
> > +#ifndef CONFIG_MMU
> 
> again, don't sprinkle ifdefs around the C code files - make inlines in a
> header file or something

will revert it.

> > +	/*
> > +	 * child of vfork(2) comes here.
> > +	 * clone(2) also enters here but doesn't need to advance the %rsp.
> > +	 *
> > +	 * This fork can only come from libc's vfork, which
> > +	 * does this:
> > +	 *	popq %%rdx;
> > +	 *	call *%rax; // zpoline => __kernel_vsyscall
> > +	 *	pushq %%rdx;
> 
> or maybe not zpoline ... so maybe need to update this

will do it.

> > +++ b/arch/um/os-Linux/skas/process.c
> > @@ -144,6 +144,7 @@ void wait_stub_done(int pid)
> >  
> >  extern unsigned long current_stub_stack(void);
> >  
> > +#ifdef CONFIG_MMU
> 
> I'll stop commenting on ifdef sprinkling :)

ditto.

> > +++ b/arch/x86/um/asm/processor.h
> > @@ -38,6 +38,18 @@ static __always_inline void cpu_relax(void)
> >  
> >  #define task_pt_regs(t) (&(t)->thread.regs)
> >  
> > +#ifndef CONFIG_MMU
> > +#define task_top_of_stack(task) \
> > +({									\
> > +	unsigned long __ptr = (unsigned long)task->stack;	\
> > +	__ptr += THREAD_SIZE;			\
> > +	__ptr;					\
> > +})
> > +
> > +extern long current_top_of_stack;
> > +extern long current_ptregs;
> > +#endif
> 
> no need for "extern".
> 
> you only use all that once, does it need to be here?

sorry, I don't understand both of these comments; could you care to
elaborate ?

> > +
> >  #include <asm/processor-generic.h>
> >  
> >  #endif
> > diff --git a/arch/x86/um/do_syscall_64.c b/arch/x86/um/do_syscall_64.c
> > index 5d0fa83e7fdc..ca468caff729 100644
> > --- a/arch/x86/um/do_syscall_64.c
> > +++ b/arch/x86/um/do_syscall_64.c
> > @@ -1,14 +1,43 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  
> > +//#define DEBUG 1
> 
> please remove

yes, will do it.

> > +/*
> > + * save/restore the return address stored in the stack, as the child overwrites
> > + * the contents after returning to userspace (i.e., by push %rdx).
> > + *
> > + * see the detail in fork_handler().
> > + */
> > +static void *vfork_save_stack(void)
> > +{
> > +	unsigned char *stack_copy;
> > +
> > +	stack_copy = kzalloc(8, GFP_KERNEL);
> 
> Using a heap allocation to track 8 bytes, when the pointer to the
> allocation is already 8 bytes (you're on 64-bit) seems ... rather
> wasteful?
> 
> I also don't see you ever free it? Restore probably should, but anyway,
> it shouldn't exist.

oops, my bad...
indeed the memory is never freed.

I'll update this part by not using heap allocation, but instead with
a variable.

-- Hajime


