Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DFCCE7A88
	for <linux-um@archiver.kernel.org>; Sat, 23 Sep 2023 05:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:To:Subject:MIME-Version:
	Date:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2nhxrkSAeTv5Qg0amkHst9Xfy4XTOFGA/d8LFCqb0k8=; b=OBalsiQ9nYb5sZsTYw6T4Tmp6b
	SLuw9Ow+U2kUitBx5rV7zoX36wqLDpSAlVVfSr8z/KnLUsUaqs6+AgaYp3RHlYpcvuY9jLOxA917x
	8Ssm0JfPfgP0F17/ZqQHzIy1R0igxSqaB0wvvkADg/UWLzfiIDikZgsUrHS3WoYwHMEIuB/UG/md5
	WqeC/6pPauX16DJKP6nJB/Ym2QbcrkaIueXrS7G6+R97cynfEQSvsPAa5tf5BPvaRSXpSIJe3m4yl
	797K9Taga5KghhdLgAGffUNuS5f2+7YS7B34dcqBA8rxZ1MQ9YseIk9egeDwJhmQmcP7TJO8bjnzZ
	PYyKZANw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjvDS-00AT2A-0O;
	Sat, 23 Sep 2023 05:30:06 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjvDO-00AT1G-2P
	for linux-um@lists.infradead.org;
	Sat, 23 Sep 2023 05:30:04 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qjvCz-002e35-Hw; Sat, 23 Sep 2023 05:29:37 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
	by jain.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qjvCw-003Lty-TO; Sat, 23 Sep 2023 06:29:37 +0100
Message-ID: <44c606c0-c846-0bcb-0269-66974dee3c4b@cambridgegreys.com>
Date: Sat, 23 Sep 2023 06:29:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] um: clean up mm creation
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
References: <20230922131638.2c57ec713d1c.Id11dff4b349e6a8f0136bb6bb09f6e01a80befbb@changeid>
 <88e0568b-6860-9042-7f8b-ab53edb4242e@cambridgegreys.com>
 <ce18cec1dbacb366f2cf74ebc941c9fbc4b1e116.camel@sipsolutions.net>
 <9cc73695-b3c7-d194-72e9-9bde142c81f8@cambridgegreys.com>
 <6bc1a06d1b91b2badd388a4e13d467ed4eace651.camel@sipsolutions.net>
Content-Language: en-US
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
In-Reply-To: <6bc1a06d1b91b2badd388a4e13d467ed4eace651.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_223002_789163_F1F50A0C 
X-CRM114-Status: GOOD (  15.92  )
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
>>>>
>>>> It is nearly twice slower than the current approach on a find /usr -type f -exec cat {} > /dev/null \;
>>>>
>>>
>>> Btw, I cannot reproduce that at all - seems about the same in my tests?
>>>
>>> Is there anything special in your setup?
>>>
>>> Or maybe it's because I'm using hostfs? But not sure why that would
>>> matter.
>>
>> I am using a ubd with ext4 sitting on an nfs server. The host, however,
>> has more than enough memory to cache all of it, so it is pretty much
>> like reading off a ramdisk as it is fully cached.
>>
>> It is quite clear in that case.
>>
> 
> Did you have your preempt patch applied also, btw? Because I was working
> off that now.
> 
> But even with PREEMPT turned off, I see basically no difference in such

One more thing. Is your find "real" /bin/find or busybox.

Real find will exec() /bin/cat
Busybox find will shortcut internally to the code of its cat applet. As 
a result it is much faster and there is no exec overhead.

> a benchmark. I was running only over /usr/bin/ because otherwise it's
> just too much time on my system overall, but there's basically no
> difference in the 4x4 matrix of
> 
>   - preempt off / preempt voluntary
>   - with / without my patch
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
