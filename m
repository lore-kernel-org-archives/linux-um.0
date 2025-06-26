Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD6EC7EE31
	for <linux-um@archiver.kernel.org>; Thu, 26 Jun 2025 14:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NnA5hU4w76XtfuXjc9T7ovjYs8AsRuW+URyzZY2p7PU=; b=yoYptaed2kXdmAeGmJx3lq1sE9
	galPWUi/REM0033Tr3ybPpvcBKvKRQ1oEEaWqnCzFfUnWqxa0qX8R0IUHjIosiqQ5WyJqaR2pBY0h
	BBe1lHPkNLPDQQ98ZJfNXQIWQ1XnilU8tXQaY5gOHyoU16k7No6kvxrTcOb/PnUInWuilA/gd2zrx
	4/B3M/1H1W2ynktadkAq04ehoB8m5SQj/r0L6hDjzmx9JJjHVAsS6fe0qS4H6dbqopyWI29EnGOKo
	dePZ9+YbdXeemEdwJqd/tg6sUkq6lfInNdJZKmtONxQ3WEHNBVKLAAOp9tO+iqefbSm8DYK205Gv+
	sXtXjq+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUncs-0000000BveT-08G9;
	Thu, 26 Jun 2025 14:30:54 +0000
Received: from out0-202.mail.aliyun.com ([140.205.0.202])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUnQx-0000000BtP5-0fW2
	for linux-um@lists.infradead.org;
	Thu, 26 Jun 2025 14:18:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1750947509; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=NnA5hU4w76XtfuXjc9T7ovjYs8AsRuW+URyzZY2p7PU=;
	b=UVSVbJz/eolDGBK8zJXOW5dyJDMFYN4ksjiMx4eUF8xlk/S1u30RUPT/jHe/9nr8+cly3XvtPAsDKXRJ2652MjyuMUgvuzNbupKwY0bvq4GxvukUplM6jeyD/GZFbvuULqzjXLG4yKOoAWwHJVqpFOk0bB0R/ppPK5RKVDmLGUc=
Received: from 30.174.123.233(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.dXILOmi_1750947492 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 26 Jun 2025 22:18:20 +0800
Message-ID: <963cbbe7-8064-461e-b134-1a43e037c33a@antgroup.com>
Date: Thu, 26 Jun 2025 22:18:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] uml-for-6.16-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org,
 linux-um@lists.infradead.org, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>
References: <20250625121529.42911-3-johannes@sipsolutions.net>
 <CAHk-=wjTCAzaw4AXXpxcYc7v7ZjAeyaOOJw7FWXO+gV7v7Cp0g@mail.gmail.com>
 <0d630dec-41fe-4968-8d6a-7faae8a554a1@antgroup.com>
 <CAHk-=wh=_ZmpYtCx11wqsGGdrZRHsPorTzpzh2-QccT8PGKW1w@mail.gmail.com>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <CAHk-=wh=_ZmpYtCx11wqsGGdrZRHsPorTzpzh2-QccT8PGKW1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250626_071835_742157_A8DF9FAC 
X-CRM114-Status: GOOD (  14.10  )
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

On 2025/6/26 11:48, Linus Torvalds wrote:
> On Wed, 25 Jun 2025 at 19:44, Tiwei Bie <tiwei.btw@antgroup.com> wrote:
>>
>> The behavior of gcc and clang differs. Clang's behavior appears to be
>> related to the volatile qualifier in arch_spinlock_t:
> 
> Ahh. That kind of makes sense.

I also just noticed it today after taking a closer look.

> 
> At the same time, I think clang is being stupid here. Yes, it makes
> sense to treat volatile specially in this way - just not for an
> initializer.
> 
> I realize that initializers can be made to be their own data
> structures in modern C (ie taking the address of an initializer and
> using the initializer itself as an argument to a function call, for
> example), but when an initializer is used to set the value of a
> variable, the only real thing there is that variable.

That makes sense!

> 
> Oh well. The patch certainly looks fine and I obviously already merged
> the pull request.

Yeah, I saw that. Thanks! :)

> It does make me go "I wonder how many other places
> clang just generates stupid code due to this".

+1.

Regards,
Tiwei


