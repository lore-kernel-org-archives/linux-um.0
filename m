Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC6AC021BE
	for <linux-um@archiver.kernel.org>; Wed, 26 Feb 2025 03:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-id:Date:References:
	In-reply-to:Subject:Cc:To:From:MIME-Version:Content-Transfer-Encoding:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hi2lTyABX6F+Zk3VP84YZcYJcPAqNVeDNsTUYCj+h2E=; b=ght2PmAxlnfBc827eIosqyylI9
	fmKGXuKY092uX6UBSIwQ7B1Myqe8cbLXEDI4hFPWXZO/7YrW5TOw/Wd9TkEw5KCBAwhiV35k6HTGG
	I2lkqgJWTmGkK27/VeVYiGktcnsU9BG8a1lhokMn/VE7epBeqZTyFPz/HRcHyGVzkkT6WZTfrzFFp
	cJsI7ghBzw9LHkPDOmw3fM4F5grhl6qfc4SRBjaoJOkCOj4MjOUWxR3C1y08cU+A0hUPXxe8XWiIy
	yzO2qnT70ZtD2gXMasaFhPmdRowy8L6QOrR/OddL+6fKrhMnQI0Ilhx+apKU63tFGDnYk9+uDcmjy
	tsSsimFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tn7wD-00000002HHh-3OND;
	Wed, 26 Feb 2025 03:18:21 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tn7wB-00000002HH2-1yZh
	for linux-um@lists.infradead.org;
	Wed, 26 Feb 2025 03:18:21 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DECD921185;
	Wed, 26 Feb 2025 03:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740539897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hi2lTyABX6F+Zk3VP84YZcYJcPAqNVeDNsTUYCj+h2E=;
	b=zEhuAFTfm6IsEpNDNJO5Xc6cZVW0QiFbDHnBLr5VGWBbUXXJvhGp3wbd7V3zsUUbN1qVXu
	q3+qo4z7iDXaODumFWhNwKWXWXjILwySTbGzkJj8E8fepbmX+wFwS6NjlL9sJ0H/ELtAMw
	Q352GtSO7Rts7C31MWlPIXD2LAzQsYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740539897;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hi2lTyABX6F+Zk3VP84YZcYJcPAqNVeDNsTUYCj+h2E=;
	b=E1+pozVjwSpODLNi6k/C/UGijOjJ62EqcPQYuabXGiu7p9SbLDtEvFqYZPm9IsQBQJpzJ7
	c1TbLOiIjXr5oUAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tU6jn1Vc;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=uSu6mEyJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740539896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hi2lTyABX6F+Zk3VP84YZcYJcPAqNVeDNsTUYCj+h2E=;
	b=tU6jn1Vc/w9SxfcdTk9W0KPhwzFtRkstbWKw33r4giZ8UqAGBhbuLK7cf1l4cHzRopo5uz
	lVK5VR3uWx48Fwlz6WqHDLdnkwOUIB9vNI9D3GaGqyviA1Ukb2qobmV758a10khWtB0zjJ
	B2MSUbrJ2SEJkjxOb+UqPxZAQ4JCGA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740539896;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hi2lTyABX6F+Zk3VP84YZcYJcPAqNVeDNsTUYCj+h2E=;
	b=uSu6mEyJStRTu5JWG6fW8zpu+ADnh0C1nN2rbqrQuxPLjI050eHP/t3WY/o7ZUxt9e5nPQ
	rM6O40yxt9DEoDBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CEEEF13404;
	Wed, 26 Feb 2025 03:18:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id x4+RH/CHvmfcbwAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 26 Feb 2025 03:18:08 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Trond Myklebust" <trondmy@hammerspace.com>
