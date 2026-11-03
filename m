Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF11606A327
	for <linux-um@archiver.kernel.org>; Tue,  3 Nov 2026 09:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=39MHN2zt;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=skdfO9ZF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=OnJjS8Dd9kV1QuRv0ju2mVkDrGbSfyDN4nVRbAhdHVw=; b=39MHN2ztnqatrUnX3WMUEn0Twu
	htyKSVfzgAwGIZ4u9dOcXHvDh/CjXWtdHSuNfdHs4G0bCVn0/i4C3Zb0rge6hU9IVGV23iHor5VH0
	UfmwUuJDLY9Akx5PZNnfft1KT7Q4BHmm58Jz6xaphYVNalDOWQgfdjOQMFttAAmf13ZBY2vSw3W5z
	UoKamUSFS2p6kmCIv6jGynRfEukXZ2dGMEGFhL0l4bSSzTRKthUa8vz7rmW+CTJ387v50tODGcqgW
	c8OsxtOaBU/sCIVQ9wtqZWd4DAaq4eCK7+HqZ46DZnT7g/oqZ6LV38fCiHDsAJT7jSiva19XevqRI
	NEORSipQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOAzG-00000001m3K-3QiO;
	Tue, 03 Nov 2026 09:39:26 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOAzE-00000001m2O-2QGx
	for linux-um@lists.infradead.org;
	Tue, 03 Nov 2026 09:39:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=OnJjS8Dd9kV1QuRv0ju2mVkDrGbSfyDN4nVRbAhdHVw=;
	t=1793698764; x=1794908364; b=skdfO9ZFf6OLMCXGv/X/yJjwasB/XpJ4GoghenzRGLzW0Si
	6QQvKDh9fmWJ9azaXGveLyM641UHytOu4NbX9YeRSwcTwgpIyZh95f3x5nRz6Xq48miuLFGbDdeXo
	F3iL5JZEiT2OE756L5ucW9Y2lFepxk/9NpeGYJHJ5GhGq0dfE3fre80tOPl+SEhS/k2eZc8NyS3+y
	qO9SMwIWo688cQ+RSBnT7ZC8pTQdw1phE3JPDOXJZwud4jeVegAH/QkTDDHlivLlqqpRj4ZrZUZk5
	96fxaeWk42D027x1tCA1zxwzpxloVFmt+H2AGmyszc8Gg5rm8w8YteLjc17dGI3A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xOAz2-00000003EMq-39l8;
	Tue, 03 Nov 2026 10:39:12 +0100
Message-ID: <0730c9d467af3897a547860d036a5591cb40905b.camel@sipsolutions.net>
Subject: Re: [PATCH v1] rust: arch/um: Fix loading Rust modules
From: Johannes Berg <johannes@sipsolutions.net>
To: FUJITA Tomonori <tomo@flapping.org>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: ojeda@kernel.org, a.hindborg@kernel.org, acourbot@nvidia.com, 
	aliceryhl@google.com, bjorn3_gh@protonmail.com, boqun@kernel.org,
 dakr@kernel.org, 	daniel.almeida@collabora.com, david@davidgow.net,
 gary@garyguo.net, 	linux-um@lists.infradead.org, lossin@kernel.org,
 tamird@kernel.org, 	tmgross@umich.edu, work@onurozkan.dev,
 rust-for-linux@vger.kernel.org, 	fujita.tomonori@gmail.com
Date: Tue, 03 Nov 2026 10:39:11 +0100
In-Reply-To: <20261103.180207.1243555897796693771.tomo@flapping.org>
References: <20261004121230.373216-1-tomo@flapping.org>
	 <20261103.180207.1243555897796693771.tomo@flapping.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_013924_614796_E2FB109E 
X-CRM114-Status: UNSURE (   9.86  )
X-CRM114-Notice: Please train this message.
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 2026-11-03 at 18:02 +0900, FUJITA Tomonori wrote:
> >=20
> > diff --git a/arch/um/Makefile b/arch/um/Makefile
> > index 937639edc295..c4a99073f014 100644
> > --- a/arch/um/Makefile
> > +++ b/arch/um/Makefile
> > @@ -62,8 +62,6 @@ KBUILD_CFLAGS +=3D $(CFLAGS) $(CFLAGS-y) -D__arch_um_=
_ \
> > =C2=A0=C2=A0	-Din6addr_any=3Dkernel_in6addr_any -Dstrrchr=3Dkernel_strr=
chr \
> > =C2=A0=C2=A0	-D__close_range=3Dkernel__close_range
> > =C2=A0=20
> > -KBUILD_RUSTFLAGS +=3D -Crelocation-model=3Dpie
> > -
> > =C2=A0 KBUILD_AFLAGS +=3D $(ARCH_INCLUDE)
> > =C2=A0=20
> > =C2=A0 USER_CFLAGS =3D $(patsubst $(KERNEL_DEFINES),,$(patsubst -I%,,$(=
KBUILD_CFLAGS))) \
> >=20
> > base-commit: 2dee3d3adcadcc57d62ba6608cd02f50b0c10264
>=20
> Gentle ping. The patch still applies cleanly on top of v7.4-rc1. If
> it looks fine, could you take it through the UML tree?

I guess I figured with the "rust:" prefix it'd go through their tree,
but either way during the merge window and all I wasn't really paying
attention to UML.

I'll pick it up now.

johannes

