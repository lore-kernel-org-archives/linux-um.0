Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBAF9106ACFE
	for <linux-um@archiver.kernel.org>; Fri, 13 Mar 2026 00:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-id:Date:
	References:In-reply-to:Subject:Cc:To:From:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mVG8eebTQIYrNSCfz5AoYNPWvAP9zOmA/oSXBEUNMDg=; b=C3uwEebrgIx1pW
	wagnBOJmsgLZ+ES8Mgql0K0X07O06fOzFHYbUPjJoyXri2AKb7dKwEkPmQ/0HElendQj6OvsNj5Cm
	zJWsB21mLt3OVlSuXLAM9ERdshD55avRp+wBUQD2+2MZs/ozTbsIbuzDDh8L4qFrICCH04gX4/mlR
	xnheJNUfhRlOPVACSqWdMaicDeBAnAH+8YnPMOKtiavCF333YRMb1ozJ10wLoW7UV8hM7uy+r8Grj
	3UBNfBx6nzQMRwJBpEEZR0dGAkfOo8ueX6i0prHG8QSRC0RX/t2K1hwOFk/sHErsgAHkRvRawol5p
	hZyzECE3bjf2kan8sh4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0qFC-0000000Fu1v-0PID;
	Fri, 13 Mar 2026 00:19:10 +0000
Received: from flow-b3-smtp.messagingengine.com ([202.12.124.138])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0qF8-0000000Fu1A-3EDV;
	Fri, 13 Mar 2026 00:19:08 +0000
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 8CEA61301B20;
	Thu, 12 Mar 2026 20:19:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 12 Mar 2026 20:19:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1773361144; x=1773368344; bh=mVG8eebTQIYrNSCfz5AoYNPWvAP9zOmA/oS
	XBEUNMDg=; b=gHD+X8LZJV5BmcTxyVzSi4eOH+f9NWdLk6voSZ3Dk2TmtFtrTPT
	n0z2oXB44COIaMxym9EotuPwl3zhBchA17LQD1aiXLP0HZVx+1sB2rDvs+59CClN
	HQKjtkq+MLlefiP50e3G0ZUzDRVImhJt8LXC5Gk+3LL4kz0dWCTiZEgkORI83H3g
	IYzMIhIFS+pW8u+iq3O1fDK+eB6xv0w3oEKr75CQKG3ENMDVGe/ATK98/l7Dvx/P
	8BZhP/BMTsa8A8nINOCn4yT0evPyJ+NeT9UVxbDjMi1RnmCTf2Vmbpsgbeb+2prd
	AnO6/VSTlvk8uuzd90K874TkKVJWxfC+iOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773361144; x=
	1773368344; bh=mVG8eebTQIYrNSCfz5AoYNPWvAP9zOmA/oSXBEUNMDg=; b=c
	CdkekOPdZGeTHq9Q9fn6kwRHxICBqhAbEe7Mbn8RL0/ghUTZud8i2luiteEmp2Ir
	nIdMJTy2arC7PIdd3QUxuvFoTPxCOMLV9z6Gm7Dry2+55WAsz8/lpUpp6KLCvOb5
	vppTuCMIOaaruvILxo7wGqRgbVRfmvszAtPJWbhzUWIoBUdJz8+7BU3zgxJSlbc3
	fpGHsm7gMQ5BqZ2Qbs1zxa7FgNneoKrfT70cZbcDqlzmSr5Rt1Zdfq8ZqH/0hCpG
	u4ztiIjqn7BZ94m/pkzsJPqZlNum+Fn4NWKv3hqcNWG2BtBRflNBWi/TcF8QJ+Eo
	3H4DqYmdO0Ph/KIpM2FGA==
X-ME-Sender: <xms:9lezaf2biEH_YUoVtaJ788TBctRMYMGJjfZ2DGR5uanh1iY0Bnn1tg>
    <xme:9lezaRxzKm32RjDuV_b2LpuNVPPb6Y2SpMCDjskankSuVyTtPWjSsFcMWwjNHIFU7
    GLRMDp98i1zC2yMmBsdKulbM_AH2YMuIt5X8wc4fPQA-OpC2Q>
