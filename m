Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08795C25B75
	for <linux-um@archiver.kernel.org>; Thu, 30 May 2024 02:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JT19DqDzQbqOC26Y9YKzFGJsTzvnll4uLJKhf5AOlFs=; b=ZUu8wu7MxJSNspKfbgAlmhhzCQ
	uocFWNJ2xIkhVDQfsOAmMKaDIeQTJqwMsrX7jCTlCyjO36wqeWqBqf/Lumk5HvV2iaTJbrTm+Gkkr
	3KGTPMxMoRccOpiuJJzUFeIMCXl0F2R5vEuZNOYvNM49S/kkpQwcGOQiSzAeL/Pxi1ABkNWI+mS96
	AbSzXMKvVeTc7Xm0mNECNWVM1dpWwxiPnrH2wScBqbQfojI/6OSL3kdjvqBnoZ2dAePBnwJzBZJd6
	mJ28QaG11aIIGeT9muI87GrFbTr+mrsBLvifNXb38pHHMfeSg/Ge4XllqgVBAwArBCyAwNpYfqTyu
	h37ewHmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCVwY-000000068wa-3z2R;
	Thu, 30 May 2024 02:55:06 +0000
Received: from out0-201.mail.aliyun.com ([140.205.0.201])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCVwT-000000068ve-2QIN
	for linux-um@lists.infradead.org;
	Thu, 30 May 2024 02:55:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1717037692; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=JT19DqDzQbqOC26Y9YKzFGJsTzvnll4uLJKhf5AOlFs=;
	b=d0xCTW1P6XIcyGmw6+SV+ouQLtMh5m9iIdhC5bERnIZmzGQTB4wfg3M431GK1sDDx8ohZcTs3vhAd9BunMh/UHXNzasWbBq7qGDE2kWGQb0sC4MhYOQsl338NWMitTyYhtYJy86Lyx7lPkuZUgIH1KeR9BVnnuvFzaFCMJ601os=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045129160;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---.XqrMNtM_1717037688;
Received: from 30.177.168.159(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.XqrMNtM_1717037688)
          by smtp.aliyun-inc.com;
          Thu, 30 May 2024 10:54:49 +0800
Message-ID: <759a6a53-efbc-4b11-8065-622702eb120b@antgroup.com>
Date: Thu, 30 May 2024 10:54:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] um: Do a double clone to disable rseq
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: Johannes Berg <johannes@sipsolutions.net>, benjamin@sipsolutions.net,
 linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
References: <20240528085419.1964424-1-benjamin@sipsolutions.net>
 <20240528085419.1964424-4-benjamin@sipsolutions.net>
 <5f5505da-ba67-421e-b0f5-6a5c19955f27@antgroup.com>
 <4a9d3075304f39b818009081d496b0f245bad450.camel@sipsolutions.net>
 <37d6a0e2-bbc2-4a93-bd7c-3cef847eba54@antgroup.com>
Content-Language: en-US
In-Reply-To: <37d6a0e2-bbc2-4a93-bd7c-3cef847eba54@antgroup.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240529_195502_418716_70FDA416 
X-CRM114-Status: GOOD (  12.42  )
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

On 5/28/24 10:13 PM, Tiwei Bie wrote:
> On 5/28/24 7:57 PM, Johannes Berg wrote:
>> On Tue, 2024-05-28 at 18:16 +0800, Tiwei Bie wrote:
>>> On 5/28/24 4:54 PM, benjamin@sipsolutions.net wrote:
>>>> From: Benjamin Berg <benjamin.berg@intel.com>
>>>>
>>>> Newer glibc versions are enabling rseq support by default. This remains
>>>> enabled in the cloned child process, potentially causing the host kernel
>>>> to write/read memory in the child.
>>>>
>>>> It appears that this was purely not an issue because the used memory
>>>> area happened to be above TASK_SIZE and remains mapped.
>>>
>>> I also encountered this issue. In my case, with "Force a static link"
>>> (CONFIG_STATIC_LINK) enabled, UML will crash immediately every time
>>> it starts up. I worked around this by setting the glibc.pthread.rseq
>>> tunable via GLIBC_TUNABLES [1] before launching UML.
>>>
>>> So another easy way to work around this issue without introducing runtime
>>> overhead might be to add the GLIBC_TUNABLES=glibc.pthread.rseq=0 environment
>>> variable and exec /proc/self/exe in UML on startup.
>>>
>>
>> It's also a bit of a question what to rely on - this would introduce a
>> dependency on glibc behaviour, whereas doing the double-clone proposed
>> here will work purely because of host kernel behaviour, regardless of
>> what part of the system set up rseq, how the tunables work, etc.
> 
> Makes sense. My previous concern was primarily about the runtime overhead,
> but after taking a closer look at the patch, I realized that the double-clone
> won't happen on the critical path, so there shouldn't be any performance
> issues. I also think the double-clone proposal is better. :)

But when combined with this series [1], things might be different..
Double-clone will happen for each new mm context. That's something
we might want to avoid.

[1] https://patchwork.ozlabs.org/project/linux-um/list/?series=408104

Regards,
Tiwei


