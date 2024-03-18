Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88CE8C54E58
	for <linux-um@archiver.kernel.org>; Mon, 18 Mar 2024 13:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6taV8JAUEtC4HnRx7IY+OYtv4kMrp/TsT5eNF60jDoA=; b=d2o5u2ICMUV5uLCyeN8On/PhDC
	BnDEldoEgAUrDLSwC3ma1GghHul3f1P/3aWuGGp29ggBKByoCvofmQD3Q6JwW+utx9tFf0OYoXvPI
	ty4n/n8YjqLt9gG/4aBCLlx6qCKy5kItvQ6LXdszLTAO7z83neRlhyxlE+Uyq4gtYLHc8xPUnmNE4
	9E7EisY3N6VZjd3VWvov1comHthY0onRu0a9pYkeBOAinb7CEGpfgepjKvfjvKDyb+zVEGMoE3jvs
	/Un/KzGd+U4iPnO8p4q3nGPs1h1RUShLxWHX9PMEDL0hdodc4yye/TyFY8gLiBZ1X+kEQO4q/3nJQ
	cTXadKxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmCkF-00000008cEL-285l;
	Mon, 18 Mar 2024 13:09:39 +0000
Received: from frasgout11.his.huawei.com ([14.137.139.23])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmCkB-00000008cB6-1V5s
	for linux-um@lists.infradead.org;
	Mon, 18 Mar 2024 13:09:37 +0000
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Tyvsy2xd9z9xqwn
	for <linux-um@lists.infradead.org>; Mon, 18 Mar 2024 20:53:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id F0D3314037C
	for <linux-um@lists.infradead.org>; Mon, 18 Mar 2024 21:09:16 +0800 (CST)
Received: from [10.81.220.121] (unknown [10.81.220.121])
	by APP2 (Coremail) with SMTP id GxC2BwCHcyf1PPhlpmyFBA--.45229S2;
	Mon, 18 Mar 2024 14:09:16 +0100 (CET)
Message-ID: <8d45f94c-bce1-4327-9573-cec254a4e9c3@huaweicloud.com>
Date: Mon, 18 Mar 2024 14:09:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 1/1] um: oops on accessing a non-present page in
 the vmalloc area
From: Petr Tesarik <petrtesarik@huaweicloud.com>
To: Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "open list:USER-MODE LINUX (UML)" <linux-um@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>,
 =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
References: <20240223140435.1240-1-petrtesarik@huaweicloud.com>
 <9284cda7-d7e3-4390-bf62-58092e97d1c8@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <9284cda7-d7e3-4390-bf62-58092e97d1c8@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwCHcyf1PPhlpmyFBA--.45229S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF18Wr17tF1rGr17Cr4kZwb_yoW8AFWUpF
	s3Ga18tFZFgF12vanrXa4qvr4xKa9rt3W7CrsrA34Fvr1q9FyfArW5KwnrCw1j9rWrKa1f
	tFWYyr9rAws8Jw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJV
	WxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI
	8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1a9aPUUUUU==
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240318_060935_686145_3FC9FC6D 
X-CRM114-Status: GOOD (  14.88  )
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

On 3/12/2024 4:07 PM, Petr Tesarik wrote:
> On 2/23/2024 3:04 PM, Petr Tesarik wrote:
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
> 
> Ping. Any comment on this fix?

I don't think I have seen a reply from you. If you did comment, then
your email has not reached me.

Please, can you confirm you have seen my patch?

Kind regards
Petr T

> Petr T
> 
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
>>  	int err;
>>  	int is_write = FAULT_WRITE(fi);
>>  	unsigned long address = FAULT_ADDRESS(fi);
>> +	pte_t *pte;
>>  
>>  	if (!is_user && regs)
>>  		current->thread.segv_regs = container_of(regs, struct pt_regs, regs);
>>  
>>  	if (!is_user && (address >= start_vm) && (address < end_vm)) {
>> +		pte = virt_to_pte(&init_mm, address);
>> +		if (!pte_present(*pte))
>> +			page_fault_oops(regs, address, ip);
>>  		flush_tlb_kernel_vm();
>>  		goto out;
>>  	}
> 


