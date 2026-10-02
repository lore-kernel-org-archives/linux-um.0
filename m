Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2F2CA5FC4
	for <linux-um@archiver.kernel.org>; Fri,  2 Oct 2026 06:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=agu/VYOjK7kNVTsVW73qyg7EU19zxMLH1H7KJB1gnL4=; b=s4lvBAhZM9QjQg5wFarRNI0LPq
	a/VcnHHw6Gy8kjuF3lZ158J2Mtyxzg16S8zEzryZV4BIJqjfKExPXkys2L78J8pK71Oqsl66q3aik
	8Kt28+dHPl3ZLMjGo2uZlomDodHeW4ADZMNZFPhaxe3zQGIaknWZC9jgBURNOHD981Jsx7IXz0Wvt
	V1kLEJszH3vF5u07Q4RDl24faXQbEDQK8ZYdCiIxGe6lc2JNRotU1Q/sqMa+7fF6qBwO+ZtYsV00m
	Y3ormND36qiDmWjzvvNmKlYobQ8rjjKtHX5oXtdx2+jHuRnz44+FVTysCPjM6rtS7zM8xy4tmoqgt
	IklRstkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCWS3-0000000AgVN-00Ob;
	Fri, 02 Oct 2026 06:08:59 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCWS0-0000000AgUf-3fAI
	for linux-um@lists.infradead.org;
	Fri, 02 Oct 2026 06:08:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id ECD706021E;
	Fri,  2 Oct 2026 06:08:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A121F000FF;
	Fri,  2 Oct 2026 06:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790921335;
	bh=agu/VYOjK7kNVTsVW73qyg7EU19zxMLH1H7KJB1gnL4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=k0n9BCZe437AIaCN19WoBh6UpkVlB2OxIuvSMocblVpda5vLUmTgjqGfsI2ij+gc9
	 p+tACWkGa+lgasOyQy9dpA5rbxE+OcN8wJrMmPyYIkS3O37Yhy3rb/w+HGeOVJM/ft
	 GVV7seGQ6yEQrb+r51pcfaI9C8bc/TAJuL3eNo12qZzYKc+B7nW3p+BieXJcWK3hZu
	 +JCjVCQJPTpKp55e6dCyPb0Lbcg0/hp0hB3+CuNLPMFUZl+/KZxrNUJRGDUWc26FIk
	 66aOBLsMXaUrnXxfL14PiUHqIEkBT95W/7polM1nzak6lzT0iCGcHpX5nGMJxg6HWq
	 vcK3+mBQ/Z1WQ==
Message-ID: <a65f4431-d225-4535-b921-00319ceeb2a2@kernel.org>
Date: Fri, 2 Oct 2026 08:08:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] selftests: run tests on nommu architecture
To: Hajime Tazaki <thehajime@gmail.com>, johannes@sipsolutions.net
Cc: ljs@kernel.org, linux-mm@kvack.org, liam@infradead.org, rbm@suse.com,
 akpm@linux-foundation.org, luto@amacapital.net, brendan.jackman@linux.dev,
 liuhangbin@gmail.com, corbet@lwn.net, kees@kernel.org, broonie@kernel.org,
 mhocko@suse.com, rppt@kernel.org, shuah@kernel.org, surenb@google.com,
 vbabka@kernel.org, wad@chromium.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-um@lists.infradead.org,
 geert@linux-m68k.org, daniel@thingy.jp
References: <20260929235711.2287931-1-thehajime@gmail.com>
 <20260929235711.2287931-2-thehajime@gmail.com>
 <bda5eeaa-7868-4d4a-9026-9e99347afd7c@kernel.org> <ar4br2vW7yZGd3gt@gremlin>
 <94759bed23f00d2044005e36be6f72f297e092f0.camel@sipsolutions.net>
 <m2se2o3jyc.wl-thehajime@gmail.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <m2se2o3jyc.wl-thehajime@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 10/2/26 04:38, Hajime Tazaki wrote:
> 
> David, Lorenzo, Johannes,
> 
> thanks for the comments and inputs.
> 
> On Thu, 01 Oct 2026 19:01:45 +0900,
> Johannes Berg wrote:
>>>
>>> I thought maybe uname could help but our LLM overlords tell me no.
>>
>> Hajime originally wanted uname to indicate it, but that caused
>> regressions elsewhere, so we dropped that commit. I guess we could put
>> _something_ back?
> 
> systemd uses uname information and our (old) patch changing the format
> triggered the regression.  thus, we dropped it.
> 
>>> It pointed at something though.
>>>
>>> In fs/proc/meminfo.c:
>>>
>>> #ifndef CONFIG_MMU
>>> 	show_val_kb(m, "MmapCopy:       ",
>>> 		    (unsigned long)atomic_long_read(&mmap_pages_allocated));
>>> #endif
>>>
>>> So MmapCopy in /proc/meminfo tells us definitively, weirdly enough.
>>
>> Hyrum's law and all that, but I guess it's not highly likely to (want
>> to) change :)
> 
> a runtime detection is nice.
> 
> scanning /proc/meminfo might be useful. although it requires to mount
> procfs (we can actually skip procfs mount as it is optional) so, this
> is not 100% portable.
> 
> checking ENOSYS like syscall(SYS_mprotect) might be useful but I
> wasn't sure if this is always the case of NOMMU or not.
> 

I assume there are plenty of other mechanisms. Like testing if fork isn't allowed.

> My original attempt was to use include/generated/autoconf.h; with that
> we can omit environmental variable or command argument of NOMMU=1,
> but gave up with handling standalone build/test case which might miss
> the generated file (and complicate the patch only for the NOMMU
> detection).
> 
> So, specifying NOMMU=1 is my previous, though dirty, conclusion.
Let's avoid making it harder on users by doing some runtime detection.

-- 
Cheers,

David

