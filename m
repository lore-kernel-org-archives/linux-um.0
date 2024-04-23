Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1993CC4345F
	for <linux-um@archiver.kernel.org>; Tue, 23 Apr 2024 05:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gr177csz7YXZ2gV7DqphrDjutpc344fOWXAI8IFCRzc=; b=c/jTZIBVZs1KKDZLh7AwI+gKZ/
	ByDdVPbZC4zI9seKddV7s3IMo2Z11i46/F18pxeq3jt4uabaL0bGcv4S8ozQSEWQggAuvYydM5x+3
	dY4JQs4j+Q9tjiY7tnNRToHs0WtW9nM4S4nW3dlkN87zbNDG+2R9yPTJzUWLuPo4+XcVHLmI0f1cn
	szrmlrgg1i4Df7WGZEbNX8cXXeDFqz1XjMpsEP40FPZuAYHraGClp7jFNoMyxAKzdtita1c5w2Ite
	0Miq7Lqod6/pyIfAS9YADW8mNXKN+xHNuovWzHQLK1JJ2rpS7JB8RXlE6QgoEqDCIUP5BjSX3sZgp
	eoqzraig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rz8GL-0000000Fzau-1zHm;
	Tue, 23 Apr 2024 05:00:13 +0000
Received: from out0-213.mail.aliyun.com ([140.205.0.213])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rz8GH-0000000FzWa-22ou
	for linux-um@lists.infradead.org;
	Tue, 23 Apr 2024 05:00:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1713848401; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Gr177csz7YXZ2gV7DqphrDjutpc344fOWXAI8IFCRzc=;
	b=GiyH7a4cMwNBNJNey2jt9pnpoET9N8qEsG3iuphgRtZU5A7twhxzEPJxrItk/xXfwca6MIW9KbWDsLzuKHvvXPWYx8epX0F2xroFb6bQAekTSB5TaPvzFWFMvOrUnVNptCVXz4uC++GpYosPkbSoIj6hl4C+PG8nBuNZt4FMS1I=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047207;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---.XJ9E0MI_1713848392;
Received: from 30.230.91.3(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.XJ9E0MI_1713848392)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 12:59:57 +0800
Message-ID: <d4be70dc-ab5a-415d-aaf5-0b92cd49b1e6@antgroup.com>
Date: Tue, 23 Apr 2024 12:59:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: -Wmissing-prototypes warnings in user-mode linux
To: Richard Weinberger <richard@nod.at>, Jani Nikula <jani.nikula@intel.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 anton ivanov <anton.ivanov@cambridgegreys.com>,
 linux-um <linux-um@lists.infradead.org>, intel-xe@lists.freedesktop.org,
 Lucas De Marchi <lucas.demarchi@intel.com>
References: <87jzmh2chs.fsf@intel.com>
 <5d1dfb9fce5d7647ff3203080416eadc9806059a.camel@sipsolutions.net>
 <87frx52btl.fsf@intel.com>
 <1006521759.15130.1713818128220.JavaMail.zimbra@nod.at>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <1006521759.15130.1713818128220.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240422_220009_702849_15D97D6D 
X-CRM114-Status: UNSURE (   8.79  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Hi Richard,

On 4/23/24 4:35 AM, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
>> Von: "Jani Nikula" <jani.nikula@intel.com>
>> An: "Johannes Berg" <johannes@sipsolutions.net>, "richard" <richard@nod.at>, "anton ivanov"
>>> I think this series addressed most already?
>>>
>>> https://patchwork.ozlabs.org/project/linux-um/list/?series=393619
>>>
>>> But I haven't checked myself yet.
>>
>> Oh, nice, it certainly helps!
>>
>> But after applying that in my branch, I do still get a bunch of
>> warnings.
> 
> Exactly.
> 
> Tiwei Bie, with your v3 series[0] applied,
> I still see the following build warnings:

Thanks for trying that series! As stated in its cover letter [0], some
remaining -Wmissing-prototypes warnings are as expected.

That series includes only the straightforward fixes and has addressed
a large portion of the -Wmissing-prototypes warnings.

I plan to fix the remaining warnings in a separate smaller followup series.
But the fixes in it might not be as straightforward, and some might be
contentious. I will post it tonight or tomorrow.

[0] https://patchwork.ozlabs.org/project/linux-um/cover/20240306101925.1088870-1-tiwei.btw@antgroup.com/

Regards,
Tiwei

> arch/x86/um/signal.c:559:6: warning: no previous prototype for ‘sys_rt_sigreturn’ [-Wmissing-prototypes]
>   559 | long sys_rt_sigreturn(void)
>       |      ^~~~~~~~~~~~~~~~
> arch/um/os-Linux/mem.c:28:6: warning: no previous prototype for ‘kasan_map_memory’ [-Wmissing-prototypes]
>    28 | void kasan_map_memory(void *start, size_t len)
>       |      ^~~~~~~~~~~~~~~~
> arch/um/os-Linux/mem.c:212:13: warning: no previous prototype for ‘check_tmpexec’ [-Wmissing-prototypes]
>   212 | void __init check_tmpexec(void)
>       |             ^~~~~~~~~~~~~
> arch/x86/um/os-Linux/registers.c:146:15: warning: no previous prototype for ‘get_thread_reg’ [-Wmissing-prototypes]
>   146 | unsigned long get_thread_reg(int reg, jmp_buf *buf)
>       |               ^~~~~~~~~~~~~~
> arch/um/os-Linux/skas/process.c:107:6: warning: no previous prototype for ‘wait_stub_done’ [-Wmissing-prototypes]
>   107 | void wait_stub_done(int pid)
>       |      ^~~~~~~~~~~~~~
> arch/um/os-Linux/skas/process.c:683:6: warning: no previous prototype for ‘__switch_mm’ [-Wmissing-prototypes]
>   683 | void __switch_mm(struct mm_id *mm_idp)
>       |      ^~~~~~~~~~~
> arch/x86/um/vdso/um_vdso.c:16:5: warning: no previous prototype for ‘__vdso_clock_gettime’ [-Wmissing-prototypes]
>    16 | int __vdso_clock_gettime(clockid_t clock, struct __kernel_old_timespec *ts)
>       |     ^~~~~~~~~~~~~~~~~~~~
> arch/x86/um/vdso/um_vdso.c:30:5: warning: no previous prototype for ‘__vdso_gettimeofday’ [-Wmissing-prototypes]
>    30 | int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
>       |     ^~~~~~~~~~~~~~~~~~~
> arch/x86/um/vdso/um_vdso.c:44:21: warning: no previous prototype for ‘__vdso_time’ [-Wmissing-prototypes]
>    44 | __kernel_old_time_t __vdso_time(__kernel_old_time_t *t)
>       |                     ^~~~~~~~~~~
> arch/x86/um/vdso/um_vdso.c:57:1: warning: no previous prototype for ‘__vdso_getcpu’ [-Wmissing-prototypes]
>    57 | __vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused)
>       | ^~~~~~~~~~~~~
> 
> [0] https://patchwork.ozlabs.org/project/linux-um/list/?series=397986
> 
> Thanks,
> //richard


