Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C6DC021B2
	for <linux-um@archiver.kernel.org>; Thu, 20 Feb 2025 23:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K365lrHE4tT4tHcA+ZRmIzk529KAE57axlSUnXIkK90=; b=ls1xkBxocljCurp8DiWJui1cOv
	Nn/H4H/rMZT5tI7hLgIB+ZiXCEl75O1+gytLtiowwVuLun46SCL+eMGGlay8Lp64Cxxuo2DF5Pt/Y
	AHqaW/L3PQdJ185giKPPKsPDdmwYmzbbNr0GfUaD0VUy+iHhDEWrFwyMWXS6TCuKy8y1W26rMtNyG
	nrTb0btfsVdVme0FlE/876kAwjW68GJ6niu0A2/vrA8e/m0vcBqEJxgIE0jHAA+jgy+6Oh+EaKhF5
	M6kjdaohQhOICd1We/d6onv5jXuk7bZWFlyKY5PRMLyBlhH4/NohiAHOifWohhw1Q/YIEMFd/FDMv
	tkszkCgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tlGGJ-00000003O8I-3Cr9;
	Thu, 20 Feb 2025 23:47:23 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tlGGH-00000003O6Y-0aYh
	for linux-um@lists.infradead.org;
	Thu, 20 Feb 2025 23:47:22 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 47B6C21193;
	Thu, 20 Feb 2025 23:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740095239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K365lrHE4tT4tHcA+ZRmIzk529KAE57axlSUnXIkK90=;
	b=fAnJmkUiRBLf9T8Gc6/VkmKEIvWQU98UxDilOFtsaIq6ALZLsXpC71p5TiFfY/wDLlGE6U
	9KhDZYIVRqEHv70nB6mSUWJFRAY4vpG/XTYV9LYkzKhaOl9j0AS2Ptj7+T1NUCePgAr+C2
	k5wn/0mncmYgpwWXZJcpmvEl0rOxS/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740095239;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K365lrHE4tT4tHcA+ZRmIzk529KAE57axlSUnXIkK90=;
	b=8wyPm5HalY3T2xTNgJwrL9khVs8CjsoixgSP9yNucBoog4ot4uNU1F18b0KbeNwzZU8vVb
	iSEQjbpZo05SfJCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740095239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K365lrHE4tT4tHcA+ZRmIzk529KAE57axlSUnXIkK90=;
	b=fAnJmkUiRBLf9T8Gc6/VkmKEIvWQU98UxDilOFtsaIq6ALZLsXpC71p5TiFfY/wDLlGE6U
	9KhDZYIVRqEHv70nB6mSUWJFRAY4vpG/XTYV9LYkzKhaOl9j0AS2Ptj7+T1NUCePgAr+C2
	k5wn/0mncmYgpwWXZJcpmvEl0rOxS/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740095239;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K365lrHE4tT4tHcA+ZRmIzk529KAE57axlSUnXIkK90=;
	b=8wyPm5HalY3T2xTNgJwrL9khVs8CjsoixgSP9yNucBoog4ot4uNU1F18b0KbeNwzZU8vVb
	iSEQjbpZo05SfJCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E2B3913301;
	Thu, 20 Feb 2025 23:47:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MWYQJv++t2cbAwAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 20 Feb 2025 23:47:11 +0000
From: NeilBrown <neilb@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-um@lists.infradead.org,
	ceph-devel@vger.kernel.org,
	netfs@lists.linux.dev
Subject: [PATCH 2/6] hostfs: store inode in dentry after mkdir if possible.
Date: Fri, 21 Feb 2025 10:36:31 +1100
Message-ID: <20250220234630.983190-3-neilb@suse.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250220234630.983190-1-neilb@suse.de>
References: <20250220234630.983190-1-neilb@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.19)[-0.960];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,szeredi.hu,redhat.com,gmail.com,nod.at,cambridgegreys.com,sipsolutions.net,oracle.com,talpey.com,chromium.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250220_154721_328997_BE643440 
X-CRM114-Status: GOOD (  11.41  )
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

After handling a mkdir, get the inode for the name and use
d_splice_alias() to store the correct dentry in the dcache.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/hostfs/hostfs_kern.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index ccbb48fe830d..a2c6b9051c5b 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -682,14 +682,22 @@ static int hostfs_symlink(struct mnt_idmap *idmap, struct inode *ino,
 static struct dentry *hostfs_mkdir(struct mnt_idmap *idmap, struct inode *ino,
 				   struct dentry *dentry, umode_t mode)
 {
+	struct inode *inode;
 	char *file;
 	int err;
 
 	if ((file = dentry_name(dentry)) == NULL)
 		return ERR_PTR(-ENOMEM);
 	err = do_mkdir(file, mode);
+	if (err) {
+		dentry = ERR_PTR(err);
+	} else {
+		inode = hostfs_iget(dentry->d_sb, file);
+		d_drop(dentry);
+		dentry = d_splice_alias(inode, dentry);
+	}
 	__putname(file);
-	return ERR_PTR(err);
+	return dentry;
 }
 
 static int hostfs_rmdir(struct inode *ino, struct dentry *dentry)
-- 
2.47.1


