Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606A9D59F6C
	for <linux-um@archiver.kernel.org>; Wed,  6 Nov 2024 19:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hhh0YTh8Ye1ZCMRiBBnzq2Y3Q75pmNoA6oa3eotaSUA=; b=OLl9c1kaLXFqFnP+2JgQvHMXF1
	e8DMueCYyHN6y9ZkSgyxsJByVUrstJYA1etXdhQ0XeDmk0KwIX+SkqYJL2u/lge/MOBpXrPJVROQN
	DsPIS0FrQr0vt5RWhfbHxe5n/kG3+nR339I2JHRueAYNFXueHMHmdro/7hh4M0y1VqfRXdlApPnTJ
	nfSD/k9ds0Cl0IxWHdWF6kfCPNOt1yPal5BKTKdCO+xr8u3ytII2xLTJpCsRECtbx0MSJsycD3mOq
	6k5fRiOV89yrtf9/+63ewdKSWG0R8h5bXi9EkwMsz1TP50Oj/auHxs8JJtYvtrRWaGM53JDqCcRHE
	Q7dAuFuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8lkc-00000004WIV-42bI;
	Wed, 06 Nov 2024 19:31:34 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8lf9-00000004VQc-2L7A
	for linux-um@lists.infradead.org;
	Wed, 06 Nov 2024 19:25:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=hhh0YTh8Ye1ZCMRiBBnzq2Y3Q75pmNoA6oa3eotaSUA=;
	t=1730921152; x=1732130752; b=Zmm987vVOLaVOiwnLuNqh5tU9SrBEqumaG7PphhTWiG0LVs
	eEtJ67oWKucgpAla4AO2sB3erJr7Zdaj2ammRFbss9YGQI+vdzVUD3pydElcjKMLbZmDxp9C9C9Ka
	jExyHmMgk/pGR5bHYKN2M9B5tGSyMqgYmVGEByl2AW3pUfoyxM6eo+I+l1NYVQ9FOBu9rnxHBJk8R
	kGV3zg8MjCNOJ6EJP4HRJAAyGZl/Ii+KzTq+QJ22sZ9uH/lXHiP9ds4CCMcaKlyGp+iPsS5O7pMPJ
	8OpdL4yPlPk7PTZdfU04J/r8vi1zIwl83GNLxn7aS8mSfc5Pc0Sxb4Ph6sG3H+6Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1t8lez-0000000Fj6a-3063;
	Wed, 06 Nov 2024 20:25:46 +0100
Message-ID: <3acd79d1111a845aed34ed283f278423d0015be3.camel@sipsolutions.net>
Subject: Re: UML mount failure with Linux 6.11
From: Benjamin Berg <benjamin@sipsolutions.net>
To: rrs@debian.org, linux-um@lists.infradead.org
Cc: Hongbo Li <lihongbo22@huawei.com>
Date: Wed, 06 Nov 2024 20:25:41 +0100
In-Reply-To: <093e261c859cf20eecb04597dc3fd8f168402b5a.camel@debian.org>
References: <857ff79f52ed50b4de8bbeec59c9820be4968183.camel@debian.org>
	 <2ea3c5c4a1ecaa60414e3ed6485057ea65ca1a6e.camel@sipsolutions.net>
	 <093e261c859cf20eecb04597dc3fd8f168402b5a.camel@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241106_112555_624109_992E41C7 
X-CRM114-Status: GOOD (  24.87  )
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

Hi,

I am probably not the right person to talk to. Maybe Hongbo Li can say
more?

That said, it looks like the filesystem now has the "hostfs" option. So
you can probably just use
  mount -t hostfs -o hostfs=3D/path none /mount/point
which is nicer anyway. Just a bit annoying as you probably need to pass
it differently for older kernels.

Benjamin

On Wed, 2024-11-06 at 17:22 +0530, Ritesh Raj Sarraf wrote:
> Hello Benjamin,
>=20
> On Thu, 2024-10-31 at 11:07 +0100, Benjamin Berg wrote:
> > Hi,
> >=20
> > Newer kernels have become more picky about that with the new mount
> > API.
> > This is relevant, see the discussion about "Unknown options":
> > =C2=A0 https://lwn.net/Articles/979166/
> >=20
> > We only use hostfs for the root file system and in that case it
> > works
> > well if you pass the path using "hostfs=3D/path" on the kernel
> > command
> > line. Doing that avoids issues when remounting the file system
> > later
> > on.
> >=20
>=20
> As upstream developers for UML, what would you conclude it as ?
>=20
> We've recommended using hostfs for the UML kernel modules as well.
> What
> would be the alternate approach to ensuring a proper boot for a
> modular
> UML kernel ?
>=20
>=20
> > I suppose that currently it does not work to mount hostfs later on.
> > No
> > idea what the right fix is. Maybe the host directory should be an
> > explicit option like "hostpath=3D..." or so to make it compatible
> > with
> > the new mount APIs.
>=20
> The ability to mount any hostfs mount point was/is a feature provided
> by UML. We've used it and integrated with many tools like debos,
> fakemachine etc; the Debian bug report has the details.
>=20
> There'll be more reports following once UML 6.11 hits Debian Testing.
>=20
> I hadn't expected a working feature to break with a newer Linux
> release. :-(
>=20
> Thanks,
> Ritesh
>=20


