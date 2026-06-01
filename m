Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C28CD6E56
	for <linux-um@archiver.kernel.org>; Mon,  1 Jun 2026 12:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3ZjcplI1IRnFnk0efUVPi4+MY/klXOGYW0jLHAuU0HQ=; b=rFSSO88RKansEyBKarVpPJYvdF
	8aPZ0Hcp+jUDWCHqed6UKPb23WxoCLRkrKkDro1w8mK6KCtiOFslYwZMNLyuzfJOZgHwpOsDWy0Ux
	SO5DwnoZ3EWlwf0pqNLzU6O+rbd0qylDLdm3C2CdVFygPILvQ+AQWOnKYxPc0WiJgI2oS1mMKq0I8
	j8RuvzOr55Jen/McshA87DcZ3wxR1LVssm5CnFpsXFUZ0dABMd/eXcPWxUZHD3sl/7+bVGH2Ae+8n
	TXr9TThTnVFO0/k9GaaSHvNpJschYjsn7ZuTiPedLNfqpybCBgJrlvuWvWrPkaArGv/oCiIhNypQN
	uqZjkGEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU1l2-0000000B8Ae-0oNe;
	Mon, 01 Jun 2026 12:28:40 +0000
Received: from fout-a3-smtp.messagingengine.com ([103.168.172.146])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU1kz-0000000B89v-33pG
	for linux-um@lists.infradead.org;
	Mon, 01 Jun 2026 12:28:39 +0000
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id B19F5EC00F4;
	Mon,  1 Jun 2026 08:28:34 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Mon, 01 Jun 2026 08:28:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1780316914;
	 x=1780403314; bh=3ZjcplI1IRnFnk0efUVPi4+MY/klXOGYW0jLHAuU0HQ=; b=
	Ui0v4TSuPzRO7xRaZDafNYDDdCd8XqYPEVdhwIHp4sChfdDE+TLdfu9mHQGySD3I
	iCe/d9DjD9gutWZxWtPy0ar1wHhJuU32SHo76dzfUilKnqFHwjIsfvnMiF3Abjic
	OS4mMgFPhTHZicj87I38jlNTHJ+HDuKe0VtJ2+8xwuntICw5W3U4rskEBd/Of+SQ
	RxDvda/f9GX5fYhKOah/w5RrqoLWe0HzXZRBhoI42EtrX0BHn8QTc4beyFqyZqGF
	uNL0E2DhX8tQ5tBdJ7fwd0pu1mwxLZTFXcnT0GeKvVXDBY/nufa55hq9XxbHt86a
	GyYJK7lkhbnH9uUkpl9WvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780316914; x=
	1780403314; bh=3ZjcplI1IRnFnk0efUVPi4+MY/klXOGYW0jLHAuU0HQ=; b=H
	BMnFWcmLkGttdFD9lZSuiXVbzIbLR7PDO6HT+cLz9wOs22ZJQyq2RBxDAcIXJA49
	sN9QP+PMiS499sE1zWgHkFcTQV/M2gTLo6xAg6rbUNbqVepHhioHscH+AWRZWcwY
	62YDjRQwBhyATENDZjO/ryl5XAh2cjH3M6UgsFEmhOjh5cPRgwQ0m0gF+DI1yOg8
	SpcjgZC6xx/tsH7NSisgcQblNj611Tpgsmpxxq+eZ0R8P5aVq8vMjMKha9joLV08
	ORVEOtzGhhEMwpEE3h3ltjcKW++YvCPLOD0QzQHWWMT2IdLR/DuEMkokUkVMAiM+
	E0h49qrx8gQmliSOhb09Q==
X-ME-Sender: <xms:8HodanPncEQEYzpKYw8Hvfer_eF51AqBU5ac1K_C_w3hJAVf1ZY1iA>
    <xme:8HodasyxloeLB3tOnCtcqCD_zcYAtNvE6JDjWJFDtUTBV-ePgDd51PKUftDjLbJc5
    iW3SbLVqWfSKGnrfBS89de3l_htHgtuAY973YG6w0z0nSjDWKMeEgY>
