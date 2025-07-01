Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A21C7EE30
	for <linux-um@archiver.kernel.org>; Tue,  1 Jul 2025 08:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oKa+vwtB7YyoVPcQ4gyGwML/TgoSR/BQcVAJaCcMNKw=; b=xecr3kSCfDb5ZDiJoy2yq3FbzN
	lRFitoEXZ6XP0KkmSVv6ubvSenpxENM724EXoS0wrqnU2DMApsz81PYZo5ITHQ+Vy6gBg6CNp1Vst
	JFgbgkPYYrri80+L/2Uxi0XddQ1XFrRoBA4VneRwxZhpVP33auS8Ium40ItYQaaK4VluuxXaVOKQ+
	4HDkB8SrPj3j9vCXO7epAyfZFkDArkbmy/h09pWyRPCbMObG0sQDz+FaUf5xtpdxUm2nx1aZvsQWb
	s4qgzq+BZ0W+jaeQvXtTPAKyCCKP8cPrIPOn2ipDazFulMqpWXAd7O/E5Q/P9EjIuzx4Zg/VCFaSU
	TwA3yQsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWWjV-00000004UIX-2rhX;
	Tue, 01 Jul 2025 08:52:53 +0000
Received: from fout-a5-smtp.messagingengine.com ([103.168.172.148])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWWaO-00000004Rpl-003o
	for linux-um@lists.infradead.org;
	Tue, 01 Jul 2025 08:43:29 +0000
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 8FB19EC0444;
	Tue,  1 Jul 2025 04:43:26 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Tue, 01 Jul 2025 04:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1751359406;
	 x=1751445806; bh=oKa+vwtB7YyoVPcQ4gyGwML/TgoSR/BQcVAJaCcMNKw=; b=
	NtdHq9nNraGy1OrjJzY3DxAca7nsn1zDg91zEi9WWORKqfELTg6BCHbthM6Ov2jg
	PzDvanuk29XCJoQm4dP9/CSE16hX07kI3sOjIh2xCO/mYvJYJSUeKLyW2equihKO
	fc7JlqvuYSN4XciiW7/0cHJ0uLnd3uaN50m9LN/nvc3toU0ooEJua9ucHSalnNP+
	BOVMzzUc5RMSdmigRAa2/AwhbOACbaod8gvu1g/pnt9Hj8zAl/DXvwxWECoSkgKb
	mZdrr1JnDW9ixBNVF/j/KhIzAaVFDil+4UsCrDAyT6gbVbvhBH/+UXxNKUt1+b8V
	to255ONqQmZLFXi4xEZyPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751359406; x=
	1751445806; bh=oKa+vwtB7YyoVPcQ4gyGwML/TgoSR/BQcVAJaCcMNKw=; b=g
	w8li2kccFkp7xYPOPlJkis/xJAlsOhAVpVwHgk/mpbWx2i69pQAtfHe4ABqB0Jaw
	hz7ZlS4XL5RlLbDHSgA2p/LRuJp6CY5+cwYIAOR9AsA+f7LUiAl3ieniqrwRtJSe
	Wv4IfD/6bBUALe8vVEJdrhJj+78kh/Bs7h0esT2UltXS2KOxq3H2lHms2HXQih6j
	7CIOT9Dg1kH9jWDMnCDqhkeJHp1phFM63aicG4MfU0OhwZv6D46SEHPOhpBIt7XP
	49icTQ0xxQHbNC+m45NxSM3H92gnzEvYk+Dplipu/CVEVd0I5oJgbB30BPn5CETY
	C6t41Z5erLxbe+y43AkDQ==
