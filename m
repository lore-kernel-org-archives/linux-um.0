Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DFD2CE79CF
	for <linux-um@archiver.kernel.org>; Wed, 20 Sep 2023 12:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:MIME-Version:
	Date:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q3oLM3NSALQqwAfBWJ8Eb22HGs+QNfXRYxJLspb9zog=; b=raBi4l+zEWhje5qiOWP/Z+U5mx
	jzAXzr/Yg14KHL3uybw2FrnBxqVjp7IFU8MBcIxTY0sG6elC+AaBiGx7vG+m3W+EXfpPtus5T3eKC
	tEhxNOKYPzDq0vaKQvhQUAHrqWgg280Yxiu2fe/FKYPOgTzBg3G2GKi0V9MXryBL/aO1dFGDnORH6
	zlBGmZv3OZUcwQi7q4lqv04ZzvuL6/wArawyaARm5g9GqEl97y1hoBuhFFtkMalDLdkj9xdvokR+O
	gXRGJ+7eOZIC+msR6+xvF8T8mQyBs++lAetY7j6nZrdbY1yVGGV3O6IN+1yiw+yrFuMBv/Qa5Jlws
	2A/5Dm6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiwM6-0031gs-0B;
	Wed, 20 Sep 2023 12:30:58 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiwM3-0031fI-1Y
	for linux-um@lists.infradead.org;
	Wed, 20 Sep 2023 12:30:56 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1qiwM0-002Vqu-0a
	for linux-um@lists.infradead.org; Wed, 20 Sep 2023 12:30:52 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1qiwLx-00HFGd-9G
	for linux-um@lists.infradead.org; Wed, 20 Sep 2023 13:30:51 +0100
Message-ID: <d1d9054e-197c-18b1-bb2d-ef7f5737495f@kot-begemot.co.uk>
Date: Wed, 20 Sep 2023 13:30:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Boots and seems to work with PREEMPT enabled
Content-Language: en-US
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
To: User Mode Linux <linux-um@lists.infradead.org>
References: <6eb21cc7-05d5-c9be-6abd-07bdda64dcb6@kot-begemot.co.uk>
In-Reply-To: <6eb21cc7-05d5-c9be-6abd-07bdda64dcb6@kot-begemot.co.uk>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230920_053055_520986_0C29F24A 
X-CRM114-Status: GOOD (  11.91  )
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



On 20/09/2023 12:14, Anton Ivanov wrote:
> Added support for kernel side fpu store/restore and real kernel_fpu_begin/kernel_fpu_end using gcc intrinsics. Enabled PREEMPT.
> 
> It boots and seems to be alive and kicking. I do not notice any significant effect on performance either.
> 

I take my words back - I was testing with VOLUNTARY which seems to provide a difference withing the margin of error.

Enabling forced preemption drops the time for

find /usr -type f -exec cat {} > /dev/null \;

from

real	19m11.207s
user	0m0.180s
sys	2m41.160s

to

real	3m13.647s
user	0m0.000s
sys	2m58.270s

And boot time from 11.5s to 6s.

It did complain on shutdown though with some traces. Nothing while running.

The patch will hit the mailing list shortly.


> How do I test it from here onwards?

The question still stands. Can we use anything as a specific test suite? It is not an area I am familiar with, so any pointers will be welcome.

> 
> I am happy to throw the patches on the list as an RFC, though I would prefer to test first :)
> 

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
