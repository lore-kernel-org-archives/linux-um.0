Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CA2CE7A94
	for <linux-um@archiver.kernel.org>; Mon, 25 Sep 2023 13:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:To:Subject:MIME-Version:
	Date:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L1k0HExPgIzm9+FqD9ylp2r7iNsUHwQtVEdXol+cUFI=; b=pNqmacZ3jl16VpLoYVRIDMwg3c
	a9F51AGxrWMdXGHoo+sfBBqly4rzaq5WFGfvF9pcQ1tJ3T0y/xoUONRiPhiQS3ud0C75m30O8GE/r
	aZiK09TTpNuMGCgLQvG0aqLrHjqcOVeFTOS7NvMwoyExCPWhnf9sGCR8qnLB5bKTyvxlhdnffc0sv
	Fc3O+NPvbAvvfvMu9pka7OlLwmBBtl9vfzLpdF4RSZbVeeZqlRP7bJF40Lyrp/PFxosrWUR1k5JIX
	htFokaxP8+SclotrFf5NgKjk+soUg0jTja1DnTp5YyMWykYfNcjmUVVjLKN7FPHfHh0CAd/jOrAl8
	SSLP5wog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qkljT-00ELnW-34;
	Mon, 25 Sep 2023 13:34:39 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qkljR-00ELmo-1c
	for linux-um@lists.infradead.org;
	Mon, 25 Sep 2023 13:34:38 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qkljQ-002nhx-5B; Mon, 25 Sep 2023 13:34:36 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.96)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qkljN-006FHe-18;
	Mon, 25 Sep 2023 14:34:35 +0100
Message-ID: <2242739e-d53c-4ab6-55f6-7e63e4734475@cambridgegreys.com>
Date: Mon, 25 Sep 2023 14:34:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 0/3] um: clean up mm creation - another attempt
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
References: <20230922223737.1206223-4-johannes@sipsolutions.net>
 <bcc1170b-89b9-7c5e-d047-7055f97c1716@cambridgegreys.com>
 <4f79b781db6d5892c86e103733c7c30cda78afdf.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <4f79b781db6d5892c86e103733c7c30cda78afdf.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230925_063437_534751_06F3AC6C 
X-CRM114-Status: GOOD (  10.40  )
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



On 25/09/2023 14:33, Johannes Berg wrote:
> On Mon, 2023-09-25 at 14:29 +0100, Anton Ivanov wrote:
>> I have rebased the preempt patch on top of these series.
>>
>> PREEMPT works with some performance decrease.
>>
>> VOLUNTARY deadlocks early in boot around the time it starts loading modules.
>>
>> non-preemptible deadlocks very early in boot.
>>
> 
> Well I guess that means there's still some issue in here? Hmm.
> 
> Now I don't understand anything anymore, I guess.

UML VM and process handling.

And here be dragons :)

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
