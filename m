Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A4EC4332F
	for <linux-um@archiver.kernel.org>; Fri, 10 Nov 2023 16:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qJPcakNpGlBW7EOUQDEGiF+c6vD6jzSvdzAGZBZrFtI=; b=Rh75/Y3aT7bFq2
	OErZ1zWyiWQzq4r5tfyMrhDABcotM8SSXbUAaUzXWuSRpmdLEaG9Kvxs1+j1UWnhWloU9wdWaJIWq
	wNsm+sFFTMvtV6D8bCe5LtK9403BVByyWj/LZzr8v7KX7XWcDJujsgxW2+JqXLJZrdVxB5xZzzDLq
	3qlYaiJ4IoaYkXUwLyUb9BkS0mLxDkXgwFtjQAM9ur76BBlJotleJ40PIOCwFwou9w8nl7vLoxWsT
	VWo+MefNMg28aTUD5rykSBIxtSxeaD0+yTHHtVjFcF5fA/uf31njqZDfi9Sb8vNfX5ycGcj8vZzzl
	Ajxu+Xulqa/bvWAPBQow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r1UIc-00958s-0G;
	Fri, 10 Nov 2023 16:24:02 +0000
Received: from mx2.uni-rostock.de ([139.30.22.72])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r1UIY-00958S-1o
	for linux-um@lists.infradead.org;
	Fri, 10 Nov 2023 16:24:00 +0000
Received: from 139.30.22.84 by mx2.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Fri, 10 Nov 2023 16:23:54 GMT
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmze; 
 t=1699633434; bh=2eEHm81dFTomuJg2ebthavUKVMsuypuiVijbos6WDvs=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=ed25519-sha256; b=
 738dIKGDynf08zq60Q/RngPxUJWYpxYH5gBADL5MwzL3JQT39YbA+uoqbOt6K0A4j3S11KQb6dhulDNvFtsUBw==
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmz; 
 t=1699633434; bh=2eEHm81dFTomuJg2ebthavUKVMsuypuiVijbos6WDvs=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=rsa-sha256; b=
 LgH/4Hh1XGwLe2I6V17JYJlm0zNAVZNhc+yT/DeZebHfig3z1xYz+pRQ2tmXu0VxEGsgb1EXRt0sCkcu3QzeT/FBKwBhI42F9qjdAIttu2BS71zUURhxgcPUun/La6LPvGtcmBjAQqd7nfs5dw0zx1v36YpE4PcfpQwBiRlTSLQ=
Received: from [139.30.201.32] (139.30.201.32) by mail1.uni-rostock.de
 (139.30.22.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 10 Nov
 2023 17:23:53 +0100
Message-ID: <f63d0965-5bea-4752-ba5c-d4b39b68e6d6@uni-rostock.de>
Date: Fri, 10 Nov 2023 17:23:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 07/11] um: add TIMETRAVEL_REQUEST handler to request
 latest event
Content-Language: de-DE
To: Johannes Berg <johannes@sipsolutions.net>, Richard Weinberger
	<richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
CC: <linux-um@lists.infradead.org>
References: <20231103-bb-timetravel-patches-v1-0-e2c68efcf664@uni-rostock.de>
 <20231103-bb-timetravel-patches-v1-7-e2c68efcf664@uni-rostock.de>
 <883e7458a05db3ec4733c2cb3bf46f2ae4ec9ee6.camel@sipsolutions.net>
From: Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>
Organization: =?UTF-8?Q?Universit=C3=A4t_Rostock?=
In-Reply-To: <883e7458a05db3ec4733c2cb3bf46f2ae4ec9ee6.camel@sipsolutions.net>
X-Originating-IP: [139.30.201.32]
X-ClientProxiedBy: EMAIL2.uni-rostock.de (139.30.22.82) To
 mail1.uni-rostock.de (139.30.22.84)
X-TM-SNTS-SMTP: 5225FF3F118478F134FF286F4B9E1132EB331C8F6EF36940026F9A9AAC8449222000:8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231110_082358_899945_FF113381 
X-CRM114-Status: GOOD (  10.56  )
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

Am 06.11.2023 um 21:33 schrieb Johannes Berg:
> ________________________________
>
> On Fri, 2023-11-03 at 16:41 +0000, Benjamin Beichler wrote:
>> Allow the so called Calendar (or simulation master) to request the
>> latest timetravel event. This can be used in situations, where the
>> former request message from UML to Calendar was missed.
> How ... is it possible to _miss_ a message?! It must've even sent an ACK
> to it...?
I must admit, this patch is older than those for protecting the event 
list. I think mostly I mean here, the UM-instance miss to send the 
current request, not that the calendar missed it :-)

We were able to trigger that situation often, so I made some call to 
make a check what the current state in the instance is.

Benjamin




_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
