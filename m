Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 097EBCD3445
	for <linux-um@archiver.kernel.org>; Fri,  8 May 2026 17:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fa/e34xs+vWwC/zpkG0Qp4UvPM0UzqYtHRg0W2k7uTo=; b=TdlSzU1sctqRsYE/fvu6W888OC
	utRJmpbjKgrnkHR5v9xMYKs47BAvmCNT+qC7L3bpzZKhyKUX0xRHUdOBbqx+jB4Bxkwuj8Gt2BYkW
	NqSZUB+sK4Znm1uckg0y5EVBWLFg67lbQYfsYyR0WkMpaihGfaQgc0fdacn2O5aKgZAnKODh51BDA
	m81jbVh5OcfRcx7Y6k2DcGqg4jEeFj4hwwQRN3TNwVqjl3A0wDQTfR9grivyuyJspUyQOqnKoqk8b
	jgZRSAWeLQJZ+SumtAiJG9+V2Dfm1G+GuN6e8F8Bdx3UTylbB4JFTVtzVW5JzgigXG09l67r05qPG
	LCyjG/gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLPFG-00000007B88-0yJ0;
	Fri, 08 May 2026 17:44:14 +0000
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLPFD-00000007B7a-273Y;
	Fri, 08 May 2026 17:44:11 +0000
Message-ID: <7bb54e36-44cf-4816-b66d-a18534ea05c8@infradead.org>
Date: Fri, 8 May 2026 10:44:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] docs: fix repeated prepositions across documentation
To: Shuah Khan <skhan@linuxfoundation.org>,
 Adrien Reynard <reynard.adrien.08@gmail.com>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Jonathan Corbet <corbet@lwn.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "open list:KASAN" <kasan-dev@googlegroups.com>,
 "open list:DOCUMENTATION PROCESS" <workflows@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
 "open list:USER-MODE LINUX (UML)" <linux-um@lists.infradead.org>
References: <20260508163804.16267-1-reynard.adrien.08@gmail.com>
 <2b771350-0562-4cb1-b9b3-cc3ce59b1a63@linuxfoundation.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <2b771350-0562-4cb1-b9b3-cc3ce59b1a63@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 5/8/26 10:23 AM, Shuah Khan wrote:
> On 5/8/26 10:38, Adrien Reynard wrote:
> 
> Missing commit log
> 
>> Signed-off-by: Adrien Reynard <reynard.adrien.08@gmail.com>
>> ---
>>   Documentation/dev-tools/kasan.rst                   | 2 +-
>>   Documentation/networking/switchdev.rst              | 2 +-
>>   Documentation/virt/uml/user_mode_linux_howto_v2.rst | 2 +-
>>   3 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
>> index 4968b2aa60c8..3a8bd40ad905 100644
>> --- a/Documentation/dev-tools/kasan.rst
>> +++ b/Documentation/dev-tools/kasan.rst
>> @@ -392,7 +392,7 @@ reserved to tag freed memory regions.
>>   If the hardware does not support MTE (pre ARMv8.5), Hardware Tag-Based KASAN
>>   will not be enabled. In this case, all KASAN boot parameters are ignored.
>>   -Note that enabling CONFIG_KASAN_HW_TAGS always results in in-kernel TBI being
>> +Note that enabling CONFIG_KASAN_HW_TAGS always results in-kernel TBI being
> 
> This is correct the way it is - no need to change this. "results in in-kernel"

ack.

>>   enabled. Even when ``kasan.mode=off`` is provided or when the hardware does not
>>   support MTE (but supports TBI).
>>   diff --git a/Documentation/networking/switchdev.rst b/Documentation/networking/switchdev.rst
>> index 2966b7122f05..948bce44ca9b 100644
>> --- a/Documentation/networking/switchdev.rst
>> +++ b/Documentation/networking/switchdev.rst
>> @@ -162,7 +162,7 @@ The switchdev driver can know a particular port's position in the topology by
>>   monitoring NETDEV_CHANGEUPPER notifications.  For example, a port moved into a
>>   bond will see its upper master change.  If that bond is moved into a bridge,
>>   the bond's upper master will change.  And so on.  The driver will track such
>> -movements to know what position a port is in in the overall topology by
>> +movements to know what position a port is in the overall topology by
> 
> This looks fine.

Change not needed.

>>   registering for netdevice events and acting on NETDEV_CHANGEUPPER.
>>     L2 Forwarding Offload
>> diff --git a/Documentation/virt/uml/user_mode_linux_howto_v2.rst b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
>> index c37e8e594d12..7b08738c30aa 100644
>> --- a/Documentation/virt/uml/user_mode_linux_howto_v2.rst
>> +++ b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
>> @@ -1092,7 +1092,7 @@ be formatted as plain text.
>>     Developing always goes hand in hand with debugging. First of all,
>>   you can always run UML under gdb and there will be a whole section
>> -later on on how to do that. That, however, is not the only way to
>> +later on how to do that. That, however, is not the only way to
> 
> This change is not needed. If at all add a comma after "later" to make
> a distinction between the use two back to back "on"s
> 
>  "later on,"

We disagree. :)
This change LGTM.

-- 
~Randy


