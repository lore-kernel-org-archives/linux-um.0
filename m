Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A014AC10F04
	for <linux-um@archiver.kernel.org>; Mon,  4 Dec 2023 12:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OCIXVOliNM/mKvIQEs2vJxlTlzv3NC4XIbxWAn96+Ls=; b=wDV2TA9NaZPi3qeclB4aEGbahH
	lJndwOocq+OrJSuABOlp8RjNnA+xy0pDTrRFa1TPlwfCqzIVrfp+QiBDn5OI5TzVwMPleCFt7nTHa
	OyjuKH68YDjzGdaMQuez0XEsryjztvor5LmK7tlrSJ+bfr82G74NbDK0B0mDDXkeQIvli6VsluBi0
	dUyWTTxkmtigH7D2Fl6BBBPcON2AP5HoT1//BsaSwgwPPak88ny+SCN2okNrzckHJNhuZiXrBphAg
	GXaWk5TOMsRjryE87BziAWa4SvXySNN98rvf7+Z/EkK8mEA7+85/IK/sY8lhq22uF9OZ44YIlVN5X
	G/9//Rng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rA7j5-003naP-10;
	Mon, 04 Dec 2023 12:07:03 +0000
Received: from mx1.uni-rostock.de ([139.30.22.71])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rA7iz-003nVZ-1p
	for linux-um@lists.infradead.org;
	Mon, 04 Dec 2023 12:07:02 +0000
Received: from 139.30.22.84 by mx1.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Mon, 04 Dec 2023 12:06:45 GMT
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmze; 
 t=1701691605; bh=OCIXVOliNM/mKvIQEs2vJxlTlzv3NC4XIbxWAn96+Ls=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=ed25519-sha256; b=
 Wp1y7VjEAET3niNQ+QN86zfAKFiRJFGS9odoGivA3yfsm//StMnWDZ/lM+VxvgB76jlvkm1+R/CDY9vWw/u5Cw==
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmz; 
 t=1701691605; bh=OCIXVOliNM/mKvIQEs2vJxlTlzv3NC4XIbxWAn96+Ls=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=rsa-sha256; b=
 qAgQWY57jeYONfIMve0kMF2WH2kRlp0IPOUUsFiVmN/lbRtgwH3ofWVwfEU08OJN1Uinl8ynIQUAO+TlRqSeKO0hQvozLYy0W004hgb7Bedst9RMTuHa3Dt/nQYGYPl6YOOLyvUlIei2zq+tMhiNH0xqnac1KLJG5AT7FMDJewI=
Received: from [139.30.201.32] (139.30.201.32) by mail1.uni-rostock.de
 (139.30.22.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 4 Dec
 2023 13:06:44 +0100
Message-ID: <6cffe622-bf4b-4cba-bfac-037c5aa89a25@uni-rostock.de>
Date: Mon, 4 Dec 2023 13:06:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: jitterentropy vs. simulation
Content-Language: de-DE
To: Johannes Berg <johannes@sipsolutions.net>, Anton Ivanov
	<anton.ivanov@kot-begemot.co.uk>, <linux-um@lists.infradead.org>
CC: <linux-crypto@vger.kernel.org>, =?UTF-8?Q?Stephan_M=C3=BCller?=
	<smueller@chronox.de>
References: <e4800de3138d3987d9f3c68310fcd9f3abc7a366.camel@sipsolutions.net>
 <7db861e3-60e4-0ed4-9b28-25a89069a9db@kot-begemot.co.uk>
 <8ddb48606cebe4e404d17a627138aa5c5af6dccd.camel@sipsolutions.net>
From: Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>
Organization: =?UTF-8?Q?Universit=C3=A4t_Rostock?=
In-Reply-To: <8ddb48606cebe4e404d17a627138aa5c5af6dccd.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.30.201.32]
X-ClientProxiedBy: EMAIL2.uni-rostock.de (139.30.22.82) To
 mail1.uni-rostock.de (139.30.22.84)
X-TM-SNTS-SMTP: 6F2B22E2EF85B60F7C1A3ABE4129E3D73B303944A0C3E9D993A51785A6D002632000:8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_040659_372745_9F4BE729 
X-CRM114-Status: GOOD (  18.27  )
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

Am 01.12.2023 um 19:35 schrieb Johannes Berg:
> [I guess we should keep the CCs so other see it]
> 
>> Looking at the stuck check it will be bogus in simulations.
> 
> True.
> 
>> You might as well ifdef that instead.
>>
>> If a simulation is running insert the entropy regardless and do not compute the derivatives used in the check.
> 
> Actually you mostly don't want anything inserted in that case, so it's
> not bad to skip it.
> 
> I was mostly thinking this might be better than adding a completely
> unrelated ifdef. Also I guess in real systems with a bad implementation
> of random_get_entropy(), the second/third derivates might be
> constant/zero for quite a while, so may be better to abort?
Maybe dump question: could we simply implement a timex.h for UM which 
delegates in non-timetravel mode to the x86 variant and otherwise pull 
some randomness from the host or from a file/pipe configurable from the 
UML commandline for random_get_entropy()?

I would say, if the random jitter is truly deterministic for a 
simulation, that seems to be good enough.

Said that, it would be nice to be able to configure all random sources 
to pull entropy from some file that we are able to configure from the 
command line, but that is a different topic.

> 
> In any case, I couldn't figure out any way to not configure this into
> the kernel when any kind of crypto is also in ...
> 
> johannes
> 
> 





