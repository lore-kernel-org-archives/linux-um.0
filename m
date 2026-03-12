Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2ABD106FD62
	for <linux-um@archiver.kernel.org>; Fri, 13 Mar 2026 00:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W+v0RL/pMIx9j3nL0G9XTRWShzNEiYc7Idmh4VPeJRE=; b=YzymcYmCL4R0vYNY9onCul5Zs9
	u3RdFjo1w/d0Dv9T+V3jGCGmKyos2AoQIs998DY82CuePjvM35sQm2KUN4ZPydSjnGlNGb8TVi+/S
	qxpxyewv20YY5zqr+my8Q0ruEfWYVQ5fYEhp3Mn6uAedYiyXPhfYWLmNvLsb9QAe/SnF0TB/YYa3D
	PxVL7bdrFF1CDEQsMY/SUFgPxFkZSNCbtYGiosUMpYWluwWbYYDO7jUCy95rNVW8HnLJEt4qBD/yM
	qd2SGh09oJHp+g2/Es72G1sqMjhKL0B1yoc8KqJAyicIbTbXwWxqRbXp8hzmuVaON3kCG1Q1f7mim
	9592cFvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0qdu-0000000FyDS-1wso;
	Fri, 13 Mar 2026 00:44:42 +0000
Received: from flow-b5-smtp.messagingengine.com ([202.12.124.140])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0qdr-0000000FyCX-3hZ0;
	Fri, 13 Mar 2026 00:44:41 +0000
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id E582F1301B38;
	Thu, 12 Mar 2026 20:44:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 12 Mar 2026 20:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773362677;
	 x=1773369877; bh=W+v0RL/pMIx9j3nL0G9XTRWShzNEiYc7Idmh4VPeJRE=; b=
	Uiezvf1WupOqSkTJUVDzQj/e45sCFlF/EsxnaQRySLaMDeWubPQp5OddX1k1Tvyc
	fM8hXdjfAyk7mBWyOtJyl1XY3cLisZtYpoTj/wWI94u1+6Q1OTxA1xkorKNlWngZ
	19E1fuDeIU0QMydCYSd84SxYxTpG7sb9SkBfgNPvcxBV0NZIOsCaBRE1a4KLzZE1
	GjAYqOrBgI9TC6KxLc2SGiccYXPQXEx7/Wi8CMKCPXcZgKxji1zDJ/7l359QMTZa
	ywFy44n0vrD30GmvqShSeh7b/fwsohR/niM5kxoAlO95aTu0XwAx0CU7d688/FST
	arzVZR6P9jQqOOl/aBeZTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773362677; x=1773369877; bh=W
	+v0RL/pMIx9j3nL0G9XTRWShzNEiYc7Idmh4VPeJRE=; b=aFZ9JpaMDgkx+1Rfj
	50EtuvgPbTu5u0p7h44/q79D178w3fkvuVwv2nTvXR1ZNLOWKPhEDjcXjRir7VU7
	zylNpYhPxXxgBAKwhYD5kG02FWQKM1yzB/OjVyPTUbXfqbNW7xMtuQ11zWCu5qhy
	8Qc/j0zpzCEtWZ5Pm5ap8yjnRvZxGUiVrHBgy5LW4llPZ1rSVe7AWeu11RiniJgk
	At57JqIa/txEQMSlOGgTWOftoLO6WArZ/AByvN2cKJ5FpiPU8PweDjNbLU/7Vf0Y
	BOGmEgiG57SWk7kyCNZ8fVwmdnUIkfzFF4d8/iw2mdvQvfAm9DHbT2S7Su5nZHrl
	zS9Vg==
X-ME-Sender: <xms:9V2zaQSw-WmTgNYr0os8VUGhQsueljKBGrE2oRSZGDy0Iuk7HwIJTA>
    <xme:9V2zaRdEwsU2zqEFcZKm0YLSqmFebJVxRT3LQI5x03edzqoO3rZaYgm01LJcI-WhT
    U9avNwHdvf99EaegUy6t6YanZkzJ4I8cwHeja0DE4EDWE_2Bw>
