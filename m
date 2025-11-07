Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D86D7CCFA1A
	for <linux-um@archiver.kernel.org>; Fri,  7 Nov 2025 23:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-id:Date:
	References:In-reply-to:Subject:Cc:To:From:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZcRWR0XGRVohQHNqpTmVOGqvgKfDCmeABc6Q5B6kVA0=; b=PJ5gQbOP4kgf3M
	Bse7zR8MsjB9/3okiMh6R6B6d9xD1o1XICifMBN5wmWfXOWndi51hswqaADntZjAVZCtRcplvFut8
	7uNCpo6l40cb9AaByHJpKaCEO4APckZHTEbCmAtsHIPBuIkwdoxFIX06kB2LteXSSJgY+S69GGyG1
	AHErvuCSqamHRdk7jg4iCNv32OtHNWAbmf7cvZjfNylc1rG4+dE2iCW4U9ikrzA1VnfAq7cjIYwVU
	sPy85r8Pen4PcJ59Wa9egHqlYDnG/D2rUlg0+yS+ejY7kRRh4Z37fnYm1SK0BmjqoMhv5aPt+dREg
	zzzlgMfLKCr5p++MUK6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHW1z-00000001ZVH-1gDP;
	Fri, 07 Nov 2025 23:38:11 +0000
Received: from flow-b3-smtp.messagingengine.com ([202.12.124.138])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHW1v-00000001ZTb-3ZhS;
	Fri, 07 Nov 2025 23:38:09 +0000
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 3696013001EB;
	Fri,  7 Nov 2025 18:38:03 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 07 Nov 2025 18:38:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1762558683; x=1762565883; bh=ZcRWR0XGRVohQHNqpTmVOGqvgKfDCmeABc6
	Q5B6kVA0=; b=E4OMnSLCME0PmpfRUhAwNxIceLFq3/FAK5GtwevM7iICUCUuV5x
	chVCFB6fdmay7+ooFw0uv6Azy1ChdRqJqvR+mkrCRIpg73LnR+/X59PszjPwZ/rz
	8CPuwHb/xwC5N1QSJvSaLdjI57addGAeTJRkLimMYRo6wgCZPhDhW+hNxZlCxMuJ
	hAPkIxK9zjio+5tvTHBm3a+bqM8CDMop81FHuSYzFd2NCfNmjV5NgDtUDa2Eyf25
	3VuDhIEZvIbIrGiHuAnMLfItwaVgsWO7Q33GX+ggP6/jGDAegWeYBoQRn47aNko2
	PunoNsPduYvN8zewgDdm1dEy75bfZgIQYaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762558683; x=
	1762565883; bh=ZcRWR0XGRVohQHNqpTmVOGqvgKfDCmeABc6Q5B6kVA0=; b=a
	v+lzygtoc1HX4ZadDskwTpZwJtb1oG3peL6O0gr4iO5O5jYd+vaRP7/no7N27oF3
	EzxSXy6KoH6IHmfzzAjLPr0QATO37tQfExkHIQ/kLMEtcMIpZa9opvRREQRlIldG
	Q9D0WkBAPuYtKKTvP1JAxo1/Rx7n6G2bitd51++grbdTyzCWIWx3DW0/Nhivcp1A
	s7ZtqshuHntLjgQgQJ+crHlgWYzKyD5izePEyTID8AqXRiIHiDEt9qwC/wQbmAXC
	g/7fHF+pLwFi9swg49B8mIz8mdbJ+nyJwVG9AYbNRT/JTg129nrTn8NZkPgHxX+2
	7BatW30ZGfoIC5BANZTig==
X-ME-Sender: <xms:04IOaUS1llkqfnpj0hP0k9hck1nUGtgZum40Y0dtCM64yfklBqqJ5g>
    <xme:04IOaV4vrSP4x6QNhepje5WcwIcNTd1apJim4xvCzIrniX8SAiYXqKNGGHIuD1WKQ
    33nU51_RKbR52XMFfrIspvHlzrBn079yJ8CWMmi6dxhoUy63Q>
