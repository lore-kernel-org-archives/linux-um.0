Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A1DC83F1A
	for <linux-um@archiver.kernel.org>; Fri, 11 Jul 2025 12:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lgrWzWoGA4T2qMNx99vSTk0N0vEs3RmQ3ckOl6a7eyA=; b=WS7FUIkLsKZifHHEPLe+gAWJNC
	TkD1YveM+TDHvgo2hD30jU3DWlYUMWHZrQoysO82Inv0eXfi31A0crBl7ULpmfxCMvZi7EauLum/u
	XFTg78ALZxTGgufNGi8/tHIRTF4bh6xbws0bAPYWibQHndYApQ3fOv/zT1mKMheC20UfiVXgWSrIo
	wTgsIAfHEO917Cnb4SGX/Yx70cheuu3+zJmW5B39n1gyWDA/GXsJ1mreN5owEssdGyEJ9lYcZzgJZ
	uaL8ycK4pyFzAINxX4RafTVEEqfKpg03vYsrvXyT4ru77Fb0KCK7bf6RKym47wOrkC+nCPEBPsGbv
	E58d9r4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uaCtf-0000000EkHy-41BV;
	Fri, 11 Jul 2025 12:30:35 +0000
Received: from out-171.mta1.migadu.com ([95.215.58.171])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uaCrt-0000000EjwE-0ujB
	for linux-um@lists.infradead.org;
	Fri, 11 Jul 2025 12:28:46 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752236922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lgrWzWoGA4T2qMNx99vSTk0N0vEs3RmQ3ckOl6a7eyA=;
	b=tOJnpellZmp4qNI0G9qIsuxeVc/7S8LVQlyHFR3QNkMabg51iwgjyk2Xm51ww/mr2lv2pr
	ew9MuhEG2ywsBaLQhekR5WlZvQzveN/u3j9PWERZ+phsDtpdXaDbPHzikIbNdTEUlT9vck
	Rvuvop82n9qaYO07mqa9zVso1kh9vb4=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: johannes@sipsolutions.net
Cc: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	linux-um@lists.infradead.org,
	tiwei.bie@linux.dev,
	tiwei.btw@antgroup.com
Subject: Re: [PATCH v2 3/3] um: Stop tracking stub's PID via userspace_pid[]
Date: Fri, 11 Jul 2025 20:28:19 +0800
Message-Id: <20250711122819.2727024-1-tiwei.bie@linux.dev>
In-Reply-To: <7dec916560a07a6d9d3f8e37bae482738d2c360c.camel@sipsolutions.net>
References: <7dec916560a07a6d9d3f8e37bae482738d2c360c.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250711_052845_808908_6AAA8E55 
X-CRM114-Status: GOOD (  25.12  )
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

On Fri, 11 Jul 2025 09:03:26 +0200, Johannes Berg wrote:
> On Fri, 2025-07-11 at 14:50 +0800, Tiwei Bie wrote:
> > From: Tiwei Bie <tiwei.btw@antgroup.com>
> > 
> > The PID of the stub process can be obtained from current_mm_id().
> > There is no need to track it via userspace_pid[]. Stop doing that
> > to simplify the code.
> 
> So that is really obvious cleanups, and I can go apply them on that
> grounds, but I started wondering if we're not separately being
> inconsistent here, which perhaps didn't matter due to non-SMP:
> 
> >  #define activate_mm activate_mm
> >  static inline void activate_mm(struct mm_struct *old, struct mm_struct *new)
> >  {
> > -	/*
> > -	 * This is called by fs/exec.c and sys_unshare()
> > -	 * when the new ->mm is used for the first time.
> > -	 */
> > -	__switch_mm(&new->context.id);
> >  }
> 
> This is now empty, so I wondered if we can just remove it _entirely_.
> 
> But the generic version calls switch_mm():

Yeah, removing activate_mm() will cause it to call switch_mm(). This is
somewhat a behavior change beyond the scope of this patchset, so I kept
it as is.

>  
> >  static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next, 
> > @@ -28,11 +23,9 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
> >  {
> >  	unsigned cpu = smp_processor_id();
> >  
> > -	if(prev != next){
> > +	if (prev != next) {
> >  		cpumask_clear_cpu(cpu, mm_cpumask(prev));
> >  		cpumask_set_cpu(cpu, mm_cpumask(next));
> > -		if(next != &init_mm)
> > -			__switch_mm(&next->context.id);
> >  	}
> >  }
> 
> which plays with the CPU mask, but realistically being non-SMP the CPU
> mask is never really used?
> 
> Certainly removing activate_mm() entirely seems to _work_, but of course
> it never does anything since smp_processor_id() eventually is just
> macros that expand to "0" (unless preempt debug is enabled). Any
> thoughts?

Yeah, things are a bit messy here and need to be sorted out.

IIUC, activate_mm() and switch_mm() are primarily used to update the
page table and manage the TLBs on the CPU for each user address space.
However, in UML, each user address space is represented by a separate
stub process, and the host kernel already takes care of that. So, I'm
not entirely sure why we need to maintain the mm_cpumask. Perhaps we
could just do this:

--- a/arch/um/include/asm/mmu_context.h
+++ b/arch/um/include/asm/mmu_context.h
@@ -13,20 +13,9 @@
 #include <asm/mm_hooks.h>
 #include <asm/mmu.h>
 
-#define activate_mm activate_mm
-static inline void activate_mm(struct mm_struct *old, struct mm_struct *new)
-{
-}
-
 static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next, 
 			     struct task_struct *tsk)
 {
-	unsigned cpu = smp_processor_id();
-
-	if (prev != next) {
-		cpumask_clear_cpu(cpu, mm_cpumask(prev));
-		cpumask_set_cpu(cpu, mm_cpumask(next));
-	}
 }
 
 #define init_new_context init_new_context

Regards,
Tiwei

