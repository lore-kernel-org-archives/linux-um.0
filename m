Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C262C106FD62
	for <linux-um@archiver.kernel.org>; Fri, 13 Mar 2026 00:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vcLY9NjcITx2BXCNwc1K2QRLwUNNN9sEl0XxFiatrQo=; b=d76SErGShQ7LxJjh1IIr75eQF8
	RQPd0o0+bR6rz1x3y0Wlx0v1Kz+V/59OowIlvZy0t0gXoyu+leYMMksrmgw0pX4Dcdm+Yk9pFkuv4
	h7XtbIPs1yyOJ0g2jkPH4cRJ0KEiGtJjX5/cl/vDLAuZHjSEKySiq9++y+QHQujF349HSDvftYxCX
	H5Vcl4faJp1JEdoTWYmWEFhxTLvxlb8e1kq/v5s8fV6VJznGXR5TEqCpHEu6AzzcPzsRrP+qCv+vI
	+dtYM4bRnZ+oYmvH5xIDgTmMUD+wD1PJ4CGwqivToc0eDCNcdjHfUcWhk/R2ghl8pz3AykX44P/Dy
	1Ld+yccw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0qhG-0000000Fz86-2Eai;
	Fri, 13 Mar 2026 00:48:10 +0000
Received: from flow-b5-smtp.messagingengine.com ([202.12.124.140])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0qhC-0000000Fz7J-2xKD;
	Fri, 13 Mar 2026 00:48:07 +0000
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id ABF701301B7A;
	Thu, 12 Mar 2026 20:48:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 12 Mar 2026 20:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773362884;
	 x=1773370084; bh=vcLY9NjcITx2BXCNwc1K2QRLwUNNN9sEl0XxFiatrQo=; b=
	mdKzMrUCmCgev5rjqMYLbCk9/NmPt8l5SN1cuh/XYEGVQSm40ukfPkz/tmPxK/Fw
	C8CU42AUDwoB+BWyvZtfv3qDJQwJMZqdkw0S72eJstmGGGMBhaX3ZHeVREPYyC2V
	fvUXlbJyg6aO5H4oucGa1RsaVgY2d21FE00GybtMYM8I1ew/f4keraC6xDUPB7c+
	5Pn0hGoCJlIddOhvP8sj6pXnoHeVeH2/moOy4KjHgIUwC35SmgVP2TRJhtJl4ARo
	qOU1z9u/0AZz+m+raqJO2irqtfbC4sPHEnz+cJH8kzFrV31gL9Yt6CTvQ0AfNIcZ
	ThO11BMQNTi0fw4x0ZoXng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773362884; x=1773370084; bh=v
	cLY9NjcITx2BXCNwc1K2QRLwUNNN9sEl0XxFiatrQo=; b=yDEdPqoxm0mvV/5PV
	Tn/eyzEfPnGUZEUvP0huJ0EgtFB+R+oNg15Lem1KP+cIB5aYs2Z0gfeS39ngIbKd
	sOWHNPGK+ZBSJt6wqiz2s389Zx158JBtkDde4mi+o9LWu2L220htc5Z57Rzo3VCu
	Z90aAHSpgBiPjX8Yb5AmV6q6FQWHuRjLfpHlr9jZjWb14gW0ydd4OI2iRf2hiTOH
	MlOKV6hphPTxCpVXdLyVJMEyK2ZBPk/i/vECEPqsu4qQtVl5VtfC5ZMnfsQ25QJV
	yMMfqpO4OcTvkWzFGghdY4we94eIkCp4DUNmAIn0DHytKFG5IxjjFvYe1zdHOPjm
	yg30A==
X-ME-Sender: <xms:xF6zaULW-NwfZ6qu3iJ9TlEpAEC4uvO82gKtANaBAXYbdtWdN5XVkQ>
    <xme:xF6zaX1A6f3iSCrTwSwJZCB6Tw6LuoRySNxlr4ygzru7LHkCgercK7wD_YNFghaPH
    blQzzGMx3reVFOfFHrMVsy8tYCFIb3P9olIpEKtDle8iuAB>
