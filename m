Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41270106ACEC
	for <linux-um@archiver.kernel.org>; Thu, 12 Mar 2026 21:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tG1sAZ33EfRbToxRaM5utlCqwlH2sGHBZL6Q+fSZ/kg=; b=OZb35YaOCJNQdG5qZuiYGVJwAS
	JbfoeCRzvigqtN27Jecu2J37Q7j1M82uvdESIeisuQG3lunbpOWaqr0B83fIJKSR1X/7FKFXLDjwm
	Ty08bTQ05/tZcOkvGml0dmCuTVOr+q6cS/MLPAXVv5Si4cnUWz74EuCUDbKL1bsAwq0k1TknWAipv
	vnmu8Ooww6CZKauZ+MMSl7ssAi5dESYQ9C41SQBtISXN1L748ZxlV0CFVCxiAxjBfH8dAsb7JNq8D
	yLuZibTwPj68X3Un5qpeCOWfujTlovL2mND2v9FVl/6Td21CoRf0kjkyG+ox8slkm4+iXrgXI/Vwc
	WzOH/WLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0o2Z-0000000FZ55-3397;
	Thu, 12 Mar 2026 21:57:59 +0000
Received: from flow-b6-smtp.messagingengine.com ([202.12.124.141])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0o2X-0000000FZ4N-1wfT;
	Thu, 12 Mar 2026 21:57:58 +0000
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailflow.stl.internal (Postfix) with ESMTP id 9E9601300F6C;
	Thu, 12 Mar 2026 17:57:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 12 Mar 2026 17:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773352675;
	 x=1773359875; bh=tG1sAZ33EfRbToxRaM5utlCqwlH2sGHBZL6Q+fSZ/kg=; b=
	OmN1n9vTcFKpHoHUGImFy0CQZvz9KEtReJX8p0OX7kUzjl9V1nlaH0yIJxxNJ5o5
	oET4VMjoMdSHj7IP5T4w/Rg6YRHXE0F+yv/zv6JIVNaEu04OcGt8i2Z31ixKUARE
	DgWSGk08+PgsvbboVZfumYegJ49ceyganU4rmEo80NNQt8dBC4CP9Wg3fGyUFm/H
	JqPNMalfP80ve+bbpg9QT7R10mOUfPal3L+Ic8nXjpuv3ShR8ZVXFaW54uMweLe0
	Uq9Qii9ZXDmV3HkZ8LfHyMvZo42uRI7668NHYPRCfw63wFbH2Rx07hB+CGfTU/+0
	5h1RkHy0wyR2U7RjIeMU+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773352675; x=1773359875; bh=t
	G1sAZ33EfRbToxRaM5utlCqwlH2sGHBZL6Q+fSZ/kg=; b=DUkArunM0luViPOSC
	jYYHJCnZBtZFu1yArXIwY0hvu6BErdZBDdHUc16HB0A4qYJKkcPzwpLxrDs9bVos
	bzYgAA+8UttTRhFKZ0bpoi8CaHHQoxiV1ip3XmTGLLS3OhflYcg/lSPRa3aw9Esw
	9Dby830jyY6S1LECOhApUa2X7BsIoOuRyilaw6sD+gyYb3+jHWgRcHxC9iAw/Z2u
	IRdPeUpUN5OYAHfWgBBL/r028pjWmk4Ha2AjbAGHczLxiNwGIUOrONuduvNIGDUf
	DAhRMe7hKq4+w9i2cCgr2MKWCq0AYV+anj+y7k2zwww+ByYy121ZFJq9XFjo8x6e
	Ofj3w==
X-ME-Sender: <xms:4jazaeFn5-5ZjBYkhGw6hC20rPqHC-eoU5MGnd0AAZ-I6bLvJ9ELCg>
    <xme:4jazaTAb5hcSgkknkeWENiMzD0gJfSYjyQXXByW8kZl3-XtihuGn7S-WhHyf9t_DZ
    W5RFB22BmI8VxOSTUeMxFjSuzsbFQ0lX7QdTDENtegi8SjeDQ>
X-ME-Received: <xmr:4jazaTPB-I988aMIRhAYzbmhIdiFT34StuynorRC9fmZ45TsXPyLi-7rrLHrfLGp3j1X2aItdBJIN23x4LtanxXAQN3pBDJgtRAcTrG66GIU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejledvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:4zazaVj0-tqVWhDOqcWRHbmE5sTiu5G-_3jkKNnvE-EBbnuhNpaNxg>
    <xmx:4zazaZ02uemv5SlntkWgkuepkyXHF8GDbc1lqqSCc-aqTpQp9BetEg>
    <xmx:4zazaXrW2_YS0Q0DIZy_BeDgcsnjcbvGRVUzdNgVYU-TpIFIV4rvkQ>
    <xmx:4zazaW1GzIlqYt011d9e3OM1PzStUWJLIQpdtToNWeDDvTiQufyyBQ>
    <xmx:4zazadRhJAD24D_AyMwEqRBB2ZN0piXoDW7SGjuVeK14jeJI3r62dA4J>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 17:57:42 -0400 (EDT)
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
Subject: [PATCH 50/53] VFS: remove lookup_one() and lookup_noperm()
Date: Fri, 13 Mar 2026 08:12:37 +1100
Message-ID: <20260312214330.3885211-51-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260312214330.3885211-1-neilb@ownmail.net>
References: <20260312214330.3885211-1-neilb@ownmail.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_145757_609322_05916963 
X-CRM114-Status: GOOD (  14.30  )
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

These are no longer used, so remove them.

