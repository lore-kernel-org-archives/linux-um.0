Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E396BCDB474
	for <linux-um@archiver.kernel.org>; Fri, 20 Oct 2023 12:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:To:Subject:MIME-Version:
	Date:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o57Jd/+nUZ/b+fXkehFFHti6Gw6iCVy4iUyDSTjF/V4=; b=rB7GVWUF0Lrw8o/qL+pmwEwaca
	7Za1hbdlzRRc3bMwNouBF8JvJ3tZC8UhQqVn3Vn2dCOC1mDhXhMUUsPbPgCDEixr0P5VhRug7cmJm
	gpYaFmzBQJgcu8dtajwYxeIdsPARr6DrDyAS4y1lYLVSzOtJuUQYBWOYHTjrKF+aWXAYcwOwgZsKs
	DKr+zyNXO3qmH8jPiVKQE7NffGpI7PTz5twHLZH5ZuXv63mQtPsOg8XljIUPRMOU/gjNFzZQowzL2
	GXGKQHLRwHtFE1D8Ouo+/H8beIQ3pv8si9FpCDZz/ECp6qmgLOTJY+HPpJiI0VNl8QKr52wnswYdU
	/i/RU7PQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtoqa-002GKS-0y;
	Fri, 20 Oct 2023 12:43:24 +0000
Received: from mx1.uni-rostock.de ([139.30.22.71])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtoqW-002GK1-2U
	for linux-um@lists.infradead.org;
	Fri, 20 Oct 2023 12:43:22 +0000
Received: from 139.30.22.84 by mx1.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Fri, 20 Oct 2023 12:43:14 GMT
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmze; 
 t=1697805794; bh=3B6B5+sicnnajlM/0iPYbh88WO0qQsJpMAFKnZF0L6M=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=ed25519-sha256; b=
 pTCRgYvqXPuFctHWOTvO0Dh9DZBGX5zvDVgx/y0Ayk9e8a0/fKv2HRuTFpy6V/2oNpFTGYHS6r5h4+g8HhuMBQ==
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmz; 
 t=1697805794; bh=3B6B5+sicnnajlM/0iPYbh88WO0qQsJpMAFKnZF0L6M=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=rsa-sha256; b=
 m77Z0y1VX+94+U3e70GAmP3F6YAtnQp7jePoh2bB0V7yN2k2MEJM0fdYAV4kPuDW1W/Yc+EO93l3h6cAG29IBGNGs6Ge7o9ExD4EULVdJjsjhb8M2DGb+REMOyWU6TF/WmXDAh/0kiD62rbRBZkGQhnfkJEQ5ueg3RiXecwb1Wo=
Received: from [139.30.201.32] (139.30.201.32) by mail1.uni-rostock.de
 (139.30.22.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 20 Oct
 2023 14:43:14 +0200
Message-ID: <9768bf43-5a73-4eba-ae4b-532b952f9e04@uni-rostock.de>
Date: Fri, 20 Oct 2023 14:43:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] um: irqs: process outstanding IRQs when unblocking
 signals
Content-Language: de-DE
To: Johannes Berg <johannes@sipsolutions.net>, <linux-um@lists.infradead.org>
References: <20231018123643.1255813-1-benjamin@sipsolutions.net>
 <6082036a-c7f9-4bd5-8234-14957ed9953d@uni-rostock.de>
 <11ab4d47dd8fdcdc2148e00618cc496866016883.camel@sipsolutions.net>
 <549de9c0-05f8-437e-8460-5b013b0cd87b@uni-rostock.de>
 <348de3de5cbd6df96ac51bb07d6e485b2ecc5cc8.camel@sipsolutions.net>
 <d77b66af-249d-4dd1-b78f-730d252bcf84@uni-rostock.de>
 <10c4e61c2e62ba12cf88ddecd84271c5788c1e6b.camel@sipsolutions.net>
 <76ebb80dd7fca6ef2ed7108a541d3ea3c764a3d5.camel@sipsolutions.net>
From: Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>
Organization: =?UTF-8?Q?Universit=C3=A4t_Rostock?=
In-Reply-To: <76ebb80dd7fca6ef2ed7108a541d3ea3c764a3d5.camel@sipsolutions.net>
X-Originating-IP: [139.30.201.32]
X-ClientProxiedBy: email3.uni-rostock.de (139.30.22.83) To
 mail1.uni-rostock.de (139.30.22.84)
X-TM-SNTS-SMTP: ED2997E67E2B315706C2327B4F4E3944EC04C2625BFDC28D5407C135C210F57C2000:8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_054321_137109_A1721865 
X-CRM114-Status: UNSURE (   9.10  )
X-CRM114-Notice: Please train this message.
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

>> Yes but you need to schedule for the interrupt, and you don't
>> necessarily know what 'current time' is at interrupt time.
>>
>> So let's say you have "something" that's scheduled to run at times
>>   - 1000
>>   - 2000
>>   - 3000
>>
>> and free-until is 10000 or something high.
>>
> It can also happen without free-until, then it just depends which one of
> the two - they're running in parallel now (linux doing time-travel
> interrupt handling and adding the event, the other thing continuing to
> schedule and doing the next entry)  - asks the controller first.

Since they happen at the same time, most discrete event simulations make 
the assumption, that the actual order of execution should not be part of 
the semantics.

Although, most of the implementations demand a deterministic order (for 
repetition) but even that requirement is sometimes lifted. So this is no 
contradiction to common discrete event simulations.



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
