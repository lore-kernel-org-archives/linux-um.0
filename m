Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43BCCCE7A81
	for <linux-um@archiver.kernel.org>; Fri, 22 Sep 2023 20:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:To:Subject:MIME-Version:
	Date:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E3RGcNZ4KEOW12jYCbiNurcwulTWARsPIFpmfWh8a+Q=; b=4/y2bT6gfiAnx5gFpkP/UY3hd0
	1Cs1+j2PkufP8BbToWjdNYmLGH4H0bL8z0LgHrAtzLBTNo0AztPqrycHTOYjP9PvRM0hwx8swvnd0
	Mj/S/R6xIcAwkctNvJK4wpRB1xDNQaaOcpgEr0wGJjs0rE9x9QbD7j1xtb/0XbK60uufTVP7GoBVJ
	H8ATdQNhnU90QhftQ1Us1pRzvMYIlJ3LvYlrgY4AWpV6KCY9N81BJOkb6z+LdNt4RBgnekLzvzVm/
	uhDS3oSwvAq7RwOg0a96QZ7szKtDvuYZE/QsCngjYlYJ+Z5eg+S9djmYQ0+6disebfG+nKrkeaJuU
	YACnRlfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjmap-009mG6-2b;
	Fri, 22 Sep 2023 20:17:39 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjmam-009mFW-10
	for linux-um@lists.infradead.org;
	Fri, 22 Sep 2023 20:17:38 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qjmak-002cmm-NY; Fri, 22 Sep 2023 20:17:34 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
	by jain.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qjmai-002r2M-45; Fri, 22 Sep 2023 21:17:34 +0100
Message-ID: <668fbedd-e866-0526-4f9c-8d48a0c8e78c@cambridgegreys.com>
Date: Fri, 22 Sep 2023 21:17:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] um: clean up mm creation
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
References: <20230922131638.2c57ec713d1c.Id11dff4b349e6a8f0136bb6bb09f6e01a80befbb@changeid>
 <88e0568b-6860-9042-7f8b-ab53edb4242e@cambridgegreys.com>
 <ce18cec1dbacb366f2cf74ebc941c9fbc4b1e116.camel@sipsolutions.net>
 <9cc73695-b3c7-d194-72e9-9bde142c81f8@cambridgegreys.com>
 <6bc1a06d1b91b2badd388a4e13d467ed4eace651.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
In-Reply-To: <6bc1a06d1b91b2badd388a4e13d467ed4eace651.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_131736_373301_4A9158ED 
X-CRM114-Status: GOOD (  17.33  )
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

On 22/09/2023 21:12, Johannes Berg wrote:
> On Fri, 2023-09-22 at 21:08 +0100, Anton Ivanov wrote:
>> On 22/09/2023 20:41, Johannes Berg wrote:
>>> On Fri, 2023-09-22 at 14:41 +0100, Anton Ivanov wrote:
>>>> It is nearly twice slower than the current approach on a find /usr -type f -exec cat {} > /dev/null \;
>>>>
>>> Btw, I cannot reproduce that at all - seems about the same in my tests?
>>>
>>> Is there anything special in your setup?
>>>
>>> Or maybe it's because I'm using hostfs? But not sure why that would
>>> matter.
>> I am using a ubd with ext4 sitting on an nfs server. The host, however,
>> has more than enough memory to cache all of it, so it is pretty much
>> like reading off a ramdisk as it is fully cached.
>>
>> It is quite clear in that case.
>>
> Did you have your preempt patch applied also, btw? Because I was working
> off that now.

Yes.

>
> But even with PREEMPT turned off, I see basically no difference in such
> a benchmark. I was running only over /usr/bin/ because otherwise it's
> just too much time on my system overall, but there's basically no
> difference in the 4x4 matrix of
>
>   - preempt off / preempt voluntary
>   - with / without my patch

I can retest with hostfs and nfs over the weekend. For the /usr on the 
test system (Debian base + build deps for the kernel) it is at present:

9m without the patch, 15m with. On top of PREEMPT, PREEMPT is set to ON.

I have not tried without PREEMPT as that is somewhere around 30 mins :)

I can run smaller benches of course (f.e. /usr/bin).

Brgds,

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
