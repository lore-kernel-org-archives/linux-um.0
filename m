Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECCDED10BE5
	for <linux-um@archiver.kernel.org>; Sat, 26 Oct 2024 08:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8xvFuMBW1keE9gV9hm4gKhkdue9DAfMsI9BXde4g/fg=; b=hgBFMct1plt2Xut/aw5Tse8Hcr
	RVU5jpcj0Pj3DtYi/EVGfoR0M3ovvh+q4S4wRYC2pTdCkY7ksPeyC5UJ0C9/z8TOoGfUQqEaAYIll
	SCLKJxMbwtbHdMjHhlIltrz7SOcFLRTO4vwaDmheSrcK+4So1LPYh7dY2MfF1ROgoaljeIpsqI02S
	srKy885iPMA+UO323867K81KUetoGzwL6uS8o9Q3NzS3Ne8ivWS1MnF0CHzuiYCdAh1TAulumNae3
	/ZyWWfqnc7aWjl+UWntYISJ/y1n6OOg8hJktKS7MfaXH+/5/N4Faodqi9g7u5EJOAhXNvZXXBZFm6
	+jz/PZPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4blw-00000006BlG-2Hwy;
	Sat, 26 Oct 2024 08:03:44 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4blt-00000006Bkn-49l2
	for linux-um@lists.infradead.org;
	Sat, 26 Oct 2024 08:03:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=8xvFuMBW1keE9gV9hm4gKhkdue9DAfMsI9BXde4g/fg=;
	t=1729929821; x=1731139421; b=O7dJ2tEzRfAtdZnCAKnkQbf9E2XKWI92WLxRby3WdLboOFh
	pUaJP2xJ3v7n4hqzcj5Vq/CwZFJQhmPVOx+aS1ND+ALHyEtYQoYuV0F4gw5vIkEHVoh284pPVRsLN
	ZdejUBN3RNvyhkdh+mJj2UCUktXGaR7TIRphRjI5OrBiZNwHR5XIIvtdAOZTz1UFRWaF/zDgcgv8D
	l5j62WBwUULSturHI4NOEu0bDIatJ+gr1Fuf8s38cUCKQOjmX5E9Q01v7LKoa9lFi3B7gEQCatfGD
	Nj5kIcMLM/87cXmHrpkINCeYr2G+EaSApeTdR0qH0mSyIENFiePsXQSBw4kUcR8Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t4blq-00000005Jb4-0fRQ;
	Sat, 26 Oct 2024 10:03:38 +0200
Message-ID: <433fb0eb0132a583dc5f575f0c99c4adb8ef6cab.camel@sipsolutions.net>
Subject: Re: [PATCH][next] um: Malloc just enough space for fitting pid file
From: Johannes Berg <johannes@sipsolutions.net>
To: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com, kees@kernel.org, 
	tiwei.btw@antgroup.com, linux-um@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Date: Sat, 26 Oct 2024 10:03:37 +0200
In-Reply-To: <ZxyhbCw39rBzAvtg@mail.google.com>
References: <ZxxmLngMg3iNjOfK@mail.google.com>
	 <cd892fb5436f1de0fa2ffc9c9ec229873227210f.camel@sipsolutions.net>
	 <ZxyhbCw39rBzAvtg@mail.google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241026_010342_048721_8CE8EDB9 
X-CRM114-Status: UNSURE (   7.34  )
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

On Sat, 2024-10-26 at 20:59 +1300, Paulo Miguel Almeida wrote:
>=20
> when I said that "umid is already generated during make_umid_init
> __initcall", from my humble point of view, I was explaining the 'why'
> using UMID_LEN for calculation buffer sizes was redundant. Then again,
> once we know the size of char* umid, we can use strlen(umid) instead.

That's not "why am I changing it" though, that's "why does it work".

The only reasonable explanation I could come up with is that you're
trying to save memory ... but why go to the trouble for a function
that's called exactly once?

johannes

