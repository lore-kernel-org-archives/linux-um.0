Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91EB2CF9C73
	for <linux-um@archiver.kernel.org>; Mon, 23 Sep 2024 21:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tEZ49QXsYnqbRJJBT+sPHhXBqEHfcsGKnzbc92vCdIw=; b=lzQOjCSsLj/UWzpnpfsXlGLYVL
	e1hDoDwmgYl5yapD1jGoEC+1YpzKHE9sR5tVpuR0sKjSzjcx3mThdiJijkHsU1fJUlaO1P5WUHKDM
	i6sI64sIiG0xN1MAoGEkK1kX+t5zJ67LPv+4ZWPoJxKsequCEaMJ4yvBuZ5lT24nofZLiJ+kdT/kY
	4+rX6P1Ak/sfgXBk0Grdy6UL7owmwcbAuZ52lDRBUMspso4huDzCV0po/wKImqhcaTgh3hB0K3PC6
	WoPX/gZSUlHiEo4d0EfZCXIS6eKt7pgRIIsZl4iK/LRe8mVPSGikCsuJT8h0bxyv/6m1bsEW8DhRy
	GDyW1w9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1ssqx6-00000000Xj7-3Q1k;
	Mon, 23 Sep 2024 21:50:40 +0000
Received: from mx2.uni-rostock.de ([139.30.22.72])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1ssqx1-00000000XiC-3Qa9
	for linux-um@lists.infradead.org;
	Mon, 23 Sep 2024 21:50:39 +0000
Received: from 139.30.22.84 by mx2.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Mon, 23 Sep 2024 21:50:28 GMT
Received: from [192.168.0.113] (79.242.135.123) by mail1.uni-rostock.de
 (139.30.22.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 23 Sep
 2024 23:50:28 +0200
Message-ID: <f8fce20b-5330-41ac-9020-3fa9149df581@uni-rostock.de>
Date: Mon, 23 Sep 2024 23:50:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um: insert scheduler ticks when userspace does not yield
Content-Language: de-DE, en-US
To: Benjamin Berg <benjamin@sipsolutions.net>, <linux-um@lists.infradead.org>
References: <20240913201756.1223327-1-benjamin@sipsolutions.net>
 <3ea4c557-df8f-4312-84f6-8dc0b2c2a5f1@uni-rostock.de>
 <b9e99c84ec953cc1459928c103fc4789eacce486.camel@sipsolutions.net>
 <5f2de09a-0af6-46b7-9e9e-6dc0a5d0b885@uni-rostock.de>
 <071d74214d6b2f58e0ea92d8b1cb0381a78304b0.camel@sipsolutions.net>
 <a10197a3-e185-4f74-a35c-8f7cb3f43014@uni-rostock.de>
 <0b7adfea0a3f24963c2baf22f0d6762ad3d82a09.camel@sipsolutions.net>
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
In-Reply-To: <0b7adfea0a3f24963c2baf22f0d6762ad3d82a09.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [79.242.135.123]
X-ClientProxiedBy: email3.uni-rostock.de (139.30.22.83) To
 mail1.uni-rostock.de (139.30.22.84)
X-TM-SNTS-SMTP: 3D6253FEEF01951C2D7A53862106A0757022204387A2A79DC8607B9D55C7100C2000:8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240923_145036_173955_08CD2D1D 
X-CRM114-Status: GOOD (  33.81  )
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

Hi,

Am 23.09.2024 um 16:48 schrieb Benjamin Berg:
>> Actually, I think, timeouts are no problem, if we can assure, that a
>> timeout is never rounded down to 0. Mostly a direct input of 0 have
>> special meanings, or provokes wrong behavior in the first place from
>> user space program.
> I don't think that is a problem. The kernel should guarantee that a
> timeout never fires too early.
>
> I believe in the case of the linked python code, the timeout fires at
> exactly the correct time. And then the python code (incorrectly)
> detects that the timeout has not passed and tries to "select" again
> with a timeout of exactly zero.
>
> Really, that implementation is just buggy in subtle ways. It could
> probably just trust the kernel to not wake up early. And, if it does
> check whether the timeout has passed, then it should just accept the
> exact time.

Maybe I'm doing a captain obvious here, but I had the impression this 
code was written this way, to handle interruptions by signals and not to 
doubt the time accuracy. Possibly I'm totally wrong, but it seems quite 
elegant to simply use time here to avoid that dance to mask signals or 
check for interruptions etc.

I believe this code was written in mind that time() will advance, so 
this will never be an endless loop, so even the corner case that timeout 
was 0 would be covered by this.

>> Since time-travel mode has a very limited niche, I would not try to
>> prevent every possible dumb behavior that bad user space programs could
>> have. I think busy-waiting on a system clock advancement is not the best
>> style, but acceptable.
>>
>> So my list was:
>>
>> sys_getitimer
>> sys_gettimeofday
>> sys_time
>> sys_timer_gettime
>> sys_clock_gettime
>> sys_timerfd_gettime
>>
>> While overthinking it, I see the possibility to read the access
>> timestamps of a file to create an endless loop, so maybe the stat
>> syscalls may be included, although this makes me a bit uncomfortable
>> again. I tend to say, this "bad" behavior of asking the same information
>> over and over again, should only be punished, if it happens multiple times.
>>
>> I was thinking about, storing the PID of a busy-looped process, and only
>> increase time, if the same PID is "suspicious".  However, this "hack"
>> becomes more and more costly, which is on the other hand not important
>> for timetravel mode.
> Maybe a stupid question, but aren't we overthinking this in general?
>
> While I think that Johannes' solution to make reading the time cost
> time is kind of ingenious, I really wonder how much of an issue this
> actually is. Because if this is just a few userspace applications and
> libraries misbehaving, then we might as well fix the issue there
> instead of doing anything special in UML.

Your point is right, and such bugs may be fixed in user space. On the 
other hand, what about software we can't or don't want to fix, which in 
the wild simply works. For my future use cases, I will run code, that 
I'm not able to compile myself. I would even consider to have a runtime 
switch to change the behavior of this hack, to reduce the overhead in 
simulations that behave nicely, but have some quick workaround for 
misbehaving code.

And sorry for repeating myself, but I believe, that busy waiting on an 
increasing timer value is not the best style, but considered okay/normal 
for some use cases. So I think it would be helpful to be able to execute 
such user space code.

But I want to bring in another idea: Could we use an ebpf program to 
dynamically hook into syscalls and do a timetravel_update or something 
similar? Actually, I do not know whether ebpf works normally in UM, but 
that way it would be flexible and moving the dirty hacks into small 
portions outside the kernel. From what I understand, we would need to 
add an ebpf callable wrapper for the time travel update function, isn't it?

>
>>> One neat side effect is that if reading time does not actually cost
>>> time, then we could implement clock_gettime in the VDSO.
>> That would exactly not work, because of my comment from before.
> Of course. It is just that I have always in the back of my mind that
> syscalls and pagefaults (including minor faults) are really expensive
> in UML. So if the hack is moved elsewhere then implementing
> clock_gettime in the vDSO could be an easy win to speed up the
> simulation.

Mhh I did only a quick look into "arch/x86/um/vdso/um_vdso.c" and from 
my understanding, currently every vdso call is converted into syscalls 
of the host. So we need much more code to use here the time travel 
clock, isn't it? Of course, my proposed ebpf hook would not work here 
either...


>
> Benjamin
>
  kind regards

(the other) Benjamin



