Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFE1C3064D
	for <linux-um@archiver.kernel.org>; Tue,  2 Jul 2024 10:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B9Wy+e4vhQ3tNy9dQIZdNonINNpIur19DvyWc0QsBHA=; b=XU3OObbw/6HsBA7HQmOXhV0qZN
	OOUguhDDtH5cdJzf+48w7hLSiAT9ShRInMZa/qrZOrHmHQ7Z/tlZKlbDNo05i/iPKIWB+o+owKwpP
	UQvBMNq+ox5dqXnpmrbquF+jhEP+L/CJAneiwqqY71dCkse8keb2MMpzIenUBgljOAfdoXOULaO2d
	4wVc4XKvRKyZMJTxW12E03vctyxsCoSy+hWqoJmQgNtY2E6cP4H4hXYJFRDWMxydtqIvnUdHRXdz8
	rPsIP07YCVKXEHoatcWbNWswueXS4MuNYMEPvLvj4jSF7B9tnHhFCPwbASgYhbGXoS87u/R6y0M83
	0X4Y9Uaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOacT-00000006KfR-32ZE;
	Tue, 02 Jul 2024 10:20:17 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOacQ-00000006Key-2WAr
	for linux-um@lists.infradead.org;
	Tue, 02 Jul 2024 10:20:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=B9Wy+e4vhQ3tNy9dQIZdNonINNpIur19DvyWc0QsBHA=;
	t=1719915614; x=1721125214; b=PZO6LvO0BorSenIno5wDubXSQE6XCCZ6Gujn6KImcgDBENs
	WuyBK+JoWmTIEXKTLLxcOdUVQdSd21vBh3FRgxjAllNWdJztiyQsVFvzwZSNWC7J32+FBmOJH1uT8
	T7AgRC1gyqAWfREFZ18wiZF9R0BsoNw/OKn6jP3aZRn+3yJxWnI0hcRlw/L9oui9y+ckL5yRTe6rL
	uXC0ZbupT3rYUnk6FKoAwI0yMNI10UhAqo742WYJtuAcJGCa0Y8bUPoNu3XJ86nB5/LMvL3oRlpK9
	GANlzeSkcknpAzo3nx286xY+r30/jUElU4WXO5rjSI+EXO5WOnV4HCXJtvCRTBYg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sOacO-00000005CE3-26aH;
	Tue, 02 Jul 2024 12:20:12 +0200
Message-ID: <c0d51320d81cd0573ec2923376abdd0c3b58f923.camel@sipsolutions.net>
Subject: Re: [PATCH v10] um: Enable preemption in UML
From: Johannes Berg <johannes@sipsolutions.net>
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	linux-um@lists.infradead.org
Date: Tue, 02 Jul 2024 12:20:11 +0200
In-Reply-To: <6d4c32b6237f02b6f53ed91bbc7fdfc0b293874a.camel@sipsolutions.net>
References: <20240702102549.d2fcea450854.I12f5a53d80ec1e425e66ef272b1e95cb523b608e@changeid>
	 <2c584137-211b-4746-bb6b-ebdec4c486af@cambridgegreys.com>
	 <6d4c32b6237f02b6f53ed91bbc7fdfc0b293874a.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240702_032014_663794_BB815122 
X-CRM114-Status: UNSURE (   8.35  )
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

On Tue, 2024-07-02 at 12:18 +0200, Johannes Berg wrote:
>=20
> We have 40 patches in patchwork now, including the 7 64-bit address
> space ones from Benjamin where I think some rework is needed. I've
> rebased/applied the other 33, I've just pushed that to the 'pending'
> branch:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git/log/?h=3Dpe=
nding
>=20

I should add - the hostfs fix really should go to 'fixes', not 'next',
perhaps soon? Otherwise I think it's all fine for 'next', some fixes are
there but they're limited to unusual (time-travel) configs.

johannes

