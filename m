Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E2DC4332F
	for <linux-um@archiver.kernel.org>; Fri, 10 Nov 2023 11:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:To:Subject:MIME-Version:
	Date:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oJXaesJjtZNYo6ilXkiwZ2DGmF6vMJEhS0BS9tTPIao=; b=QUY2Bg6zbVJAIQ0nOW/RKej4zl
	kArwOHqaG/lCM0s9EeLrSxCy5y7knKFIW5iQ6cwU9EFYsJ3o07wbcn5tc+VwulTLLlSuvT+fOjzuh
	iQ8QAQ03RUdXgxWyCDc2U4p1c2I8OOSR5ImgZy4Aejek8770A46j0LrRDtQ4A48FTWzNJp6GoLz3L
	OXJ+pdKDlUU1SrPiFHIdDvE4ZyDSv+jwCtySpvKMALGgwqSh2sDrICW37gLxmfrEPlr+sCr/5PwTn
	pSQU0CMZBlh8+PgjAgyeqTNC5+6V2fm8eSYM2m1nhTlAk/Iv84ecmHvrRz0/NM15NhO36xOSpetOP
	+YrkXoDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r1PRe-008MnJ-1W;
	Fri, 10 Nov 2023 11:13:02 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r1PRb-008Mmk-1i
	for linux-um@lists.infradead.org;
	Fri, 10 Nov 2023 11:13:01 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1r1PRX-005eWh-Qn; Fri, 10 Nov 2023 11:12:56 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.96)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1r1PRR-00Ahrn-2b;
	Fri, 10 Nov 2023 11:12:55 +0000
Message-ID: <4cec737d-204f-6add-d262-0bf7e2d4d183@kot-begemot.co.uk>
Date: Fri, 10 Nov 2023 11:12:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] um: hostfs: catch EINTR and partial read/write
Content-Language: en-US
To: Benjamin Berg <benjamin@sipsolutions.net>, linux-um@lists.infradead.org
References: <20231110094425.1810667-1-benjamin@sipsolutions.net>
 <f0c614a6-cf3a-b6e1-6f40-ad6d59460fcf@kot-begemot.co.uk>
 <458e033f-1769-fc04-c491-e9a69058c7da@kot-begemot.co.uk>
 <b94879fbac02117df724d0ef8fa4d3b3b400b8aa.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
In-Reply-To: <b94879fbac02117df724d0ef8fa4d3b3b400b8aa.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231110_031259_573427_10F4DA35 
X-CRM114-Status: GOOD (  11.05  )
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



On 10/11/2023 11:10, Benjamin Berg wrote:
> Hi,
> 
> On Fri, 2023-11-10 at 10:56 +0000, Anton Ivanov wrote:
>> On 10/11/2023 10:42, Anton Ivanov wrote:
>>> [SNIP]
>>>
>>> If we are going to use this definition of CATCH_EINTR throughout we
>>> might as well remove the partial read/write code in UBD and other
>>> places.
>>
>> Actually - some of it. In some places it will still be needed (trying
>> to get my head around where this will work and where not).
> 
> Do you mean that we could just use the os_* helpers here and define
> them to catch EINTR and also deal with partial read()/write()?
>

Yep :)


> Benjamin
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
