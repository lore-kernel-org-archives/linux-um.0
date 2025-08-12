Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90905CA0EE8
	for <linux-um@archiver.kernel.org>; Tue, 12 Aug 2025 23:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ssHu3V7JFrSrn/um/kRdgU4+z4xao5mhWoY79E667ow=; b=kJwmDfYKrmxzVHJh7VgodsmETJ
	lfNBJ24zdNh05f4FCFatHgDEQJ55N8cEt0JuEnpCdjdu/HHOwJLXp85NKZhJbNDMGzGzwNAX/3hvR
	4fqrFlsHYOze2pQdMrHk2C6h3U3XmC5w8nC82fXzTl5vR+/58JTNbu1rAUiw6855Fxs9rrUjFyo+O
	6aD2vgTjMz7Fq3wMQm311ZRvEmqX+vWIdwyvJ5Tm5cxdt1hDMK8goFagFgmhhhPfkg6QJCs5M63/e
	8shgh/+crFNjHx2i2BAcKeCaGJ5f5w1N6nhg2xE3/z8IyZjzBorHLRGnKCVb8ZN3+CNTCyj6ZzU/0
	fBhASfuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulyoT-0000000CEBn-0zf2;
	Tue, 12 Aug 2025 23:53:53 +0000
Received: from neil.brown.name ([103.29.64.221])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulyoE-0000000CDy4-17cg;
	Tue, 12 Aug 2025 23:53:40 +0000
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ulynQ-005Y2D-85;
	Tue, 12 Aug 2025 23:52:49 +0000
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
Subject: [PATCH 10/11] VFS: use d_alloc_parallel() in lookup_one_qstr_excl().
Date: Tue, 12 Aug 2025 12:25:13 +1000
Message-ID: <20250812235228.3072318-11-neil@brown.name>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250812235228.3072318-1-neil@brown.name>
References: <20250812235228.3072318-1-neil@brown.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_165338_493141_A4033C9E 
X-CRM114-Status: GOOD (  24.34  )
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

lookup_one_qstr_excl() is used for lookups prior to directory
modifications, whether create, unlink, rename, or whatever.

To prepare for allowing modification to happen in parallel, change
lookup_one_qstr_excl() to use d_alloc_parallel().

As a result, ->lookup is now only ever called with a d_in_lookup()
dentry.  Consequently we can remove the d_in_lookup() check from
d_add_ci() which is only used in ->lookup.

If LOOKUP_EXCL or LOOKUP_RENAME_TARGET is passed, the caller must ensure
d_lookup_done() is called at an appropriate time, and must not assume
that it can test for positive or negative dentries without confirming
that the dentry is no longer d_in_lookup() - unless it is filesystem
code acting on itself and *knows* that ->lookup() always completes the
lookup (currently true for all filesystems other than NFS).

Signed-off-by: NeilBrown <neil@brown.name>
---
 Documentation/filesystems/porting.rst | 14 +++++++++
 fs/dcache.c                           | 16 +++-------
 fs/namei.c                            | 45 +++++++++++++++++++++------
 3 files changed, 53 insertions(+), 22 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index e4a326e8fa4c..c9210d3bd313 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1291,3 +1291,17 @@ parameters for the file system to set this state.
 
 d_alloc_parallel() no longer requires a waitqueue_head.  It uses one
 from an internal table when needed.
+
+---
+
+** mandatory**
+
+All dentry_lookup* functions may return a d_in_lookup() dentry if passed
+"O_CREATE|O_EXCL" or "O_RENAME_TARGET".  done_dentry_lookup() calls the
+necessary d_lookup_done().  If the caller *knows* which filesystem is
+being used, it may know that this is not possible.  Otherwise it must be
+careful testing if the dentry is positive or negative as the lookup may
+not have been performed yet.
+
+inode_operations.lookup() is now only ever called with a d_in_lookup()
+dentry.
diff --git a/fs/dcache.c b/fs/dcache.c
index 5473d906783e..7e3eb5576fa4 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2136,18 +2136,10 @@ struct dentry *d_add_ci(struct dentry *dentry, struct inode *inode,
 		iput(inode);
 		return found;
 	}
