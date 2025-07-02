Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 151A5C83F04
	for <linux-um@archiver.kernel.org>; Wed,  2 Jul 2025 12:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Aldw2Ogfyx1CehWhilkqansZzDF+FITKsrnRoMnX6vs=; b=NE1GDIaSUCXYSZ6lW4j4Wiihzo
	KK+exbnzso3M+9ExTDCY0t33swgjpu1/5WcoBnitXIEiB1jeiwMBlRQJN6D6uanwft8ZG72DCCa3e
	RIMtruMdUUE6PJaqoXpYkcGLJeJ7LT7AMwf4KUs+rDnml1AzxuCRjmel6q7pAi30rA5hb4ZcpC7Rt
	1GvHhlUzYj9ZUbbkR0FmlSqf4Gr1hfSw2K8wvC7czglZQIo+wyK4xTla3ijAOEkwfFk/ng0j7ynxK
	Hlw2y98sWu8M1x6uUmRfQzzllHkevnOSqcQo44alh5hCxQkNTWVLWiKE8+Q2rMgr7WEeHCus6Np5+
	l8YrGEmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWwHC-00000008FxG-2dzG;
	Wed, 02 Jul 2025 12:09:22 +0000
Received: from fhigh-a6-smtp.messagingengine.com ([103.168.172.157])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWvLX-000000085RJ-43h0
	for linux-um@lists.infradead.org;
	Wed, 02 Jul 2025 11:09:49 +0000
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9CDA8140003F;
	Wed,  2 Jul 2025 07:09:46 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 02 Jul 2025 07:09:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1751454586;
	 x=1751540986; bh=Aldw2Ogfyx1CehWhilkqansZzDF+FITKsrnRoMnX6vs=; b=
	WXgW6w+eomuLsLHh0RSY81vtoy5bWUW23cGkehDhUjDpzIJdFI61sF0Jk/Q3E3uY
	u8Crx/xUFkSmoHy6hncBtyuPpFIHRutzY56Sm/0N/a53w459jDwzODypQ5WazuBs
	T8Ya3zfiPRt2H9j/FUTmTRmq4lmARvgF84Z19B+ZdEL9Aln/Ol0PeGbODHfNLYbx
	QCxiv0XkzbWKcG3E06P+vViLppMiJ42QqNETaoLqcU70q+jukYPBJyZdOmdKH2a4
	P9caDH5ya4w6cBECqnoNrDkjtgXsGHL1uDVn8BjdwPSJhX4/UIRlhIDczg82nDaU
	AgU06OLDwRzffqaBytRnrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751454586; x=
	1751540986; bh=Aldw2Ogfyx1CehWhilkqansZzDF+FITKsrnRoMnX6vs=; b=c
	+XxRjHJo+quTz8Gw123qrQVnnMAdNqx76vQnkRhCB48lBfW8M0iYOOOQiZblQVFn
	2NPJfO3poLrovSSdNTPCaK/r2YIexWN3C1QHqmgssSuz5M4b3NAoE5Nl+BBCi5xj
	StaBsFAfwVLHEhFCCp19idmKXnOpMATL03lORVjkHKinai5nzgAnuWbRFnyUMK8A
	KlaYCtPOjTreSBgAKyaDNIKcHKDTwgY6H2PHVjHRYwUz7/6f2L3ZphLVUja/EuQg
	8tR5BuvDWrWK3DP6RS2HkXtqA4Z6Xflz/9tv6JkvdsQEjV8+ArBtEtTA+fNiXFEW
	eT583m1huP1El3T0/s6Mw==
X-ME-Sender: <xms:eRNlaNielCadADjLoXft5MdKL_oWj5FEIXTsEbGksMTRWM_rBN99sA>
    <xme:eRNlaCDOE_t95r6vSkyLq2kMHbyqg9doCYsmjfCot2r9IWoWNzU6mLJCGLPUd5v_8
    uaI7CRD7JjGkjkohh4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehtihifvghirdgsthifsegrnhhtghhrohhuphdrtghomhdprhgtphhtth
    hopegrnhhtohhnrdhivhgrnhhovhestggrmhgsrhhiughgvghgrhgvhihsrdgtohhmpdhr
    tghpthhtoheplhhkphesihhnthgvlhdrtghomhdprhgtphhtthhopehgvggvrhhtsehlih
    hnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehlihhnuhigqdhumheslhhishhtshdr
    ihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrth
    dprhgtphhtthhopehjohhhrghnnhgvshesshhiphhsohhluhhtihhonhhsrdhnvght
