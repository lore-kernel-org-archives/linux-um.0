Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D98F0EB64D7
	for <linux-um@archiver.kernel.org>; Fri, 23 Jun 2023 09:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iEXgr9M6L06yfXF9cbEYeTBvkwLXRd91PGa+EbZTK6w=; b=c20Y/VW+eAaTCF
	dAAWmf/ZwKHcKRFfXxkItDdIN4EvryQp87RT+8mZmg9M4ofSvwwnNgAA1MmLMxazZxs2ABfXqhJAN
	9NsRRniuAGev+3JFQKm1aKZ2FvknUZAZS7lON5YNohYHipAI9OUPUzUtZknsJuQ2Du3kHJlHzevlt
	3TMiA+vfQufgcMxprPAliU/jCT4y6aDbbeiXF0pYM9M7n1Ycrt9Eudh/7qeAVAZWAKihbChCfNOjl
	mM53KlqwrLy1NMC4mPjP0efJvF8PndzDmCeebdQVbwgDqIL/JwbJzcY/iyg1/x6brbXNPxQP1kb0+
	+EIhVBRzCUnbyHnTdiBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qCcgq-002z5h-29;
	Fri, 23 Jun 2023 09:02:48 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qCcgn-002z51-0y
	for linux-um@lists.infradead.org;
	Fri, 23 Jun 2023 09:02:47 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qCcQ5-00Fag8-7p; Fri, 23 Jun 2023 08:45:31 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qCcQ4-00B838-Cn; Fri, 23 Jun 2023 09:45:30 +0100
Message-ID: <4b9ce898-9f3f-229b-c2d0-2c3290b5dea1@cambridgegreys.com>
Date: Fri, 23 Jun 2023 09:45:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: UML for arm64
Content-Language: en-US
To: Benjamin Berg <benjamin@sipsolutions.net>,
 Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
 Richard Weinberger <richard@nod.at>
Cc: linux-um@lists.infradead.org
References: <20230622192247.GA2278576-robh@kernel.org>
 <dc5704a5d452f7432313170ed900975b2b72354f.camel@sipsolutions.net>
 <69707b721698594f96899c050871bcbb3594a9a1.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <69707b721698594f96899c050871bcbb3594a9a1.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230623_020245_389770_77F1A2CC 
X-CRM114-Status: GOOD (  22.94  )
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



On 22/06/2023 21:13, Benjamin Berg wrote:
> Hi,
> 
> On Thu, 2023-06-22 at 21:41 +0200, Johannes Berg wrote:
>> On Thu, 2023-06-22 at 13:22 -0600, Rob Herring wrote:
>>> I'm interested in getting UML working on Arm. Is anyone aware of any
>>> efforts to do this already?
>>
>> Not me ... But yeah, agree that it seems likely to require some
>> refactoring, even if _some_ degree of attempts were made to keep arch-
>> specific things there ...
>>
>> There might be a ton of arch-specific things in the ptrace code too
> 
> At least a lot of the register handling, but that will always be
> somewhat architecture specific.

In the arm case there may be some paging issues.

Arm pages are not necessarily 4096. I tried to implement non-4096 page support for UML a couple of years ago and gave up.

It will be nice if we manage to fix this. End of the day - UML uses mmap(), so it should be able to use page sizing which differs from the host one.

> 
>> ... , so perhaps it'd be easier to start with the seccomp-based model:
>>
>> https://patchwork.ozlabs.org/project/linux-um/list/?series=329466
>>
>> But that's not really done yet either.
> 
> Yes, though I have quite some updates locally that solve the security
> issues (i.e. prevent host syscalls from userspace). So, it does need
> rebasing and I am sure bugfixes, but I think it is getting into a
> pretty good shape overall.
> 
> Either way, the old patchset will give you a good idea about how it all
> works, the changes are mostly in the details. I am happy to push out a
> new version sooner rather than later if it might help with any efforts
> on your side.
> 
> Benjamin
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
