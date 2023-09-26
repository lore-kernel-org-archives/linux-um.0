Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10780E7E632
	for <linux-um@archiver.kernel.org>; Tue, 26 Sep 2023 13:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:To:Subject:MIME-Version:
	Date:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N2Y4zlDJOK3rSQwCnuiYNDRjPvI0Hr/Oq6u3hR1RRP0=; b=imainwIIx//dKUVZ6Kqub3KM9V
	aQk7Txo7PSktreMxi0TIuxA1LWpHR3yObzjnZKcQQEbJfYmLtLsYOPoE6FaN68HJEsuSX8RH02GJE
	cas/HoW77t1Aq81eG1r3mo+pS9RsLLZIpZQ2cwqh0wLjckFQm/afO1bw4qYLdLlhD1Sr+G1JFWVGm
	jQHlHAmIwdMAxgbROlJkclH1RDdltp7thcMY4jSBPmu6rPXSnQB1Rhqy4+o8vp2JK2VRHEh7i6n0x
	RZeN8hPqpXF6d+WCQW4MFEJ2JbjqTYZeB8PZ2MNPVqHUx1p8GeNu/r0tbDG6CqnyE2+K+33sWmt0q
	NFeabe3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ql7jv-00GQsc-0A;
	Tue, 26 Sep 2023 13:04:35 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ql7jq-00GQrI-2s
	for linux-um@lists.infradead.org;
	Tue, 26 Sep 2023 13:04:32 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1ql7jo-002rNW-OV; Tue, 26 Sep 2023 13:04:29 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.96)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1ql7jk-001KdM-2W;
	Tue, 26 Sep 2023 14:04:28 +0100
Message-ID: <a63c092d-73c2-5d08-1d00-c409066a415a@cambridgegreys.com>
Date: Tue, 26 Sep 2023 14:04:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 0/3] um: clean up mm creation - another attempt
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
References: <20230922223737.1206223-4-johannes@sipsolutions.net>
 <bcc1170b-89b9-7c5e-d047-7055f97c1716@cambridgegreys.com>
 <4f79b781db6d5892c86e103733c7c30cda78afdf.camel@sipsolutions.net>
 <4b5764f0-d2c0-12ce-56bb-73c07ab59ebc@cambridgegreys.com>
 <d6ac37b196ebc0443997a942f8efb16a69e424fc.camel@sipsolutions.net>
 <18290c11-2d97-3aec-3fd7-b3dd0d33a88b@cambridgegreys.com>
 <2d041a80-0ba4-d48b-07b1-b1bc835b3e0d@cambridgegreys.com>
 <4d772184b2b39944de8444b0a6f437581297e1d4.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <4d772184b2b39944de8444b0a6f437581297e1d4.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230926_060430_929048_C829B1A0 
X-CRM114-Status: GOOD (  40.62  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org



On 26/09/2023 13:38, Johannes Berg wrote:
> On Tue, 2023-09-26 at 13:16 +0100, Anton Ivanov wrote:
>>
>> For the time being it is mostly negative :)
> 
> Oh well :)
> 
>> 1. The performance after the mm patch is down. By 30-40% on my standard bench.
> 
> For the record, you mean this three-patch series that we're discussing
> in the thread of?

Yes. It has no stability issues on its own as well as with the PREEMPT patch on top.

> 
> 
> Btw, Benjamin realized that MADV_DONTFORK is broken in UML, precisely
> _because_ we fork/copy the whole mm process and then try to fix it up.
> But we can only fix up things that actually have VMAs, and of course
> there are no VMAs with VM_DONTCOPY (set by MADV_DONTFORK) in the new mm
> after fork.
> 
> To fix this, really we should either
> 
> 1. Start from scratch, without copying, which my other patch [1] did.
> 
>     [1] https://lore.kernel.org/all/20230922131638.2c57ec713d1c.Id11dff4b349e6a8f0136bb6bb09f6e01a80befbb@changeid/
> 
>     But of course that's more expensive because we now have to page-fault
>     everything in the new process, and page faults are expensive.
> 
> 2. Compare the new mm and the old mm, which requires putting it into
>     arch_dup_mmap() like these patches here - where I'm not sure I
>     understand at all why they cause a perf regression - and remove the
>     VMAs that are marked VM_DONTCOPY in the old one.
> 
> 
> To be honest I don't really like _either_ of these approaches, nor the
> current "fork the process" approach that UML takes. It's very magic, and
> very much works around how Linux works.

+1

> 
> Remember that basically the mm process contents should match the page
> tables in the VMAs; but this is decidedly not true where fork() is
> involved, because while the VMAs are copied, most of the page tables are
> _not_ copied. Thus, we have a situation where after fork we don't take
> page faults in UML that we would take in a normal system (this part is
> good for performance), and I believe also vice versa, which would then
> perhaps explain the flush_tlb_page() in handle_page_fault(), because
> honestly I don't otherwise have an explanation for it.
> 
> 
> I think the better approach for correctness and integration into the
> kernel would be to actually admit that UML is special because page
> faults are so expensive, and
> 
>   * start with a fresh mm process every time
>   * have vma_needs_copy() return true
>   * completely fill the mappings according to only the new mm's VMAs
>     in arch_dup_mmap() or perhaps later
> 
> I don't know how that'd behave wrt. performance, though it likely cannot
> be better than with these patches, but at least it'd be more correct,
> and more obviously correct too, for starters, because then the actual
> mappings in the UML mm process would actually reflect the PTEs that
> Linux knows about.

We can try that.

> 
> 
>> 2. The preemption patches work fine on top (all 3 cases). The performance difference stays.
> 
> OK.
> 
>> 3. We do not have anything of value to add in term of cond_resched() to the drivers :(
>> Most drivers are fairly simplistic with no safe points to add this.
> 
> Yeah, not surprised by this.
> 
>> 6. Do we still need force_flush_all() in the arch_dup_mmap()? This works with a non-forced tlb flush
>> using flush_tlb_mm(mm);
> 
> Maybe not, does it make a difference though?

Nope. Same numbers in both cases.

> 
>> 7. In all cases, UML is doing something silly.
>> The CPU usage while doing find -type f -exec cat {} > /dev/null measured from outside in non-preemptive and
>> PREEMPT_VOLUNTARY stays around 8-15%. The UML takes a sabbatical for the remaining 85 instead of actually
>> doing work. PREEMPT is slightly better at 60, but still far from 100%. It just keeps going into idle and I
>> cannot understand why.
> 
> Is it just waiting for IO?

Nope. Nearly all I see on strace is wait4 and PTRACE. The epoll_waits are few and far between.

The bottleneck is mm and vm, not IO :(

> 
> johannes
> 

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
