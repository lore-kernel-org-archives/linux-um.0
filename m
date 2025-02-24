Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E3E8C021B2
	for <linux-um@archiver.kernel.org>; Mon, 24 Feb 2025 01:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-id:Date:References:
	In-reply-to:Subject:Cc:To:From:MIME-Version:Content-Transfer-Encoding:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N6DmzFO4HIzWBxdCLLN4FbtoKwoidbgVbtC5hcg04Dc=; b=ZlwQ36nuATfCusF1I3clIxWcIA
	Up8/D2cYicfIlvsO2TR6r0y6FA6NbIrtZnWJEsfqDuYPzDxDflMMpzC7PEyodQ5ykaP5016ztd7Ri
	5PfsoJeDD8pExgm924pcW/iDQY3Exfb/uJpepclOjN2i6q/9Mp0wV1qydWPr+mFEloXwB0LLwczOf
	ZtdOw1WCw5BL/o2p/1AtqZ6BeQ9ityMz1GsWvSjI0K4jnN5BlJxeP9n3bH6UajmzGnWIuZ5N9rdK/
	6CjLh0nQAh95g3ZHLJE+AalZ0uRuHS00pKC5THIc44FIoogXevcsG2eDDP3dZs53mcwBz+MBDdH9U
	ZtcJWbDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmNMW-0000000C4gI-28bT;
	Mon, 24 Feb 2025 01:34:24 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmNMT-0000000C4er-3rQO
	for linux-um@lists.infradead.org;
	Mon, 24 Feb 2025 01:34:23 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8CC902116D;
	Mon, 24 Feb 2025 01:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740360858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N6DmzFO4HIzWBxdCLLN4FbtoKwoidbgVbtC5hcg04Dc=;
	b=rzonImDkwJoVgWfKV5OP1Ih17Ix4H0Uj8cYlPZ+aY6Hdv0gpMIjIyh0ZkQKVgVT/FndPIi
	sZMx93YtVbo91VfBLYw5Sd6QCpfSxUdFevY2NXEwZL0R6VVTI4hCqHByOBkOvB43Ien6pD
	P/6G9UJwoNlFoBYkRddy4ZWrLNokImU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740360858;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N6DmzFO4HIzWBxdCLLN4FbtoKwoidbgVbtC5hcg04Dc=;
	b=wKHL00mL1XwcnqReM3IXJ5QvOzvSSWlBJfXq7VRTKaOqqQlFbKoDoTYOYWQwP6zgNjjEty
	3hVZKYyoFwDy9BDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740360857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N6DmzFO4HIzWBxdCLLN4FbtoKwoidbgVbtC5hcg04Dc=;
	b=qCjqXg8KOIWeT3woveYRbx7VhkwuOymOoulEdAyAbzEyKPU1njqvzcfJPElrVedFsxBHIA
	hxTuG7Yu2Md3OY4EmdKk88M7EAXGOkBVk431FVrQCkAV3L5EonJ6odzCnm3MPhvA4Tkm0C
	xCoR6Ww2x6WwPLM+/hg9l/iLduL29nU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740360857;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N6DmzFO4HIzWBxdCLLN4FbtoKwoidbgVbtC5hcg04Dc=;
	b=NnMPKFp7uSRVRE7AKEKm5nzIqIWLBtvgf0+qLo3xf1arIZxW9yW/A3b6APtVdlgfYPoB/h
	GnKso9DG+FqdTyDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 903E0136B3;
	Mon, 24 Feb 2025 01:34:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2AUiCpHMu2dQagAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 24 Feb 2025 01:34:09 +0000
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
Subject: Re: [PATCH 1/6] Change inode_operations.mkdir to return struct dentry *
In-reply-to: <20250222041937.GM1977892@ZenIV>
References: <>, <20250222041937.GM1977892@ZenIV>
Date: Mon, 24 Feb 2025 12:34:06 +1100
Message-id: <174036084630.74271.16513912864596248299@noble.neil.brown.name>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250223_173422_125466_6710370A 
X-CRM114-Status: GOOD (  11.39  )
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
> On Fri, Feb 21, 2025 at 10:36:30AM +1100, NeilBrown wrote:
>=20
> > +In general, filesystems which use d_instantiate_new() to install the new
> > +inode can safely return NULL.  Filesystems which may not have an I_NEW i=
node
> > +should use d_drop();d_splice_alias() and return the result of the latter.
>=20
> IMO that's a bad pattern, _especially_ if you want to go for "in-update"
> kind of stuff later.

Agreed.  I have a draft patch to change d_splice_alias() and
d_exact_alias() to work on hashed dentrys.  I thought it should go after
these mkdir patches rather than before.

Thanks,
NeilBrown


>=20
> That's pretty much the same thing as d_drop()/d_rehash() window.
>=20
> We'd be better off dropping that BUG_ON() in d_splice_alias() and teaching
> __d_add() to handle the "it's a hashed negative" case.
>=20


