Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4619D6DDED
	for <linux-um@archiver.kernel.org>; Fri, 15 Nov 2024 11:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VXUOaxIWsKMLruHMh1wdTy8Au/sph9ltKzNxBJD4dHE=; b=mEs27uvbqsXZFmo0ecKeh9dc4W
	LQdqdD5nrdV3U9EHwtIhtSRidlCQv2yE9Pk87vIcyp7y9Ya1Epu/Yxnh/JMqKEl5a/2/mCrDpY1wM
	9vN6rZU9VBAPchwrQmFxcn9iKL+FQcZT+JKpEY5sMg6m3ntchMlXGwVFtW4ZIQ2cv6v/tLntFsyod
	GT90qo3AQrMELE48GZNp/MKam/N+iu907GBUH8tiqi2fhEQjR5MtSC6rOTFisdpclVXOcjJfyj1SF
	O9S5nXaOPd8dL9Kia2CoRYgx7+sPA+wev8jBCP/5Fkrc5+nfuYq63q6/AVjwiPvhKaRUB+u/80WGc
	+oAbWWBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBu54-00000002ST9-3iWa;
	Fri, 15 Nov 2024 11:01:38 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBu52-00000002SSY-209v
	for linux-um@lists.infradead.org;
	Fri, 15 Nov 2024 11:01:37 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1tBtWl-00Ez1T-R7; Fri, 15 Nov 2024 10:26:12 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.96)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1tBtWh-00HBFz-1T;
	Fri, 15 Nov 2024 10:26:11 +0000
Message-ID: <e60d2240-4205-472f-9fdd-60b90287c97a@kot-begemot.co.uk>
Date: Fri, 15 Nov 2024 10:26:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 00/13] nommu UML
To: Johannes Berg <johannes@sipsolutions.net>,
 Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org
Cc: ricarkol@google.com, Liam.Howlett@oracle.com
References: <cover.1729770373.git.thehajime@gmail.com>
 <cover.1731290567.git.thehajime@gmail.com>
 <c85bd71e0f4797edf2635cf4059699d1a3862218.camel@sipsolutions.net>
Content-Language: en-US
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
In-Reply-To: <c85bd71e0f4797edf2635cf4059699d1a3862218.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241115_030136_521418_1DA84AFA 
X-CRM114-Status: GOOD (  37.86  )
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



On 15/11/2024 10:12, Johannes Berg wrote:
> On Mon, 2024-11-11 at 15:27 +0900, Hajime Tazaki wrote:
>> This is a series of patches of nommu arch addition to UML.  It would
>> be nice to ask comments/opinions on this.
> 
> So I've been thinking about this for a while now...
> 
> To be clear, I'm not really _against_ it. With around 1200 lines of
> code, it really isn't even big. But I also don't know how brittle it is?
> Testing it is made somewhat difficult with the map-at-zero requirement
> too.
> 
> 
> And really I keep coming back to asking myself what the use case is?
> 
> Is it to test something for no-MMU platforms more easily? But I'm not
> sure what that would be? Have any no-MMU platform maintainers weighed in
> on this, have they even _seen_ it? Is that interesting? Is it more
> interesting than testing an emulated system with the right architecture?
> With it this way you'd probably have to build the right libraries and
> binaries for x86-64 no-MMU, does such a thing already exist somewhere?
> 
> It also doesn't look like it's meant to replace LKL? But even LKL I
> don't really know - are people using it, and if so what for? Seems
> lklfuse is a thing for some BSD folks?
> 
> Is there something else to use it for?
> 
> If it's the first (test no-MMU) then it probably should be smarter about
> not really relying on retpoline. Why is the focus so much on that
> anyway? If testing no-MMU was the most important thing then probably
> you'd have started with seccomp, and actually execute the syscalls from
> that, to not have all those restrictions that come from rewriting
> binaries, rather than ignoring the whole thing. Though of course you did
> add a filter now, but I think it'll just crash?
> So I could perhaps see this use case, but then I'd probably think it
> should be more generic (i.e. able to execute all no-MMU binaries
> including ones that may be using JIT compilation etc.) and not _require_
> retpoline, but rather use it as an optimisation where that's possible
> (i.e. if you can map at zero)?
> 
> If the use case instead of more LKL-type usage, I guess I don't really
> understand it, though to be honest I also don't really fully understand
> LKL itself, but it always _seemed_ very different.
> 
> Somewhat hyperbolically, I'm wondering if it's just a tech demo for
> retpoline?
> 
> So I dunno. Reading through it again there are a few minor things wrt.
> code style and debug things left over, but it's not awful ;-) I'd also
> prefer the code to be more clearly "marked" (as nommu), perhaps putting
> new files into a nommu/ directory, or something like that. But that's
> pretty minor.
> 
> Still it's in a lot of places and chances are it'll make bigger
> refactoring (like seccomp mode) harder. Perhaps if at all it should come
> after seccomp mode and use that to execute syscalls if zpoline can't be
> done, and to catch all the cases where zpoline doesn't work (you have
> that in the docs)?
> 
> What do others think? Would you use it? What for?

I always thought of it as "another LKL". In that case, it can be compared
to LKL on merit and if it is equivalent or better - go into kernel.

If there is another use case, I will be glad to hear it.

> 
> johannes
> 
> 

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

