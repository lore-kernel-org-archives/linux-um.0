Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A96C4167B
	for <linux-um@archiver.kernel.org>; Fri,  1 Dec 2023 20:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dxveFagBNj5/ty55lDPJPyZWurWMS/8ve7eeXES38tY=; b=arAopESWtBoqwpTrliq46kDky8
	fOA+c1mZHbuT615ExaE54zwfzObuODkuu2jqMgzLYNXUc+4osysW9YaGWWRmamyg7n/9WDp3RLaD1
	m71ZO4NQbtJPjl0A1sn6P0sav7GjP/WrIMKe/crW7V5eKu4nmQsBvTnyKW1W41aRLIK/bU1RejwWw
	S5HPpCK8xPx9mAYUHEp0QdabBRUeqymm3VdkScqkA3ChooATQBXk+j3kDMDK7a2LmmDAlFzeCzafb
	ZyyNqwnIVriQ48SzviEGwbUb8sNaLopYickk/Qq/Pn6N4PN6O5OsHS7xszqUxvEvOj1q/o4QPUMaG
	4EA4ytYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r99kc-00EZ9B-0E;
	Fri, 01 Dec 2023 20:04:38 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r99kZ-00EZ8s-1W
	for linux-um@lists.infradead.org;
	Fri, 01 Dec 2023 20:04:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=dxveFagBNj5/ty55lDPJPyZWurWMS/8ve7eeXES38tY=;
	t=1701461073; x=1702670673; b=kJu6L8AL9oh+n5iZciI+9L5U0ZTez2NquGhXaZ4/KWc7KTM
	RKbI+bMFhdA8AiULPFUBsB01ZV/we92OCoqTZp9JZyMr7yWOzr3yZSYhvXRX7k1/Fm57eNtZ2q7yW
	aEwXaKXOA6JIv2Myb8u+MjSdHhWHMHJFmvwbeMhDTmDN+3umCkzIX0+X7v+a6W3534pjETNa9keSb
	UQWHUU4oRJfscNccnNKBv5ZVMz6nJZUFNk75Ku5/7MWilOm0FNnIWNGgDRcMCLjYVcepqbKmAyKvD
	g3zSbuQF9icRMGt0erfR0HqOXzL5pVnBHo6WSWVOKZ1DX8snBJfxPKRp+OKNh8Kw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r99kV-0000000BRhY-1WHh;
	Fri, 01 Dec 2023 21:04:31 +0100
Message-ID: <640c12810b336aa99584697e21215f3cacb13c79.camel@sipsolutions.net>
Subject: Re: jitterentropy vs. simulation
From: Johannes Berg <johannes@sipsolutions.net>
To: Simo Sorce <simo@redhat.com>, Anton Ivanov
 <anton.ivanov@kot-begemot.co.uk>,  linux-um@lists.infradead.org
Cc: linux-crypto@vger.kernel.org, Stephan =?ISO-8859-1?Q?M=FCller?=
	 <smueller@chronox.de>
Date: Fri, 01 Dec 2023 21:04:30 +0100
In-Reply-To: <e1b3ccb744d67e6214cf206ba8480cb3e35694cf.camel@redhat.com>
References: <e4800de3138d3987d9f3c68310fcd9f3abc7a366.camel@sipsolutions.net>
	 <7db861e3-60e4-0ed4-9b28-25a89069a9db@kot-begemot.co.uk>
	 <8ddb48606cebe4e404d17a627138aa5c5af6dccd.camel@sipsolutions.net>
	 <e1b3ccb744d67e6214cf206ba8480cb3e35694cf.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231201_120435_530106_27A30CA4 
X-CRM114-Status: UNSURE (   6.37  )
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

On Fri, 2023-12-01 at 14:25 -0500, Simo Sorce wrote:
>=20
> Doesn't this imply the simulation is not complete

Kind of?

>  and you need to add
> clock jitter for the simulation to be more useful?
>=20

No, it's more _intentionally_ incomplete. This works fine in normal
ARCH=3Dum, but with time-travel variants we have more of a discrete event-
based simulation, to integrates well with other things (e.g. SystemC or
similar based device simulations). So this is quite intentional, and
yes, it breaks in a few spots such as this one.

johannes