X-ME-Received: <xmr:9V2zaY61aWrMvr4oWcQ4QrQqpeDMkYMzw_-2zOUtrUaxf727cWq4eVI8D37sO-WVpowEgy45YnLzJotwmdflit8yW-zofMJzVxhLF0oJ_VZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
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
X-ME-Proxy: <xmx:9V2zaRfBgIZEKNLftG1LyzVgU7NQ9DTMJ9kqBffjs9Na9LJNHlONYg>
    <xmx:9V2zafD9uInAbKGVcHuPpvvmpqxfgHGBYWWNujV3Yx4pCCqkZGx5aQ>
    <xmx:9V2zadFGXJ7cnAoIVm7EfZjxx8HeO2Wlz5enlMzCxbDZrdR-p2bMIw>
    <xmx:9V2zaXhFnkJBxDQSUZFlUwtvHMV6z-EQ2eB8IojUDHrrl0G8fshbww>
    <xmx:9V2zaSd2ICZlyrNVeZ_29UAt4vlNyQXkBhVEkUNQDaml3-NsmN3jVodG>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 20:44:24 -0400 (EDT)
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
Subject: [PATCH 32/53] ext4: move dcache modifying code out of __ext4_link()
Date: Fri, 13 Mar 2026 08:12:19 +1100
Message-ID: <20260312214330.3885211-33-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260312214330.3885211-1-neilb@ownmail.net>
References: <20260312214330.3885211-1-neilb@ownmail.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_174439_987448_80A81C2A 
X-CRM114-Status: GOOD (  21.11  )
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

__ext4_link() is separate from ext4_link() so that it can be used for
replaying a "fast_commit" which records a link operation.
Replaying the fast_commit does not require any interaction with the
dcache - it is purely ext4-local - but it uses a dentry to simplify code
reuse.

An interface it uses - d_alloc() - is not generally useful and will soon
be removed.  This patch prepares ext4 for that removal.  Specifically it
removes all dcache-modification code from __ext4_link().  This will mean
that __ext4_link() treats the dentry as read-only so fast_commit reply
can simply provide an on-stack dentry.

Various "const" markers are sprinkled around to confirm that the dentry
is treated read-only.

This patch only rearranges code and slightly re-orders it, so those
changes can be reviewed separately.  The next patch will remove the use
of d_alloc().

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/dcache.c                 |  2 +-
 fs/ext4/ext4.h              |  4 ++--
 fs/ext4/fast_commit.c       | 14 +++++++++++---
 fs/ext4/namei.c             | 23 +++++++++++++----------
 include/linux/dcache.h      |  2 +-
 include/trace/events/ext4.h |  4 ++--
 6 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index a1219b446b74..c48337d95f9a 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -358,7 +358,7 @@ static inline int dname_external(const struct dentry *dentry)
 	return dentry->d_name.name != dentry->d_shortname.string;
 }
 