X-ME-Proxy-Cause: dmFkZTEuJ8z3Npq/dH3C9xP6qXfCRbHTe9gj4rOILrQUCzqX8oO8KWWCSR169Z//vxGG/n
    T9k6AEXlUZb1Pxob5RE0+HEVsHGUVZWFNr0tjiNlwbYIt8i2dYMmuDaivMAhOa8QaAJlm4
    yiYxKFDH3zZ2aWyhC3Mp4b3brwFIPhorOLB1X2dpWI61Zk1xHrpkq8F5vWxapJaHR1OtBw
    RFgfuaactUUmz4gSt4Wx7qh8WPO/D9WdS/WRIPklOWuk/mnS5qSDD/LWvewEGK7LWeO7mG
    phdhiGNvyVNFikhD39gPgxoltn91897OPGino+8xWACj4o+iq+phlvei/JJxNc5Jt3jVcO
    xWfHUCQDJtecA1t9Y4AK0Tf6Hc596+CpHpu8T9r93/USE+5kkyMtqEwuQIy23kDlJv9xMK
    ylUmqACtFKQsabZMJ0UdR2/hPWDxoUtqWc4EmpRA/eXH4D3ET3fVunLhF8b9MJvOJCyabM
    EeOlxYAdCcjquXba8ftqBvLDOYSMptTMiHC4JFczMJoQ0ryN3fY75hadiUgPD/Ot4i4eGN
    6TkhLCsbGgbSKeD2nLEEH8QakT1zAivQTpqj5iVyKhJyXBFXllkCwXifHbwaXVmIJESn5P
    ETNQOszvaMmZ23cphcPUNJh/UnnaautLCampyBGSMsfBUY39yH06qfPN0L+w
X-ME-Proxy: <xmx:8HodarnLpdY7C9tAvkiQ0HdhJr1XvLCAzRkkISOgL2FoaOGUW6IJVg>
    <xmx:8Hodaiw7VmSR8YsJ74TDyERR-jicz0l_08fKTlNMeGfUgGMtFjUscw>
    <xmx:8HodaqL5LS_5slnre2b6BEI02KW9xpnjLi8o1RBX5bNdEKbd-Z9jOQ>
    <xmx:8HodatLmDnSuqPQPvwFepkeWJPLFj_605sJeFpChDhFl_RYtaLUgVQ>
    <xmx:8nodaqOEPmaQprN-yV6S-ZGFsmeSiih4MMsOvjOpebtovSyD08V-f7Z0>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C2A1E182007E; Mon,  1 Jun 2026 08:28:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: ABuN838N9sew
Date: Mon, 01 Jun 2026 14:27:52 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Ingo Molnar" <mingo@redhat.com>, "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Thomas Gleixner" <tglx@kernel.org>, "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Peter Zijlstra" <peterz@infradead.org>,
 "Will Deacon" <will@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, "Yury Norov" <yury.norov@gmail.com>,
 "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
 "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
 "Alexander Usyskin" <alexander.usyskin@intel.com>,
 "Anthony L Nguyen" <anthony.l.nguyen@intel.com>,
 "Przemek Kitszel" <przemyslaw.kitszel@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-um@lists.infradead.org,
 "Savoir-faire Linux Inc." <kernel@savoirfairelinux.com>
Message-Id: <95b6f585-f52e-481e-9d55-cc1a5dd9ace2@app.fastmail.com>
In-Reply-To: <CAMuHMdWroJRgr-p7CXLf08EJkbPxhro1WVYGe0pQ8Zu__jMobA@mail.gmail.com>
References: <20260522141959.1071595-1-arnd@kernel.org>
 <20260522141959.1071595-2-arnd@kernel.org>
 <CAMuHMdWroJRgr-p7CXLf08EJkbPxhro1WVYGe0pQ8Zu__jMobA@mail.gmail.com>
Subject: Re: [PATCH 1/8] x86: remove ts5500 platforms support
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_052838_038041_B2A7BC3F 
X-CRM114-Status: GOOD (  11.56  )
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

On Mon, Jun 1, 2026, at 10:31, Geert Uytterhoeven wrote:
> Hi Arnd,
>
> On Fri, 22 May 2026 at 16:20, Arnd Bergmann <arnd@kernel.org> wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> Support for =C3=89lan was removed in 7.1, but the ts5500 platform
>> still depends on it. Remove this one as well, not that it
>> cannot be used any more.
>
> https://www.embeddedts.com/products/TS-5500
>
>    "Retired. Last Time Buy. This product is being retired. We will
>     have a Last Time Buy until 01/07/26. Supplies are limited."
>
> but
>
>    "Available with Linux 2.4 kernel"

Linux-2.4 and DOS are probably more commonly used on these than
anything modern, given that this is a 486 with 32 MB.

There is a good chance it still would have worked with
linux-7.0 if anyone had tried.

        Arnd