Signed-off-by: NeilBrown <neil@brown.name>
---
 Documentation/filesystems/porting.rst |  7 +++
 fs/ecryptfs/inode.c                   |  2 +-
 fs/namei.c                            | 61 ++-------------------------
 include/linux/namei.h                 |  2 -
 4 files changed, 12 insertions(+), 60 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 154a38cd7801..7e83bd3c5a12 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1396,3 +1396,10 @@ and d_alloc_parallel() or d_alloc_noblock() when standard interfaces can be used
 d_rehash() is gone. It should never be needed.  Only unhash a dentry if
 you really don't want it.
 
+---
+
+** mandatory**
+
+lookup_one() and lookup_noperm() are no longer available.  Use
+start_creating() or similar instead.
+
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index beb9e2c8b8b3..a7a596d51d67 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -414,7 +414,7 @@ static struct dentry *ecryptfs_lookup(struct inode *ecryptfs_dir_inode,
 
 	lower_dentry = lookup_noperm_unlocked(&qname, lower_dir_dentry);
 	if (IS_ERR(lower_dentry)) {
-		ecryptfs_printk(KERN_DEBUG, "%s: lookup_noperm() returned "
+		ecryptfs_printk(KERN_DEBUG, "%s: lookup_noperm_unlocked() returned "
 				"[%ld] on lower_dentry = [%s]\n", __func__,
 				PTR_ERR(lower_dentry),
 				qname.name);
diff --git a/fs/namei.c b/fs/namei.c
index eed388ee8a30..cb80490a869f 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3148,59 +3148,6 @@ struct dentry *try_lookup_noperm(struct qstr *name, struct dentry *base)
 }
 EXPORT_SYMBOL(try_lookup_noperm);
 
-/**
- * lookup_noperm - filesystem helper to lookup single pathname component
- * @name:	qstr storing pathname component to lookup
- * @base:	base directory to lookup from
- *
- * Note that this routine is purely a helper for filesystem usage and should
- * not be called by generic code.  It does no permission checking.
- *
- * The caller must hold base->i_rwsem.
- */
-struct dentry *lookup_noperm(struct qstr *name, struct dentry *base)
-{
-	struct dentry *dentry;
-	int err;
-
-	WARN_ON_ONCE(!inode_is_locked(base->d_inode));
-
-	err = lookup_noperm_common(name, base);
-	if (err)
-		return ERR_PTR(err);
-
-	dentry = lookup_dcache(name, base, 0);
-	return dentry ? dentry : __lookup_slow(name, base, 0);
-}
-EXPORT_SYMBOL(lookup_noperm);
-
-/**
- * lookup_one - lookup single pathname component
- * @idmap:	idmap of the mount the lookup is performed from
- * @name:	qstr holding pathname component to lookup
- * @base:	base directory to lookup from
- *
- * This can be used for in-kernel filesystem clients such as file servers.
- *
- * The caller must hold base->i_rwsem.
- */
-struct dentry *lookup_one(struct mnt_idmap *idmap, struct qstr *name,
-			  struct dentry *base)
-{
-	struct dentry *dentry;
-	int err;
-
-	WARN_ON_ONCE(!inode_is_locked(base->d_inode));
-
-	err = lookup_one_common(idmap, name, base);
-	if (err)
-		return ERR_PTR(err);
-
-	dentry = lookup_dcache(name, base, 0);
-	return dentry ? dentry : __lookup_slow(name, base, 0);
-}
-EXPORT_SYMBOL(lookup_one);
-
 /**
  * lookup_one_unlocked - lookup single pathname component
  * @idmap:	idmap of the mount the lookup is performed from
@@ -3209,8 +3156,8 @@ EXPORT_SYMBOL(lookup_one);
  *
  * This can be used for in-kernel filesystem clients such as file servers.
  *
- * Unlike lookup_one, it should be called without the parent
- * i_rwsem held, and will take the i_rwsem itself if necessary.
+ * It should be called without the parent i_rwsem held, and will take
+ * the i_rwsem itself if necessary.
  *
  * Returns: - A dentry, possibly negative, or
  *	    - same errors as try_lookup_noperm() or
@@ -3322,8 +3269,8 @@ EXPORT_SYMBOL(lookup_one_positive_unlocked);
  * Note that this routine is purely a helper for filesystem usage and should
  * not be called by generic code. It does no permission checking.
  *
- * Unlike lookup_noperm(), it should be called without the parent
- * i_rwsem held, and will take the i_rwsem itself if necessary.
+ * This should be called without the parent i_rwsem held, and will take
+ * the i_rwsem itself if necessary.
  *
  * Unlike try_lookup_noperm() it *does* revalidate the dentry if it already
  * existed.
diff --git a/include/linux/namei.h b/include/linux/namei.h
index b3346a513d8f..cb79e84c718d 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -74,10 +74,8 @@ int vfs_path_lookup(struct dentry *, struct vfsmount *, const char *,
 		    unsigned int, struct path *);
 
 extern struct dentry *try_lookup_noperm(struct qstr *, struct dentry *);
-extern struct dentry *lookup_noperm(struct qstr *, struct dentry *);
 extern struct dentry *lookup_noperm_unlocked(struct qstr *, struct dentry *);
 extern struct dentry *lookup_noperm_positive_unlocked(struct qstr *, struct dentry *);
-struct dentry *lookup_one(struct mnt_idmap *, struct qstr *, struct dentry *);
 struct dentry *lookup_one_unlocked(struct mnt_idmap *idmap,
 				   struct qstr *name, struct dentry *base);
 struct dentry *lookup_one_positive_unlocked(struct mnt_idmap *idmap,
-- 
2.50.0.107.gf914562f5916.dirty