Cc: "xiubli@redhat.com" <xiubli@redhat.com>,
 "brauner@kernel.org" <brauner@kernel.org>,
 "idryomov@gmail.com" <idryomov@gmail.com>,
 "okorniev@redhat.com" <okorniev@redhat.com>,
 "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
 "Dai.Ngo@oracle.com" <Dai.Ngo@oracle.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
 "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
 "jlayton@kernel.org" <jlayton@kernel.org>,
 "anna@kernel.org" <anna@kernel.org>, "miklos@szeredi.hu" <miklos@szeredi.hu>,
 "anton.ivanov@cambridgegreys.com" <anton.ivanov@cambridgegreys.com>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "jack@suse.cz" <jack@suse.cz>, "tom@talpey.com" <tom@talpey.com>,
 "richard@nod.at" <richard@nod.at>,
 "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "netfs@lists.linux.dev" <netfs@lists.linux.dev>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
 "senozhatsky@chromium.org" <senozhatsky@chromium.org>
Subject: Re: [PATCH 1/6] Change inode_operations.mkdir to return struct dentry *
In-reply-to: <50e6b21c644b050a29e159c9484a5e01061434f6.camel@hammerspace.com>
References: <>, <50e6b21c644b050a29e159c9484a5e01061434f6.camel@hammerspace.com>
Date: Wed, 26 Feb 2025 14:18:01 +1100
Message-id: <174053988113.102979.18024415194793753569@noble.neil.brown.name>
X-Rspamd-Queue-Id: DECD921185
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,gmail.com,vger.kernel.org,oracle.com,sipsolutions.net,szeredi.hu,cambridgegreys.com,zeniv.linux.org.uk,suse.cz,talpey.com,nod.at,lists.infradead.org,lists.linux.dev,chromium.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DKIM_TRACE(0.00)[suse.de:+];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250225_191819_805635_48A26C3F 
X-CRM114-Status: GOOD (  50.71  )
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

On Wed, 26 Feb 2025, Trond Myklebust wrote:
> On Wed, 2025-02-26 at 13:09 +1100, NeilBrown wrote:
> > On Tue, 25 Feb 2025, Trond Myklebust wrote:
> > > On Mon, 2025-02-24 at 14:09 +1100, NeilBrown wrote:
> > > > On Mon, 24 Feb 2025, Al Viro wrote:
> > > > > On Mon, Feb 24, 2025 at 12:34:06PM +1100, NeilBrown wrote:
> > > > > > On Sat, 22 Feb 2025, Al Viro wrote:
> > > > > > > On Fri, Feb 21, 2025 at 10:36:30AM +1100, NeilBrown wrote:
> > > > > > >=20
> > > > > > > > +In general, filesystems which use d_instantiate_new() to
> > > > > > > > install the new
> > > > > > > > +inode can safely return NULL.=C2=A0 Filesystems which may not
> > > > > > > > have an I_NEW inode
> > > > > > > > +should use d_drop();d_splice_alias() and return the
> > > > > > > > result
> > > > > > > > of the latter.
> > > > > > >=20
> > > > > > > IMO that's a bad pattern, _especially_ if you want to go
> > > > > > > for
> > > > > > > "in-update"
> > > > > > > kind of stuff later.
> > > > > >=20
> > > > > > Agreed.=C2=A0 I have a draft patch to change d_splice_alias() and
> > > > > > d_exact_alias() to work on hashed dentrys.=C2=A0 I thought it
> > > > > > should
> > > > > > go after
> > > > > > these mkdir patches rather than before.
> > > > >=20
> > > > > Could you give a braindump on the things d_exact_alias() is
> > > > > needed
> > > > > for?
> > > > > It's a recurring headache when doing ->d_name/->d_parent
> > > > > audits;
> > > > > see e.g.
> > > > > https://lore.kernel.org/all/20241213080023.GI3387508@ZenIV/=C2=A0for
> > > > > related
> > > > > mini-rant from the latest iteration.
> > > > >=20
> > > > > Proof of correctness is bloody awful; it feels like the
> > > > > primitive
> > > > > itself
> > > > > is wrong, but I'd never been able to write anything concise
> > > > > regarding
> > > > > the things we really want there ;-/
> > > > >=20
> > > >=20
> > > > As I understand it, it is needed (or wanted) to handle the
> > > > possibility
> > > > of an inode becoming "stale" and then recovering.=C2=A0 This could
> > > > happen,
> > > > for example, with a temporarily misconfigured NFS server.
> > > >=20
> > > > If ->d_revalidate gets a NFSERR_STALE from the server it will
> > > > return
> > > > '0'
> > > > so lookup_fast() and others will call d_invalidate() which will
> > > > d_drop()
> > > > the dentry.=C2=A0 There are other paths on which -ESTALE can result in
> > > > d_drop().
> > > >=20
> > > > If a subsequent attempt to "open" the name successfully finds the
> > > > same
> > > > inode we want to reuse the old dentry rather than create a new
> > > > one.
> > > >=20
> > > > I don't really understand why.=C2=A0 This code was added 20 years ago
> > > > before
> > > > git.
> > > > It was introduced by
> > > >=20
> > > > commit 89a45174b6b32596ea98fa3f89a243e2c1188a01
> > > > Author: Trond Myklebust <trond.myklebust@fys.uio.no>
> > > > Date:=C2=A0=C2=A0 Tue Jan 4 21:41:37 2005 +0100
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 VFS: Avoid dentry aliasing problems in files=
ystems like NFS,
> > > > where
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inodes may be =
marked as stale in one instance (causing
> > > > the
> > > > dentry
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to be dropped)=
 then re-enabled in the next instance.