X-ME-Received: <xmr:xF6zafzQznsFTdMpan5mFbq7xcgpUC_0AeCWzRdATCvsU8ZvZPDZNod_8tQfK5u15bLRkg3QSLtcNDY4l8SUvRBc_s98YD0PPSRUwc6_MXez>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohephedupdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtoheplhhinhhugidqgihfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqthhrrggtvgdqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqvgigthegsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqvghfihesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:xF6zae1CmnJpT51rTdmfgm3qsIuMeUX2qKE-vHu6G96-t9rU5tfCfg>
    <xmx:xF6zaQ6Kg0DhF3JyA7Grw7T5XFPqYZr7dC9NGUkrW1os-H7djLtabg>
    <xmx:xF6zaZfjJJxvAh-lv1fnj6C-QCEXixW2zPJzDqHfmxNxsWpWg-scjA>
    <xmx:xF6zacbpasj86nZdirEODaqhQnsR5vPmsB0fhCgedqBfuHkUzp7tIQ>
    <xmx:xF6zaUUkZ-bPNnauXw_6I8hrTSreHohEU96-xm7UFeGDs5FbnFLK1l-1>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 20:47:50 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,	Carlos Maiolino <cem@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,	Amir Goldstein <amir73il@gmail.com>,
	Jan Harkes <jaharkes@cs.cmu.edu>,	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,	Steve French <sfrench@samba.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,	"Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,	Tyler Hicks <code@tyhicks.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,	Jeremy Kerr <jk@ozlabs.org>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	coda@cs.cmu.edu,
	linux-mm@kvack.org,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	ecryptfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-um@lists.infradead.org,
	linux-efi@vger.kernel.org
Subject: [PATCH 20/53] afs: don't unhash/rehash dentries during unlink/rename
Date: Fri, 13 Mar 2026 08:12:07 +1100
Message-ID: <20260312214330.3885211-21-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260312214330.3885211-1-neilb@ownmail.net>
References: <20260312214330.3885211-1-neilb@ownmail.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_174806_832869_3F68140E 
X-CRM114-Status: GOOD (  25.70  )
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

From: NeilBrown <neil@brown.name>

afs needs to block lookup of dentries during unlink and rename.
There are two reasons:
1/ If the target is to be removed, not silly-renamed, the subsequent
   opens cannot be allowed as the file won't exist on the server.
2/ If the rename source is being moved between directories a lookup,
   particularly d_revalidate, might change ->d_time asynchronously
   with rename changing ->d_time with possible incorrect results.

afs current unhashes the dentry to force a lookup which will wait on the
directory lock, and rehashes afterwards.  This is incompatible with
proposed changed to directory locking which will require a dentry to
remain hashed throughout rename/unlink/etc operations.

This patch copies a mechanism developed for NFS.  ->d_fsdata which is
currently unused is now set to a non-NULL value when lookups must be
blocked.  d_revalidate checks for this value, and waits for it to become
NULL.

->d_lock is used to ensure d_revalidate never updates ->d_time while
->d_fsdata is set.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/afs/afs.h      |  7 ++++++
 fs/afs/dir.c      | 64 +++++++++++++++++++++++++++++------------------
 fs/afs/internal.h |  5 +---
 3 files changed, 47 insertions(+), 29 deletions(-)

diff --git a/fs/afs/afs.h b/fs/afs/afs.h
index ec3db00bd081..019e77b08458 100644
--- a/fs/afs/afs.h
+++ b/fs/afs/afs.h
@@ -26,6 +26,13 @@ typedef u64			afs_volid_t;
 typedef u64			afs_vnodeid_t;
 typedef u64			afs_dataversion_t;
 