-	if (d_in_lookup(dentry)) {
-		found = d_alloc_parallel(dentry->d_parent, name);
-		if (IS_ERR(found) || !d_in_lookup(found)) {
-			iput(inode);
-			return found;
-		}
-	} else {
-		found = d_alloc(dentry->d_parent, name);
-		if (!found) {
-			iput(inode);
-			return ERR_PTR(-ENOMEM);
-		}
+	found = d_alloc_parallel(dentry->d_parent, name);
+	if (IS_ERR(found) || !d_in_lookup(found)) {
+		iput(inode);
+		return found;
 	}
 	res = d_splice_alias(inode, found);
 	if (res) {
diff --git a/fs/namei.c b/fs/namei.c
index 2c98672fdb6a..6a645f3a2b20 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1666,13 +1666,14 @@ static struct dentry *lookup_dcache(const struct qstr *name,
 }
 
 /*
- * Parent directory has inode locked exclusive.  This is one
- * and only case when ->lookup() gets called on non in-lookup
- * dentries - as the matter of fact, this only gets called
- * when directory is guaranteed to have no in-lookup children
- * at all.
- * Will return -ENOENT if name isn't found and LOOKUP_CREATE wasn't passed.
- * Will return -EEXIST if name is found and LOOKUP_EXCL was passed.
+ * Parent directory has inode locked.
+ * d_lookup_done() must be called before the dentry is dput()
+ * if LOOKUP_EXCL or LOOKUP_RENAME_TARGET is set.
+ * If the dentry is not d_in_lookup():
+ *   Will return -ENOENT if name isn't found and LOOKUP_CREATE wasn't passed.
+ *   Will return -EEXIST if name is found and LOOKUP_EXCL was passed.
+ * If it is d_in_lookup() then these conditions can only be checked by the
+ * file system when carrying out the intent (create or rename).
  */
 struct dentry *lookup_one_qstr_excl(const struct qstr *name,
 				    struct dentry *base, unsigned int flags)
@@ -1690,18 +1691,27 @@ struct dentry *lookup_one_qstr_excl(const struct qstr *name,
 	if (unlikely(IS_DEADDIR(dir)))
 		return ERR_PTR(-ENOENT);
 
-	dentry = d_alloc(base, name);
-	if (unlikely(!dentry))
-		return ERR_PTR(-ENOMEM);
+	dentry = d_alloc_parallel(base, name);
+	if (unlikely(IS_ERR(dentry)))
+		return dentry;
+	if (unlikely(!d_in_lookup(dentry)))
+		/* Raced with another thread which did the lookup */
+		goto found;
 
 	old = dir->i_op->lookup(dir, dentry, flags);
 	if (unlikely(old)) {
+		d_lookup_done(dentry);
 		dput(dentry);
 		dentry = old;
 	}
 found:
 	if (IS_ERR(dentry))
 		return dentry;
+	if (d_in_lookup(dentry))
+		/* We cannot check for errors - the caller will have to
+		 * wait for any create-etc attempt to get relevant errors.
+		 */
+		return dentry;
 	if (d_is_negative(dentry) && !(flags & LOOKUP_CREATE)) {
 		dput(dentry);
 		return ERR_PTR(-ENOENT);
@@ -1767,6 +1777,8 @@ static int lookup_one_common(struct mnt_idmap *idmap,
  * This function is for VFS-internal use only.
  *
  * Returns: the dentry, suitably locked, or an ERR_PTR().
+ *    The dentry may be d_in_lookup() if LOOKUP_EXCL or LOOKUP_RENAME_TARGET
+ *    is given, depending on the filesystem.
  */
 static struct dentry *__dentry_lookup(struct qstr *last,
 				      struct dentry *base,
@@ -1796,7 +1808,10 @@ static struct dentry *__dentry_lookup(struct qstr *last,
  * The "necessary locks" are currently the inode lock on @base.
  * The name @last is NOT expected to have the hash calculated.
  * No permission checks are performed.
+ *
  * Returns: the dentry, suitably locked, or an ERR_PTR().
+ *    The dentry may be d_in_lookup() if LOOKUP_EXCL or LOOKUP_RENAME_TARGET
+ *    is given, depending on the filesystem.
  */
 struct dentry *dentry_lookup_noperm(struct qstr *last,
 				    struct dentry *base,
@@ -1825,6 +1840,8 @@ EXPORT_SYMBOL(dentry_lookup_noperm);
  * Permission checks are performed to ensure %MAY_EXEC access to @base.
  *
  * Returns: the dentry, suitably locked, or an ERR_PTR().
+ *    The dentry may be d_in_lookup() if LOOKUP_EXCL or LOOKUP_RENAME_TARGET
+ *    is given, depending on the filesystem.
  */
 struct dentry *dentry_lookup(struct mnt_idmap *idmap,
 			     struct qstr *last,
@@ -1852,7 +1869,10 @@ EXPORT_SYMBOL(dentry_lookup);
  * If a fatal signal arrives, or is already pending, the operation is aborted.
  * The name @last is NOT expected to already have the hash calculated.
  * Permission checks are performed to ensure %MAY_EXEC access to @base.
+ *
  * Returns: the dentry, suitably locked, or an ERR_PTR().
+ *    The dentry may be d_in_lookup() if LOOKUP_EXCL or LOOKUP_RENAME_TARGET
+ *    is given, depending on the filesystem.
  */
 struct dentry *dentry_lookup_killable(struct mnt_idmap *idmap,
 				      struct qstr *last,
@@ -1937,6 +1957,7 @@ void done_dentry_lookup(struct dentry *dentry)
 {
 	if (!IS_ERR(dentry)) {
 		inode_unlock(dentry->d_parent->d_inode);
+		d_lookup_done(dentry);
 		dput(dentry);
 	}
 }
@@ -3613,9 +3634,11 @@ __rename_lookup(struct renamedata *rd, int lookup_flags)
 	return 0;
 
 out_unlock_3:
+	d_lookup_done(d2);
 	dput(d2);
 	d2 = ERR_PTR(err);
 out_unlock_2:
+	d_lookup_done(d1);
 	dput(d1);
 	d1 = d2;
 out_unlock_1:
@@ -3732,6 +3755,8 @@ EXPORT_SYMBOL(rename_lookup);
  */
 void done_rename_lookup(struct renamedata *rd)
 {
+	d_lookup_done(rd->old_dentry);
+	d_lookup_done(rd->new_dentry);
 	unlock_rename(rd->old_parent, rd->new_parent);
 	dput(rd->old_parent);
 	dput(rd->old_dentry);
-- 
2.50.0.107.gf914562f5916.dirty


