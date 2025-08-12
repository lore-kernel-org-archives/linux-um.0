Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A65CA0EE6
	for <linux-um@archiver.kernel.org>; Tue, 12 Aug 2025 23:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=667wWyWcJRhdcCfMvoto8I0qodHR2FAlLnMeg64pRlM=; b=LSGNG6GXP/KeDLogwfHfkQDpTC
	cw+Yh1GjNnBQ0ZEgGiMGzirhUUyJM0atLq7GfNFu9PqQKxhv9dsSYGQIYMV2gqr8y1Wt/6N9d921M
	sEGOv70JziTCgDwfCvV/hW2pe+l8/u8TO35q8jSNvlvvDK+evKWsHF7iI8e6wEpBz7dWgTo49PiDm
	pC1UITW7LnZnSTei/9W8rV5wcpqH/HB8dqPlS0o/83QJnxdNMuL6Ra3hjW77UpN7Jyme1UFszFLZu
	vPcIgWFi5tmvDb7V+wmxFPMh/rFkQiGTrDyrS0U4Q3Hclx/A9VB1f0ZTViIzLRmKv3NB4hZQKIMdZ
	SgZp8sEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulyoQ-0000000CE7B-1i4b;
	Tue, 12 Aug 2025 23:53:50 +0000
Received: from neil.brown.name ([103.29.64.221])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulyoD-0000000CDy0-0hqs;
	Tue, 12 Aug 2025 23:53:39 +0000
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ulynK-005Y1y-Ic;
	Tue, 12 Aug 2025 23:52:44 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Tyler Hicks <code@tyhicks.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Steve French <sfrench@samba.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-afs@lists.infradead.org,
	netfs@lists.linux.dev,
	ceph-devel@vger.kernel.org,
	ecryptfs@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] VFS: add dentry_lookup_killable()
Date: Tue, 12 Aug 2025 12:25:06 +1000
Message-ID: <20250812235228.3072318-4-neil@brown.name>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250812235228.3072318-1-neil@brown.name>
References: <20250812235228.3072318-1-neil@brown.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_165337_207422_B4B0F079 
X-CRM114-Status: GOOD (  13.27  )
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

btrfs/ioctl.c uses a "killable" lock on the directory when creating an
destroying subvols.  overlayfs also does this.

This patch adds dentry_lookup_killable() for these users.

Possibly all dentry_lookup should be killable as there is no down-side,
but that can come in a later patch.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c            | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/namei.h |  3 +++
 2 files changed, 40 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index 85b981248a90..7af9b464886a 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1837,6 +1837,43 @@ struct dentry *dentry_lookup(struct mnt_idmap *idmap,
 }
 EXPORT_SYMBOL(dentry_lookup);
 
+/**
+ * dentry_lookup_killable - lookup and lock a name prior to dir ops
+ * @last: the name in the given directory
+ * @base: the directory in which the name is to be found
+ * @lookup_flags: %LOOKUP_xxx flags
+ *
+ * The name is looked up and necessary locks are taken so that
+ * the name can be created or removed.
+ * The "necessary locks" are currently the inode lock on @base.
+ * If a fatal signal arrives, or is already pending, the operation is aborted.
+ * The name @last is NOT expected to already have the hash calculated.
+ * Permission checks are performed to ensure %MAY_EXEC access to @base.
+ * Returns: the dentry, suitably locked, or an ERR_PTR().
+ */
+struct dentry *dentry_lookup_killable(struct mnt_idmap *idmap,
+				      struct qstr *last,
+				      struct dentry *base,
+				      unsigned int lookup_flags)
+{
+	struct dentry *dentry;
+	int err;
+
+	err = lookup_one_common(idmap, last, base);
+	if (err < 0)
+		return ERR_PTR(err);
+
+	err = down_write_killable_nested(&base->d_inode->i_rwsem, I_MUTEX_PARENT);
+	if (err)
+		return ERR_PTR(err);
+
+	dentry = lookup_one_qstr_excl(last, base, lookup_flags);
+	if (IS_ERR(dentry))
+		inode_unlock(base->d_inode);
+	return dentry;
+}
+EXPORT_SYMBOL(dentry_lookup_killable);
+
 /**
  * done_dentry_lookup - finish a lookup used for create/delete
  * @dentry:  the target dentry
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 932cb94c3538..facb5852afa9 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -83,6 +83,9 @@ struct dentry *lookup_one_positive_unlocked(struct mnt_idmap *idmap,
 struct dentry *dentry_lookup(struct mnt_idmap *idmap,
 			       struct qstr *last, struct dentry *base,
 			       unsigned int lookup_flags);
+struct dentry *dentry_lookup_killable(struct mnt_idmap *idmap,
+				      struct qstr *last, struct dentry *base,
+				      unsigned int lookup_flags);
 struct dentry *dentry_lookup_noperm(struct qstr *name, struct dentry *base,
 				      unsigned int lookup_flags);
 void done_dentry_lookup(struct dentry *dentry);
-- 
2.50.0.107.gf914562f5916.dirty