X-ME-Received: <xmr:04IOaT3MWpLgDLL757W25o-tMfqjGpak2vFwG2uUDPGL2GuLLHFgVWSCwflcxilp3PZXpLTiHfR-SxGJx5w8TjROMf9sHRUcJd4NP_ZWYt62>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduledutddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegouf
    hprghmfghrlhculdeftddtmdenucfjughrpegtgfgghffvvefujghffffkrhesthhqredt
    tddtjeenucfhrhhomheppfgvihhluehrohifnhcuoehnvghilhgssehofihnmhgrihhlrd
    hnvghtqeenucggtffrrghtthgvrhhnpedvueetleekjeekveetteevtdekgeeludeifedt
    feetgfdttdeljefglefgveffieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuuf
    hprghmfghrlhephhhtthhpshemsddslhhorhgvrdhkvghrnhgvlhdrohhrghdsrghllhds
    jeeiieeffeeileekvdeltdehuddurdehfedtvdekfeekqdelqdgurghvvgdrhhgrnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsges
    ohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepleejpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhr
    tghpthhtohepfhhrrghnkhdrlhhisehvihhvohdrtghomhdprhgtphhtthhopehlihhnuh
    igqdigfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidq
    uhhnihhonhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuh
    igqdhnihhlfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    hkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhig
    qdhhrghruggvnhhinhhgsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:04IOaUUP8Agp5i-ePskgdOIZ3qDw3X8wH2n0PkSgIS-qUH6nBwUnqg>
    <xmx:04IOaTnQGxLDK6TRtOgEGVijEWvd6FvZOuwL0vyqcWwYM4LX-zVZXA>
    <xmx:04IOaVhEuGeVrKovELx7lzKD-9IxEW9YEYZ2LQZX-iUA996QSWwOgg>
    <xmx:04IOab5K6Z-7wWhbIK2-S_EvLNyL4_2HwgPfi2l7GSRp7-b2X_0qug>
    <xmx:24IOabMc8-grgTNo-sBp23kB4IC_01hhvLJuap-Y8_HG_nozNoQTctxM>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Nov 2025 18:37:32 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Jonathan Corbet" <corbet@lwn.net>,
 "Eric Van Hensbergen" <ericvh@kernel.org>,
 "Latchesar Ionkov" <lucho@ionkov.net>,
 "Dominique Martinet" <asmadeus@codewreck.org>,
 "Christian Schoenebeck" <linux_oss@crudebyte.com>,
 "David Sterba" <dsterba@suse.com>, "David Howells" <dhowells@redhat.com>,
 "Marc Dionne" <marc.dionne@auristor.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
 "Chris Mason" <clm@fb.com>, "Xiubo Li" <xiubli@redhat.com>,
 "Ilya Dryomov" <idryomov@gmail.com>, "Jan Harkes" <jaharkes@cs.cmu.edu>,
 coda@cs.cmu.edu, "Tyler Hicks" <code@tyhicks.com>,
 "Jeremy Kerr" <jk@ozlabs.org>, "Ard Biesheuvel" <ardb@kernel.org>,
 "Namjae Jeon" <linkinjeon@kernel.org>,
 "Sungjong Seo" <sj1557.seo@samsung.com>,
 "Yuezhang Mo" <yuezhang.mo@sony.com>, "Theodore Ts'o" <tytso@mit.edu>,
 "Andreas Dilger" <adilger.kernel@dilger.ca>,
 "Jaegeuk Kim" <jaegeuk@kernel.org>, "Chao Yu" <chao@kernel.org>,
 "OGAWA Hirofumi" <hirofumi@mail.parknet.co.jp>,
 "Miklos Szeredi" <miklos@szeredi.hu>,
 "Andreas Gruenbacher" <agruenba@redhat.com>,
 "Viacheslav Dubeyko" <slava@dubeyko.com>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Yangtao Li" <frank.li@vivo.com>, "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Mikulas Patocka" <mikulas@artax.karlin.mff.cuni.cz>,
 "Muchun Song" <muchun.song@linux.dev>,
 "Oscar Salvador" <osalvador@suse.de>,
 "David Hildenbrand" <david@redhat.com>,
 "David Woodhouse" <dwmw2@infradead.org>,
 "Dave Kleikamp" <shaggy@kernel.org>,
 "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>,
 "Ryusuke Konishi" <konishi.ryusuke@gmail.com>,
 "Konstantin Komarov" <almaz.alexandrovich@paragon-software.com>,
 "Mark Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>,
 "Joseph Qi" <joseph.qi@linux.alibaba.com>,
 "Bob Copeland" <me@bobcopeland.com>,
 "Mike Marshall" <hubcap@omnibond.com>,
 "Martin Brandenburg" <martin@omnibond.com>,
 "Amir Goldstein" <amir73il@gmail.com>,
 "Steve French" <sfrench@samba.org>, "Paulo Alcantara" <pc@manguebit.org>,
 "Ronnie Sahlberg" <ronniesahlberg@gmail.com>,
 "Shyam Prasad N" <sprasad@microsoft.com>, "Tom Talpey" <tom@talpey.com>,
 "Bharath SM" <bharathsm@microsoft.com>,
 "Zhihao Cheng" <chengzhihao1@huawei.com>,
 "Hans de Goede" <hansg@kernel.org>, "Carlos Maiolino" <cem@kernel.org>,
 "Hugh Dickins" <hughd@google.com>,
 "Baolin Wang" <baolin.wang@linux.alibaba.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Kees Cook" <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 linux-kernel@vger.kernel.org, v9fs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
 linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
 codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
 linux-efi@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, gfs2@lists.linux.dev,
 linux-um@lists.infradead.org, linux-mm@kvack.org,
 linux-mtd@lists.infradead.org, jfs-discussion@lists.sourceforge.net,
 linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
 ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
 linux-karma-devel@lists.sourceforge.net, devel@lists.orangefs.org,
 linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, linux-xfs@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: LLM disclosure (was: [PATCH v2] vfs: remove the excl argument
 from the ->create() inode_operation)
