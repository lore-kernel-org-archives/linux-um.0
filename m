Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E63BCA5FDD
	for <linux-um@archiver.kernel.org>; Sat,  3 Oct 2026 13:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:From:Subject:Cc:To:
	Message-Id:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pn2sg7weLrjzI4ECJlJfS11tPcYHTMFJ2xiA4mHDavw=; b=bxn2iGsfnleIz3c2bJD70xtStw
	3kjBzxt279ymyHtGqdFjQrIOc/70YcLPRmQYyiJqPRXgZ9DnGFWXgXPLLZAgsb07EdvbMH0ek5QBR
	DwW3+nAMFdNO6VLn2qV5TKTAawa1mI2pD6y/sdG8Bjagiyhxaz3MwaEgdgnRnlAg16UkS4TzfzrGS
	mLOvCvO1XHtQeGqYA2pUDRBOrAbfXuKzkIZwNdOjFK8xYPlyVf1TGNvFixRdqC34iUxGo79FsO2Yn
	b2z/BExlZViYz2rite4vB1HllA9WyY8tlkAUbxbRBK8HJElbNalTsAAOE7ZYkiM/uv7L/oLnbmcU+
	ek4uZVCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCzsL-0000000DXSP-1xHj;
	Sat, 03 Oct 2026 13:34:05 +0000
Received: from fhigh-a7-smtp.messagingengine.com ([103.168.172.158])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCzsI-0000000DXRr-3eKs
	for linux-um@lists.infradead.org;
	Sat, 03 Oct 2026 13:34:04 +0000
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 91421140011E
	for <linux-um@lists.infradead.org>; Sat,  3 Oct 2026 09:33:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sat, 03 Oct 2026 09:33:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flapping.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1791034437;
	 x=1791120837; bh=Pn2sg7weLrjzI4ECJlJfS11tPcYHTMFJ2xiA4mHDavw=; b=
	jf9CfJca+wFywhgYpRO5e+jwJiXXSxvMnBVDSpvHGUKBq8wLOrpMhP0XebToM2gz
	MBPtPJfdHDceWPtRsKxMsE3atdzvD3cfJl1dFsyk+cDYpglTm3wZQtrbNppIFFBe
	4NoJMekSDCgxvwbAbUJmbdh3KeEjJOVHZoTlT5MUvH7zkaRgpbzhPTHQ1gDqrRnq
	eiqIBIqBTG1+rz07w/rGAXvfsgoaf/rom5I0d8M8aQSkb4Idtp8G6mAlkrNqn80D
	tu7Vklz6XH4BHQugMyXRsto6/zUJehSyBjVW/jWfOV0MxCTYdL7SSDuF3M4Oru14
	d0iGh0FSswmBUq9eUEka+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791034437; x=
	1791120837; bh=Pn2sg7weLrjzI4ECJlJfS11tPcYHTMFJ2xiA4mHDavw=; b=i
	Nodo4ZeKd7xmcPuORk+MB9COxpvUxEjxNULZIUjDThNPirf7mpe1vmDYbFzArPIK
	5ge937aupofmsm/oYvOcDOcawG75nsRphcxYTQQBKaP1I6U1txJFqjNwbEPDvwi0
	sOOcEj1oF53uZZLOacIJvkzD+N+5bo/X7NR8v5klEPGsDLqvDcu/NPTmX2DfDk9A
	UXsO9b72EUOthlFr7zEAfHrbTVqIRKkq3X8VXLqZUHhq61xwpoCv1+HncX9alIkt
	5y6D4PwajCG4ncu8cOaTOkbr0gA2K+KBQ/6IzFJZitid/1xMoO7u0BYf1lvI334V
	GFpiRZpE9dbVMQpbEucLA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=flapping.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791034437; d=flapping.org;
	mf=PHRvbW9AZmxhcHBpbmcub3JnPg==;
	rt=PGxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmc+;
	s=fm3:rsa-sha256:b0RoAU8tZJJ424gZKiyWe3aL+w4vebyyoA6MGykc3ziCm+3
	k2a/V775Uskt5ldB7Hil5uPejH5RmDNzLCjsvBQqUvIU+xhQd/G+bUpaW6CR0Doh
	EABzjnUKlWnbB8jrMwEZA6MVzUfrHORVqkyTMN2gyDGWoTyQ/aNU8//PR/d60zzF
	ZtGKEcoYkvQxMil5ILOwncpNKEwmm9Kxr+SBKD4NiC/GnbIfOVUT8Wyl/bggmV2e
	gqvU22GI0sKBAdF5URAIHhFKCi2zMeETONhMo5PjslAXcd6zV8VoRoxah1PvI258
	1nORLEczhrwfa3SIqBtPpqX0W6aN4Gy7m9jMKHg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:N6mfz6FURiQZ/ii4vP0VUmv5KYBTSqzquMSlWHJRJqs=:Pn2sg7weLrjzI4ECJlJfS11tPcYHTMFJ2xiA4mHDavw=;
