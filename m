Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B098CF3957
	for <linux-um@archiver.kernel.org>; Thu, 19 Sep 2024 14:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kElC6zl/TkasMx/xZrwJjGVm8lki5TsgbpfWjJ++uKE=; b=YvaxWSZ8Y9HRGB0wEEwR6nhgOx
	Gmy4PdBFHyb/UtMYZ0/aDaCD3RIBz+FFZhAlYWuo5QYOlgI1JKXABjxTbVzFs5jrcenxJMbdyS/fT
	6ahFRj1Z0nB7X6G1YxWeChd6S9Jueo04p1mtrKH2om1zQ9bauMBBuYwRsP4ed3ND8MNdXDBmSgfFA
	AAsM3xsDXI0sCWtbtguUfRBRSdiDOIHj6NC0fTH4Q60d3bku5ipRgtaptlqWmcqduUH2TmD96ceq2
	iyNg8g1gtbTzGJ34h93G9IPTaBBC4JvwqGMY3iXKjzadf6PSyARPr698nX20cEKRMvRhuLS/Ot7JE
	bsnkiIKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1srIII-0000000ATIU-2ouj;
	Thu, 19 Sep 2024 14:38:06 +0000
Received: from mx1.uni-rostock.de ([139.30.22.71])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1srIIF-0000000ATI5-1S5C
	for linux-um@lists.infradead.org;
	Thu, 19 Sep 2024 14:38:05 +0000
Received: from 139.30.22.84 by mx1.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Thu, 19 Sep 2024 14:38:00 GMT
Received: from [139.30.201.77] (139.30.201.77) by mail1.uni-rostock.de
 (139.30.22.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 19 Sep
 2024 16:38:00 +0200
Message-ID: <5f2de09a-0af6-46b7-9e9e-6dc0a5d0b885@uni-rostock.de>
Date: Thu, 19 Sep 2024 16:37:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um: insert scheduler ticks when userspace does not yield
Content-Language: de-DE
To: Benjamin Berg <benjamin@sipsolutions.net>, <linux-um@lists.infradead.org>
References: <20240913201756.1223327-1-benjamin@sipsolutions.net>
 <3ea4c557-df8f-4312-84f6-8dc0b2c2a5f1@uni-rostock.de>
 <b9e99c84ec953cc1459928c103fc4789eacce486.camel@sipsolutions.net>
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
In-Reply-To: <b9e99c84ec953cc1459928c103fc4789eacce486.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.30.201.77]
X-ClientProxiedBy: email3.uni-rostock.de (139.30.22.83) To
 mail1.uni-rostock.de (139.30.22.84)
X-TM-SNTS-SMTP: 76E59C16F2AE87F2DF8957B191C9908E94126F87673B62E98C4BEE3499BD79052000:8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240919_073803_713450_CB689E6F 
X-CRM114-Status: GOOD (  10.57  )
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

Am 19.09.2024 um 16:22 schrieb Benjamin Berg:
>> Could this also eliminate/address the busy-loop hack in timer_read in
>> time.c?
> Hmm, I was considering changing the other hack in handle_syscall to
> also use this approach.
>
> But, I don't think the timer_read hack can be removed. In the case of
> userspace reading the time, it should not see the difference of the
> sched_clock. So even though the process would start use CPU time, the
> realtime clock should not change and python would continue to busyloop.
> the actual clock ticks.

Okay, I think you are right.

Nonetheless, my proposal would be anyway to shift the advance of the 
realtime clock only into user space systemcalls and not every function 
in the kernel, that reads the timer.

I made ages ago the mediocre proposal to check the syscall number here, 
to detect "malicious" user space programs doing busy loops.

For "clean" semantics of a simulative execution of the kernel, it feels 
erroneous to advance time even if this value is only read once.

In my experiments timer_read was called much more often than I 
anticipated (e.g., filesystem code).



