Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AFD6C54E64
	for <linux-um@archiver.kernel.org>; Thu, 28 Mar 2024 08:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KZze3ZzfavWk1+8elAuc+UQUWhJ28qdV6neycjnuvQo=; b=F8Wje9HxWZGqt8V5OhRL4Pqqvc
	L9zPcrwM/xxsRoe00GKe3Q2YhPFx9OIY9dMmjLfxBz642pcoLy7ErY5RzztCfTz/lo9kHuRh6DZ6C
	OXvHa7bXpsz85g3OiIu+KlkzUtTG9oU5AXIe81Nv02YA8kxftac0I/rgDRdu7Dq0Y1KWlVXwUnBHg
	r0/42oCgQx+Ee4L0YKZx/fooeFratQecgUeLVCzwGR0bTudc2Or+RFEY/YslO6FANaH9eIACxLOch
	ckrFfKtDknqZwZxdXS6Le7GHOH3QqIq2TSDgie9D7RoTVrv6QbOW8khTzimiB85KP9W2qch9Em92M
	X+xip4fA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpkrU-0000000D2LV-2Ytm;
	Thu, 28 Mar 2024 08:11:48 +0000
Received: from frasgout13.his.huawei.com ([14.137.139.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpkrQ-0000000D2Kd-2yN7
	for linux-um@lists.infradead.org;
	Thu, 28 Mar 2024 08:11:46 +0000
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4V4wnT3D9Nz9xrq5
	for <linux-um@lists.infradead.org>; Thu, 28 Mar 2024 15:55:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 601D5140797
	for <linux-um@lists.infradead.org>; Thu, 28 Mar 2024 16:11:25 +0800 (CST)
Received: from [10.81.206.1] (unknown [10.81.206.1])
	by APP2 (Coremail) with SMTP id GxC2BwD3LyQlJgVmWJYbBQ--.7342S2;
	Thu, 28 Mar 2024 09:11:24 +0100 (CET)
Message-ID: <a8e2444e-7fab-485e-975b-6563504f3efa@huaweicloud.com>
Date: Thu, 28 Mar 2024 09:11:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um: Add winch to winch_handlers before registering winch
 IRQ
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net
Cc: linux-kernel@vger.kernel.org, linux-um@lists.infradead.org,
 Roberto Sassu <roberto.sassu@huawei.com>
References: <20240307104926.3531358-1-roberto.sassu@huaweicloud.com>
 <2d70513e9f84e650ef1ede5a8ae5960a9de782bc.camel@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <2d70513e9f84e650ef1ede5a8ae5960a9de782bc.camel@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwD3LyQlJgVmWJYbBQ--.7342S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFy8KF4kWr4fZrykGF4rXwb_yoW8Kry8pF
	WDKasakrWFq3W09anrXan0yF97Aws7Gr1Uur1kK3y5Zryqvr9aqF1rGa4agF1DCry7Jr93
	Xr4rCa9xuFZ8AwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAQBF1jj5vieQACsm
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_011145_069508_C1E4442E 
X-CRM114-Status: GOOD (  16.08  )
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

On 3/7/2024 1:43 PM, Roberto Sassu wrote:
> On Thu, 2024-03-07 at 11:49 +0100, Roberto Sassu wrote:
>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>
>> Registering a winch IRQ is racy, an interrupt may occur before the winch is
>> added to the winch_handlers list.
>>
>> If that happens, register_winch_irq() adds to that list a winch that is
>> scheduled to be (or has already been) freed, causing a panic later in
>> winch_cleanup().
>>
>> Avoid the race by adding the winch to the winch_handlers list before
>> registering the IRQ, and rolling back if um_request_irq() fails.
>>
>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Fixes: 42a359e31a0e ("uml: SIGIO support cleanup")
> 
> I see that before that commit there was the same ordering (list_add()
> before um_request_irq()).
> 
> Failure from um_request_irq() should not result in executing
> winch_interrupt() which could call list_del() itself. Then, it should
> be fine to delete the winch in the error path.

Richard, did you have time to look at this?

Thanks

Roberto

> Roberto
> 
>> ---
>>   arch/um/drivers/line.c | 14 ++++++++------
>>   1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
>> index ffc5cb92fa36..d82bc3fdb86e 100644
>> --- a/arch/um/drivers/line.c
>> +++ b/arch/um/drivers/line.c
>> @@ -676,24 +676,26 @@ void register_winch_irq(int fd, int tty_fd, int pid, struct tty_port *port,
>>   		goto cleanup;
>>   	}
>>   
>> -	*winch = ((struct winch) { .list  	= LIST_HEAD_INIT(winch->list),
>> -				   .fd  	= fd,
>> +	*winch = ((struct winch) { .fd  	= fd,
>>   				   .tty_fd 	= tty_fd,
>>   				   .pid  	= pid,
>>   				   .port 	= port,
>>   				   .stack	= stack });
>>   
>> +	spin_lock(&winch_handler_lock);
>> +	list_add(&winch->list, &winch_handlers);
>> +	spin_unlock(&winch_handler_lock);
>> +
>>   	if (um_request_irq(WINCH_IRQ, fd, IRQ_READ, winch_interrupt,
>>   			   IRQF_SHARED, "winch", winch) < 0) {
>>   		printk(KERN_ERR "register_winch_irq - failed to register "
>>   		       "IRQ\n");
>> +		spin_lock(&winch_handler_lock);
>> +		list_del(&winch->list);
>> +		spin_unlock(&winch_handler_lock);
>>   		goto out_free;
>>   	}
>>   
>> -	spin_lock(&winch_handler_lock);
>> -	list_add(&winch->list, &winch_handlers);
>> -	spin_unlock(&winch_handler_lock);
>> -
>>   	return;
>>   
>>    out_free:


