Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06575C77B7C
	for <linux-um@archiver.kernel.org>; Wed,  2 Jul 2025 14:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nz+yC6wxqPgvx9ofXJnUFR1KSWJ3tK+ENKxxvFDvSYA=; b=0crBEypShcxdpgzvq7euuZvbDW
	zA8dBGoOnj4LPYJGRgqUnSt86xJ+5QDhImQQmPEnAS/IeTYfO//RPEoCvUMxo0A9lMnl88ZwyqdLl
	2ihDhCoGhfKH/CFdkX0tXIjDhiIibM2f5iSj2yUrvcasU7akv1c0fZuKDoYbMN0ZTvdwjZrRqDpyt
	a/P34uwFaoJq/t4i8g5j5bBC9eS8SPvaUm9qLwZ6mLnXgPIu1z0jAczfXkAuzx/5RYbWIkFe7PE5r
	oKryOAjU8Z5T1oixfGJMWEtaetj/gs2TpfPtxy+PRamLiOSo9lCoqp6x71jsE4t6Ghqk+C8Dn8r/4
	eTEFq0sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWymX-00000008fzd-2bJx;
	Wed, 02 Jul 2025 14:49:53 +0000
Received: from fout-b5-smtp.messagingengine.com ([202.12.124.148])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWxgn-00000008Uj3-37vS
	for linux-um@lists.infradead.org;
	Wed, 02 Jul 2025 13:39:55 +0000
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 6215A1D0009F;
	Wed,  2 Jul 2025 09:39:52 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 02 Jul 2025 09:39:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1751463592;
	 x=1751549992; bh=nz+yC6wxqPgvx9ofXJnUFR1KSWJ3tK+ENKxxvFDvSYA=; b=
	JKYZJSGlA2DiuE3L3n5nARMe+kZmmtA1Z4WdbYRgdppnS7BxRjIneKT879GKm4Mv
	KgHHNwhf5HV07cVU2EUPaBaDROtUKJjV8eYXwDtJ8aDcsB33LrMvU7sPJa9YygYH
	pRLT4dHLuIK8MJfQrq/rFvhbViho+ujKHMzC2B++NVrxPUODTmw3ZfnOtpwwp1lS
	rVRD7WKSeoXTO9X0CE6p+zJe9/+1vkWrp/9HaeW59IJ1yPOmndXHr2fIjiLQMuGA
	3VqjCg4IFbIs1yGSl2aju89n+jbw5w3r109+Lm7MYFQdFZEGncfY+RFxFuUBtfYu
	s4Oih699LtQyC8ma2QPOfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751463592; x=
	1751549992; bh=nz+yC6wxqPgvx9ofXJnUFR1KSWJ3tK+ENKxxvFDvSYA=; b=N
	5y1pMppJ7BM93I3J6P4jHlvMyVn4u9RCmbG93+jY0OCEFKiwBBQDxpXtyiakX87t
	82UkH5wV0KlfY9kktQZzQQ+JUk34LRe8QxqSp+VxB/orwVldyUBmQ/yhHiO2X6hl
	FUndbDwftkaCvRuiw+cYK0yzvLv3B91zSgK2OtsSzuKzZ2h3P76O+DpCYDAMzXnw
	QZP/lzO55zwRvmZzCJXEMpla0HW4mkl781Cnm6sEIJZvTHp5FcxzLiAZCnyZjs0s
	5Ralqv03C+t+3wuZBkMnNWR89eaXdJ41IhuQpnXPmXKInJp1/TJqvvGBLneJriiA
	w2x91XWW9MdfRjwxKMRKA==
