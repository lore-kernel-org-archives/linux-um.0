Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D8ECA0EE5
	for <linux-um@archiver.kernel.org>; Tue, 12 Aug 2025 23:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ysSmaM4rPZI1kq/gGFw0SS6pYu7vCBYTDIh2NSP6fbk=; b=rQUjP61NRO3leUHbvNBT4ZMeyZ
	pplmoyScP4bZKMR0caHSjmDyngps9TaTl236yCNV9LASzhKP2HTZq/YPDL83tiG3zfG/uoXhNn1kx
	CiBAWYuFrSjc7fSO9BRjzjAeM81E4FPn6k0TArDU+OrRR/RLNYs41g4ApdZycietqmvVBmC0eSePz
	Cf4HHoxjAwkgA6Epd7nf9VNZ4/IkbiRcYsfW0CuQLULCVsHdhefe/Dn+3K8a/OxfS01YAeH4WkpAj
	ZxTpABybTKRQggXEKTTLq/ZYZnU6XsQN7y1FPBvJqDgXn7AXJ4EmaT/KVZnzsO7l+EkMRrJV1m+Eu
	lYDVwHAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulyoP-0000000CE66-0etp;
	Tue, 12 Aug 2025 23:53:49 +0000
Received: from neil.brown.name ([103.29.64.221])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulyoC-0000000CDxw-2tst;
	Tue, 12 Aug 2025 23:53:37 +0000
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ulynL-005Y20-C5;
	Tue, 12 Aug 2025 23:52:45 +0000
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
Subject: [PATCH 04/11] VFS: introduce dentry_lookup_continue()
Date: Tue, 12 Aug 2025 12:25:07 +1000
Message-ID: <20250812235228.3072318-5-neil@brown.name>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250812235228.3072318-1-neil@brown.name>
References: <20250812235228.3072318-1-neil@brown.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_165336_729002_7BB3E08B 
X-CRM114-Status: GOOD (  20.13  )
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

A few callers operate on a dentry which they already have - unlike the
normal case where a lookup proceeds an operation.

For these callers dentry_lookup_continue() is provided where other
callers would use dentry_lookup().  The call will fail if, after the
lock was gained, the child is no longer a child of the given parent.

There are a couple of callers that want to lock a dentry in whatever
its current parent is.  For these a NULL parent can be passed, in which
case ->d_parent is used.  In this case the call cannot fail.

The idea behind the name is that the actual lookup occurred some time
ago, and now we are continuing with an operation on the dentry.

When the operation completes done_dentry_lookup() must be called.  An
extra reference is taken when the dentry_lookup_continue() call succeeds
and will be dropped by done_dentry_lookup().

This will be used in smb/server, ecryptfs, and overlayfs, each of which
have their own lock_parent() or parent_lock() or similar; and a few
other places which lock the parent but don't check if the parent is
still correct (often because rename isn't supported so parent cannot be
incorrect).

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c            | 39 +++++++++++++++++++++++++++++++++++++++
 include/linux/namei.h |  2 ++
 2 files changed, 41 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index 7af9b464886a..df21b6fa5a0e 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1874,6 +1874,45 @@ struct dentry *dentry_lookup_killable(struct mnt_idmap *idmap,
 }
 EXPORT_SYMBOL(dentry_lookup_killable);
 
+/**
+ * dentry_lookup_continue: lock a dentry if it is still in the given parent, prior to dir ops
+ * @child: the dentry to lock
+ * @parent: the dentry of the assumed parent
+ *
+ * The child is locked - currently by taking i_rwsem on the parent - to
+ * prepare for create/remove operations.  If the given parent is not
+ * %NULL and is no longer the parent of the dentry after the lock is
+ * gained, the lock is released and the call fails (returns
+ * ERR_PTR(-EINVAL).
+ *
+ * On success a reference to the child is taken and returned.  The lock
+ * and reference must both be dropped by done_dentry_lookup() after the
+ * operation completes.
+ */
+struct dentry *dentry_lookup_continue(struct dentry *child,
+				      struct dentry *parent)
+{
+	struct dentry *p = parent;
+
+again:
+	if (!parent)
+		p = dget_parent(child);
+	inode_lock_nested(d_inode(p), I_MUTEX_PARENT);
+	if (child->d_parent != p) {
+		inode_unlock(d_inode(p));
+		if (!parent) {
+			dput(p);
+			goto again;
+		}
+		return ERR_PTR(-EINVAL);
+	}
+	if (!parent)
+		dput(p);
+	/* get the child to balance with done_dentry_lookup() which puts it. */
+	return dget(child);
+}
+EXPORT_SYMBOL(dentry_lookup_continue);
+
 /**
  * done_dentry_lookup - finish a lookup used for create/delete
  * @dentry:  the target dentry
diff --git a/include/linux/namei.h b/include/linux/namei.h
index facb5852afa9..67eef91603cc 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -88,6 +88,8 @@ struct dentry *dentry_lookup_killable(struct mnt_idmap *idmap,
 				      unsigned int lookup_flags);
 struct dentry *dentry_lookup_noperm(struct qstr *name, struct dentry *base,
 				      unsigned int lookup_flags);
+struct dentry *dentry_lookup_continue(struct dentry *child,
+				      struct dentry *parent);
 void done_dentry_lookup(struct dentry *dentry);
 /* no_free_ptr() must not be used here - use dget() */
 DEFINE_FREE(dentry_lookup, struct dentry *, if (_T) done_dentry_lookup(_T))
-- 
2.50.0.107.gf914562f5916.dirty


