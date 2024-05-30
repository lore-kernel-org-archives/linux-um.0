Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B67C27C44
	for <linux-um@archiver.kernel.org>; Thu, 30 May 2024 14:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XadCedOdAMFMGDk+Ozpu9xlDzQsycuf73oKUMlGNUDg=; b=C5krUMZ3uZIs4txpbbdm60NvZ/
	DG6W6gcN5BBk+2+TsBkA/xGthocJpvNqx1GNioCSbVUAeywvgDKhdGzNKAlfPLXiYX0qCPtoIN/5O
	XSB3Ppg/gFhhURA46pT9pG4JpNSucYMlgZzXnm7i87uNkf8EXr82v9Plw1GGUPnBRu+53A+SJLeuj
	11pabJM1q2Gvfax7DhCd07nXkZ49U5lT1gM9+kRohBhhheT5Sfo4jc/nnKutmbl0BkZdVcEQsahFl
	ISb31BHDI4E8KeNwALHQ3S6zYf8WcbdZJVV9Ftd/biVCQmS1Gc74PLnEy2x1XPZvvh+X+bIj/zFWC
	4wHffGHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCgP9-00000007TMm-0Dsx;
	Thu, 30 May 2024 14:05:19 +0000
Received: from out0-197.mail.aliyun.com ([140.205.0.197])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCgP5-00000007TJC-2KYk
	for linux-um@lists.infradead.org;
	Thu, 30 May 2024 14:05:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1717077908; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=XadCedOdAMFMGDk+Ozpu9xlDzQsycuf73oKUMlGNUDg=;
	b=PoNGeEEqlRvjTC3/aPibqRu8stsk8ctB087qNBHUZ/5NTZLFz0Qc7wwJxXBKBFFlw0+EWluPC59ujqiLc8YOrfR6Z/tFAXYQDovGGboONVNEMWJPsBrk89iXo3UYibsEUZmQLviS8IJEj3wTRmazcUrvyJ1Lqk73ZSbWfzlb178=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045129160;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---.XrQBivS_1717077903;
Received: from 30.177.168.159(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.XrQBivS_1717077903)
          by smtp.aliyun-inc.com;
          Thu, 30 May 2024 22:05:04 +0800
Message-ID: <18a57365-659c-406a-a836-d575cad586e0@antgroup.com>
Date: Thu, 30 May 2024 22:05:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] um: Do a double clone to disable rseq
To: Benjamin Berg <benjamin@sipsolutions.net>,
 Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
References: <20240528085419.1964424-1-benjamin@sipsolutions.net>
 <20240528085419.1964424-4-benjamin@sipsolutions.net>
 <5f5505da-ba67-421e-b0f5-6a5c19955f27@antgroup.com>
 <4a9d3075304f39b818009081d496b0f245bad450.camel@sipsolutions.net>
 <37d6a0e2-bbc2-4a93-bd7c-3cef847eba54@antgroup.com>
 <759a6a53-efbc-4b11-8065-622702eb120b@antgroup.com>
 <6a1a9b9fe5c7d8c7ecd2b42c9f61346318a5f659.camel@sipsolutions.net>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <6a1a9b9fe5c7d8c7ecd2b42c9f61346318a5f659.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240530_070516_314172_41175E58 
X-CRM114-Status: GOOD (  20.37  )
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

On 5/30/24 4:54 PM, Benjamin Berg wrote:
> Hi,
> 
> On Thu, 2024-05-30 at 10:54 +0800, Tiwei Bie wrote:
>> On 5/28/24 10:13 PM, Tiwei Bie wrote:
>>> On 5/28/24 7:57 PM, Johannes Berg wrote:
>>>> On Tue, 2024-05-28 at 18:16 +0800, Tiwei Bie wrote:
>>>>> On 5/28/24 4:54 PM, benjamin@sipsolutions.net wrote:
>>>>>> From: Benjamin Berg <benjamin.berg@intel.com>
>>>>>>
>>>>>> Newer glibc versions are enabling rseq support by default. This remains
>>>>>> enabled in the cloned child process, potentially causing the host kernel
>>>>>> to write/read memory in the child.
>>>>>>
>>>>>> It appears that this was purely not an issue because the used memory
>>>>>> area happened to be above TASK_SIZE and remains mapped.
>>>>>
>>>>> I also encountered this issue. In my case, with "Force a static link"
>>>>> (CONFIG_STATIC_LINK) enabled, UML will crash immediately every time
>>>>> it starts up. I worked around this by setting the glibc.pthread.rseq
>>>>> tunable via GLIBC_TUNABLES [1] before launching UML.
>>>>>
>>>>> So another easy way to work around this issue without introducing runtime
>>>>> overhead might be to add the GLIBC_TUNABLES=glibc.pthread.rseq=0 environment
>>>>> variable and exec /proc/self/exe in UML on startup.
>>>>>
>>>>
>>>> It's also a bit of a question what to rely on - this would introduce a
>>>> dependency on glibc behaviour, whereas doing the double-clone proposed
>>>> here will work purely because of host kernel behaviour, regardless of
>>>> what part of the system set up rseq, how the tunables work, etc.
>>>
>>> Makes sense. My previous concern was primarily about the runtime overhead,
>>> but after taking a closer look at the patch, I realized that the double-clone
>>> won't happen on the critical path, so there shouldn't be any performance
>>> issues. I also think the double-clone proposal is better. :)
>>
>> But when combined with this series [1], things might be different..
>> Double-clone will happen for each new mm context. That's something
>> we might want to avoid.
> 
> I cannot believe that this overhead is something to worry about. The
> CLONE_VM step should be really fast compared to the second clone as it
> runs in the same MM as the kernel (it is how posix_spawn avoids the
> fork overhead to execute another process if possible).

Hmm.. I just think that creating a temporary "thread" every time to do this
is perhaps a bit unnecessary. But I also agree that using GLIBC_TUNABLES in
UML will introduce a dependency on glibc behaviour, which is undesirable.
Honestly, I don't have a strong opinion on this.

Regards,
Tiwei

> 
> Note that using execve in the second step would speed things up even
> more as the process will then run in a new MM instead of copying the
> kernel MM and cleaning it.
> 
> That said, this patch can be made simpler by using CLONE_VFORK.
> 
> Benjamin
> 
>>
>> [1] https://patchwork.ozlabs.org/project/linux-um/list/?series=408104
>>
>> Regards,
>> Tiwei
>>
>>