X-ME-Sender: <xms:pzZlaPc3dwkmgKuGP1B0NiVgoJt9NOiHjANjr0BjD4RtN1DAVOF8cQ>
    <xme:pzZlaFPatDXhk3r3nq6w5nd-2PqolgoZ7kSgNSfDEl1QSC69TtSVc0aSLMl9CTZPr
    XuSX1QIGtMH05kImQs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehtihifvghirdgsthifsegrnhhtghhrohhuphdrtghomhdprhgtphhtth
    hopegrnhhtohhnrdhivhgrnhhovhestggrmhgsrhhiughgvghgrhgvhihsrdgtohhmpdhr
    tghpthhtoheplhhkphesihhnthgvlhdrtghomhdprhgtphhtthhopehgvggvrhhtsehlih
    hnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehlihhnuhigqdhumheslhhishhtshdr
    ihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrth
    dprhgtphhtthhopehjohhhrghnnhgvshesshhiphhsohhluhhtihhonhhsrdhnvght
X-ME-Proxy: <xmx:pzZlaIjfC5DRTed9RrzqnytI8OAc8xqaQXh8_PyIJ6gHIJWo-yiVDg>
    <xmx:pzZlaA_JJUYMRDqflO-KynZ6TSLvhwMX-FFsz27FaRU81YyoZ6dxmQ>
    <xmx:pzZlaLvZ0WghZxjO1aExKzblBuYNZjauwQAr_AUkXPjp6DKhADF5mA>
    <xmx:pzZlaPFSQo48zJC7aPFVR1Njxg-tvui8RY3zW4a_ZxIuuoF4thgcZA>
    <xmx:qDZlaLtv3Gj--dZGikY-lLeUUcvLKHHuewgU1Wt9rffoGCvqMwdcZdTA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E89FD700069; Wed,  2 Jul 2025 09:39:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: T3f3fca64c57e0295
Date: Wed, 02 Jul 2025 15:39:20 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Tiwei Bie" <tiwei.btw@antgroup.com>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>, linux-um@lists.infradead.org,
 "kernel test robot" <lkp@intel.com>
Message-Id: <49982e79-957d-401b-882c-849d2892bf4c@app.fastmail.com>
In-Reply-To: <dcb0d307-a0cf-480e-888f-1020d1441d1d@antgroup.com>
References: <20250628164740.353989-1-tiwei.btw@antgroup.com>
 <CAMuHMdUa1D3mLtNfOhE9RB7uWyf765-9kiQzG5ku05zz2f+zjw@mail.gmail.com>
 <e7d95c03-5098-401e-b885-1569822cdd0e@app.fastmail.com>
 <c71581d8-350f-4523-862f-5be84358ad8f@antgroup.com>
 <1724be1e-174c-4837-8768-83a90004f7fe@app.fastmail.com>
 <dcb0d307-a0cf-480e-888f-1020d1441d1d@antgroup.com>
Subject: Re: [PATCH] um: Turn HAS_IOPORT_MAP off
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250702_063953_840216_CC2B1C3F 
X-CRM114-Status: UNSURE (   9.29  )
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

On Wed, Jul 2, 2025, at 15:02, Tiwei Bie wrote:
> On 2025/7/2 19:09, Arnd Bergmann wrote:
>> On Tue, Jul 1, 2025, at 14:22, Tiwei Bie wrote:
>> xtensa selects NO_IOPORT_MAP, which means that HAS_IOPORT_MAP
>> gets disabled here:
>> 
>> arch/xtensa/Kconfig:config NO_IOPORT_MAP
>> arch/xtensa/Kconfig-    def_bool n
>
> The value of NO_IOPORT_MAP on xtensa is inverted compared to that
> on most other platforms that explicitly defines NO_IOPORT_MAP.

Ah of course, sorry for misunderstanding. Apparently this only
existed because it was selected by a long gone platform:

-config XTENSA_PLATFORM_S6105
-       bool "S6105"
-       select HAVE_IDE
-       select SERIAL_CONSOLE
-       select NO_IOPORT_MAP

Before commits

d38efc1f150f ("xtensa: adopt generic io routines")
d046f77ec4a4 ("xtensa: set NO_IOPORT to 'n' by default")

it was always-on, and I think the idea at the time was to
make it behave more like the generic PCI code, while it
was originally copied from sparc, which does things quite
differently.

It is rather clear that the I/O port implementation on
xtensa never actually worked, and some of the comments
on its PCI code suggest that it was never really used
either.

    Arnd

