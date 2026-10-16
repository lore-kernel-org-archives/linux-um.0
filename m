Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEEBCCA462
	for <linux-um@archiver.kernel.org>; Fri, 16 Oct 2026 09:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f/uMLjCIp2jROhfmRYKxJtNgmOf39cw4XgLVOb0p/jw=; b=FNGszH9q+n5X3meYv4TetqvoMJ
	Al8hkve/L2ETjScsDByGIonRBCsTwlSv9SvkO7ojcLrOqRKX3EVRPCT3J2rPLLajqIdqNbifidy4G
	s61kk8pETViwljHsLO72nT+4Fd8klX3vbiO1NbRiyVIIZD8Aik+70WqtO4HRLCMIXas+r6DlII416
	j9s5tlBKuPYPqaXihmhmUStveM7cLR7BHR6aJpJmzCbL0c6P+sAUZ4XChtypJ2VTqGv1SUDlFdKiA
	1jFmZdKrofSrTCI261/0lRdGIj938CtlkuIonmRipWSjJSegXCVPS3eg76ToBTlAEl7Y4GGsU/8ZD
	FHcvOHyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHeUV-00000002Wi9-1BOF;
	Fri, 16 Oct 2026 09:44:43 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHeUS-00000002WhL-2L5y
	for linux-um@lists.infradead.org;
	Fri, 16 Oct 2026 09:44:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=f/uMLjCIp2jROhfmRYKxJtNgmOf39cw4XgLVOb0p/jw=;
	t=1792143880; x=1793353480; b=bbU9IMlfVyNylOCU2e3WapG20ov6p8iJtJicVuJ1533LQiE
	xUH1ce3LFN9cz2OG0uXYq821OMwAvHSGkomgEnq2LeLPtWnO+9SipO3gccKJHNxJsWazq4Www7Aho
	RXWKneGuDTMKHQWYvHAIin+6gUl6HvN5/AdDoaVe15Inw71stljqyZZ0+f73+LQpSN//oxoPwQp8b
	jGBW7Xow9k7GmD15tpM5dp9nSUH3TuwVKGlhEcVs1WaD4rr1LLM7mhnJRXsUGsguHoIR6Ws3yrG3L
	gDfnAOQYGi8PhqJDfx/dFf/4KCLfv2CsA4IO8HBQsb7SgSpSkUroWrSTU675DyDw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xHeU5-00000005eqa-3gLI;
	Fri, 16 Oct 2026 11:44:18 +0200
Message-ID: <18ba10ec7aa6659ee4711f8dd3f3138e314e4af6.camel@sipsolutions.net>
Subject: Re: [PATCH net-next v2 2/7] um: vector: honor virtio net hdr
 conversion failures
From: Johannes Berg <johannes@sipsolutions.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Willem de Bruijn	
 <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowangio@gmail.com>, 
 Eugenio =?ISO-8859-1?Q?P=E9rez?=	 <eperezma@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Andrew Lunn	 <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet	 <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni	 <pabeni@redhat.com>,
 netdev@vger.kernel.org, virtualization@lists.linux.dev,  Rusty Russell
 <rusty@rustcorp.com.au>, Max Krasnyansky <maxk@qualcomm.com>, Richard
 Weinberger <richard@nod.at>,  Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
Date: Fri, 16 Oct 2026 11:44:16 +0200
In-Reply-To: <20261016054142-mutt-send-email-mst@kernel.org>
References: <cover.1792067836.git.mst@redhat.com>
	 <6716834884238de0ab1ab313004044122aa2adbf.1792067836.git.mst@redhat.com>
	 <8420ba1fe84fc7d105825026802d4ad10d44af71.camel@sipsolutions.net>
	 <20261015085119-mutt-send-email-mst@kernel.org>
	 <64ee40b97fc447bbf3abb80250ad0d9f3cf3c6fa.camel@sipsolutions.net>
	 <20261016054142-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261016_024440_608637_80F683BF 
X-CRM114-Status: GOOD (  19.43  )
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

On Fri, 2026-10-16 at 05:43 -0400, Michael S. Tsirkin wrote:
>=20
> > > > > -	virtio_net_hdr_to_skb(skb, vheader, virtio_legacy_is_little_end=
ian());
> > > > > +	if (virtio_net_hdr_to_skb(skb, vheader,
> > > > > +			virtio_legacy_is_little_endian()) < 0)
> > > > > +		return -1;
> > > > >  	return 0;
> > > > >=20
> > > >=20
> > > > Seems it'd be simpler to just
> > > >=20
> > > > 	return virtio_net_hdr_to_skb(...);
> > > >=20
> > > > As far as I can tell, the function only returns -EINVAL or 0 (never=
 a
> > > > positive value), and the caller only cares about negative (error) o=
r
> > > > positive (no checksum needed), so that'd be equivalent?
> > > >=20
> > > > johannes
> > >=20
> > > if raw_verify_header can safely return any errno - i did not want to
> > > audit it.
> >=20
> > You already used an LLM and still didn't want to? ;-)
> >=20
> > I checked briefly (by hand) and it seems fine, it's assigned to the
> > function pointer, which only has two callers on the _kern.c side.
> >=20
> > johannes
>=20
>=20
>                                header_check =3D vp->verify_header(
>                                         mmsg_vector->msg_hdr.msg_iov->iov=
_base,
>                                         skb,
>                                         vp
>                                 );
>                                 if (header_check < 0) {
>                                 /* Overlay header failed to verify - disc=
ard.
>                                  * We can actually keep this skb and reus=
e it,
>                                  * but that will make the prep logic too
>                                  * complex.
>                                  */
>                                         dev_kfree_skb_irq(skb);
>                                         vp->estats.rx_encaps_errors++;
>                                         (*skbuff_vector) =3D NULL;
>                                         mmsg_vector++;
>                                         skbuff_vector++;
>                                         continue;
>                                 }
>                                 if (header_check > 0) {
>                                         vp->estats.rx_csum_offload_good++=
;
>                                         skb->ip_summed =3D CHECKSUM_UNNEC=
ESSARY;
>                                 }
>=20
>=20
>=20
> so any negative is fine, but if we return 1 then it will force to CHECKSU=
M_UNNECESSARY
> which I am not sure is what was intended?
>=20
Right, but virtio_net_hdr_to_skb() cannot return 1, only 0 on success
and -ERROR on failure?

johannes

