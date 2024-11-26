Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2455ED3B98B
	for <linux-um@archiver.kernel.org>; Tue, 26 Nov 2024 13:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rHa2Pkh7li/QGEhGcNYZNveFmh5qRI5DCHiWMi+k3g8=; b=EOKpDxD6hks5c07W2clRGzyMtq
	h6NSuYQc7E0JfbNR98snaf2Jb4YCTkN4dvJtUBsyHZvMcVOSMFk4uiH3YqRH7haJpXVQNofUuGN/b
	ZkHS4kukoxCtip33bDPoFT85pBwLacD/cHNl12AsA00oHwRIrlYXfsSnGxrs/4m20Oy6oMabUwkSX
	dFY84Q8uf6qmvUOY7k0CKXH5JAvalBnZCBFULPriHKdh8RCufE03SZc/KGTcfHomv6acmAnG1pUMT
	WOLR/BuV/Co20FyQxGSx3Uc/Wdgx2tj/RdJoLDXOLlJ2/Jrljb+lr3vshR6XYP4zOvDb5xR3ZNGy9
	BAU5pyaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFvxq-0000000AmYH-1WxY;
	Tue, 26 Nov 2024 13:50:50 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFvxo-0000000AmXC-0QGs
	for linux-um@lists.infradead.org;
	Tue, 26 Nov 2024 13:50:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=rHa2Pkh7li/QGEhGcNYZNveFmh5qRI5DCHiWMi+k3g8=;
	t=1732629045; x=1733838645; b=HkowGnqSh0MmgBUzhB3CHYW8n3NS+CIedGqUq620fBddubH
	9TxBuqVEPEN7yCxg8YUQRSEPVY7aY7mZBf9LTT0E7LOiBDcSM1OYeRZ8MCear7Mj/sVknilhdwPS9
	vq3xuKCbE955hPnckBEATK+76bShSnJzbKy/aHLJCfiE4JeCA50WvH1Af9KQhY1jlgcQT40CLVNQX
	aAEGY0IYKyWEhen58l4U6Kj3F6vEn4ifm8/Gkw7tSfXbRCOdTtKDjZKEGrFlUT1AiB1C92LW6NReL
	y8HSqKjYsKKIgwS7bQIDrJDllTT0PneK/fMADH/PeWj6EmzHDiD2BSg2RT3UDaPw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tFvxe-0000000FT0O-3euF;
	Tue, 26 Nov 2024 14:50:39 +0100
Message-ID: <6e6ccc76005d8c53370d8bdcb0e520e10b2b7193.camel@sipsolutions.net>
Subject: Re: UML mount failure with Linux 6.11
From: Johannes Berg <johannes@sipsolutions.net>
To: Karel Zak <kzak@redhat.com>, Hongbo Li <lihongbo22@huawei.com>
Cc: linux-um@lists.infradead.org, linux-fsdevel@vger.kernel.org, Christian
 Brauner <brauner@kernel.org>, Benjamin Berg <benjamin@sipsolutions.net>,
 rrs@debian.org
Date: Tue, 26 Nov 2024 14:50:38 +0100
In-Reply-To: <ykwlncqgbsv7xilipxjs2xoxjpkdhss4gb5tssah7pjd76iqxf@o2vkkrjh2mgd>
References: <093e261c859cf20eecb04597dc3fd8f168402b5a.camel@debian.org>
	 <3acd79d1111a845aed34ed283f278423d0015be3.camel@sipsolutions.net>
	 <0ce95bbf-5e83-44a3-8d1a-b8c61141c0a7@huawei.com>
	 <420d651a262e62a15d28d9b28a8dbc503fec5677.camel@sipsolutions.net>
	 <f562158e-a113-4272-8be7-69b66a3ac343@huawei.com>
	 <ac1b8ddd62ab22e6311ddba0c07c65b389a1c5df.camel@sipsolutions.net>
	 <b0acfbdf-339b-4f7b-9fbd-8d864217366b@huawei.com>
	 <buizu3navazyzdg23dsphmdi26iuf5mothe3l4ods4rbqwqfnh@rgnqbq7n4j4g>
	 <9f56df34-68d4-4cb1-9b47-b8669b16ed28@huawei.com>
	 <3d5e772c-7f13-4557-82ff-73e29a501466@huawei.com>
	 <ykwlncqgbsv7xilipxjs2xoxjpkdhss4gb5tssah7pjd76iqxf@o2vkkrjh2mgd>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241126_055048_136711_15742DB8 
X-CRM114-Status: GOOD (  10.72  )
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

On Mon, 2024-11-25 at 18:43 +0100, Karel Zak wrote:
>=20
> The long-term solution would be to clean up hostfs and use named
> variables, such as "mount -t hostfs none -o 'path=3D"/home/hostfs"'.

That's what Hongbo's commit *did*, afaict, but it is a regression.

Now most of the regression is that with fsconfig() call it was no longer
possible to specify a bare folder, and then we got discussing what
happens if the folder name actually contains a comma...

But this is still a regression, so we need to figure out what to do
short term?

Ignoring the "path with comma" issue, because we can't even fix that in
the kernel given what you describe changed in userspace, we can probably
only

 1) revert the hostfs conversion to the new API, or
 2) somehow not require the hostfs=3D key?

I don't know if either of those are even possible


Fixing the regression fully (including for paths containing commas)
probably also requires userspace changes. If you don't want to make
those we can only point to your workarounds instead, since we can't do
anything on the kernel side.

I don't know the fsconfig() API, is it possible to have key-less or
value-less calls? What does happen=20

johannes

