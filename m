Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E115DC25B78
	for <linux-um@archiver.kernel.org>; Tue, 28 May 2024 14:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WuUd35Q6yYjIOOfaAre102PEqivcXRu0RxcYUXtDPR8=; b=MLjXfTgWA6M23nRCmRwDFuPVFV
	xrvB12VxwHhN2eoZb3BS2Hjb3QNIsEu6JTxQop9lOmOu9WtAmgS3Zh6E8dCgX2UKk2SvzVEnIzKxb
	xckCYrQ+3QMyJEx2rHZ4uUFeQteOpZ35s8xBfEl+YeggG74GzGtvTGeiQnqPVV/m/8k2pWarQJjMT
	1r6b68cwVqDmwORg5ESiwjy37yohcRXhlZeBAJdww5goG5akvhjbzVpq9lFyU3lntMqbiQ89z7x27
	M1jHoE71J8XRSpJSEIPE5PIiO2HvP8/R4IZVWZkAKZDv9whMI35maQdalRSqhd4i1lqcnXuNVfNDR
	pFaNGG7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBxZn-00000000xj8-4BZ8;
	Tue, 28 May 2024 14:13:20 +0000
Received: from out0-201.mail.aliyun.com ([140.205.0.201])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBxZk-00000000xh8-1Ar9
	for linux-um@lists.infradead.org;
	Tue, 28 May 2024 14:13:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1716905585; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=WuUd35Q6yYjIOOfaAre102PEqivcXRu0RxcYUXtDPR8=;
	b=pAwOzvFLW6naBE7aI025T+dPEvIWLhVXCOt4trHGpJ9JqQvBc9Uu0xSOg40EZAn+2UYwNGoxrJfUxqkfkyQunXKw6tCQdpkGQS/nR3LomCKeVYmnhy1+KSBWE3xf5+Wp4cZf4CdiOif2+FvhdXbK5x1M4oqopUsWYDPfAB8FqJU=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033070021158;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---.XpWSoFG_1716905582;
Received: from 30.177.166.179(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.XpWSoFG_1716905582)
          by smtp.aliyun-inc.com;
          Tue, 28 May 2024 22:13:03 +0800
Message-ID: <37d6a0e2-bbc2-4a93-bd7c-3cef847eba54@antgroup.com>
Date: Tue, 28 May 2024 22:13:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] um: Do a double clone to disable rseq
To: Johannes Berg <johannes@sipsolutions.net>, benjamin@sipsolutions.net,
 linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
References: <20240528085419.1964424-1-benjamin@sipsolutions.net>
 <20240528085419.1964424-4-benjamin@sipsolutions.net>
 <5f5505da-ba67-421e-b0f5-6a5c19955f27@antgroup.com>
 <4a9d3075304f39b818009081d496b0f245bad450.camel@sipsolutions.net>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <4a9d3075304f39b818009081d496b0f245bad450.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240528_071316_932763_F4DE87B8 
X-CRM114-Status: GOOD (  13.11  )
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

On 5/28/24 7:57 PM, Johannes Berg wrote:
> On Tue, 2024-05-28 at 18:16 +0800, Tiwei Bie wrote:
>> On 5/28/24 4:54 PM, benjamin@sipsolutions.net wrote:
>>> From: Benjamin Berg <benjamin.berg@intel.com>
>>>
>>> Newer glibc versions are enabling rseq support by default. This remains
>>> enabled in the cloned child process, potentially causing the host kernel
>>> to write/read memory in the child.
>>>
>>> It appears that this was purely not an issue because the used memory
>>> area happened to be above TASK_SIZE and remains mapped.
>>
>> I also encountered this issue. In my case, with "Force a static link"
>> (CONFIG_STATIC_LINK) enabled, UML will crash immediately every time
>> it starts up. I worked around this by setting the glibc.pthread.rseq
>> tunable via GLIBC_TUNABLES [1] before launching UML.
>>
>> So another easy way to work around this issue without introducing runtime
>> overhead might be to add the GLIBC_TUNABLES=glibc.pthread.rseq=0 environment
>> variable and exec /proc/self/exe in UML on startup.
>>
> 
> It's also a bit of a question what to rely on - this would introduce a
> dependency on glibc behaviour, whereas doing the double-clone proposed
> here will work purely because of host kernel behaviour, regardless of
> what part of the system set up rseq, how the tunables work, etc.

Makes sense. My previous concern was primarily about the runtime overhead,
but after taking a closer look at the patch, I realized that the double-clone
won't happen on the critical path, so there shouldn't be any performance
issues. I also think the double-clone proposal is better. :)

Regards,
Tiwei

