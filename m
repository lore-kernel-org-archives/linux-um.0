Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD89606A320
	for <linux-um@archiver.kernel.org>; Thu, 19 Nov 2026 13:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2g1CuCe1;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=wUaWgdnr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=C9rYyNnTEc/BelkezMP38g9VihbCHXQ5/KykvN5a2HA=; b=2g1CuCe1ADn5YY+FPEKZh8z+SZ
	M/UYMg7BDyHsvUcJQgxJ9H3SxBanKJcwIKBof00dGubpKE9oiecrsEo4QAfrIzaKmRVsr98Ln+epb
	o1nLSLmIQDuRnbokXbEX7zlFiYYzRgc6GDmJV1U++Jkmahj5oIpbh44GgzWalEyh6j+8LMsFqTjO1
	3Cy4OuqQ67ZhrE8+12ExnGD3/dWndSM/k+cLE/4Ayikni/vk5qHcKv0yFkV1xh3PWoAtYyOymUxQ/
	m4iAyjB9x4NfxOSH3A1JwkcMIbKwIK3VSAQA6cROFO5EHbUiKseku2nhPSzirpO8NO0oAOx7P/dJG
	kA+9gVsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU2Cy-0000000C3kz-0zig;
	Thu, 19 Nov 2026 13:29:48 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU2Cv-0000000C3h3-0LYi
	for linux-um@lists.infradead.org;
	Thu, 19 Nov 2026 13:29:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=C9rYyNnTEc/BelkezMP38g9VihbCHXQ5/KykvN5a2HA=;
	t=1795094984; x=1796304584; b=wUaWgdnrpfN8OO11Rh08nSPAAse7dhWtiJtA6FLoEQRy0aY
	AyFwcwplC1EaFij7eumtFCiuN8SJs3yXBbJ/OPcoHZhTRERsx6H1HOlERuYwlBHBqkdmDSNhIwcBL
	HsnEuhlxXG4bAmVVXKSfc8i9B0p3Nb0Emt54hHKTXG7XpxuZlx9VCuDAvJoB8uRt9aY8sT0uwKV2M
	I8b085zcnvj1UEMuwEcbp70Bn49oKgTEnmrc6ju9h/Az3raLV0LUsPpTQ3UYBskBhZhH0cBCx4K0q
	JlvUpyjBC1mWZdoZTmqTr8e8qNdA7SWns0EuOUtHmbRoLBWiU+rSs5VQcJxitESw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1xU2Cm-00000004LcI-25LB;
	Thu, 19 Nov 2026 14:29:36 +0100
Message-ID: <cfd763cf2f3b9a7b47dc0f651bd2e11854baaed2.camel@sipsolutions.net>
Subject: Re: [External Mail]Re: [RFC] um: reproducible randomness for
 time-travel tests
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>, 
 =?UTF-8?Q?=E5=AD=9F=E4=BB=A4=E6=BE=B3?=
	 <menglingao@xiaomi.com>
Cc: "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, 
 "richard@nod.at"
	 <richard@nod.at>, "anton.ivanov@cambridgegreys.com"
	 <anton.ivanov@cambridgegreys.com>
Date: Thu, 19 Nov 2026 14:29:35 +0100
In-Reply-To: <cf5b39641d70ef666a8fc27bac893ab57354d4d5.camel@sipsolutions.net> (sfid-20261119_141650_964681_F7BF37DB)
References: <D2219FFB-73EF-4E27-B84A-5C8E550E3553@xiaomi.com>
		 <480fe566b40da65fc2102c951394e39c4d8b7f22.camel@sipsolutions.net>
		 <304D77DF-B1EF-454A-88D9-1BB898BD5F2B@xiaomi.com>
		 (sfid-20261119_140447_724071_B1362E65) <cf5b39641d70ef666a8fc27bac893ab57354d4d5.camel@sipsolutions.net>
	 (sfid-20261119_141650_964681_F7BF37DB)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261119_052945_133103_C9E2FD82 
X-CRM114-Status: GOOD (  20.96  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Thu, 2026-11-19 at 14:16 +0100, Johannes Berg wrote:
> [SNIP]
> > We compared two runs in the same image and got byte-identical HCI and
> > over-the-air captures for the BlueZ cases. That's the scope of our
> > reproducibility check.
>=20
> Ah OK. We actually did (at some point in the past at least) validate
> that /dev/urandom returns the same stream :) But I guess BT would also
> have keys derived etc. that depends on that anyway.

We are still collecting that data for every run and I am somewhat
monitoring how reproducible repeated runs are.

Our setup is quite a lot more complicated (hostfs, multiple machines,
etc.) and unfortunately, we are not fully there and still see some
failures.

If I recall correctly though, it was mostly an issue that happens when
running on different hosts at this point. But I have not found out what
the difference is, as I seemed to be able to rule out CPU, host kernel
and some other factors.

Btw. we do also set some environment variables for ld.so to avoid
loading different optimizations depending on the exact host CPU
instruction set.

Benjamin

>=20
> > The awkward part is that we have to build a separate 32-bit shared
> > library and rely on UML calling the interposable libc symbol. The shim
> > fixes the bytes UML gets from the host through that call. The guest
> > RNG still mixes in other inputs, including the kernel build
> > information, command line, and interrupt timing you mentioned.
>=20
> Right.
>=20
> > Would it make sense to start with the os_getrandom() seed from your
> > list, enabled only when a seed is explicitly supplied for a
> > time-travel boot? If your patch is available, I'd be happy to try it
> > against our BlueZ tests.
>=20
> I'll just send all of our related patches, there's no real secret here,
> we just didn't think anyone would care, and didn't bother polishing the
> changes enough to be upstreamable :)
>=20
> johannes

