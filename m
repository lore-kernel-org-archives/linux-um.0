Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D59A5C021B2
	for <linux-um@archiver.kernel.org>; Mon, 24 Feb 2025 02:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-id:Date:References:
	In-reply-to:Subject:Cc:To:From:MIME-Version:Content-Transfer-Encoding:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sokZcRi5Jle+fsK51aZ7tjNiImsvREKG7vGnUqDo1c4=; b=Kfj6XduhwkIrelZS33MrA+HiaI
	aefLyITMWuMmt2k/KgJ8tkDVGP9OzhSztt5U5snutDat7wbN3511sZ9lq1KD1BK6lkgsZZVJTs4zM
	46ICBWur69OJ6fRNf1f63lABV0mb3y3h4YGPR88h6BmS6Cf4R519bfTkRhajIUiSmf+XH2FkOboaw
	f4INpMO+cLWqhK0Ve83dl9NmgGBF9GOOEUz6nwcFkBdocsQRFZCQewU4JpfQ5SJF9+Pm6NU53Znqq
	0EIL9gTyZhZiY4cPGNZCi+1mXWvU37lybZvTnk5zJDwWvFE2aW2i5NEHSdc6A8bNfQYbsg24JgZqU
	LLxoQNQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmOPw-0000000CAxn-3Akz;
	Mon, 24 Feb 2025 02:42:00 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmOPt-0000000CAxE-3qvW
	for linux-um@lists.infradead.org;
	Mon, 24 Feb 2025 02:41:59 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E24EE1F383;
	Mon, 24 Feb 2025 02:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740364916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sokZcRi5Jle+fsK51aZ7tjNiImsvREKG7vGnUqDo1c4=;
	b=PF1/A9dbKEquPdrr+y+sOIJOOSf8woWxlVHOwGLWU8Dbhu1YxsLdDU/bC0u4Wqm+q5o+6D
	hNvr6eWdM+/bz/17A5Pp3pP3AeCkxJ1UGnS6YyTiQgt6AHodPSIAsAFyyxOZEw09DdKlj4
	C2TGaRGduVqP+MYYWWF1DG89EHrwh3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740364916;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sokZcRi5Jle+fsK51aZ7tjNiImsvREKG7vGnUqDo1c4=;
	b=4W/SAG+fRUk7tp1wd1ozQxfjBIqxOqr4nqDIxvYnaLAQOnNOyiaOJI4CQvuUdeCjLGYj52
	lJS3rRsYKQLb1KAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=J7xr5LAV;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2FUNoupm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740364915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sokZcRi5Jle+fsK51aZ7tjNiImsvREKG7vGnUqDo1c4=;
	b=J7xr5LAVZNN5Mh8sDgv6/hHinb6Iuf/Ln5E5/G3ELY1aOwfF54zp55MTeawr5BiI1Bk4uz
	FtVeccRBlZZxHc4tw69hJD5HJZfkhCrYT63OdzsL3iiwG0bsZwpcUBKObsr9q6bSDIw9gC
	STSzkXWsfKRb2MldZbU+uY3e+ib+2hU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740364915;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sokZcRi5Jle+fsK51aZ7tjNiImsvREKG7vGnUqDo1c4=;
	b=2FUNoupmwUKtO/g8AMP0aUFbysA9B7OVFNWZUTF5EcBMJ1OImqv8CcszVjdJvbnFACkwF/
	16e0OuJo856N4NBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DBE2613332;
	Mon, 24 Feb 2025 02:41:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yOoRH2vcu2csegAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 24 Feb 2025 02:41:47 +0000
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
Subject: Re: [PATCH 5/6] nfs: change mkdir inode_operation to return alternate
 dentry if needed.
