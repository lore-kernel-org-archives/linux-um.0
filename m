Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A992C4345F
	for <linux-um@archiver.kernel.org>; Mon, 22 Apr 2024 12:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XqwhHrYYQteewCbPMun6kSxyclp2LgBDGzs5BzliO64=; b=iLCLqguHY6zub6P6XDFDHN0F5b
	Jh+CXAs8AG+5yrecB7ydcjbEg0G6O5rd/qZE17UImlzxd9u2xXgNLz5IvCd3IKR1vJXtnHUn69Usi
	xE0lH7yc+WqHmpZG0Bl7tT2UVzzAA54ZkacMjlURVTp8gSh8u1P24Qy4Mvj9/RTlg0VyYQz6khpoD
	mQC/jQlErOeX5c9UtdgQkeGN0fJGUWjpys/gFMKTDGswSNIGfzeczRCBVnMtgcSJT9c8SYElCbusc
	4cWazbKW9klgIc2QUaqsQ3f1IQaFD5ssjX9Ku669nVjyhRMowBgEYYsO2PhffpptR1OXHMlV8nyZQ
	VjVTlagw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rysTU-0000000DSNt-3e8b;
	Mon, 22 Apr 2024 12:08:44 +0000
Received: from out0-219.mail.aliyun.com ([140.205.0.219])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rysTQ-0000000DSJV-2l4Z
	for linux-um@lists.infradead.org;
	Mon, 22 Apr 2024 12:08:43 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047203;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---.XIhzZyg_1713787696;
Received: from 30.230.85.101(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.XIhzZyg_1713787696)
          by smtp.aliyun-inc.com;
          Mon, 22 Apr 2024 20:08:29 +0800
Message-ID: <f647fa8f-6cc8-4e8e-9c1c-27b9161f3fdb@antgroup.com>
Date: Mon, 22 Apr 2024 20:08:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] Rework stub syscall and page table handling
To: Benjamin Berg <benjamin@sipsolutions.net>, linux-um@lists.infradead.org
References: <20240418092327.860135-1-benjamin@sipsolutions.net>
 <e213cf20-bf70-4e53-a5f2-5ec88cfa6ff5@antgroup.com>
 <4aeca286d181797b7fb02a7fea6bc62a8f616589.camel@sipsolutions.net>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <4aeca286d181797b7fb02a7fea6bc62a8f616589.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240422_050840_903665_BB017E65 
X-CRM114-Status: GOOD (  12.33  )
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

On 4/22/24 3:41 PM, Benjamin Berg wrote:
> On Mon, 2024-04-22 at 10:35 +0800, Tiwei Bie wrote:
>> On 4/18/24 5:23 PM, benjamin@sipsolutions.net wrote:
>>> From: Benjamin Berg <benjamin.berg@intel.com>
>>>
>>> This patchset reworks the stub syscall handling and also redos how page
>>> table updates are tracked and synchronized. Some of this originated in
>>> the SECCOMP patchset, but it became clear that these refactorings make
>>> sense independently as they result in a considerably fewer page faults.
>>
>> I saw your SECCOMP patchset. It's pretty cool! Just wondering if you're about
>> to post a new version soon. :)
> 
> I am planning to work on it again, but it is not very high on my
> priority list. So, could be quite soon or some months :-)
> 
> In the ARM support thread ("UML for arm64"), there were some ideas to
> use FD passing in order to protect memory mappings better. Doing that
> should allow the SECCOMP approach to scale to SMP and will also
> simplify the security model.
> 
> Making those changes will take a bit of thought and experimentation.
> Nothing really big though, it pretty much boils down to using sockets
> for (some of) the synchronization and replacing mprotect with mmap so
> the FD can authorize the operation.

Cool. Thanks for the details! Looking forward to your new version. :)

Regards,
Tiwei