> > > > =C2=A0=C2=A0=C2=A0=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 Signed-off-by: Trond Myklebust <trond.mykleb=
ust@fys.uio.no>
> > > >=20
> > > > in history.git
> > > >=20
> > > > Trond: do you have any memory of this?=C2=A0 Can you explain what the
> > > > symptom
> > > > was that you wanted to fix?
> > > >=20
> > > > The original patch used d_add_unique() for lookup and atomic_open
> > > > and
> > > > readdir prime-dcache.=C2=A0 We now only use it for v4 atomic_open.=C2=
=A0
> > > > Maybe
> > > > we
> > > > don't need it at all?=C2=A0 Or maybe we need to restore it to those
> > > > other
> > > > callers?=20
> > > >=20
> > >=20
> > > 2005? That looks like it was trying to deal with the userspace NFS
> > > server. I can't remember when it was given the ability to use the
> > > inode
> > > generation counter, but I'm pretty sure that in 2005 there were
> > > plenty
> > > of setups out there that had the older version that reused
> > > filehandles
> > > (due to inode number reuse). So you would get spurious ESTALE
> > > errors
> > > sometimes due to inode number reuse, sometimes because the
> > > filehandle
> > > fell out of the userspace NFS server's cache.
> >=20
> > So this was likely done to work-around known weaknesses in NFS
> > servers
> > at the time.
> >=20
> > The original d_add_unique() was used in nfs_lookup()
> > nfs_atomic_lookup()
> > and nfs_readdir_lookup() but the current descendent d_exact_alias()
> > is
> > only used in _nfs4_open_and_get_state() called only by nfs4_do_open()
> > which is only used in nfs4_atomic_open() and nfs4_proc_create().
> >=20
> > So the usage in 'lookup' and 'readdir' have fallen by the wayside
> > with
> > no apparent negative consequences.=C2=A0=20
> > The old NFS servers have probably been fixed.
> >=20
> > So do you have any concerns with us discarding d_exact_alias() and
> > only
> > using d_splice_alias() in _nfs4_open_get_state() ??
> >=20
>=20
> AFAIK, there were never any NFSv4 servers in public use that mimicked
> the quirks of the userspace NFSv2/NFSv3 server. So I'm thinking it
> should be safe to retire d_exact_alias.

Thanks.  I'll submit a patch through the VFS tree as I have other VFS
patches in the works that will depend on that so having them together
would be good.

Thanks,
NeilBrown