X-ME-Sender: <xms:RATBarpe_3F_8YsYgIziJ_ht-quHYGa0rGulp7cymbrIGVvAwQKZlw>
    <xme:RATBam8iIDblyvcEgyv5G6npgMKmzIyskn4Q5MXVpnQAYDd9ggm8LLIqkBGW2l_lr
    bjvKOuS2b0EL35CqYqN5QzhoiuFu-Gy6Jc5ZUx8MWrEpSihrAkA5p0TOQ>
X-ME-Received: <xmr:RATBas1nIYZwPEoy5XgdDJcWis0Eifaf2p2VV4jmels8JujohLeMqo_p94PiF2cHl0opI94sPzie4uICs2q67jQx>
X-ME-Proxy-Cause: dmFkZTF1RRdeD7QT+V2/c0R644WkJQJ1dVo0BhZtSRIkSprddmPtOVPnlUaZNjvKkdaQYx
    wkNsFpvU9js3MRZRYUmLboYXfT2kL3Zl9bq8K6kYh1Zd1MHNm/9pAKasFXAa2hE4s4IswV
    Rs4RgcVbSw3sqBHMw5+y3XFv6CM7rVEBequwdJi2cqFVeIufAxgZqqZLt0UaDFfsyTriqV
    qrLKsHiw7XgMkXZgJi9mr7IK8Wb67rMu4FHN/D+lE56jZX+UPLQKnQTbmf0V6Uw4T+4RqR
    vExTwQqVkYf0RBJOVzeslp/Tow+K3oNoEjhy8rvapljhr57vZzdMw4y/4jx8pYc46sfUin
    WTaHHNoxXm6ADdV+RNbkds7wqQDGaNI9ZPC0JqfbrpuMCR6Dqp1TU5765JYgZWp749mz1l
    +etHHSx3OznD9z1HEc1wZSJ/3S0WT7qWzRu37LEGYA7cXrQ4m8hhpwWTnWJvyf7OP64L44
    4b17slaiLJPtl0CHjv0hzsb7sC9U0Lvf1xieRGafjDdk1fih8IzGc2VzDppln3StXVNrJR
    DXNnBIJZV98nIvNQunEghoPYkg76u6IBpR/80vfM8acna/B+pFsPli2QxxhM+svrgKkIXm
    R41NCqpX9c3vhg93DPxQJnLg9u6I9vEIiZMngNSQbgTiVegkjuU75JoX5Nxg
X-ME-Proxy: <xmx:RATBahkIM0HMNUw_Lg9ttbgnLVHlPWNDJdQQmYvgWAIpO6z5CdwJdQ>
    <xmx:RATBah2GMgfoYwZ1FQqyIIuyKbx-CGLHaHUHAOaztgKsYseHBRi1WA>
    <xmx:RATBaojvKVmV67CrTZubay_1YmxKacYL0-eaOZ-jUZ9kN7kIpYLCtA>
    <xmx:RATBanVwLTox6Lo5OXwgfhwi9lr_lEJKLK2wB5U2H9IBoH27cDwk9A>
    <xmx:RQTBagmpoyRG8ZXiKAIrneRvTjcYzWZK9HbPTOt5vdPmzVGflt71G4Z9>
Feedback-ID: i51fe4b43:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Oct 2026 09:33:52 -0400 (EDT)
Date: Sat, 03 Oct 2026 22:33:48 +0900 (JST)
Message-Id: <20261003.223348.1401081578886692905.tomo@flapping.org>
To: miguel.ojeda.sandonis@gmail.com
Cc: tomo@flapping.org, ojeda@kernel.org, a.hindborg@kernel.org,
 acourbot@nvidia.com, aliceryhl@google.com,
 anton.ivanov@cambridgegreys.com, bjorn3_gh@protonmail.com,
 boqun@kernel.org, dakr@kernel.org, daniel.almeida@collabora.com,
 david@davidgow.net, gary@garyguo.net, johannes@sipsolutions.net,
 linux-um@lists.infradead.org, lossin@kernel.org, richard@nod.at,
 tamird@kernel.org, tmgross@umich.edu, work@onurozkan.dev,
 rust-for-linux@vger.kernel.org, fujita.tomonori@gmail.com
Subject: Re: [PATCH v1] rust: bug: update the SAFETY comment for
 warn_slowpath_fmt() on UML
From: FUJITA Tomonori <tomo@flapping.org>
In-Reply-To: <CANiq72=i189z9iKtz0x8qR2YO_R1WEPLcRGr3q3aOTwXsEQN4A@mail.gmail.com>
References: <20261002104550.2877930-1-tomo@flapping.org>
	<CANiq72=i189z9iKtz0x8qR2YO_R1WEPLcRGr3q3aOTwXsEQN4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261003_063403_267326_D458F0C7 
X-CRM114-Status: UNSURE (   8.50  )
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

On Fri, 2 Oct 2026 12:54:47 +0200
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

> (By the way, you have been authoring all the work in this file -- we
> could have an entry for the file in `MAINTAINERS` if you want it)

Thanks, let's add one. It would make sure that I am Cc'd on changes to
the file. I'll send a patch to update MAINTAINERS.

