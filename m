Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44800CF9C69
	for <linux-um@archiver.kernel.org>; Mon, 23 Sep 2024 13:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LpHcwfQKa+kUVCbdXJu0vErMHGyD14fBJj68BFfAqnw=; b=qN/IDSwdZDygzmnZbKZpXYwBRZ
	gOrXPuoaFSaYD/B5Q3Db0TtHDIWIOfR5aCXO+gDqY9FkjkR3YuqGRonoH9HIIx7GoXJqKqLsPM+cA
	vE9Y7An33qgQuOUUbmjZ/pGvxxE0OFwJvSuP+rqDI6SRsR1p4CB2VBj1FMK+xwTdKeAR5ik3lX1z5
	nCf0ArxMcCorQisiTcAmkTRg0l6CV7dAv1L/axqRfTeDkKZWInqneXlr7YpYA3hy5SJTVSfN9ThNR
	IAbDqhAWlznSh5qF1tzVo7AKSWcd2P5gCQrojyOjsHjsSIgD1SjuuCHAa8aFwLKOz67SrVgTqzpGQ
	iXzYHFUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1ssjYX-0000000HJlO-40ai;
	Mon, 23 Sep 2024 13:56:49 +0000
Received: from mx1.uni-rostock.de ([139.30.22.71])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1ssjYT-0000000HJkT-1SzC
	for linux-um@lists.infradead.org;
	Mon, 23 Sep 2024 13:56:49 +0000
Received: from 139.30.22.84 by mx1.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Mon, 23 Sep 2024 13:56:34 GMT
Received: from [139.30.201.121] (139.30.201.121) by mail1.uni-rostock.de
 (139.30.22.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 23 Sep
 2024 15:56:34 +0200
Message-ID: <a10197a3-e185-4f74-a35c-8f7cb3f43014@uni-rostock.de>
Date: Mon, 23 Sep 2024 15:56:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um: insert scheduler ticks when userspace does not yield
Content-Language: de-DE
To: Benjamin Berg <benjamin@sipsolutions.net>, <linux-um@lists.infradead.org>
References: <20240913201756.1223327-1-benjamin@sipsolutions.net>
 <3ea4c557-df8f-4312-84f6-8dc0b2c2a5f1@uni-rostock.de>
 <b9e99c84ec953cc1459928c103fc4789eacce486.camel@sipsolutions.net>
 <5f2de09a-0af6-46b7-9e9e-6dc0a5d0b885@uni-rostock.de>
 <071d74214d6b2f58e0ea92d8b1cb0381a78304b0.camel@sipsolutions.net>
From: Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>
Autocrypt: addr=Benjamin.Beichler@uni-rostock.de; keydata=
 xjMEW08D4RYJKwYBBAHaRw8BAQdARRw5LUE0LoG/3A8AuH6shJZQcVbm0p/m5fCc3FkaJ6vN
 NEJlbmphbWluIEJlaWNobGVyIDxCZW5qYW1pbi5CZWljaGxlckB1bmktcm9zdG9jay5kZT7C
 lgQTFggAPhYhBOqpEBj9dq+XmH8UxxVpu/kKw5GKBQJiL1tzAhsjBQkNDl+SBQsJCAcCBhUK
 CQgLAgQWAgMBAh4BAheAAAoJEBVpu/kKw5GK/fIA/AsNIaUC4L3WUn7HqKRU4ccUwMRlS2yr
 7Ql08OWoNFI0AQD7td2pcr1LYqDPr0jj+0thDJ2T5XLyeDnun9iyleplA844BFtPA+ESCisG
 AQQBl1UBBQEBB0BcpmVLLpJQJPcC7Y8iIFOpshER+LqiAQiJSS6kZc7YUAMBCAfCiAQYFggA
 JhYhBOqpEBj9dq+XmH8UxxVpu/kKw5GKBQJiL1t0AhsMBQkNDl+SABQJEBVpu/kKw5GKCRAV
 abv5CsORisHWAQDM4ToSmmwlB1bTM+OT42FqgM6R5mpUoEOI4wdfPvw2SAD/XJPzeWWgIsIN
 DtlwmFu6Z0g7RszoHSIslLQb7dfMlQc=
Organization: =?UTF-8?Q?Universit=C3=A4t_Rostock?=
In-Reply-To: <071d74214d6b2f58e0ea92d8b1cb0381a78304b0.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [139.30.201.121]
X-ClientProxiedBy: email3.uni-rostock.de (139.30.22.83) To
 mail1.uni-rostock.de (139.30.22.84)
X-TM-SNTS-SMTP: 154A2EA53AAD2E875933D227C63A378E942C04E9EA1097614EE093837425C0932000:8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240923_065645_749637_E1088FB8 
X-CRM114-Status: GOOD (  16.86  )
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

>> For "clean" semantics of a simulative execution of the kernel, it feels
>> erroneous to advance time even if this value is only read once.
>>
>> In my experiments timer_read was called much more often than I
>> anticipated (e.g., filesystem code).
> Yeah, that does not really sound like something we would want (and it
> will also not help with performance with time-travel=ext).
>
> Looking at the old discussion, it doesn't seem that Johannes was
> against the idea of doing the time insertion only in more specific
> scenarios. So, we "just" need a reasonably elegant solution.
>
> If we accept writing a list of syscalls, then maybe we could just do it
> within handle_syscall and do a um_udelay(1) for any syscall that takes
> a timeout parameter (select, pselect6, poll, ...)? It is going to be a
> pretty long list, but could still be reasonable.

That's actually not what my "hack" did. I filtered out all syscalls, 
that give some information about the current timestamp of the system.

Actually, I think, timeouts are no problem, if we can assure, that a 
timeout is never rounded down to 0. Mostly a direct input of 0 have 
special meanings, or provokes wrong behavior in the first place from 
user space program.

Since time-travel mode has a very limited niche, I would not try to 
prevent every possible dumb behavior that bad user space programs could 
have. I think busy-waiting on a system clock advancement is not the best 
style, but acceptable.

So my list was:

sys_getitimer
sys_gettimeofday
sys_time
sys_timer_gettime
sys_clock_gettime
sys_timerfd_gettime

While overthinking it, I see the possibility to read the access 
timestamps of a file to create an endless loop, so maybe the stat 
syscalls may be included, although this makes me a bit uncomfortable 
again. I tend to say, this "bad" behavior of asking the same information 
over and over again, should only be punished, if it happens multiple times.

I was thinking about, storing the PID of a busy-looped process, and only 
increase time, if the same PID is "suspicious".  However, this "hack" 
becomes more and more costly, which is on the other hand not important 
for timetravel mode.


>
> One neat side effect is that if reading time does not actually cost
> time, then we could implement clock_gettime in the VDSO.

That would exactly not work, because of my comment from before.



