Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D00C4167B
	for <linux-um@archiver.kernel.org>; Fri,  1 Dec 2023 18:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fG2Fz4H3y08YKpGEdC2oAWvh9beJ6Xli5gxvnBYWfVU=; b=nShCzhBQd/Js44GdVfzBHH54Xw
	tpuawWjS7ghEaT4fpyy3bsHoSa4EZ6Mb4zu7/kZLx/HZ0MI22Th1UjC6q5otM9XHjXHnmNEqpoKD6
	ntjj4ADmkTPkzOqOSHuM7jPwxxa1VcksB12PcJ7DwBYuMFCOz2654YSDL6WkRuYc33hZQt3SIUoYL
	JnD0KgrSj5opInLSCXRtQgpPDJX9DNd2H+OllbapONL287aNb/HN/i6IS8dKomSC4VRrEWrE9qbEv
	JyTf3fty6GkJuFx6Rq5zp8FSuklK3DGoZ3ugBx5Vb1rM6W1TCwxyFCwwlwBP1gw7B43lNZA8iCXxx
	NgHTfLrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r98ME-00ERiU-03;
	Fri, 01 Dec 2023 18:35:22 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r98MA-00ERht-2x
	for linux-um@lists.infradead.org;
	Fri, 01 Dec 2023 18:35:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=fG2Fz4H3y08YKpGEdC2oAWvh9beJ6Xli5gxvnBYWfVU=;
	t=1701455715; x=1702665315; b=XEFyTw9Y+h+QCzl6gRDFFx4QuVn/ODExXKfw/qJ7pehvo+n
	SBPe867rINz8dr6EL7HP6JDPrvkhCSwIVPRVkyS5UHEO9k5yuOR9kFkP8M9GXm32pnRkktb3MYclK
	AeO8OiUvYQ8t2nFvKHbnexAUdmztRljv/Ckrt9gnjJT9NWwtYz9POOLN7NThDGe46sm09TvzfkCpA
	Sw7HxgYarqTugZJC+Hlao+HZyLcd/HrDzVCDkD46Fx5nWuM4d6WgVt2A8NXWCWfHkBf1MNsFGOZ+B
	Ic1pAUcEh/wKnY3RXNuR58DZNcXDHtABHN81QzxJRAOWBGMSpCPmwGpammF4eF2g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r98M4-0000000BPGG-1voz;
	Fri, 01 Dec 2023 19:35:12 +0100
Message-ID: <8ddb48606cebe4e404d17a627138aa5c5af6dccd.camel@sipsolutions.net>
Subject: Re: jitterentropy vs. simulation
From: Johannes Berg <johannes@sipsolutions.net>
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, 
	linux-um@lists.infradead.org
Cc: linux-crypto@vger.kernel.org, Stephan =?ISO-8859-1?Q?M=FCller?=
	 <smueller@chronox.de>
Date: Fri, 01 Dec 2023 19:35:11 +0100
In-Reply-To: <7db861e3-60e4-0ed4-9b28-25a89069a9db@kot-begemot.co.uk>
References: <e4800de3138d3987d9f3c68310fcd9f3abc7a366.camel@sipsolutions.net>
	 <7db861e3-60e4-0ed4-9b28-25a89069a9db@kot-begemot.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231201_103519_580786_5AF5221A 
X-CRM114-Status: UNSURE (   9.05  )
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

[I guess we should keep the CCs so other see it]

> Looking at the stuck check it will be bogus in simulations.

True.

> You might as well ifdef that instead.
>=20
> If a simulation is running insert the entropy regardless and do not compu=
te the derivatives used in the check.

Actually you mostly don't want anything inserted in that case, so it's
not bad to skip it.

I was mostly thinking this might be better than adding a completely
unrelated ifdef. Also I guess in real systems with a bad implementation
of random_get_entropy(), the second/third derivates might be
constant/zero for quite a while, so may be better to abort?

In any case, I couldn't figure out any way to not configure this into
the kernel when any kind of crypto is also in ...

johannes


