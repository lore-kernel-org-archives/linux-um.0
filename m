Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0AC6C021B8
	for <linux-um@archiver.kernel.org>; Thu, 27 Feb 2025 01:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sqlgJrRfFfOStNHDiZ1evU6ja72lhQY7pRBIMD+Gk1o=; b=Tsc1u82c7YaWUXXB5rZt1xmadH
	t6cKZwaATJ4R3Yr1UCBlLqoxXm8lVsRQDlOD/eYDa60tMqpAFe6uta0YyBaGm+SMmF4nBPwikQRqp
	4SzB7mYW7aFSKs9h463gtbiLBujwAmf1HNWbSIcAWhV4ESMSN0cawvXGpapllBdDUYbIWD7tZqSTl
	LdfOg6+9EgV36jNRd2VGOp4PY6YGXMz9fARg20Ltky/2i9lwur95rxvX2S2VzKeKNU0YpeE3X5Fqy
	sESRnN/PZrrloOTh3h4AywOD6ncYM+3XG2jifrfBz4VCDRoomD6jQ7E464gE/u8KbQZRfJxnDBVrG
	mehL0DMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnStE-00000005y7x-2HAT;
	Thu, 27 Feb 2025 01:40:40 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnStB-00000005y75-3LuS
	for linux-um@lists.infradead.org;
	Thu, 27 Feb 2025 01:40:39 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E27161F387;
	Thu, 27 Feb 2025 01:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740620435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sqlgJrRfFfOStNHDiZ1evU6ja72lhQY7pRBIMD+Gk1o=;
	b=uEvueHF4nkSgnjrPw+Upej5yrG03aOEaiAMrBeGdRiHQsMgbCDWhjHsPAn5PFrSav43LjM
	0VSOd69ZTVuXDGMLo1hU+3toKe/BS6om1s6PhBfe8fo1nGLhlYM0LM7H4fk9KuSkY2sPdR
	LU1dqDutdbUyvb4HluZPdPmdnGplMTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740620435;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sqlgJrRfFfOStNHDiZ1evU6ja72lhQY7pRBIMD+Gk1o=;
	b=tQ+YLCmPx6s51q6fgfH/Ge15LzwEIjaGCuw30NRYR+Ya58VwxYj1M6p8oj+FffLFPV0gJ/
	lIbEOCuiDGG+j8DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740620435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sqlgJrRfFfOStNHDiZ1evU6ja72lhQY7pRBIMD+Gk1o=;
	b=uEvueHF4nkSgnjrPw+Upej5yrG03aOEaiAMrBeGdRiHQsMgbCDWhjHsPAn5PFrSav43LjM
	0VSOd69ZTVuXDGMLo1hU+3toKe/BS6om1s6PhBfe8fo1nGLhlYM0LM7H4fk9KuSkY2sPdR
	LU1dqDutdbUyvb4HluZPdPmdnGplMTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740620435;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sqlgJrRfFfOStNHDiZ1evU6ja72lhQY7pRBIMD+Gk1o=;
	b=tQ+YLCmPx6s51q6fgfH/Ge15LzwEIjaGCuw30NRYR+Ya58VwxYj1M6p8oj+FffLFPV0gJ/
	lIbEOCuiDGG+j8DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9EC07134A0;
	Thu, 27 Feb 2025 01:40:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uvqnE43Cv2fqEQAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 27 Feb 2025 01:40:29 +0000
From: NeilBrown <neilb@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org,
	Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubli@redhat.com>,
	ceph-devel@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] ceph: return the correct dentry on mkdir
Date: Thu, 27 Feb 2025 12:32:55 +1100
Message-ID: <20250227013949.536172-4-neilb@suse.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227013949.536172-1-neilb@suse.de>
References: <20250227013949.536172-1-neilb@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,kernel.org,vger.kernel.org,gmail.com,redhat.com,szeredi.hu,nod.at,cambridgegreys.com,sipsolutions.net,lists.infradead.org];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn),to_ip_from(RL99f7qjgz3j4qaff4fhggowz5)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250226_174037_999876_0C7D85B7 
X-CRM114-Status: GOOD (  15.40  )
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

ceph already splices the correct dentry (in splice_dentry()) from the
result of mkdir but does nothing more with it.

Now that ->mkdir can return a dentry, return the correct dentry.

Note that previously ceph_mkdir() could call
   ceph_init_inode_acls()
on the inode from the wrong dentry, which would be NULL.  This
is safe as ceph_init_inode_acls() checks for NULL, but is not
strictly correct.  With this patch, the inode for the returned dentry
is passed to ceph_init_inode_acls().

Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/ceph/dir.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 39e0f240de06..5e98394e2dca 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1099,6 +1099,7 @@ static struct dentry *ceph_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_mds_request *req;
 	struct ceph_acl_sec_ctx as_ctx = {};
+	struc dentry *ret;
 	int err;
 	int op;
 
@@ -1116,32 +1117,32 @@ static struct dentry *ceph_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		      ceph_vinop(dir), dentry, dentry, mode);
 		op = CEPH_MDS_OP_MKDIR;
 	} else {
-		err = -EROFS;
+		ret = ERR_PTR(-EROFS);
 		goto out;
 	}
 
 	if (op == CEPH_MDS_OP_MKDIR &&
 	    ceph_quota_is_max_files_exceeded(dir)) {
-		err = -EDQUOT;
+		ret = ERR_PTR(-EDQUOT);
 		goto out;
 	}
 	if ((op == CEPH_MDS_OP_MKSNAP) && IS_ENCRYPTED(dir) &&
 	    !fscrypt_has_encryption_key(dir)) {
-		err = -ENOKEY;
+		ret = ERR_PTR(-ENOKEY);
 		goto out;
 	}
 
 
 	req = ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
 	if (IS_ERR(req)) {
-		err = PTR_ERR(req);
+		ret = ERR_CAST(req);
 		goto out;
 	}
 
 	mode |= S_IFDIR;
 	req->r_new_inode = ceph_new_inode(dir, dentry, &mode, &as_ctx);
 	if (IS_ERR(req->r_new_inode)) {
-		err = PTR_ERR(req->r_new_inode);
+		ret = ERR_CAST(req->r_new_inode);
 		req->r_new_inode = NULL;
 		goto out_req;
 	}
@@ -1165,15 +1166,22 @@ static struct dentry *ceph_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	    !req->r_reply_info.head->is_target &&
 	    !req->r_reply_info.head->is_dentry)
 		err = ceph_handle_notrace_create(dir, dentry);
+	ret = ERR_PTR(err);
 out_req:
+	if (!IS_ERR(ret) && req->r_dentry != dentry)
+		/* Some other dentry was spliced in */
+		ret = dget(req->r_dentry);
 	ceph_mdsc_put_request(req);
 out:
-	if (!err)
+	if (!IS_ERR(ret)) {
+		if (ret)
+			dentry = ret;
 		ceph_init_inode_acls(d_inode(dentry), &as_ctx);
-	else
+	} else {
 		d_drop(dentry);
+	}
 	ceph_release_acl_sec_ctx(&as_ctx);
-	return ERR_PTR(err);
+	return ret;
 }
 
 static int ceph_link(struct dentry *old_dentry, struct inode *dir,
-- 
2.48.1