X-ME-Received: <xmr:9lezaa84oPqo9JeTHF-KiyHUZaJt4h0JSykKqUiirLVobFQ0qtPIFeYYpGFOGnN83U9sO87B36Hyg9vaeC9k5oIsMjNlS0OCsh5IMJauHcVf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epffevjeeljeehueejgeehleelueevudehjeekgeevueffteevhfefvedtueeugfejnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsgesohifnhhm
    rghilhdrnhgvthdpnhgspghrtghpthhtohephedupdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtghpthht
    oheplhhinhhugidqgihfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhinhhugidqthhrrggtvgdqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqvgigthegsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqvghfihesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9lezaSQ88me8CYxNCjygrSQBmtG4cdv1lL3aUTLRRuM52pJKUU1ccw>
    <xmx:9lezaXkQlDHP4UxMpnGEVP1brRONq1oRM3xyFBblzX9245pjYr4Vpw>
    <xmx:9lezaSZBls0VHhctSLEpvUTcq6jJd_Fbrs8I5U1SyxvxEE-JGS1Fuw>
    <xmx:9lezaak5kvHNn-TYlzGIxM5qxPwoE_QzIk7oFu49dZPa1Fp3mUUnVA>
    <xmx:-FezaRCDWnLXkmnc85hbOjTGKD_omhp2YPsIbC_7rVSfPvFCo06RTGxC>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 20:18:49 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Steven Rostedt" <rostedt@goodmis.org>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Jeff Layton" <jlayton@kernel.org>,
 "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Carlos Maiolino" <cem@kernel.org>,
 "Miklos Szeredi" <miklos@szeredi.hu>,
 "Amir Goldstein" <amir73il@gmail.com>,
 "Jan Harkes" <jaharkes@cs.cmu.edu>, "Hugh Dickins" <hughd@google.com>,
 "Baolin Wang" <baolin.wang@linux.alibaba.com>,
 "David Howells" <dhowells@redhat.com>,
 "Marc Dionne" <marc.dionne@auristor.com>,
 "Steve French" <sfrench@samba.org>,
 "Namjae Jeon" <linkinjeon@kernel.org>,
 "Sungjong Seo" <sj1557.seo@samsung.com>,
 "Yuezhang Mo" <yuezhang.mo@sony.com>,
 "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Breno Leitao" <leitao@debian.org>, "Theodore Ts'o" <tytso@mit.edu>,
 "Andreas Dilger" <adilger.kernel@dilger.ca>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Ilya Dryomov" <idryomov@gmail.com>,
 "Alex Markuze" <amarkuze@redhat.com>,
 "Viacheslav Dubeyko" <slava@dubeyko.com>,
 "Tyler Hicks" <code@tyhicks.com>,
 "Andreas Gruenbacher" <agruenba@redhat.com>,
 "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Jeremy Kerr" <jk@ozlabs.org>, "Ard Biesheuvel" <ardb@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
 coda@cs.cmu.edu, linux-mm@kvack.org, linux-afs@lists.infradead.org,
 linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 ceph-devel@vger.kernel.org, ecryptfs@vger.kernel.org,
 gfs2@lists.linux.dev, linux-um@lists.infradead.org,
 linux-efi@vger.kernel.org
Subject: Re: [PATCH RFC 00/53] lift lookup out of exclive lock for dir ops
In-reply-to: <20260312193847.28c32a2c@gandalf.local.home>
References: <20260312214330.3885211-1-neilb@ownmail.net>,
 <20260312193847.28c32a2c@gandalf.local.home>
Date: Fri, 13 Mar 2026 11:18:47 +1100
Message-id: <177336112755.5556.2850267364383380917@noble.neil.brown.name>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_171906_854133_FCAB1FE0 
X-CRM114-Status: GOOD (  11.12  )
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
Reply-To: NeilBrown <neil@brown.name>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Fri, 13 Mar 2026, Steven Rostedt wrote:
> On Fri, 13 Mar 2026 08:11:47 +1100
> NeilBrown <neilb@ownmail.net> wrote:
>=20
> > *[PATCH 26/53] smb/client: don't unhashed and rehash to prevent new
> > *[PATCH 27/53] smb/client: use d_splice_alias() in atomic_open
> >  [PATCH 28/53] smb/client: Use d_alloc_noblock() in
> > *[PATCH 29/53] exfat: simplify exfat_lookup()
> > *[PATCH 30/53] configfs: remove d_add() calls before
> >  [PATCH 31/53] configfs: stop using d_add().
> > *[PATCH 32/53] ext4: move dcache modifying code out of __ext4_link()
> > *[PATCH 33/53] ext4: use on-stack dentries in
>=20
> >  [PATCH 34/53] tracefs: stop using d_add().
>=20
> Hmm, another reason I hate being Cc'd on every patch of a patch bomb where
> I only need to look at one (and maybe the first) patch.

I could try to refine my tooling, but you can't please all the people
all the time...  I wonder how many people would be bothered if only the
cover-letter was sent to everyone, and the patches only went to lkml -
to be fetched from lore if not subscribed.

You would probably need to look at 02/53

https://github.com/neilbrown/linux/commit/aebdc6545eb18e5b6a7d41320f30d752996=
b3c6c

to have the context to understand 34/53

>=20
> For some reason, I'm missing several patches, and this is one of them :-p

They don't seem to have made it to lore.kernel.org either.  Maybe I'm
being rate-limited somewhere.

https://github.com/neilbrown/linux/commit/77074c04a94176d6b2b2caf44dd84f0788a=
420c4

Thanks,
NeilBrown

>=20
> -- Steve
>=20
>=20
> >  [PATCH 35/53] cephfs: stop using d_add().
> > *[PATCH 36/53] cephfs: remove d_alloc from CEPH_MDS_OP_LOOKUPNAME
> >  [PATCH 37/53] cephfs: Use d_alloc_noblock() in
> >  [PATCH 38/53] cephfs: Don't d_drop() before d_splice_alias()
> >  [PATCH 39/53] ecryptfs: stop using d_add().
> >  [PATCH 40/53] gfs2: stop using d_add().
>=20