X-ME-Sender: <xms:rJ9jaH6tNYtSRgq7uwuiVuvuKFIXbcBUMIiLM00IAhUnMVQHUwc7MQ>
    <xme:rJ9jaM4u2Pt2nvLtqI250ZZHDHD3fD4gPO5PxyFraMikHIw6EfDS1rHsFRk5NlGYp
    b3mGSk7BtfqSKjm6ZM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpeefhfehteffuddvgfeigefhjeetvdekteekjeefkeekleffjeetvedvgefhhfeihfen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghp
    thhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhifigvihdrsghtfi
    esrghnthhgrhhouhhprdgtohhmpdhrtghpthhtoheprghnthhonhdrihhvrghnohhvsegt
    rghmsghrihgughgvghhrvgihshdrtghomhdprhgtphhtthhopehlkhhpsehinhhtvghlrd
    gtohhmpdhrtghpthhtohepghgvvghrtheslhhinhhugidqmheikehkrdhorhhgpdhrtghp
    thhtoheplhhinhhugidquhhmsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtg
    hpthhtoheprhhitghhrghrugesnhhougdrrghtpdhrtghpthhtohepjhhohhgrnhhnvghs
    sehsihhpshholhhuthhiohhnshdrnhgvth
X-ME-Proxy: <xmx:rJ9jaOdZYTZTBVzUgP6nf0JTtAQzz2kkaWk7HgkULeuLNdoIqr7azA>
    <xmx:rJ9jaII9EBb0fiJDoXvigF57xC2TxKXNBPUztuDzDDQnSIpLXi85LA>
    <xmx:rJ9jaLLASKgjKFigvMje6iMbczHHRR3D7DuarLi0sk2DCJvI6_A9Fg>
    <xmx:rJ9jaByUGIXSBS32KTcI6DNm1B0VKEhaM2M8ArGJIspxwtJYVgLtFA>
    <xmx:rp9jaMDtZfonzhTgtRlUbqTk7184zG9Wjq7UFlCqXqcQFLyFgQPUw5GI>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D5A95700063; Tue,  1 Jul 2025 04:43:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: T3f3fca64c57e0295
Date: Tue, 01 Jul 2025 10:43:04 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Tiwei Bie" <tiwei.btw@antgroup.com>
Cc: "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>, linux-um@lists.infradead.org,
 "kernel test robot" <lkp@intel.com>
Message-Id: <e7d95c03-5098-401e-b885-1569822cdd0e@app.fastmail.com>
In-Reply-To: <CAMuHMdUa1D3mLtNfOhE9RB7uWyf765-9kiQzG5ku05zz2f+zjw@mail.gmail.com>
References: <20250628164740.353989-1-tiwei.btw@antgroup.com>
 <CAMuHMdUa1D3mLtNfOhE9RB7uWyf765-9kiQzG5ku05zz2f+zjw@mail.gmail.com>
Subject: Re: [PATCH] um: Turn HAS_IOPORT_MAP off
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250701_014328_111876_E007D6E9 
X-CRM114-Status: UNSURE (   9.18  )
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

On Tue, Jul 1, 2025, at 10:26, Geert Uytterhoeven wrote:
> CC arnd
>
> On Sat, 28 Jun 2025 at 18:48, Tiwei Bie <tiwei.btw@antgroup.com> wrote:
>> Since we don't have port I/O support, we should turn HAS_IOPORT_MAP
>> off as well. It will fix clang warnings like below:
>>
>> ./include/asm-generic/io.h:1175:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>>  1175 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
>>       |                                                   ~~~~~~~~~~ ^
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202506271049.MtzHqdSd-lkp@intel.com/
>> Fixes: b8c9c3b822fe ("um: stop using PCI port I/O")
>> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
>> ---

I think this one would be a more generic solution, does that work for you?

--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -381,7 +381,7 @@ config HAS_IOPORT
 config HAS_IOPORT_MAP
        bool
        depends on HAS_IOMEM && !NO_IOPORT_MAP
-       default y
+       default HAS_IOPORT
 
 source "kernel/dma/Kconfig"
 
It seems silly to turn off HAS_IOPORT_MAP on platforms that don't
have HAS_IOPORT to start with.

      Arnd

