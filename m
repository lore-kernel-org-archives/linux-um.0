Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E98FD45F9
	for <linux-um@archiver.kernel.org>; Thu, 26 Feb 2026 01:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-id:Date:
	References:In-reply-to:Subject:Cc:To:From:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MIfXBGDQB4RR7qswdmhZCaPdgdKBr+0rVg2Ck+fxHVw=; b=YYs0oNhsBgqOcN
	oULMvdmbEYv8pWiJaK4peJY1IageOBvNmbF/jWdrt/ivV/FaAoOWH+2JLKikeP2H52NxVYVJ9woIm
	1i+u/mMY3lNbRkwXyI84kB1Njn95M7bRuOnLYMeV+axDcO+NqufNvGnhAn3YXWc9UrQdbxVg6t8/V
	+PS0VwZze9WtQK2APKJ/EuXnsIGDfQ55FJQa51D6gSKB9zdRlcfxE/TC5QeuVnxTKmFJaEWI2BNSG
	nZwvEDxTEe4N/ib4JLez0qlHtdc6tC9OULqoQyJ45RLLQOtqTCyZPK4JYyEJ5CRWDiU9oXYuw6O+c
	kqe+J8sGANzhvthd2m8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvPk9-00000005A9A-0TtU;
	Thu, 26 Feb 2026 01:00:41 +0000
Received: from flow-b7-smtp.messagingengine.com ([202.12.124.142])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvPk5-00000005A8I-0ovj;
	Thu, 26 Feb 2026 01:00:38 +0000
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id 073CD1301680;
	Wed, 25 Feb 2026 20:00:31 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 25 Feb 2026 20:00:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1772067631; x=1772074831; bh=MIfXBGDQB4RR7qswdmhZCaPdgdKBr+0rVg2
	Ck+fxHVw=; b=I+BIJN1yBbaT7Ye9NnHRN7RVbmR/fZZLe0tXB8yF8zn9oXauu82
	DCQb8SWZsf2Eux70Szs13mXlKZJydWgAFhCkU613aKC6BynUEKyIJYvLWjNmMuTA
	Yq0Bel04MQ2ATiVCczLvA+HfXixsTYCDPFWHtIyj7HXmaFl79RWlvcQNTtQRyjKW
	n5tiq26wllB1dWR0649OQtna+Iy5678L6qs08lAcJa3Z3B3HDTKgCi/gKr/4VIor
	VkBT6VJH73t8vVvN4PYxGwKLBTT+RSR6OPcHfLTdfJvZgBLCBg4mjO5gc8q5UhoM
	HMaTnS0ufEBiNOLUkLQv/dD/A1ClZ8ZNc9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1772067631; x=
	1772074831; bh=MIfXBGDQB4RR7qswdmhZCaPdgdKBr+0rVg2Ck+fxHVw=; b=a
	tfl/zZ4iH745WvQOalFyGLty4aVWIkMh/5MMH9bYfCswcXevMv3jQyYiqtpXnGm0
	9VcCLew1NcMO747wDJEtMVNQ/slb5OKeR+Joqkhh7wDujSxlj2Wp6IW9t7xowNf/
	aqpoX6qfp8uyrfHybhPw4IzMQpcoTCg44CYwdigB/NRFJpuj9UBFZNyzDHM6T4AK
	l76bogL7WO2pHeoii+bSfJGzoLsna2oDEEZJU/1hZH4m5OXcQI2vHka07AJjAqIi
	6vjtlGi2DPs1D8ve4/SN3TCKM7MpDT0Ae2GtBO8kKlulCA46U2SX3X9ge1X+M1ef
	kTjYg/6YC5VNwu8X/GqwA==
X-ME-Sender: <xms:LZufaftPMtWgdDkitaCZ4sVT-6XAkeOh-6kcN5Zc5X5JFt6vAvwgTg>
    <xme:LZufabQh5C40SDO2iOCH4SMcjda3hdy7bhGWpaBIDETm8zryjstVIDmbBjaZDBEQ8
    pIxyJJcpnlslY_9vr8-kPhc9XB3i99MK6LqlXp9BfqrVumcGQ>
