Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D3C5CD4F33
	for <linux-um@archiver.kernel.org>; Fri, 22 Sep 2023 09:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0SBYMQHcYAmKEwPno6DhnVmHuhTkh8B8o4stz6UyCPA=; b=nAGlnTd+rYgTW2
	DP6nmVVTYMIzwhfavAkzYsFXKxkfCFS+oHp24nfqZ34MLJ+AXX+ltx1dywO4ydOPymGsWrokI7RXM
	4zRoP3UQT8ya8ukhE9za+M4ziScy2xwxpC2QBNbQvLTF6N3tFJTvWDs+ZDr7kF64gPFnQeTvSDAQr
	TM5qYOoDWSI9Wn/tS+aUeizHQ8cwyQAj7bDHqTfTq02C373CIT6uWZLR6uIIY6wd+wMKHEWV1Asgn
	vnUjWIJ7iMQWSO2AqmqS15Tr2EaMHxQmAEoZMNSJjANqE5VmLyO84Yau3b0u3Q4SIW7znR2EEJYmG
	KX6TNRNe3wgjDLU4pCnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjcD3-008WXq-0P;
	Fri, 22 Sep 2023 09:12:25 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjcD0-008WXN-1H
	for linux-um@lists.infradead.org;
	Fri, 22 Sep 2023 09:12:23 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qjcCy-002bP5-FM; Fri, 22 Sep 2023 09:12:20 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
	by jain.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qjcCv-002BG5-R0; Fri, 22 Sep 2023 10:12:19 +0100
Message-ID: <6a459c05-27d6-1b01-853e-9ca615116e10@cambridgegreys.com>
Date: Fri, 22 Sep 2023 10:12:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5] um: Enable preemption in UML
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: richard@nod.at
References: <20230922065212.484385-1-anton.ivanov@cambridgegreys.com>
 <fae1103161cf8c7bac8a138b267d2288ebb32a08.camel@sipsolutions.net>
 <fa4069f1-e026-7672-4f71-9319cdd683a2@cambridgegreys.com>
 <2de07f54b33dc060b75d982d4d8189f12e0d4c45.camel@sipsolutions.net>
 <28f0be57-829b-9ddf-7b0d-a6c84932cbda@cambridgegreys.com>
 <423e8ee5126e1dffda5f8877d07611a21972eea7.camel@sipsolutions.net>
 <210bd25b2dcd9e4424923f55053086f67e219cc4.camel@sipsolutions.net>
 <8a0085b037da53fa8af7c624116e05362b9c0e4b.camel@sipsolutions.net>
 <05c6552775bfb5b5402cd636fb22d91634a87bee.camel@sipsolutions.net>
Content-Language: en-US
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
In-Reply-To: <05c6552775bfb5b5402cd636fb22d91634a87bee.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_021222_457414_F83BC4BB 
X-CRM114-Status: GOOD (  14.09  )
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

On 22/09/2023 10:04, Johannes Berg wrote:
> On Fri, 2023-09-22 at 10:43 +0200, Johannes Berg wrote:
>>>
>>> I think this has pretty much always been wrong, just now we actually
>>> notice it?
>>>
>>> Basically, when we create a new thread (really just mm I think), we say
>>> the first thing that has to run there is fork_handler(), which
>>> initialises things the first time around. This calls force_flush_all()
>>>
> 
> So I thought we could perhaps just force_flush_all() the new mm in
> init_new_context(), but that segfaults userspace immediately.
>

Been there done that.

> So I need to fully understand first (again?) why we even need
> force_flush_all() at this spot, but probably not today.
No idea, but it does not seem to work without it. This is actually
the biggest performance bugbear in UML. If this is fixed, the 
performance will go reasonably close to native.

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
