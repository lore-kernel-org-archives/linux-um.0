Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63DAFC19776
	for <linux-um@archiver.kernel.org>; Thu, 27 Feb 2025 01:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9SWbm5loCzvI/QsJmTpfmwEStE1pMp3YcCFFrGykTpw=; b=3asBpnxL8oe8uIeoJprdqvdrV9
	RE+tJSCQy3lVDhWRpF2W+ekUqf7cd9vVQLaGDOc6uVuFSEwTWEeDffa0pGNfEF3hPs4+rzXnvaapY
	dCDRp7q50mNOGlWPDG7ivwLfCdvKFW0BYMSVKAyx1Q5/zLZwsEGe1FGCTzH5Oqu7VkYEzKP1Qf9lr
	3qwMZnD5Bz6CcO9qRzE+QLFfj2PoLXytYi483ThvZ+spolVwyqMiz+UGjNs9gBm7tg0jANJoHSize
	kBBBN3k9rijkPkdwSyX2D8iQiwD6k83AM7SkDCojMRZo2otZYiHyNSptwEha5eAq+cDcgzaWo1P2W
	z7vV1f3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnSt4-00000005y4f-0czZ;
	Thu, 27 Feb 2025 01:40:30 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnSt0-00000005y2I-3zmP
	for linux-um@lists.infradead.org;
	Thu, 27 Feb 2025 01:40:28 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A591B21188;
	Thu, 27 Feb 2025 01:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740620425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9SWbm5loCzvI/QsJmTpfmwEStE1pMp3YcCFFrGykTpw=;
	b=0smYf138evtmQey7lvWmcSypB90NSA8pg5W/w1cZrilHbcpbS2A3+5ypYLYNuX8sWw4jyN
	AQXecmS00TM2jOWhJnm1CupwJu2MHt3/dOCGHbI/ficuARObyn5J6jaSHTHDs9hajeW3qW
	YUNKeUHoNyh8EOCsgxmh/KjYL6WyZQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740620425;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9SWbm5loCzvI/QsJmTpfmwEStE1pMp3YcCFFrGykTpw=;
	b=ph+gqGLXF9n86ymjIAt7BBlGle/4PObvqqCoK8orUAYdbpoGieLXtFz1akAGyfAXtY3V0l
	WX7TYrRYqj4Ib+BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740620425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9SWbm5loCzvI/QsJmTpfmwEStE1pMp3YcCFFrGykTpw=;
	b=0smYf138evtmQey7lvWmcSypB90NSA8pg5W/w1cZrilHbcpbS2A3+5ypYLYNuX8sWw4jyN
	AQXecmS00TM2jOWhJnm1CupwJu2MHt3/dOCGHbI/ficuARObyn5J6jaSHTHDs9hajeW3qW
	YUNKeUHoNyh8EOCsgxmh/KjYL6WyZQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740620425;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9SWbm5loCzvI/QsJmTpfmwEStE1pMp3YcCFFrGykTpw=;
	b=ph+gqGLXF9n86ymjIAt7BBlGle/4PObvqqCoK8orUAYdbpoGieLXtFz1akAGyfAXtY3V0l
	WX7TYrRYqj4Ib+BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96024134A0;
	Thu, 27 Feb 2025 01:40:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OB1zEoPCv2fhEQAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 27 Feb 2025 01:40:19 +0000
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
Subject: [PATCH 2/6] hostfs: store inode in dentry after mkdir if possible.
Date: Thu, 27 Feb 2025 12:32:54 +1100
Message-ID: <20250227013949.536172-3-neilb@suse.de>
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
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,kernel.org,vger.kernel.org,gmail.com,redhat.com,szeredi.hu,nod.at,cambridgegreys.com,sipsolutions.net,lists.infradead.org];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250226_174027_140832_41C0B12B 
X-CRM114-Status: GOOD (  11.49  )
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

Reviewed-by: Jeff Layton <jlayton@kernel.org>
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
2.48.1