In-reply-to: <f5a2c41e4f272fef9f1525e17b494dd4b4bcb529.camel@kernel.org>
References: <20251107-create-excl-v2-1-f678165d7f3f@kernel.org>,
 <176255458305.634289.5577159882824096330@noble.neil.brown.name>,
 <87ikfl1nfe.fsf@trenco.lwn.net>,
 <f5a2c41e4f272fef9f1525e17b494dd4b4bcb529.camel@kernel.org>
Date: Sat, 08 Nov 2025 10:37:30 +1100
Message-id: <176255865045.634289.1814933499430115577@noble.neil.brown.name>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251107_153808_417958_4457F156 
X-CRM114-Status: GOOD (  17.77  )
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

On Sat, 08 Nov 2025, Jeff Layton wrote:
> On Fri, 2025-11-07 at 15:35 -0700, Jonathan Corbet wrote:
> > NeilBrown <neilb@ownmail.net> writes:
> >=20
> > > On Sat, 08 Nov 2025, Jeff Layton wrote:
> >=20
> > > > Full disclosure: I did use Claude code to generate the first
> > > > approximation of this patch, but I had to fix a number of things that=
 it
> > > > missed.  I probably could have given it better prompts. In any case, =
I'm
> > > > not sure how to properly attribute this (or if I even need to).
> > >=20
> > > My understanding is that if you fully understand (and can defend) the
> > > code change with all its motivations and implications as well as if you
> > > had written it yourself, then you don't need to attribute whatever fancy
> > > text editor or IDE (e.g.  Claude) that you used to help produce the
> > > patch.
> >=20
> > The proposed policy for such things is here, under review right now:
> >=20
> >   https://lore.kernel.org/all/20251105231514.3167738-1-dave.hansen@linux.=
intel.com/
> >=20
> > jon
>=20
> Thanks Jon.
>=20
> I'm guessing that this would fall under the "menial task"
> classification, and therefore doesn't need attribution. This seems
> applicable:
>=20
> + - Purely mechanical transformations like variable renaming
>=20
> This is a little different, but it's a similar rote task.
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20

The bit I particularly liked was:

+
+Even if your tool use is out of scope you should still always consider
+if it would help reviewing your contribution if the reviewer knows
+about the tool that you used.
+

"would it help the reviewer"?  I agree that is a key question.  In your
case I cannot see how it would help.

Thanks,
NeilBrown

