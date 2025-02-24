Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A66D4C021B2
	for <linux-um@archiver.kernel.org>; Mon, 24 Feb 2025 02:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-id:Date:References:
	In-reply-to:Subject:Cc:To:From:MIME-Version:Content-Transfer-Encoding:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hK0cbAMRfKN3dq7LyiWJIm5jqsIOUyoe9i5tRacJZsE=; b=HKRydJegfuwENybDjI/O+s8zvv
	v1T2jyGAk4yD08mzPLOhvUiENlepFkZ7+ciADjs/W/7MFHmoKPnMW1hhJoF6xyrLEu6NBRDJLujva
	n01NizPc0yNFEX3+VmGXPqxBl5qk9fScOgWpHnGtx5mUGKGyAEV93clOQ3nofdM3Y+lxhjicSP159
	+Q0tQCyKYC7sg33Cg3NTyX9xnPAXBrzz+ao0C26LQ3WQaXaIitXX0/ewq1LLY2bPT6kVew46Q58R9
	JZol7IMM4VwAs8DUr71nTxEFMx0GcD3DJdCNxyq5NK0EOXYbHFOZD8XHbTw75C4eDcc4iG9YoBzvC
	eTsmUxQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmOB0-0000000C9mf-40Ff;
	Mon, 24 Feb 2025 02:26:34 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmOAx-0000000C9lp-2quV
	for linux-um@lists.infradead.org;
	Mon, 24 Feb 2025 02:26:32 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AEC2621163;
	Mon, 24 Feb 2025 02:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740363989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hK0cbAMRfKN3dq7LyiWJIm5jqsIOUyoe9i5tRacJZsE=;
	b=JQqRICK5438lY9PLn1wxE4IZQxKModcl6anXKNMSLmbJGy7BRJ2Rm6nQaOs6jQU5yVoQp4
	D+AIxraGSalG/F1T7YYEvdIB3QwCr6dkBHxdOFWMLLCO8FxJq7sRx2q9eoQP+kF6T/LnCg
	COi99TOeMS9mWRm4t1Lo1+yE6rT1sQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740363989;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hK0cbAMRfKN3dq7LyiWJIm5jqsIOUyoe9i5tRacJZsE=;
	b=AFxW1Jzk0D6JeLybFeiTN4mDgWvEWNF548W7RhanejsWpbWHP8N+YnLTCRQ+YB1m/xIFIK
	RFOLtms9t32rgVCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740363989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hK0cbAMRfKN3dq7LyiWJIm5jqsIOUyoe9i5tRacJZsE=;
	b=JQqRICK5438lY9PLn1wxE4IZQxKModcl6anXKNMSLmbJGy7BRJ2Rm6nQaOs6jQU5yVoQp4
	D+AIxraGSalG/F1T7YYEvdIB3QwCr6dkBHxdOFWMLLCO8FxJq7sRx2q9eoQP+kF6T/LnCg
	COi99TOeMS9mWRm4t1Lo1+yE6rT1sQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740363989;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hK0cbAMRfKN3dq7LyiWJIm5jqsIOUyoe9i5tRacJZsE=;
	b=AFxW1Jzk0D6JeLybFeiTN4mDgWvEWNF548W7RhanejsWpbWHP8N+YnLTCRQ+YB1m/xIFIK
	RFOLtms9t32rgVCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 03C29136B3;
	Mon, 24 Feb 2025 02:26:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6DpUHM3Yu2e1dgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 24 Feb 2025 02:26:21 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Miklos Szeredi" <miklos@szeredi.hu>, "Xiubo Li" <xiubli@redhat.com>,
 "Ilya Dryomov" <idryomov@gmail.com>, "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>,
 "Sergey Senozhatsky" <senozhatsky@chromium.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-um@lists.infradead.org, ceph-devel@vger.kernel.org,
 netfs@lists.linux.dev
Subject: Re: [PATCH 4/6] fuse: return correct dentry for ->mkdir
In-reply-to: <20250222042402.GN1977892@ZenIV>
References: <>, <20250222042402.GN1977892@ZenIV>
Date: Mon, 24 Feb 2025 13:26:18 +1100
Message-id: <174036397835.74271.9038146946135155196@noble.neil.brown.name>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,suse.cz,szeredi.hu,redhat.com,gmail.com,nod.at,cambridgegreys.com,sipsolutions.net,oracle.com,talpey.com,chromium.org,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,noble.neil.brown.name:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250223_182631_860923_40EE43B5 
X-CRM114-Status: GOOD (  12.52  )
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

On Sat, 22 Feb 2025, Al Viro wrote:
> On Fri, Feb 21, 2025 at 10:36:33AM +1100, NeilBrown wrote:
>=20
> > @@ -871,7 +870,12 @@ static int fuse_mknod(struct mnt_idmap *idmap, struc=
t inode *dir,
> >  	args.in_args[0].value =3D &inarg;
> >  	args.in_args[1].size =3D entry->d_name.len + 1;
> >  	args.in_args[1].value =3D entry->d_name.name;
> > -	return create_new_entry(idmap, fm, &args, dir, entry, mode);
> > +	de =3D create_new_entry(idmap, fm, &args, dir, entry, mode);
> > +	if (IS_ERR(de))
> > +		return PTR_ERR(de);
> > +	if (de)
> > +		dput(de);
> > +	return 0;
>=20
> Can that really happen?

Probably now.  It would require S_IFDIR to be passed in the mode to
vfs_mknod().  I don't think any current callers do that, but I don't see
any code in vfs_mknod() to prevent it.

>=20
> > @@ -934,7 +939,12 @@ static int fuse_symlink(struct mnt_idmap *idmap, str=
uct inode *dir,
> >  	args.in_args[1].value =3D entry->d_name.name;
> >  	args.in_args[2].size =3D len;
> >  	args.in_args[2].value =3D link;
> > -	return create_new_entry(idmap, fm, &args, dir, entry, S_IFLNK);
> > +	de =3D create_new_entry(idmap, fm, &args, dir, entry, S_IFLNK);
> > +	if (IS_ERR(de))
> > +		return PTR_ERR(de);
> > +	if (de)
> > +		dput(de);
> > +	return 0;
>=20
> Same question.

That definitely cannot happen. - because we *know* that d_splice_alias()
never returns a dentry for any but an S_IFDIR inode (how might we
explain that to the rust type system I wonder :-).

I was going for "obviously correct" without try to optimise, but you are
correct that testing for a non-NULL non-ERR dentry should be optimsed
away as impossible in all cases except mkdir.

Thanks,
NeilBrown


>=20
> > +	de =3D create_new_entry(&invalid_mnt_idmap, fm, &args, newdir, newent, =
inode->i_mode);
> > +	if (!IS_ERR(de)) {
> > +		if (de)
> > +			dput(de);
> > +		de =3D NULL;
>=20
> Whoa...  Details, please.  What's going on here?
>=20


