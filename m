Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 500FAC44532
	for <linux-um@archiver.kernel.org>; Wed, 22 Jul 2026 16:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r02GWLSoLUNPJK4MascVVz2K6QW1fzM/BX+WtGrCpQg=; b=re4ObUCDD3S3+N2T21NYk7Y80o
	dlBH2Fjt6rmi83256fHXf8/hoebzk/H/WSPYyOfNnCIxpbPQfqpmtvxb7b8WEipTK8DgxnCpvOLDq
	FTCGSi8/xWTT0dPkua4IlDlkeuXhwj1FVRW6qFDDUZWL2CdbIamXzNPa798HSl9D2YZozY+C/X0M/
	g9YTBSiaWOb5iibo3BGjBqCNyaFHlXBKFs+yGFqfp9Zr7L6LJIWCz9kelEEaIhf60jYDpqggm1Kfp
	+86+qCOtz5JTAaVwNXTWile9rBd5tbQR46T1FMXVm1H9/wkuyotl/pbfo1vqW5TDdJtL8k/FP/dpk
	y8tC3xPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmZaM-0000000CIjL-2r7r;
	Wed, 22 Jul 2026 16:14:18 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmZaJ-0000000CIiN-2qpk
	for linux-um@lists.infradead.org;
	Wed, 22 Jul 2026 16:14:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=r02GWLSoLUNPJK4MascVVz2K6QW1fzM/BX+WtGrCpQg=;
	t=1784736855; x=1785946455; b=UfOEC+NgwX2x9KVeMbgp3gASor131tW47ooltC0do7yv8On
	9rzMJc42lqQy0XgpGs9edMdH2h7M9GKyo4aTp42PSwDcTNxDSWfeBtVDFPrQH1D42OpUH/Lqxu805
	MRDkVmXE2brZ3BdKlLznKn26Kj7G9j71cFCG3zG/pjVU+iZYnvPlxA6Cjnwnu0Bs657RADi3YlnRF
	Gdn1ddHAqLtHPRAWuBpO76QCtY+a7STwDbmW35YoLMia3y4mfKG3p3Wba33vrCae4p/WEDfAwpBQx
	MRFu0NdlhvfgVTYP6Bwmq0KJMRVJRPpUVCBhoUQoIJF4qfv1VRDzVLuLJgOA+YxA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wmZaF-00000004sT7-2ffK;
	Wed, 22 Jul 2026 18:14:11 +0200
Message-ID: <a30db44d0711d41065b1407aa5c20e062fec890c.camel@sipsolutions.net>
Subject: Re: [PATCH] um: Allow multiple symbol definitions for GCOV builds
From: Johannes Berg <johannes@sipsolutions.net>
To: Alex Hung <alex.hung@amd.com>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org
Cc: Bhawanpreet.Lakha@amd.com
Date: Wed, 22 Jul 2026 18:14:10 +0200
In-Reply-To: <313f6cf4-91a1-42e7-8e19-d2883c5c4f73@amd.com>
References: <20260708224006.3405038-1-alex.hung@amd.com>
	 <743d1be771381c86c7f264810d88876976cc508f.camel@sipsolutions.net>
	 <75f2f98c-78df-46df-9961-6ddf2870d044@amd.com>
	 <8b710b01b8117d41281595265da43ab0add10214.camel@sipsolutions.net>
	 <313f6cf4-91a1-42e7-8e19-d2883c5c4f73@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260722_091415_759865_2DE1EAD1 
X-CRM114-Status: GOOD (  16.04  )
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

On Wed, 2026-07-22 at 10:09 -0600, Alex Hung wrote:
>=20
> On 7/22/26 08:02, Johannes Berg wrote:
> > Hi,
> >=20
> > On Tue, 2026-07-21 at 16:23 -0600, Alex Hung wrote:
> > > >=20
> > > > I cannot see how that would possibly result in correct behaviour (b=
eyond
> > > > being able to link)??
> >=20
> > > Good point. --allow-multiple-definition silences the linker error, bu=
t
> > > picking kernel or libgcov's mangle_path() will break the other at run=
time.
> > >=20
> > > I saw your previous patch
> > > (https://lkml.iu.edu/hypermail/linux/kernel/2103.1/06604.html) to ren=
ame
> > > mangle_path() to seq_mangle_path(). How about reviving it to avoid na=
me
> > > conflicts instead?
> >=20
> > Honestly, I completely forgot about that. Looks like I ran into the
> > typical "nobody wants to merge it" problem ...
> >=20
> > johannes
>=20
> Is there any concerns or blockers to merge them?

I don't _think_ so, I guess it ended up mostly procedural, since it was
across different maintainers etc., and I lost interest because we
stopped trying to use gcov.

> I sure want to revive them.

Sure, sounds reasonable, feel free, of course!

> The series may also have a solution for the other patch I sent=20
> (https://lore.kernel.org/linux-um/eea36454-cbbe-4690-980d-b4ec9423f3a0@am=
d.com/T/#u).

That one we should just apply for ARCH=3Dum, seems reasonable to me.

> I will test the series and report here later.
>=20

Thanks. Please just resend whatever you think should be included, maybe
first all the UML stuff separately.

johannes

