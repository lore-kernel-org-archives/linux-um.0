Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF61CD4F35
	for <linux-um@archiver.kernel.org>; Fri, 22 Sep 2023 09:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3hI9G1AC9wT0zf8r6AC/W5t2LMAstFS8LZk5jNJx8Ic=; b=dcBPzLhp6P2Qyz
	dIx2AJfHhdzaz23pPOOd8lCRZit4sv0U3fM8rNfCRX9LhjvAKe8BPeX4yaZUgHot8pwr/nd+U/XHh
	Mb//kiwEWPD9w/P3MSfIbBxN9yF6/Z0cqK7xzlhTiU0/45VE4EqY0XfQy0uvFX6H8kzPkkD+VTpql
	6qeY0MDTQ+r5fqCyafKz4F5pbfr34PhAkmzKlXqUkmvRsnw+0ki/mrZyrNCktuKeFoLIB4yKWuCdj
	DEH06TdshcNqkDQ4s08GTEm03wtYk71OUqz7WvVjjSUxVXGs4E2ENKfIqEblO+Ia/ti++Ve/AWbvc
	3NLwZ3WPecUxtIlLFXjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjc7K-008VXD-1d;
	Fri, 22 Sep 2023 09:06:30 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjc7H-008VVr-30
	for linux-um@lists.infradead.org;
	Fri, 22 Sep 2023 09:06:29 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qjc7G-002bNN-4K; Fri, 22 Sep 2023 09:06:26 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qjc7D-002At4-Ia; Fri, 22 Sep 2023 10:06:25 +0100
Message-ID: <40babfb4-ed65-dd0e-23aa-abdfaa9c7149@cambridgegreys.com>
Date: Fri, 22 Sep 2023 10:06:23 +0100
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
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <210bd25b2dcd9e4424923f55053086f67e219cc4.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_020627_967307_BC193214 
X-CRM114-Status: GOOD (  15.80  )
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


On 22/09/2023 09:41, Johannes Berg wrote:
>> Yes, but when does the fork actually happen?
>>
> Looking further at this, now I'm confused as to why it doesn't happen
> _all_ the time.
>
> I think this has pretty much always been wrong, just now we actually
> notice it?
>
> Basically, when we create a new thread (really just mm I think), we say
> the first thing that has to run there is fork_handler(), which
> initialises things the first time around. This calls force_flush_all()
>
> But of course it's called from __schedule(), which has
> preemption/interrupts disabled. So you can't do mmap_read_lock()?

Stupid question.

If we have preemption and interrupts disabled and we are UP do we really need to lock it at this point?

>
> But I'm confused as to why it doesn't seem happen all the time?
>
> johannes
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
