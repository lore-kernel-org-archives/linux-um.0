Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34108106ACEA
	for <linux-um@archiver.kernel.org>; Thu, 12 Mar 2026 21:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jtoJ4VcsB5KJ5RIkAzW9fPn73bKnKljRG2pvIdddt9Y=; b=XRqR+vzHRU+ueDFPX01yPKWjRz
	g+AIzxdNyuSjQqHGSjZks0Z/fzcENWEY8EobrpF6fTpIRi2UDWEV7OWjofHiM49C1jkX5JGt3bVbK
	/ykcu2j3qtaUbRLOqjYqLPANleHp3/8lrW7Vy2EtXsmhjr/Fvk0fOgBZk2JdZWrTV144ihAgONln4
	siq+rvxKARGwarbjvKjooAF/ifkgx6eCiJEdsIPIVn3Wzib9K2CN8LUt4tu132e9rzbgpeX22XfCq
	a/BwXs0z/JZ1BpxBTIqAjLHQpw3HEm1mxPbPbrRIdWLQ0KxtRGkd6aw/7y0wPNeqaccXOu6Fb/+77
	D8z6PAig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0nrB-0000000FWSt-3ugR;
	Thu, 12 Mar 2026 21:46:13 +0000
Received: from flow-b6-smtp.messagingengine.com ([202.12.124.141])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0nrA-0000000FWSG-1My8;
	Thu, 12 Mar 2026 21:46:13 +0000
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 5A0321301B47;
	Thu, 12 Mar 2026 17:46:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 12 Mar 2026 17:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773351970;
	 x=1773359170; bh=jtoJ4VcsB5KJ5RIkAzW9fPn73bKnKljRG2pvIdddt9Y=; b=
	WQJKthP0rTsiI3RJocxIH3ZvletwK+s1SspQgny4TfWHov2isTsHrUD4GI2x+h1N
	0Uz3Ba5LJCq/zK5+RzsV2iv55k10jF6H59khluBI7mUd+MOoaLyvYsOhfvQyAgVj
	zeCrNgqGyjwp2B+tZiItl7z8gshz0/F73xa/PNbn+IQTYiY1gr32QdTX2H7Hrw8C
	v2ChvnkqOxTcfxmT5LfOrub5UMwIcDz/kXudaMUhKmneYYSQME5b3zRy6VW9u4BV
	BlEmUX20QekaXZmvDj12T54B2/nh09aPaUIx5wAGpvwz5mHzIyUWvw8oh5jS9w89
	3hHbH6QXcFcOR/CylE4G0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773351970; x=1773359170; bh=j
	toJ4VcsB5KJ5RIkAzW9fPn73bKnKljRG2pvIdddt9Y=; b=XqN3zbVrMt4Dgh7Xe
	Hu9v4x7EFwXrTqUlq7pGIydeYfW4eXt0t2LewIJtqvHwWZQ5vpf0H+vKOJahySNe
	ly4TeGTRFpEdg/6Bv1bvNAezzqcp4yK98kxJn0+LkZSH866Fp88T0OTZeguLrslq
	EB4fcaD5sgj2UJILJgyCfYX/ohZjgN0WVfx80rKtOk7DvlXiIkfOuPyQGuLjcU4H
	pDO9Y3ljMvqWBzqQn1SL9Y6COsNusqrqWpN1JDr8F03oMSpiF1GNMBuemKgFrzkT
	RRG6Wqns755H7VAlLA4g0/2gE5Qy5zY4Nr0+UjY2OTfoBIPRyHZ78Gkm+MTFasH4
	5PU+A==
X-ME-Sender: <xms:ITSzaQ4pY_0jtsHXvlqaq52HJb1z0X7E7CkZq8dy8zsPlwNoc3Gqeg>
    <xme:ITSzabkcVe0JUcHeok5KbioIqyE3al7k3tCaJwicmZULtfa1_4bpZccINCUeYRgo4
    zHl0uu5Jim5XkwrZLjSBmYE0OpfIyANBFgqI-lmUlZzBrPmoH4>
X-ME-Received: <xmr:ITSzaWZQEClEFlio7Df-y_-DmOCtEHIHLcMqkux5Cd7R_JVP7Ob5eyt19149uCnegWhR4Z0NnAetfnC2uM8vqeAywVcex3P2F5GYZhVmygqZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejledtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:ITSzaZP8bVpwXLqIb7hWFwes0aW8pzwPW_V-gqKxOsmAP1lWVK7poA>
    <xmx:ITSzaTgkdzCy15vasYJDF7DwWJVLFeRVt48mMQvGr2deUf13TgFlzA>
    <xmx:ITSzaVMU7QeDOZpp8wk33ZN5C1At4W4ljVX7aV625qZD0C0izznVXQ>
    <xmx:ITSzaToQBbJoPsQONFD_ASOvApA3Uk4CWwpUgux63V9yoUqDnryolg>
    <xmx:IjSzaSIUSoFNyMfOWAZMKBH7tmmRcNGbdxIO4qgzqRat9kzPFUQ86ivf>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 17:45:56 -0400 (EDT)
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
Subject: [PATCH 06/53] VFS: add d_duplicate()
Date: Fri, 13 Mar 2026 08:11:53 +1100
Message-ID: <20260312214330.3885211-7-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260312214330.3885211-1-neilb@ownmail.net>
References: <20260312214330.3885211-1-neilb@ownmail.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_144612_474409_B545C24A 
X-CRM114-Status: GOOD (  22.92  )
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

