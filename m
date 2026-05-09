Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18C1CD3447
	for <linux-um@archiver.kernel.org>; Sat,  9 May 2026 20:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8Ll9UzEIFrA/Y2cg4MLqHpnXwj68nPuPZz+mPcUm9t4=; b=264LFQuPO8gKqIij80DuJlj/Iz
	/rbo4Lk0l8a5xaI+rYox5k9JcFT9VHYOIy9FJzgiASV+GcUcsbvHhU1wPPNv78bfp6ByVg6G8z8SJ
	QMwHyNwAMg5e7iMlBsuMnwLrGbaDB9Y1oQrO5sVJD6qx7penXld3n1U7zDaTUxq6zKiwDiyV7b7bK
	u1eXMQPSbPyWAuHbqf74gYUnvAhBmvxsUu/+zjv9ys3qLdQHzo0zq/dggYkOmW/6YwxyoGy6Zgy2z
	wojgcG8N+IFTWMMmgQ8rOjBKBA0Geb3eiQfaicMsT5q1nfazowQ1serCAr8DNy3obQyqveTIMCsVz
	cfY7lGsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLoUN-00000009dCR-2Vqo;
	Sat, 09 May 2026 20:41:31 +0000
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLoUJ-00000009dBh-1fcW;
	Sat, 09 May 2026 20:41:27 +0000
Message-ID: <5cc6c7e2-f870-47fd-8fcc-0e4c2b978f2e@infradead.org>
Date: Sat, 9 May 2026 13:41:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] docs: fix repeated prepositions across documentation
To: Andrew Lunn <andrew@lunn.ch>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
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
 <3c6cde1a-9ce0-4d63-ba89-820c596cff3e@lunn.ch>
 <27c61395-f04f-420c-9a84-7e27773f2027@infradead.org>
 <3b4357a7-f70d-41b0-a75d-c30f9fb7dd98@lunn.ch>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <3b4357a7-f70d-41b0-a75d-c30f9fb7dd98@lunn.ch>
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



On 5/9/26 12:39 PM, Andrew Lunn wrote:
>>> Can we get the tool changed to add a warning, something like:
>>>
>>>   WARNING: This tool uses very simple pattern matching to look for
>>>   repeated words. It does not understand the complexity of English,
>>>   and will often result in false positive reports. Please assume it is
>>>   wrong until proven otherwise.
>>
>> There was no commit log and no cover letter AFAIK.
>> Do we know what tool was used?
>>
>> Adrien, how did you discover these repeated words?
>>
>> (If it's my script from 2021, I'll gladly update it.)

Adrien is not using my script -- they developed their own script.

> Thinking about it some more, i think the warning might actually need
> to be different.
> 
> If this tool has been around since 2021, all the real problems have
> been solved, leaving only the false positives. So the warning probably
> needs to be much stronger, saying that it probably only reports false
> positives, unless the code is new.

Makes some sense.


> Maybe we also want to extend the tool to have a list all the known
> false positives?

I'm not crazy about that one. And we have no evidence that I am aware
of that my script is causing any of these patches.


-- 
~Randy


