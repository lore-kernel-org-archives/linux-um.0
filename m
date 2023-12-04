Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC121C4167B
	for <linux-um@archiver.kernel.org>; Mon,  4 Dec 2023 10:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BwdZDQNE6NwHTCAOnOmqkJq+1IRiJC5XwuSTturBP44=; b=y9spIH/09B7OC3yNaFmmiWyQvt
	f7941DWnZY3jY5FAEfGkRvxzrq+7LAYcCwdoRGxXEW02drs5mWDPht+Vyaw29wsDCOYIRzSc9X5FR
	s2M5ZFS7uQuaELTf4xDFU0jPR8tseOXNWehfvAtmOH57vULJBCVgk5rJt0exy4AVi1CupyflYqRO1
	0dP5ey6zO8vg0NlcAI3GsV4sWfBhPOddulm2ZnMiRynOe3ZhEA5KXmdF9kfmyQ8FDPq8fIN3YFL9H
	KFKqpMBqu/m14qSiN0BPEuJZq4eIWuFNE6AJ5hcPk0bxXPRw5OXg7hB5yOavNBEYLg8XDzwZ7qzWB
	E2JkDEew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rA686-003X4w-1i;
	Mon, 04 Dec 2023 10:24:46 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rA67s-003X1w-1g
	for linux-um@lists.infradead.org;
	Mon, 04 Dec 2023 10:24:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=BwdZDQNE6NwHTCAOnOmqkJq+1IRiJC5XwuSTturBP44=;
	t=1701685469; x=1702895069; b=RYBrxAUdll8ZQfpCUIcdW2xtXsq0rhEe82pywfntLO/PFJl
	QsvzbCJV+wGNOO5/su8pWTehJv3H3lcHxRyUeAhxBhI/owd3VX+nY9+PJkadFyhaCsYt6LGVfjcuW
	yrIrBchaa4QZuh+k3jsTPULjOn4o4MoAjjWNPaJekhvpIlLqLT2eQql7oc6vaEuNkztfk3ftOqSXM
	BAUIGkg1zNIa1bqxZ7L6A+719nRFhHBaznsmHUJAfpgr6YOouXiHvEkwtGu2mCfIJ4UwABO8HGwwI
	h/Le5FipVJV8Zw6eb5yDXADc0J/lXmYO05/GB3NdOfdELTiVPxBoCV+qJ4oDQPag==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rA67m-0000000EwVY-3LbT;
	Mon, 04 Dec 2023 11:24:27 +0100
Message-ID: <e863c5fd47d6b4c36a8f4554d4470ad92e51abea.camel@sipsolutions.net>
Subject: Re: jitterentropy vs. simulation
From: Johannes Berg <johannes@sipsolutions.net>
To: Stephan Mueller <smueller@chronox.de>, Anton Ivanov
	 <anton.ivanov@kot-begemot.co.uk>, linux-um@lists.infradead.org
Cc: linux-crypto@vger.kernel.org
Date: Mon, 04 Dec 2023 11:24:25 +0100
In-Reply-To: <1947100.kdQGY1vKdC@tauon.chronox.de>
References: <e4800de3138d3987d9f3c68310fcd9f3abc7a366.camel@sipsolutions.net>
	 <7db861e3-60e4-0ed4-9b28-25a89069a9db@kot-begemot.co.uk>
	 <8ddb48606cebe4e404d17a627138aa5c5af6dccd.camel@sipsolutions.net>
	 <1947100.kdQGY1vKdC@tauon.chronox.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 (3.50.1-1.fc39) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_022432_770926_36DA1461 
X-CRM114-Status: GOOD (  15.09  )
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

Hi Stephan,

> The reason for the Jitter RNG to be dragged in is the Kconfig select in=
=20
> CRYPTO_DRBG.

Yes, but you can't get rid of DRBG either. That'd require getting rid of
CRYPTO_RNG_DEFAULT, which means you cannot even have CRYPTO_GENIV?

Hmm. Maybe it _is_ possible to get rid of all these.

> Why does the DRBG require it?
>=20
> The DRBG seeds from get_random_bytes || jitter rng output. It pulls an eq=
ual=20
> amount of data from each source where each source alone is able to provid=
e all=20
> entropy that the DRBG needs. That said, the Jitter RNG can be designated =
as=20
> optional, because the code already can handle the situation where this Ji=
tter=20
> RNG is not available. However, in FIPS mode, we must have the Jitter RNG=
=20
> source.
>=20
> That said, I could fathom to change CRYPTO_DRBG to remove the select=20
> CRYPTO_JITTERENTROPY. But instead, add the select to CRYPTO_FIPS.

Well, CRYPTO_FIPS also would break our testing, since we still have to
support WEP/TKIP (RC4-based) ...

> This change would entail a new log entry when a DRBG instance initializes=
:
>=20
> pr_info("DRBG: Continuing without Jitter RNG\n");
>=20
> I would assume that this change could help you to deselect the Jitter RNG=
 in=20
> your environment.
>=20
> Side note: do you have an idea how that Jitter RNG perhaps could still be=
=20
> selected by default when the DRBG is enabled, but allows it being deselec=
ted=20
> following the aforementioned suggestion?

Well it _looks_ like it might be possible to get rid of it (see above),
however, what I was really thinking is that jitter RNG might detect that
it doesn't actually get any reasonable data and eventually give up,
rather than looping indefinitely? It seems that might be useful more
generally too?

johannes

