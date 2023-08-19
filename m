Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50096EE49A5
	for <linux-um@archiver.kernel.org>; Sat, 19 Aug 2023 23:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:Cc:To:From:Date:References:
	In-Reply-To:Message-Id:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CArllde9P+3JKghHJHB3xs8nCvS4QlcqGGUay2LOQl8=; b=tYAWOtzCDjXSqR
	o6VG6WzGoQAChDQX6XTnMe/50ZrFubFlz7jyLgHF1Yu0gqvXQA+TAI1jpLGQVYOt9WCYRYiAsWQzz
	usXiY0PNcGEDAxlXt6Jx22P3AGhMxJnPDwF1U/R/AzjPbvLL7oJybqOqwmPiiuaHbm2skXxhLc3x2
	Tf2/Ayb8FJpCzDAYsHDtC/V+j5zNHsjaVR+ybfIGCQETvCTF6q5ZyS9NxDiVHM6qHL7WmeACJo2A9
	/hSBb6UJGKgkLhJHqovxv/rIsKtCGxFXE+xGIwWRn2x6KengsptWwcRyAFxpfpnIRiWXQV66BSakZ
	1PqKXNKuHNwnbwJUFA+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qXV86-00BEVn-0Z;
	Sat, 19 Aug 2023 23:13:14 +0000
Received: from new3-smtp.messagingengine.com ([66.111.4.229])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qXV82-00BEU5-1i
	for linux-um@lists.infradead.org;
	Sat, 19 Aug 2023 23:13:12 +0000
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailnew.nyi.internal (Postfix) with ESMTP id 0106B580126;
	Sat, 19 Aug 2023 19:12:55 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sat, 19 Aug 2023 19:12:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1692486774; x=1692493974; bh=eF
	p9xFgSVp+I1HTUH+y+7224okESMQ+VhbU3Am512Uw=; b=GXs5Ux18dB7s0wFIA7
	EqEXXEICoPI+MlJNUcsMVjF7KAdxknUeboQC5nn/yYM6tgVpl/0TwWMvATMWmHtZ
	hkhuQaHdleRtYpTuCi0aIVczwIb5ZMgxlN59ySsDf7vRpemRUuR2fS0+ICwtJJG7
	qTqYF0dpBsTOaGt81+niyXp1SOH+gdl2UekcgeMO3ns+Hw/YckLwE91NXkRyH1LK
	oLIZbt0G8sqGDBiWeWNOsvs48hgFiRT43a31LbgBuSD/BtnQI1UHBVTBXpkxygoW
	+aMuYaE7TEx2ASCa1kooI7poXJi0tfN1WFo5UrMrfVYL5r+EhBOqC0koyppfKcTW
	kjDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1692486774; x=1692493974; bh=eFp9xFgSVp+I1
	HTUH+y+7224okESMQ+VhbU3Am512Uw=; b=Udursr+emtzG/itOBWyrlF2MXy/uT
	JC8uydwvvtDYj3J6YYUbAp7hQSYTYVpNZkujBOjtQeedXkQuWLtN3LTll+AVzSwA
	yECKLkED1sAXwOkHu0SecwJbyYfbTc8vhjKF+YVTplEZpTrz7bQTwjcp0Mfdf75N
	CO3+YgwY/KEbAAWElpsSZTbhk83SrFMKVl6NFZXDq8LkSFtlTsVzmfZUGOsABvh9
	SW8hntLOBpOe9NCE2I99ewFmBrUfl7T1ejFkCvr2ExDNM58bhUMwS2gZ+2cNPrdC
	cUYhGlwW0psGSQtEJBJF5WtrasD3qV17MD7gOs+JDwzW2EaQ7hfC2ljyQ==
X-ME-Sender: <xms:dUzhZDLE_dc_K6K0vpAUQcVXmUImZgpV1_84N9Yng8QEZeY_dQgoLQ>
    <xme:dUzhZHKRX3cLgqezx5P2CgtwfNzFzojKxOmVe3o13tiG4DCgPanXrZS3O1CSXk0cM
    ZyM7vzMVkA1bMsZK-U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudduiedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:dUzhZLux1Zi5xpS4iCD97tHjabzhI9G0FDo2K5c3WVlbJ1xD3dDhOQ>
    <xmx:dUzhZMYa8lfbuwQNZ31QQc8XW_2lKi_-jfHs6gVm3JGhdoK6kRxoKg>
    <xmx:dUzhZKYO75Qn0D2iw1RJooEoSom1tSj-PNdIlOspoRWfx4U6_GCtEQ>
    <xmx:dkzhZCoWf9xiWHn0WlPoS7_tyK_KM9JWHPGnMtwc2JJfcAyVrBqQfQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id F0FB0B60089; Sat, 19 Aug 2023 19:12:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <320be16c-32a2-4f34-9a30-e352f8203671@app.fastmail.com>
In-Reply-To: <20230704083022.692368-1-davidgow@google.com>
References: <20230704083022.692368-1-davidgow@google.com>
Date: Sat, 19 Aug 2023 19:12:29 -0400
From: "Arnd Bergmann" <arnd@arndb.de>
To: "David Gow" <davidgow@google.com>, "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Noah Goldstein" <goldstein.w.n@gmail.com>
Cc: linux-um@lists.infradead.org, x86@kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] asm-generic: current: Don't include thread-info.h if building
 asm
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230819_161310_638041_F161F79E 
X-CRM114-Status: GOOD (  10.31  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Tue, Jul 4, 2023, at 04:30, David Gow wrote:
> asm/current.h is included by some assembly files (either directly, or
> indirectly). This works on some architectures (such as x86), as their
> implementation of current.h is careful to not include any C, but the
> asm-generic version includes linux/thread-info.h unconditionally, which
> leads to errors when either C code or non-asm-compatible preprocessor
> directives are included.
>
> Just wrap the contents behind an #ifndef __ASSEMBLY__ to avoid any C
> code making its way in.
>
> Signed-off-by: David Gow <davidgow@google.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
