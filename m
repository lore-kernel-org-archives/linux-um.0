Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8236CAC5A7
	for <linux-um@archiver.kernel.org>; Wed, 24 Sep 2025 07:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D2wn6RMMBnB/+9wWDZ2/t9VQgCDz7Hs9Ndx57HE6Dsg=; b=w6TBs00xiPVhUELe9pcp8kp1zl
	FB0rbMSBHuD6afvkGunxlkKInHT7EQf+0j7XFSBFw/gCpQcm513zZakUBCbgtPZLUKuIgPqON4cbD
	/AoMnaumjCO3C2hXMkDxFfSCRIovlGFxZgghw/mcfMbGF1CK4cU0M436wQq7xYKq0CMDZYuc4XMce
	8FPSJImZqtT239OzB9M4H9xobmcNnF3PZspr+RXGUr0z17aZu6yuTSFmlB4kqZdGObIT3mz8+Iu8e
	F6j82DnWhzmfrTs07tk6nYa+yIWQstbjvYUIBypHFECIRCfWBvLmErJV9Res+qp4s3GvZT2GB19pN
	AbaSnDLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1KM0-0000000Fo3Z-0yoG;
	Wed, 24 Sep 2025 07:55:56 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1KLy-0000000Fo2n-0juF;
	Wed, 24 Sep 2025 07:55:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=D2wn6RMMBnB/+9wWDZ2/t9VQgCDz7Hs9Ndx57HE6Dsg=;
	t=1758700554; x=1759910154; b=R3lXYP9aI4scTeiLBaEXA77iBdHJ7gbfni5fAj7VLFKHOvq
	MsnNCFRldGH35kPInGcwPr1WNpBu9ggDQk3GGoBYKGNB41O0C+Ms7oUgRMYkbx4J4QiuzpBqH2zI/
	ymp0lmVif3OMmaMb99aiWATXPTZ54531q2pTABB9K81BccQMhl8dpwF/dHVr8ERySs13hgkt4tCc2
	xsKy7fLUO0DakQvpuHKJssKEyMZMffbDaM6sn6zqzagOis0NxeomyC/GOnHbbyhro4yQqDqb59T6V
	woA6lHiIlXP587yuSZ9fMG5cN2cC4P9jD5R35KIn+I00hJg2QU7RHGLELk9rl4YA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1v1KLs-00000008P0I-0JrN;
	Wed, 24 Sep 2025 09:55:48 +0200
Message-ID: <97fde69716ea4742b6cb4aca1a3ecc8788693cd3.camel@sipsolutions.net>
Subject: Re: [PATCH v2 00/11] Start porting UML to nolibc
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Willy Tarreau <w@1wt.eu>, Hajime Tazaki <thehajime@gmail.com>
Cc: johannes@sipsolutions.net, hch@infradead.org,
 linux-um@lists.infradead.org, 	linux@weissschuh.net,
 linux-kselftest@vger.kernel.org, acme@redhat.com, 
	linux-kernel@vger.kernel.org
Date: Wed, 24 Sep 2025 09:55:47 +0200
In-Reply-To: <20250924033217.GA9039@1wt.eu>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
	 <aM15eChUObXfxLzs@infradead.org>
	 <4354d88c2ff7a57a7324cc39b4ce5ed4ebe5277d.camel@sipsolutions.net>
	 <m2y0q47mbs.wl-thehajime@gmail.com> <20250924033217.GA9039@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250924_005554_238087_3475E1EE 
X-CRM114-Status: GOOD (  28.55  )
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

On Wed, 2025-09-24 at 05:32 +0200, Willy Tarreau wrote:
> On Wed, Sep 24, 2025 at 08:58:47AM +0900, Hajime Tazaki wrote:
> >=20
> > Hello Benjamin, Johannes,
> >=20
> > On Mon, 22 Sep 2025 16:41:36 +0900,
> > Johannes Berg wrote:
> > >=20
> > > On Fri, 2025-09-19 at 08:40 -0700, Christoph Hellwig wrote:
> > > > On Fri, Sep 19, 2025 at 05:34:09PM +0200, Benjamin Berg wrote:
> > > > > From: Benjamin Berg <benjamin.berg@intel.com>
> > > > >=20
> > > > > This patchset is an attempt to start a nolibc port of UML.
> > > >=20
> > > > It would be useful to explain why that is desirable.
> > >=20
> > > Agree, it should be here, but FWIW it's been discussed elsewhere on t=
he
> > > linux-um list in the past and basically there are various issues arou=
nd
> > > it. Off the top of my head:
> > > =C2=A0- glibc enabling new features such as rseq that interact badly =
with how
> > > =C2=A0=C2=A0 UML manages memory (there were fixes for this, it worked=
 sometimes
> > > =C2=A0=C2=A0 and sometimes not)
> > > =C2=A0- allocation placement for TLS is problematic (see the SMP seri=
es)
> > > =C2=A0- it's (too) easy to accidentally call glibc functions that req=
uire
> > > =C2=A0=C2=A0 huge amounts of stack space
> > >=20
> > > There are probably other reasons, but the mixed nature of UML being b=
oth
> > > kernel and "hypervisor" code in a single place doesn't mix well with
> > > glibc.
> >=20
> > just curious
> >=20
> > - are those issues not happening in other libc implementation ? (e.g.,
> > =C2=A0 musl-libc)
> > - same question to nolibc: is there any possibility that nolibc will
> > =C2=A0 evolve as glibc does, and this evolution introduces the UML issu=
es ?
>=20
> Nolibc focuses on early boot programs. That does not mean it will never
> evolve towrards more generic usage but this remains unlikely, and in any
> case there's the goal will remain not to degrade the experience on the
> original target (early boot). That doesn't mean there will never be any
> breakage but we're doing our best to keep things in a clean and workable
> state. Regarding threads, it seems unlikely that they'll arrive any time
> soon. But if they did, assuming UML would by then be a long established
> user, we'd certainly find a solution together (even via build-time
> defines if needed).

Also, with nolibc it is really simple to override any functions as
needed. We will likely want to do this for malloc/free so that nothing
bad can happen there.

Actually, UML already tries to do that for glibc. However, it
effectively fails (for dynamically linked builds) because the
dynamically linked glibc still uses its internal version for these
symbols.

Benjamin