X-ME-Received: <xmr:LZufaRDegemF-eP4MDBVSFtdh9LEkJuIrKSZ9lZKDOh7S31djt_Z4ATQLDS4pub-Eo6NKrGncaTY3GVvyfVkM5NQE6WLOWJkNritwUk6WLWM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeegiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epudetfefhudevhedvfeeufedvffekveekgfdtfefggfekheejgefhteeihffggfelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepfedupdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtoheplhhinhhugidqgihfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqtghifhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepvggtrhihphhtfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheptggvphhhqdguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:LZufadykdbrD4rR2UzHpn89Kimb0saqiyga-82ZaaSj3mwEb_7ZPHw>
    <xmx:LZufaZtalLykNeLq4-QIa8O1JMPOxcOCsJat4jMZ-skFRUgtkqvKCQ>
    <xmx:LZufaekgVJBUVEpjkNqsX17DKwx83aZM76pGrLOZgfcakE7MwkqAgQ>
    <xmx:LZufaWB1hCvkt45p98B7ynEJfQD-nJ6AzTvpQgc7kF1rq92_Ut6x3A>
    <xmx:L5ufaXim2lapcwkmze5KzM105VezEEs66Gr3kySkLij0WHxjT1xfbwxO>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Feb 2026 20:00:21 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "David Howells" <dhowells@redhat.com>,
 "Marc Dionne" <marc.dionne@auristor.com>, "Xiubo Li" <xiubli@redhat.com>,
 "Ilya Dryomov" <idryomov@gmail.com>, "Tyler Hicks" <code@tyhicks.com>,
 "Miklos Szeredi" <miklos@szeredi.hu>,
 "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>,
 "Amir Goldstein" <amir73il@gmail.com>,
 "Steve French" <sfrench@samba.org>,
 "Namjae Jeon" <linkinjeon@kernel.org>,
 "Carlos Maiolino" <cem@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-afs@lists.infradead.org, netfs@lists.linux.dev,
 ceph-devel@vger.kernel.org, ecryptfs@vger.kernel.org,
 linux-um@lists.infradead.org, linux-nfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/11] VFS: allow d_splice_alias() and d_add() to work on
 hashed dentries.
In-reply-to: <20250813050717.GD222315@ZenIV>
References: <20250812235228.3072318-1-neil@brown.name>,
 <20250812235228.3072318-9-neil@brown.name>, <20250813050717.GD222315@ZenIV>
Date: Thu, 26 Feb 2026 12:00:17 +1100
Message-id: <177206761798.7472.8904569543245678825@noble.neil.brown.name>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_170037_527525_FA4A06A3 
X-CRM114-Status: GOOD (  26.07  )
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

On Wed, 13 Aug 2025, Al Viro wrote:
> On Tue, Aug 12, 2025 at 12:25:11PM +1000, NeilBrown wrote:
> > Proposed locking changes will require a dentry to remain hashed during
> > all directory operations which are currently protected by i_rwsem, or
> > for there to be a controlled transition from one hashed dentry to
> > another which maintains the lock - which will then be on the dentry.
> > 
> > The current practice of dropping (unhashing) a dentry before calling
> > d_splice_alias() and d_add() defeats this need.
> > 
> > This patch changes d_splice_alias() and d_add() to accept a hashed
> > dentry and to only drop it when necessary immediately before an
> > alternate dentry is hashed.  These functions will, in a subsequent patch,
> > transfer the dentry locking across so that the name remains locked in
> > the directory.
> 
> The problem I have with that is the loss of information.  That is to
> say, "is it hashed here" is hard to deduce from code.  I would rather
> add d_splice_alias_hashed() and d_add_hashed(), and then see what's
> going on in specific callers.  
> 
> And yes, it requires analysis of places where we have d_drop()+d_add() -
> better have it done upfront than repeat it on every code audit *for*
> *each* *single* *call* *of* d_add(), including the ones that are currently
> obviously meant to be called for unhashed dentries.
> 
> I realize that it's no fun at all - in particular, I'd never been able
> to get ceph folks to explain what is and what is not possible there.
> 
> I would really hate to have that expand by order of magnitude - in
> effect, you make *all* calls of d_splice_alias() and d_add() similar
> mysteries.
> 

I'm picking this up at last ... only 6 months later.

d_add_hashed() would be much the same as d_instantiate(), and that
could be used for d_splice_alias() when the dentry is hashed.
There aren't any cases where d_splice_alias() is called with a directory
inode and a hashed dentry.

I think atomic_open is what makes this interesting.  It can be called
with a d_in_lookup() dentry, or a negative hashed dentry.  In the former
case, d_splice_alias() is appropriate.  In the latter, d_instantiate()
is best.

No filesystems makes that distinction clearly.

Most which provide atomic_open check for d_in_lookup() and perform a
lookup in that case, resulting in a hashed dentry - if positive they
just return it.

The exceptions are ceph, smb/client, and nfs.

They d_drop() (if unhashed for ceph, unconditionally for smb and nfs)
and then d_splice_alias().

So I could change these to:

 if (d_in_lookup(de))
    d_splice_alias(de, inode);
 else
    d_instantiate(de, inode);

or maybe we could have a new interface, though I can't think of a good
name.

Could we enhance d_instantiate to do d_splice_alias() in the case where
the dentry is d_in_lookup()?

Thanks,
NeilBrown

