Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84502CD4F2B
	for <linux-um@archiver.kernel.org>; Fri, 22 Sep 2023 08:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pnOeVahU35VNupWJ6LlrSmi8kfamOgb0GCNm7BbS6wI=; b=m9McrN64dQAUrZ
	ET5dDm43pMCwReCF17ie8BinZmFz9GxMpWGlUGnXOd+d19n11OwdS9KTuW6cqhw4ADAxgDlbZcj2p
	DjLOZzQ3BFhX320Gzyctq1dKnI1Cjxg7F37xdANgoG7+Vr6GAdmHpE98XeDzAvKH/Tfk0ENo0GblF
	0rbWgLGwvtH5Kfm34+TOkqAfIiuENBaF/tfcWtZet88QaANSKHmeY1a/BUOYPsyf3N1pYphMfA0uL
	uLc8s1Ib6NWQAI3bEcqgPJhfgunkLcBeaMQK+OSVMbTIgOARr+Yzi8cWXx3GZTbQri5fWWNykqAtD
	8XWIIVPW3aBqlGAy81EA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjb7O-008JpS-1O;
	Fri, 22 Sep 2023 08:02:30 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjb7M-008Jnk-2M
	for linux-um@bombadil.infradead.org;
	Fri, 22 Sep 2023 08:02:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=+q6YS+JCStw/X0O8j/UmxtxEKeNp0xVR0fZ+3s/njVs=; b=YQuJnADrJJTtTmOsyWYrMKU4Bm
	oMb90R+s8ERVflVx/4ojVHSgeJxnF7O4rqX9nlfeixmLrGnnuVpy7hQ7m8SWz53kdAZa76fmYWfHs
	Zk5O/c4Q8enMOYvqBOfgel8DvglaUP+8UXv3kbVWZ85WC6J6uUxVz5MAQmDKDc2azSum5mPfTWCi+
	CaoxPD0QDk0gMXo5hGyBZoJBs2uGOnSNem3KTWeZxzZrPoLJgZM5J3itBSUDPttG++3nhkifcZnFq
	pRCv1zvtU8vEPJ6BNOx7DU7I32qQaaacvvyhusm9JrfmWLk0aPQPqgea8ndGBHK6GgPXXq2IMZT+L
	wCjCxJ2A==;
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjb7C-00G8ZY-2Z
	for linux-um@lists.infradead.org;
	Fri, 22 Sep 2023 08:02:27 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qjb6s-002bAa-19; Fri, 22 Sep 2023 08:01:58 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qjb6p-0026ha-9K; Fri, 22 Sep 2023 09:01:57 +0100
Message-ID: <28f0be57-829b-9ddf-7b0d-a6c84932cbda@cambridgegreys.com>
Date: Fri, 22 Sep 2023 09:01:54 +0100
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
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <2de07f54b33dc060b75d982d4d8189f12e0d4c45.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_090220_491556_E73322FC 
X-CRM114-Status: GOOD (  17.32  )
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


On 22/09/2023 08:40, Johannes Berg wrote:
> On Fri, 2023-09-22 at 08:38 +0100, Anton Ivanov wrote:
>>> I had enabled CONFIG_DEBUG_ATOMIC_SLEEP because that's actually
>>> something I'd really like to have in our testing.
>>>
>>> But with that issue I don't even know how we get there really. It
>>> doesn't even happen every time we fork?
>>>
>>> I'll dig a little bit, but did you try enabling
>>> CONFIG_DEBUG_ATOMIC_SLEEP also?
>> Will do. I have no crashes over here so I need to trigger this one first.
>>
>> Though, frankly, if it is a race in a tlb flush it may be subject to local conditions. So it will be difficult to reproduce.
>>
> Yes, it might be a race in the fork handler maybe? IOW, whenever we
> actually do fork, it depends on what conditions the rest is in? I'm not
> sure I fully figured out right now how the fork handler is doing all
> this, but I sent my mail before I could since you were discussing :)
>
> But it shouldn't be impossible - while I don't see it for every fork, it
> does happen 8 or 9 times in a very simple test that just boots, pings a
> bit, and then shuts down, so ...

My favorite test which I run on all changes is:

find /usr -type f -exec cat {} > /dev/null \;

On Debian this forks /bin/cat for each file and does IO on it. That test passes here every time :(

However, I did not have debug turned on. So, I would not be surprised if something in the debug

portion of the config makes the crashes more likely.

Otherwise, each fork is a forced tlb_flush_all, so it is a massive tlb exercise. Any bugs, locking, etc are likely to show up.

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
