Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11382CE7A86
	for <linux-um@archiver.kernel.org>; Fri, 22 Sep 2023 20:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:To:Subject:MIME-Version:
	Date:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TmmBch0ConjDTCO0oIUcmnNXmcnxnrEfnA/qDc3PDvc=; b=px6i4aMXTy1KjdL+pDrIL4URq7
	d6Pq8vAfWA7fTWPoBfUl4CY/7ld4/dH/jExgcXtiwhHyNXGiEFMDx9zb9PsNyOKDUHZ+RZiMyh7At
	DONQncXSb3DrTWihMCjD5Ea9l8jlAZqLVNqs2Wudoo9BIq96BLofLfpDCoFNv76U6jt+BrOghJ7hI
	oTF5MvXbQJ9OYQnBwHKVQJ+Vc6IC1SYCV4172t9aevee8plRRgLvGAOLChhO1ELLOiu6fibF/QFve
	3f+WPsLwUZg62w7pbPYMIiagGRdbMmnaFS7vwNxcBhQ2WbJA9TGg2QRECGnysy0eY/gguuq3IDWQU
	/HvrhB/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjmS6-009lPw-14;
	Fri, 22 Sep 2023 20:08:38 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjmS3-009lNg-09
	for linux-um@lists.infradead.org;
	Fri, 22 Sep 2023 20:08:37 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qjmRx-002clS-7W; Fri, 22 Sep 2023 20:08:29 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
	by jain.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qjmRu-002qWW-HB; Fri, 22 Sep 2023 21:08:28 +0100
Message-ID: <9cc73695-b3c7-d194-72e9-9bde142c81f8@cambridgegreys.com>
Date: Fri, 22 Sep 2023 21:08:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] um: clean up mm creation
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
References: <20230922131638.2c57ec713d1c.Id11dff4b349e6a8f0136bb6bb09f6e01a80befbb@changeid>
 <88e0568b-6860-9042-7f8b-ab53edb4242e@cambridgegreys.com>
 <ce18cec1dbacb366f2cf74ebc941c9fbc4b1e116.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
In-Reply-To: <ce18cec1dbacb366f2cf74ebc941c9fbc4b1e116.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_130835_103862_8CCB2A8C 
X-CRM114-Status: GOOD (  13.47  )
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

On 22/09/2023 20:41, Johannes Berg wrote:
> On Fri, 2023-09-22 at 14:41 +0100, Anton Ivanov wrote:
>>
>> It is nearly twice slower than the current approach on a find /usr -type f -exec cat {} > /dev/null \;
>>
> 
> Btw, I cannot reproduce that at all - seems about the same in my tests?
> 
> Is there anything special in your setup?
> 
> Or maybe it's because I'm using hostfs? But not sure why that would
> matter.

I am using a ubd with ext4 sitting on an nfs server. The host, however, 
has more than enough memory to cache all of it, so it is pretty much 
like reading off a ramdisk as it is fully cached.

It is quite clear in that case.

I can retest with nfs (easily) and I can tweak the setup to retest with 
hostfs.

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