-void take_dentry_name_snapshot(struct name_snapshot *name, struct dentry *dentry)
+void take_dentry_name_snapshot(struct name_snapshot *name, const struct dentry *dentry)
 {
 	unsigned seq;
 	const unsigned char *s;
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 293f698b7042..1794407652ff 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2972,7 +2972,7 @@ void ext4_fc_track_range(handle_t *handle, struct inode *inode, ext4_lblk_t star
 void __ext4_fc_track_unlink(handle_t *handle, struct inode *inode,
 	struct dentry *dentry);
 void __ext4_fc_track_link(handle_t *handle, struct inode *inode,
-	struct dentry *dentry);
+	const struct dentry *dentry);
 void ext4_fc_track_unlink(handle_t *handle, struct dentry *dentry);
 void ext4_fc_track_link(handle_t *handle, struct dentry *dentry);
 void __ext4_fc_track_create(handle_t *handle, struct inode *inode,
@@ -3719,7 +3719,7 @@ extern int ext4_handle_dirty_dirblock(handle_t *handle, struct inode *inode,
 extern int __ext4_unlink(struct inode *dir, const struct qstr *d_name,
 			 struct inode *inode, struct dentry *dentry);
 extern int __ext4_link(struct inode *dir, struct inode *inode,
-		       struct dentry *dentry);
+		       const struct dentry *dentry);
 
 #define S_SHIFT 12
 static const unsigned char ext4_type_by_mode[(S_IFMT >> S_SHIFT) + 1] = {
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index f575751f1cae..2a5daf1d9667 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -388,7 +388,7 @@ static int ext4_fc_track_template(
 }
 
 struct __track_dentry_update_args {
-	struct dentry *dentry;
+	const struct dentry *dentry;
 	int op;
 };
 
@@ -400,7 +400,7 @@ static int __track_dentry_update(handle_t *handle, struct inode *inode,
 	struct ext4_inode_info *ei = EXT4_I(inode);
 	struct __track_dentry_update_args *dentry_update =
 		(struct __track_dentry_update_args *)arg;
-	struct dentry *dentry = dentry_update->dentry;
+	const struct dentry *dentry = dentry_update->dentry;
 	struct inode *dir = dentry->d_parent->d_inode;
 	struct super_block *sb = inode->i_sb;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
@@ -483,7 +483,7 @@ void ext4_fc_track_unlink(handle_t *handle, struct dentry *dentry)
 }
 
 void __ext4_fc_track_link(handle_t *handle,
-	struct inode *inode, struct dentry *dentry)
+	struct inode *inode, const struct dentry *dentry)
 {
 	struct __track_dentry_update_args args;
 	int ret;
@@ -1471,7 +1471,15 @@ static int ext4_fc_replay_link_internal(struct super_block *sb,
 		goto out;
 	}
 
+	ihold(inode);
+	inc_nlink(inode);
 	ret = __ext4_link(dir, inode, dentry_inode);
+	if (ret) {
+		drop_nlink(inode);
+		iput(inode);
+	} else {
+		d_instantiate(dentry_inode, inode);
+	}
 	/*
 	 * It's possible that link already existed since data blocks
 	 * for the dir in question got persisted before we crashed OR
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index c4b5e252af0e..80e1051cab44 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2353,7 +2353,7 @@ static int make_indexed_dir(handle_t *handle, struct ext4_filename *fname,
  * may not sleep between calling this and putting something into
  * the entry, as someone else might have used it while you slept.
  */
-static int ext4_add_entry(handle_t *handle, struct dentry *dentry,
+static int ext4_add_entry(handle_t *handle, const struct dentry *dentry,
 			  struct inode *inode)
 {
 	struct inode *dir = d_inode(dentry->d_parent);
@@ -3445,7 +3445,7 @@ static int ext4_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	return err;
 }
 
-int __ext4_link(struct inode *dir, struct inode *inode, struct dentry *dentry)
+int __ext4_link(struct inode *dir, struct inode *inode, const struct dentry *dentry)
 {
 	handle_t *handle;
 	int err, retries = 0;
@@ -3460,8 +3460,6 @@ int __ext4_link(struct inode *dir, struct inode *inode, struct dentry *dentry)
 		ext4_handle_sync(handle);
 
 	inode_set_ctime_current(inode);
-	ext4_inc_count(inode);
-	ihold(inode);
 
 	err = ext4_add_entry(handle, dentry, inode);
 	if (!err) {
@@ -3471,11 +3469,7 @@ int __ext4_link(struct inode *dir, struct inode *inode, struct dentry *dentry)
 		 */
 		if (inode->i_nlink == 1)
 			ext4_orphan_del(handle, inode);
-		d_instantiate(dentry, inode);
-		ext4_fc_track_link(handle, dentry);
-	} else {
-		drop_nlink(inode);
-		iput(inode);
+		__ext4_fc_track_link(handle, inode, dentry);
 	}
 	ext4_journal_stop(handle);
 	if (err == -ENOSPC && ext4_should_retry_alloc(dir->i_sb, &retries))
@@ -3504,7 +3498,16 @@ static int ext4_link(struct dentry *old_dentry,
 	err = dquot_initialize(dir);
 	if (err)
 		return err;
-	return __ext4_link(dir, inode, dentry);
+	ihold(inode);
+	ext4_inc_count(inode);
+	err = __ext4_link(dir, inode, dentry);
+	if (err) {
+		drop_nlink(inode);
+		iput(inode);
+	} else {
+		d_instantiate(dentry, inode);
+	}
+	return err;
 }
 
 /*
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index a97eb151d9db..3b12577ddfbb 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -600,7 +600,7 @@ struct name_snapshot {
 	struct qstr name;
 	union shortname_store inline_name;
 };
-void take_dentry_name_snapshot(struct name_snapshot *, struct dentry *);
+void take_dentry_name_snapshot(struct name_snapshot *, const struct dentry *);
 void release_dentry_name_snapshot(struct name_snapshot *);
 
 static inline struct dentry *d_first_child(const struct dentry *dentry)
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index a3e8fe414df8..efcf1018c208 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -2870,7 +2870,7 @@ TRACE_EVENT(ext4_fc_stats,
 DECLARE_EVENT_CLASS(ext4_fc_track_dentry,
 
 	TP_PROTO(handle_t *handle, struct inode *inode,
-		 struct dentry *dentry, int ret),
+		 const struct dentry *dentry, int ret),
 
 	TP_ARGS(handle, inode, dentry, ret),
 
@@ -2902,7 +2902,7 @@ DECLARE_EVENT_CLASS(ext4_fc_track_dentry,
 #define DEFINE_EVENT_CLASS_DENTRY(__type)				\
 DEFINE_EVENT(ext4_fc_track_dentry, ext4_fc_track_##__type,		\
 	TP_PROTO(handle_t *handle, struct inode *inode,			\
-		 struct dentry *dentry, int ret),			\
+		 const struct dentry *dentry, int ret),			\
 	TP_ARGS(handle, inode, dentry, ret)				\
 )
 
-- 
2.50.0.107.gf914562f5916.dirty