Occasionally a single operation can require two sub-operations on the
same name, and it is important that a d_alloc_parallel() (once that can
be run unlocked) does not create another dentry with the same name
between the operations.

Two examples:
1/ rename where the target name (a positive dentry) needs to be
  "silly-renamed" to a temporary name so it will remain available on the
  server (NFS and AFS).  Here the same name needs to be the subject
  of one rename, and the target of another.
2/ rename where the subject needs to be replaced with a white-out
  (shmemfs).  Here the same name need to be the target of a rename
  and the target of a mknod()

In both cases the original dentry is renamed to something else, and a
replacement is instantiated, possibly as the target of d_move(), possibly
by d_instantiate().

Currently d_alloc() is used to create the dentry and the exclusive lock
on the parent ensures no other dentry is created.  When
d_alloc_parallel() is moved out of the parent lock, this will no longer
be sufficient.  In particular if the original is renamed away before the
new is instantiated, there is a window where d_alloc_parallel() could
create another name.  "silly-rename" does work in this order.  shmemfs
whiteout doesn't open this hole but is essentially the same pattern and
should use the same approach.

The new d_duplicate() creates an in-lookup dentry with the same name as
the original dentry, which must be hashed.  There is no need to check if
an in-lookup dentry exists with the same name as d_alloc_parallel() will
never try add one while the hashed dentry exists.  Once the new
in-lookup is created, d_alloc_parallel() will find it and wait for it to
complete, then use it.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/dcache.c            | 52 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/dcache.h |  1 +
 2 files changed, 53 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index f4d7d200bc46..c12319097d6e 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1832,6 +1832,58 @@ struct dentry *d_alloc(struct dentry * parent, const struct qstr *name)
 }
 EXPORT_SYMBOL(d_alloc);
 
+/**
+ * d_duplicate: duplicate a dentry for combined atomic operation
+ * @dentry: the dentry to duplicate
+ *
+ * Some rename operations need to be combined with another operation
+ * inside the filesystem.
+ * 1/ A cluster filesystem when renaming to an in-use file might need to
+ *   first "silly-rename" that target out of the way before the main rename
+ * 2/ A filesystem that supports white-out might want to create a whiteout
+ *   in place of the file being moved.
+ *
+ * For this they need two dentries which temporarily have the same name,
+ * before one is renamed.  d_duplicate() provides for this.  Given a
+ * positive hashed dentry, it creates a second in-lookup dentry.
+ * Because the original dentry exists, no other thread will try to
+ * create an in-lookup dentry, os there can be no race in this create.
+ *
+ * The caller should d_move() the original to a new name, often via a
+ * rename request, and should call d_lookup_done() on the newly created
+ * dentry.  If the new is instantiated and the old MUST either be moved
+ * or dropped.
+ *
+ * Parent must be locked.
+ *
+ * Returns: an in-lookup dentry, or an error.
+ */
+struct dentry *d_duplicate(struct dentry *dentry)
+{
+	unsigned int hash = dentry->d_name.hash;
+	struct dentry *parent = dentry->d_parent;
+	struct hlist_bl_head *b = in_lookup_hash(parent, hash);
+	struct dentry *new = __d_alloc(parent->d_sb, &dentry->d_name);
+
+	if (unlikely(!new))
+		return ERR_PTR(-ENOMEM);
+
+	new->d_flags |= DCACHE_PAR_LOOKUP;
+	new->d_wait = NULL;
+	spin_lock(&parent->d_lock);
+	new->d_parent = dget_dlock(parent);
+	hlist_add_head(&new->d_sib, &parent->d_children);
+	if (parent->d_flags & DCACHE_DISCONNECTED)
+		new->d_flags |= DCACHE_DISCONNECTED;
+	spin_unlock(&dentry->d_parent->d_lock);
+
+	hlist_bl_lock(b);
+	hlist_bl_add_head(&new->d_u.d_in_lookup_hash, b);
+	hlist_bl_unlock(b);
+	return new;
+}
+EXPORT_SYMBOL(d_duplicate);
+
 struct dentry *d_alloc_anon(struct super_block *sb)
 {
 	return __d_alloc(sb, NULL);
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 3cb70b3398f0..2a3ebd368ed9 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -247,6 +247,7 @@ extern struct dentry * d_alloc_anon(struct super_block *);
 extern struct dentry * d_alloc_parallel(struct dentry *, const struct qstr *);
 extern struct dentry * d_alloc_noblock(struct dentry *, struct qstr *);
 extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
+struct dentry *d_duplicate(struct dentry *dentry);
 /* weird procfs mess; *NOT* exported */
 extern struct dentry * d_splice_alias_ops(struct inode *, struct dentry *,
 					  const struct dentry_operations *);
-- 
2.50.0.107.gf914562f5916.dirty


