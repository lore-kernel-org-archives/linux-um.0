Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCCAECD4F41
	for <linux-um@archiver.kernel.org>; Fri, 22 Sep 2023 09:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Qy5C7TuCMU/8p2M8prAkpfFnN7eFiasaNexBv7QDpvw=; b=n5Q8FwTFjCoDL/
	mzH81B6FRYq5tfknS4YwmeNMFG1pj7qK1qvlnn6WJ2I4OAZbKzUv8UkE3VdVa1TE8+oPXQuPdpnly
	+wqSfp2s3Znft6ry52iJWXZfGM02/CZ4VbUvNCnJ4t+O6591kM/pJyUvd7xfo8D7uW/Qu2mGpMBeK
	EQZ5b9zhCP/YGFM9giziJuW95wjlv6tu6bjlvDGv88EBBi45AuD9rLUPxAg4BjMcBeGkaSBQlGbXW
	SwohxwnewkWIhil5KDBy27FgqcRfoGMK60dwt8EBYOUfzsCWruhJ8O02WFgaWPmxFWX6ivNJhLD/F
	l59kWnneeJFvjxJ0psNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjcK1-008YPf-1i;
	Fri, 22 Sep 2023 09:19:37 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjcJy-008YOD-29
	for linux-um@lists.infradead.org;
	Fri, 22 Sep 2023 09:19:36 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qjcJx-002bRM-2D; Fri, 22 Sep 2023 09:19:33 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qjcJu-002Bi6-BW; Fri, 22 Sep 2023 10:19:32 +0100
Message-ID: <b8769840-1e33-f9bf-7a55-6ea805a1639a@cambridgegreys.com>
Date: Fri, 22 Sep 2023 10:19:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5] um: Enable preemption in UML
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: richard@nod.at
References: <20230922065212.484385-1-anton.ivanov@cambridgegreys.com>
 <fae1103161cf8c7bac8a138b267d2288ebb32a08.camel@sipsolutions.net>
 <fa4069f1-e026-7672-4f71-9319cdd683a2@cambridgegreys.com>
 <2de07f54b33dc060b75d982d4d8189f12e0d4c45.camel@sipsolutions.net>
 <28f0be57-829b-9ddf-7b0d-a6c84932cbda@cambridgegreys.com>
 <423e8ee5126e1dffda5f8877d07611a21972eea7.camel@sipsolutions.net>
 <210bd25b2dcd9e4424923f55053086f67e219cc4.camel@sipsolutions.net>
 <40babfb4-ed65-dd0e-23aa-abdfaa9c7149@cambridgegreys.com>
 <efaa802bcd0369665b3dbc10030c9ca88aa2cb30.camel@sipsolutions.net>
 <1ce8c412b0d2bdfa176f1f783281e393da94ff6f.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <1ce8c412b0d2bdfa176f1f783281e393da94ff6f.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_021934_707418_11877462 
X-CRM114-Status: GOOD (  17.91  )
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



On 22/09/2023 10:14, Johannes Berg wrote:
> On Fri, 2023-09-22 at 11:10 +0200, Johannes Berg wrote:
>> On Fri, 2023-09-22 at 10:06 +0100, Anton Ivanov wrote:
>>> On 22/09/2023 09:41, Johannes Berg wrote:
>>>>> Yes, but when does the fork actually happen?
>>>>>
>>>> Looking further at this, now I'm confused as to why it doesn't happen
>>>> _all_ the time.
>>>>
>>>> I think this has pretty much always been wrong, just now we actually
>>>> notice it?
>>>>
>>>> Basically, when we create a new thread (really just mm I think), we say
>>>> the first thing that has to run there is fork_handler(), which
>>>> initialises things the first time around. This calls force_flush_all()
>>>>
>>>> But of course it's called from __schedule(), which has
>>>> preemption/interrupts disabled. So you can't do mmap_read_lock()?
>>>
>>> Stupid question.
>>>
>>> If we have preemption and interrupts disabled and we are UP do we really need to lock it at this point?
>>
>> Heh.
>>
> 
> Ah, but this works:
> 
> --- a/arch/um/kernel/tlb.c
> +++ b/arch/um/kernel/tlb.c
> @@ -606,8 +606,8 @@ void force_flush_all(void)
>   	struct vm_area_struct *vma;
>   	VMA_ITERATOR(vmi, mm, 0);
>   
> -	mmap_read_lock(mm);
> +	rcu_read_lock();
>   	for_each_vma(vmi, vma)
>   		fix_range(mm, vma->vm_start, vma->vm_end, 1);
> -	mmap_read_unlock(mm);
> +	rcu_read_unlock();
>   }
> 
> 
> it seems?
> 
> And it doesn't even seem _bad_ since as you say nothing can change, and
> we only inject stuff into the process in fix_range() anyway.
> 
> So maybe that works - perhaps with a big comment?

Ack. Will add this to the patch and run it through its paces.

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