X-ME-Proxy: <xmx:eRNlaNHbf2-WQEQPq3hD4e4PqC9ZZqzOgpOt0Z4iYN9ZrIlnzK8Idw>
    <xmx:eRNlaCTKfYBCsQY7whOQWK_-4IJrc4GGRwXOcC_-orMOi98koZKpfg>
    <xmx:eRNlaKwtn4ap_XbvZDVfD8RdANGLx_xF_47gQRiXRYCkxGHE3OfRVg>
    <xmx:eRNlaI6WRRglxEHlobY1iWnKmF3oGOpNSBtkebBMjFw1_POV8NrgMg>
    <xmx:ehNlaLrpsz0nf_rWWEoZOukGy0kz0sz-m9ecY_aF9kh9XJCyivBQMqWU>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 213F6700065; Wed,  2 Jul 2025 07:09:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: T3f3fca64c57e0295
Date: Wed, 02 Jul 2025 13:09:23 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Tiwei Bie" <tiwei.btw@antgroup.com>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>, linux-um@lists.infradead.org,
 "kernel test robot" <lkp@intel.com>
Message-Id: <1724be1e-174c-4837-8768-83a90004f7fe@app.fastmail.com>
In-Reply-To: <c71581d8-350f-4523-862f-5be84358ad8f@antgroup.com>
References: <20250628164740.353989-1-tiwei.btw@antgroup.com>
 <CAMuHMdUa1D3mLtNfOhE9RB7uWyf765-9kiQzG5ku05zz2f+zjw@mail.gmail.com>
 <e7d95c03-5098-401e-b885-1569822cdd0e@app.fastmail.com>
 <c71581d8-350f-4523-862f-5be84358ad8f@antgroup.com>
Subject: Re: [PATCH] um: Turn HAS_IOPORT_MAP off
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250702_040948_329798_FB06AD0B 
X-CRM114-Status: GOOD (  14.16  )
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

On Tue, Jul 1, 2025, at 14:22, Tiwei Bie wrote:
> On 2025/7/1 16:43, Arnd Bergmann wrote:
>> On Tue, Jul 1, 2025, at 10:26, Geert Uytterhoeven wrote:
>> --- a/lib/Kconfig
>> +++ b/lib/Kconfig
>> @@ -381,7 +381,7 @@ config HAS_IOPORT
>>  config HAS_IOPORT_MAP
>>         bool
>>         depends on HAS_IOMEM && !NO_IOPORT_MAP
>> -       default y
>> +       default HAS_IOPORT
>>  
>>  source "kernel/dma/Kconfig"
>>  
>> It seems silly to turn off HAS_IOPORT_MAP on platforms that don't
>> have HAS_IOPORT to start with.
>
> I'm not entirely clear on the meaning of HAS_IOPORT though. It looks
> HAS_IOPORT was introduced to support disabling compilation of the I/O
> accessor functions inb()/outb() and friends [1].

Correct

> And looking at the
> code, xtensa supports IOPORT_MAP [2][3], but doesn't select HAS_IOPORT
> (which is also stated in the commit log in [1]).

xtensa selects NO_IOPORT_MAP, which means that HAS_IOPORT_MAP
gets disabled here:

arch/xtensa/Kconfig:config NO_IOPORT_MAP
arch/xtensa/Kconfig-    def_bool n

The NO_IOPORT_MAP symbol is a bit confusing, but I think it
works as intended, at least on xtensa. There are probably
still some platforms that started selecting NO_IOPORT_MAP
because they have no actual I/O port implementation, but
that still need to be updated to not select HAS_IOPORT.

With my patch above, we should probably stop selecting
NO_IOPORT_MAP on platforms that don't also set HAS_IOPORT,
and keep the HAS_IOPORT_MAP/NO_IOPORT_MAP logic around
only for the few cases that cannot abstract inb()/outb()
through ioread8()/iowrite8(), i.e. Arm RiscPC, m68k q40,
etc.

      Arnd