In-reply-to: <20250222044130.GO1977892@ZenIV>
References: <>, <20250222044130.GO1977892@ZenIV>
Date: Mon, 24 Feb 2025 13:41:44 +1100
Message-id: <174036490460.74271.3866837223419464073@noble.neil.brown.name>
X-Rspamd-Queue-Id: E24EE1F383
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,suse.cz,szeredi.hu,redhat.com,gmail.com,nod.at,cambridgegreys.com,sipsolutions.net,oracle.com,talpey.com,chromium.org,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250223_184158_119671_24CFE4FF 
X-CRM114-Status: GOOD (  19.30  )
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
> On Fri, Feb 21, 2025 at 10:36:34AM +1100, NeilBrown wrote:
>=20
> >  nfs3_proc_mkdir(struct inode *dir, struct dentry *dentry, struct iattr *=
sattr)
> >  {
> >  	struct posix_acl *default_acl, *acl;
> > @@ -612,15 +612,18 @@ nfs3_proc_mkdir(struct inode *dir, struct dentry *d=
entry, struct iattr *sattr)
> >  		dentry =3D d_alias;
> > =20
> >  	status =3D nfs3_proc_setacls(d_inode(dentry), acl, default_acl);
> > +	if (status && d_alias)
> > +		dput(d_alias);
> > =20
> > -	dput(d_alias);
> >  out_release_acls:
> >  	posix_acl_release(acl);
> >  	posix_acl_release(default_acl);
> >  out:
> >  	nfs3_free_createdata(data);
> >  	dprintk("NFS reply mkdir: %d\n", status);
> > -	return status;
> > +	if (status)
> > +		return ERR_PTR(status);
> > +	return d_alias;
>=20
> Ugh...  That's really hard to follow - you are leaving a dangling
> reference in d_alias textually upstream of using that variable.
> The only reason it's not a bug is that dput() is reachable only
> with status && d_alias and that guarantees that we'll
> actually go away on if (status) return ERR_PTR(status).
>=20
> Worse, you can reach 'out:' with d_alias uninitialized.  Yes,
> all such branches happen with status either still unmodified
> since it's initialization (which is non-zero) or under
> if (status), so again, that return d_alias; is unreachable.
>=20
> So the code is correct, but it's really asking for trouble down
> the road.
>=20
> BTW, dput(NULL) is guaranteed to be a no-op...
>=20

Thanks for that.  I've minimised the use of status and mostly
stored errors in d_alias - which I've renamed to 'ret'.
I think that answers your concerns.

Thanks,
NeilBrown

--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -578,13 +578,13 @@ nfs3_proc_symlink(struct inode *dir, struct dentry *den=
try, struct folio *folio,
 	return status;
 }
=20
-static int
+static struct dentry *
 nfs3_proc_mkdir(struct inode *dir, struct dentry *dentry, struct iattr *satt=
r)
 {
 	struct posix_acl *default_acl, *acl;
 	struct nfs3_createdata *data;
-	struct dentry *d_alias;
-	int status =3D -ENOMEM;
+	struct dentry *ret =3D ERR_PTR(-ENOMEM);
+	int status;
=20
 	dprintk("NFS call  mkdir %pd\n", dentry);
=20
@@ -592,8 +592,9 @@ nfs3_proc_mkdir(struct inode *dir, struct dentry *dentry,=
 struct iattr *sattr)
 	if (data =3D=3D NULL)
 		goto out;
=20
-	status =3D posix_acl_create(dir, &sattr->ia_mode, &default_acl, &acl);
-	if (status)
+	ret =3D ERR_PTR(posix_acl_create(dir, &sattr->ia_mode,
+				       &default_acl, &acl));
+	if (IS_ERR(ret))
 		goto out;
=20
 	data->msg.rpc_proc =3D &nfs3_procedures[NFS3PROC_MKDIR];
@@ -602,25 +603,27 @@ nfs3_proc_mkdir(struct inode *dir, struct dentry *dentr=
y, struct iattr *sattr)
 	data->arg.mkdir.len =3D dentry->d_name.len;
 	data->arg.mkdir.sattr =3D sattr;
=20
-	d_alias =3D nfs3_do_create(dir, dentry, data);
-	status =3D PTR_ERR_OR_ZERO(d_alias);
+	ret =3D nfs3_do_create(dir, dentry, data);
=20
-	if (status !=3D 0)
+	if (IS_ERR(ret))
 		goto out_release_acls;
=20
-	if (d_alias)
-		dentry =3D d_alias;
+	if (ret)
+		dentry =3D ret;
=20
 	status =3D nfs3_proc_setacls(d_inode(dentry), acl, default_acl);
+	if (status) {
+		dput(ret);
+		ret =3D ERR_PTR(status);
+	}
=20
-	dput(d_alias);
 out_release_acls:
 	posix_acl_release(acl);
 	posix_acl_release(default_acl);
 out:
 	nfs3_free_createdata(data);
-	dprintk("NFS reply mkdir: %d\n", status);
-	return status;
+	dprintk("NFS reply mkdir: %d\n", PTR_ERR_OR_ZERO(ret));
+	return ret;
 }
=20
 static int