+/* This is stored in ->d_fsdata to stop d_revalidate looking at,
+ * and possibly changing, ->d_time on a dentry which is being moved
+ * between directories, and to block lookup for dentry that is
+ * being removed without silly-rename.
+ */
+#define AFS_FSDATA_BLOCKED ((void*)1)
+
 typedef enum {
 	AFSVL_RWVOL,			/* read/write volume */
 	AFSVL_ROVOL,			/* read-only volume */
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index a0417292314c..9c57614feccf 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -1034,6 +1034,10 @@ static int afs_d_revalidate_rcu(struct afs_vnode *dvnode, struct dentry *dentry)
 	if (!afs_check_validity(dvnode))
 		return -ECHILD;
 
+	/* A rename/unlink is pending */
+	if (dentry->d_fsdata)
+		return -ECHILD;
+
 	/* We only need to invalidate a dentry if the server's copy changed
 	 * behind our back.  If we made the change, it's no problem.  Note that
 	 * on a 32-bit system, we only have 32 bits in the dentry to store the
@@ -1069,6 +1073,10 @@ static int afs_d_revalidate(struct inode *parent_dir, const struct qstr *name,
 	if (flags & LOOKUP_RCU)
 		return afs_d_revalidate_rcu(dir, dentry);
 
+	/* Wait for rename/unlink to complete */
+wait_for_rename:
+	wait_var_event(&dentry->d_fsdata, dentry->d_fsdata == NULL);
+
 	if (d_really_is_positive(dentry)) {
 		vnode = AFS_FS_I(d_inode(dentry));
 		_enter("{v={%llx:%llu} n=%pd fl=%lx},",
@@ -1161,7 +1169,13 @@ static int afs_d_revalidate(struct inode *parent_dir, const struct qstr *name,
 	}
 
 out_valid:
+	spin_lock(&dentry->d_lock);
+	if (dentry->d_fsdata) {
+		spin_unlock(&dentry->d_lock);
+		goto wait_for_rename;
+	}
 	dentry->d_time = (unsigned long)dir_version;
+	spin_unlock(&dentry->d_lock);
 out_valid_noupdate:
 	key_put(key);
 	_leave(" = 1 [valid]");
@@ -1536,8 +1550,7 @@ static void afs_unlink_edit_dir(struct afs_operation *op)
 static void afs_unlink_put(struct afs_operation *op)
 {
 	_enter("op=%08x", op->debug_id);
-	if (op->unlink.need_rehash && afs_op_error(op) < 0 && afs_op_error(op) != -ENOENT)
-		d_rehash(op->dentry);
+	store_release_wake_up(&op->dentry->d_fsdata, NULL);
 }
 
 static const struct afs_operation_ops afs_unlink_operation = {
@@ -1591,11 +1604,7 @@ static int afs_unlink(struct inode *dir, struct dentry *dentry)
 		afs_op_set_error(op, afs_sillyrename(dvnode, vnode, dentry, op->key));
 		goto error;
 	}
-	if (!d_unhashed(dentry)) {
-		/* Prevent a race with RCU lookup. */
-		__d_drop(dentry);
-		op->unlink.need_rehash = true;
-	}
+	dentry->d_fsdata = AFS_FSDATA_BLOCKED;
 	spin_unlock(&dentry->d_lock);
 
 	op->file[1].vnode = vnode;
@@ -1885,9 +1894,10 @@ static void afs_rename_edit_dir(struct afs_operation *op)
 
 	_enter("op=%08x", op->debug_id);
 
-	if (op->rename.rehash) {
-		d_rehash(op->rename.rehash);
-		op->rename.rehash = NULL;
+	if (op->rename.unblock) {
+		/* Rename has finished, so unlocks lookups to target */
+		store_release_wake_up(&op->rename.unblock->d_fsdata, NULL);
+		op->rename.unblock = NULL;
 	}
 
 	fscache_begin_write_operation(&orig_cres, afs_vnode_cache(orig_dvnode));
@@ -1970,6 +1980,9 @@ static void afs_rename_exchange_edit_dir(struct afs_operation *op)
 
 		d_exchange(old_dentry, new_dentry);
 		up_write(&orig_dvnode->validate_lock);
+	/* dentry has been moved, so d_validate can safely proceed */
+	store_release_wake_up(&old_dentry->d_fsdata, NULL);
+
 	} else {
 		down_write(&orig_dvnode->validate_lock);
 		if (test_bit(AFS_VNODE_DIR_VALID, &orig_dvnode->flags) &&
@@ -2009,11 +2022,10 @@ static void afs_rename_exchange_edit_dir(struct afs_operation *op)
 static void afs_rename_put(struct afs_operation *op)
 {
 	_enter("op=%08x", op->debug_id);
-	if (op->rename.rehash)
-		d_rehash(op->rename.rehash);
+	if (op->rename.unblock)
+		store_release_wake_up(&op->rename.unblock->d_fsdata, NULL);
+	store_release_wake_up(&op->dentry->d_fsdata, NULL);
 	dput(op->rename.tmp);
-	if (afs_op_error(op))
-		d_rehash(op->dentry);
 }
 
 static const struct afs_operation_ops afs_rename_operation = {
@@ -2121,7 +2133,6 @@ static int afs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		op->ops		= &afs_rename_noreplace_operation;
 	} else if (flags & RENAME_EXCHANGE) {
 		op->ops		= &afs_rename_exchange_operation;
-		d_drop(new_dentry);
 	} else {
 		/* If we might displace the target, we might need to do silly
 		 * rename.
@@ -2135,14 +2146,12 @@ static int afs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		 */
 		if (d_is_positive(new_dentry) && !d_is_dir(new_dentry)) {
 			/* To prevent any new references to the target during
-			 * the rename, we unhash the dentry in advance.
+			 * the rename, we set d_fsdata which afs_d_revalidate will wait for.
+			 * d_lock ensures d_count() and ->d_fsdata are consistent.
 			 */
-			if (!d_unhashed(new_dentry)) {
-				d_drop(new_dentry);
-				op->rename.rehash = new_dentry;
-			}
-
+			spin_lock(&new_dentry->d_lock);
 			if (d_count(new_dentry) > 2) {
+				spin_unlock(&new_dentry->d_lock);
 				/* copy the target dentry's name */
 				op->rename.tmp = d_alloc(new_dentry->d_parent,
 							 &new_dentry->d_name);
@@ -2160,8 +2169,12 @@ static int afs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 				}
 
 				op->dentry_2 = op->rename.tmp;
-				op->rename.rehash = NULL;
 				op->rename.new_negative = true;
+			} else {
+				/* Block any lookups to target until the rename completes */
+				new_dentry->d_fsdata = AFS_FSDATA_BLOCKED;
+				op->rename.unblock = new_dentry;
+				spin_unlock(&new_dentry->d_lock);
 			}
 		}
 	}
@@ -2172,10 +2185,11 @@ static int afs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	 * d_revalidate may see old_dentry between the op having taken place
 	 * and the version being updated.
 	 *
-	 * So drop the old_dentry for now to make other threads go through
-	 * lookup instead - which we hold a lock against.
+	 * So block revalidate on the old_dentry until the rename completes.
 	 */
-	d_drop(old_dentry);
+	spin_lock(&old_dentry->d_lock);
+	old_dentry->d_fsdata = AFS_FSDATA_BLOCKED;
+	spin_unlock(&old_dentry->d_lock);
 
 	ret = afs_do_sync_operation(op);
 	if (ret == -ENOTSUPP)
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 106a7fe06b56..f2898ce9c0e6 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -891,10 +891,7 @@ struct afs_operation {
 			const char *symlink;
 		} create;
 		struct {
-			bool	need_rehash;
-		} unlink;
-		struct {
-			struct dentry	*rehash;
+			struct dentry	*unblock;
 			struct dentry	*tmp;
 			unsigned int	rename_flags;
 			bool		new_negative;
-- 
2.50.0.107.gf914562f5916.dirty


