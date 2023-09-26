Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D44E7E62F
	for <linux-um@archiver.kernel.org>; Tue, 26 Sep 2023 12:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:MIME-Version:
	Date:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jsx7FanHFDWkUjt2BwAeWmWDcWc5QecpgfJ1eTfS1yo=; b=TLNyo0Yg2sLK4mwcynshEagmGT
	Nr/2h3mUo6vTePcj2D9xyDez92l4rbCx3HrCgW0sfZXCBZeI8JqGmtID2LTmDgZVTpJDBDVl+4ajB
	oVsrZ3QFIfPDxlFZ2hdiBlSe0XPosa9xo8aipNSu9ghK0QdjdjKDobh+itSoq3if5+p5OVGH4HJOm
	qHId3QCzOs+RZ/0RmOSmKAen65iq/x93SjpMNPm+4DTZvHdR9gUE1pO7qhyF7NnmM+PPJhmDV5Sfp
	1NCPnb8WQ4DDEhGH+QTyAGnqC/e2/qSI6njxPKXhaM4l7zCifJjXVvRQBzwuws1jp5D5arRJEZ25X
	Un90yfkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ql6zZ-00GLTM-1z;
	Tue, 26 Sep 2023 12:16:41 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ql6zW-00GLSi-0B
	for linux-um@lists.infradead.org;
	Tue, 26 Sep 2023 12:16:40 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1ql6zS-002rJB-9b; Tue, 26 Sep 2023 12:16:34 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.96)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1ql6zN-001Fr1-1d;
	Tue, 26 Sep 2023 13:16:34 +0100
Message-ID: <2d041a80-0ba4-d48b-07b1-b1bc835b3e0d@cambridgegreys.com>
Date: Tue, 26 Sep 2023 13:16:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 0/3] um: clean up mm creation - another attempt
Content-Language: en-US
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
References: <20230922223737.1206223-4-johannes@sipsolutions.net>
 <bcc1170b-89b9-7c5e-d047-7055f97c1716@cambridgegreys.com>
 <4f79b781db6d5892c86e103733c7c30cda78afdf.camel@sipsolutions.net>
 <4b5764f0-d2c0-12ce-56bb-73c07ab59ebc@cambridgegreys.com>
 <d6ac37b196ebc0443997a942f8efb16a69e424fc.camel@sipsolutions.net>
 <18290c11-2d97-3aec-3fd7-b3dd0d33a88b@cambridgegreys.com>
In-Reply-To: <18290c11-2d97-3aec-3fd7-b3dd0d33a88b@cambridgegreys.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230926_051638_097417_6A83933A 
X-CRM114-Status: GOOD (  29.56  )
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



On 25/09/2023 16:20, Anton Ivanov wrote:
> 
> On 25/09/2023 15:44, Johannes Berg wrote:
>> On Mon, 2023-09-25 at 15:27 +0100, Anton Ivanov wrote:
>>> On 25/09/2023 14:33, Johannes Berg wrote:
>>>> On Mon, 2023-09-25 at 14:29 +0100, Anton Ivanov wrote:
>>>>> I have rebased the preempt patch on top of these series.
>>>>>
>>>>> PREEMPT works with some performance decrease.
>>>>>
>>>>> VOLUNTARY deadlocks early in boot around the time it starts loading modules.
>>>>>
>>>>> non-preemptible deadlocks very early in boot.
>>>>>
>>>> Well I guess that means there's still some issue in here? Hmm.
>>>>
>>>> Now I don't understand anything anymore, I guess.
>>> PEBKAC. The tree got corrupted somewhere during rebase. Reapplying everything on top of a clean master fixed it.
>>>
>>> So it all works.
>> OK, whew. At least now I no longer _completely_ doubt the mental model I
>> have of UML VM :-)
>>
>>> With some performance penalties compared to the old approach, but works.
>> I still find this odd though, I don't see what the flush would possibly
>> do in a new (mm host) process that's not achievable in arch_dup_mmap()?
>>
>> OK, so let's see - arch_dup_mmap() is _earlier_ than the fork_handler,
>> because that only happens on the very first switch into the process.
>> This is only when it gets scheduled. So we'd be looking for something
>> that copy_process() changes in the MM after copy_mm() and before it can
>> get scheduled?
>>
>> I guess we could even move the flush it into copy_thread(), which is a
>> simpler patch too, but it felt a bit wrong, since that's about the
>> (guest!) process, not the mm.
>>
>> But basically I don't see anything there - fork syscall tail-calls
>> kernel_clone(), which doesn't really do anything with the result of
>> copy_process() except wake it up, and copy_process() doesn't really do
>> anything either?
> 
> I am continuing to dig through that and looking for voluntary preemption points in the process.
> 
> We have none of our own and the generic ones are not invoked - voluntary for all practical purposes does not differ from no-preempt.
> 
> If I have some suspects, I will post their mugshots to the list :)

For the time being it is mostly negative :)

1. The performance after the mm patch is down. By 30-40% on my standard bench.

2. The preemption patches work fine on top (all 3 cases). The performance difference stays.

3. We do not have anything of value to add in term of cond_resched() to the drivers :(
Most drivers are fairly simplistic with no safe points to add this.

4. The upper layer resched points are not enough.
F.E. -EAGAIN from block, retries, etc should all hit paths in the upper layer which cause a
cond_resched(). They are not noticeable. VOLUNTARY behaves nearly identical to non-preemptive.

5. There are a couple of places where an if (condition) schedule() should probably be replaced
with cond_resched(). F.E. interrupt_end(). While it looks more appropriate, the performance
effect is nil.

6. Do we still need force_flush_all() in the arch_dup_mmap()? This works with a non-forced tlb flush
using flush_tlb_mm(mm);

7. In all cases, UML is doing something silly.
The CPU usage while doing find -type f -exec cat {} > /dev/null measured from outside in non-preemptive and
PREEMPT_VOLUNTARY stays around 8-15%. The UML takes a sabbatical for the remaining 85 instead of actually
doing work. PREEMPT is slightly better at 60, but still far from 100%. It just keeps going into idle and I
cannot understand why.

8. All in all I do not have an obvious suspect for the performance difference. No change candidates
either. I also do not have any ideas why it ends up in idle instead of doing work.

> 
>> johannes
>>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
