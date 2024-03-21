Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3156DC6FD1F
	for <linux-um@archiver.kernel.org>; Thu, 21 Mar 2024 17:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lGa0gIWLoWrjdnFA26nph0dMAg/4xGjL+x8igH5HbPs=; b=rdfwTHe+WVG2zeqvC3P0M5KB2W
	r3On2deet+Z1izDCI07PyE0f70vmOyDrqMzpqAAjq5tHpTM7u0OG7qCRMfUqQzOG80D4IdjKhO176
	M/ziTAsyydqme9ifT/QsNz2tUXGvLxVrdwwtd6aTL+SqLWSBVn/fZOlhOlW8iFZKo65Eux/Yuyo2A
	SETyPy3vsvVSAlGZCNOxlrtaJUYLE/1LJOAx9mPLff2HpTWFjGYgcx7lRXvxlYkj6TIyD8KNn1KqE
	nqIwNkWaYLU9XBjcCIuRD3i8AtsJcy+hXqn+L8EtgbZSKxp3HU/dKAixAs8RaOKDmywnRUpkEfSoK
	YrJV+W0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnMFJ-000000045Pb-0BEK;
	Thu, 21 Mar 2024 17:30:29 +0000
Received: from frasgout.his.huawei.com ([185.176.79.56])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnMFF-000000045Np-1YWs
	for linux-um@lists.infradead.org;
	Thu, 21 Mar 2024 17:30:27 +0000
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V0smv46GNz6K9C6;
	Fri, 22 Mar 2024 01:25:51 +0800 (CST)
Received: from frapeml500002.china.huawei.com (unknown [7.182.85.205])
	by mail.maildlp.com (Postfix) with ESMTPS id 120DC140A9C;
	Fri, 22 Mar 2024 01:30:11 +0800 (CST)
Received: from [10.81.213.73] (10.81.213.73) by frapeml500002.china.huawei.com
 (7.182.85.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 21 Mar
 2024 18:30:10 +0100
Message-ID: <9cfb4aa7-d927-4015-8ef8-1cd081250cdc@huawei-partners.com>
Date: Thu, 21 Mar 2024 18:30:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 1/1] um: oops on accessing a non-present page in
 the vmalloc area
To: David Gow <davidgow@google.com>, Petr Tesarik
	<petrtesarik@huaweicloud.com>
CC: Richard Weinberger <richard@nod.at>, Anton Ivanov
	<anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>,
	"open list:USER-MODE LINUX (UML)" <linux-um@lists.infradead.org>, open list
	<linux-kernel@vger.kernel.org>, Roberto Sassu <roberto.sassu@huaweicloud.com>
References: <20240223140435.1240-1-petrtesarik@huaweicloud.com>
 <CABVgOSmNbBzR=QV4RDSdBPzBU=8mP5r0gVf5wqADm_9e9htM2g@mail.gmail.com>
Content-Language: en-US
From: Petr Tesarik <petr.tesarik1@huawei-partners.com>
In-Reply-To: <CABVgOSmNbBzR=QV4RDSdBPzBU=8mP5r0gVf5wqADm_9e9htM2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.213.73]
X-ClientProxiedBy: frapeml500001.china.huawei.com (7.182.85.94) To
 frapeml500002.china.huawei.com (7.182.85.205)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240321_103025_801042_34618A5B 
X-CRM114-Status: GOOD (  24.69  )
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

On 3/21/2024 5:44 AM, David Gow wrote:
> On Fri, 23 Feb 2024 at 22:07, Petr Tesarik <petrtesarik@huaweicloud.com> wrote:
>>
>> From: Petr Tesarik <petr.tesarik1@huawei-partners.com>
>>
>> If a segmentation fault is caused by accessing an address in the vmalloc
>> area, check that the target page is present.
>>
>> Currently, if the kernel hits a guard page in the vmalloc area, UML blindly
>> assumes that the fault is caused by a stale mapping and will be fixed by
>> flush_tlb_kernel_vm(). Unsurprisingly, if the fault is caused by accessing
>> a guard page, no mapping is created, and when the faulting instruction is
>> restarted, it will cause exactly the same fault again, effectively creating
>> an infinite loop.
>>
>> Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
>> ---
>>  arch/um/kernel/trap.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
>> index 6d8ae86ae978..d5b85f1bfe33 100644
>> --- a/arch/um/kernel/trap.c
>> +++ b/arch/um/kernel/trap.c
>> @@ -206,11 +206,15 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
>>         int err;
>>         int is_write = FAULT_WRITE(fi);
>>         unsigned long address = FAULT_ADDRESS(fi);
>> +       pte_t *pte;
>>
>>         if (!is_user && regs)
>>                 current->thread.segv_regs = container_of(regs, struct pt_regs, regs);
>>
>>         if (!is_user && (address >= start_vm) && (address < end_vm)) {
>> +               pte = virt_to_pte(&init_mm, address);
>> +               if (!pte_present(*pte))
>> +                       page_fault_oops(regs, address, ip);
> 
> page_fault_oops() appears to be private to arch/x86/mm/fault.c, so
> can't be used here?
> Also, it accepts struct pt_regs*, not struct uml_pt_regs*, so would
> need to at least handle the type difference here.

Argh, you're right. This was originally a two-patch series, but Richard
wanted improvements in the implementation which would require more
effort, see here:

http://lists.infradead.org/pipermail/linux-um/2024-January/006406.html

So I wanted to fix only the infinite loop, but in the mean time I forgot
about the dependency on the first patch:

http://lists.infradead.org/pipermail/linux-um/2023-December/006380.html

That's because a quick git grep page_fault_oops found the function. It
was my mistake that I did not notice the other page_fault_oops() earlier.

OK, please forget about this patch for now; I must rework it.

> Could we equally avoid the infinite loop here by putting the
> 'flush_tlb_kernel_vm();goto out;' behind a if (pte_present(...))
> check, and let the rest of the UML checks panic or oops if required.
> (Actually OOPSing where we can under UML would be nice to do at some
> point anyway, but is a bigger issue than just fixing a bug, IMO.)

Yes, that would be the best quick fix until I get to implementing all
the blows and whistles (oops_* helpers, notification chains, tainting,
etc.).

Petr T

> Or am I lacking a prerequisite patch or applying this to the wrong
> version (or otherwise missing something), as it definitely doesn't
> build here.
> 
> Cheers,
> -- David

