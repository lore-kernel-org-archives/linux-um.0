Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1928B606A326
	for <linux-um@archiver.kernel.org>; Wed, 25 Nov 2026 03:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=DLEfSwX2;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=UXS7+lxA;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Ms9lWP08
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ZJj42sbdWeB/wLiTmyNjdZ8BVwwPFHh83C2++A0reDg=; b=DLEfSwX29WTeDgZgWjHx5U4OBk
	EYkyAmS7K9OMcG5is+kPl1HzqZlsxzDXFmRZu2Rkzx5yBGZksTAJPhB3ucT0Fs7qkYPfp79g2GJbh
	Fr4tlLqQzo5alf7CleowKqqbjv8nyJJMr1pE4AbUZOP2ELwsi92acYbgbcURigsrqIu0oCvV3OjY5
	yoX0qANCwPczBVeAoBkucshMfzI7/j3faB8fNBLRJ+qcFbzBlHbFXtxceW0Fd81oxe3f05s8pjSgS
	uROiaAmj6LZXXXu4Nuguo9I87FLU4qn4e58ulnjlPmufydGsLvCc+YPEMUWWpzlC4++iucMDvWxAr
	nqUSRu6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW3yH-00000008LbY-3TL3;
	Wed, 25 Nov 2026 03:47:01 +0000
Received: from fhigh-a2-smtp.messagingengine.com ([103.168.172.153])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW3yE-00000008LZb-1aRO
	for linux-um@lists.infradead.org;
	Wed, 25 Nov 2026 03:47:00 +0000
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 99F57140036E
	for <linux-um@lists.infradead.org>; Tue, 24 Nov 2026 22:46:57 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 24 Nov 2026 22:46:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1795578417;
	 x=1795664817; bh=ZJj42sbdWeB/wLiTmyNjdZ8BVwwPFHh83C2++A0reDg=; b=
	UXS7+lxA2gWzpwnXWJ/0DUPdLAmseAlhdb1N4fEFA0AzBjqGVjW6w960RQwEk4dt
	SaoSyfNlrLjcT1bqWukMtSSOIKyVfybXCZl9HY9w+c4jy2oLMUE9ltJkYR3WnBb1
	hipcMd2qL76w5eWPkAXmz0RgxGTOKMR3I4AgOD4oViagTDGwJ9+3Cu+NfKaiU4I9
	LUQCyroOmK8N26fsoJql/bfzJ/gXS4Uf3/EMGIb4fmYP2a4Hh7GFrV5Qw9YfHhnB
	7xzsRei4AnHVywy1oqZFp2ZebkmJZm++n0rd1Uw2/ZiWbdARuik3IyNSwF7uagq/
	IrD+U+qBi/YhZNX0jAlXvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1795578417; x=1795664817; bh=Z
	Jj42sbdWeB/wLiTmyNjdZ8BVwwPFHh83C2++A0reDg=; b=Ms9lWP08MTQLfhK9I
	Qn8mYgol/GVVMj8AZ1ViRbJnK2HnL/lN5WwDUsHB0ZzG4j8BRR33EILL6JCzBL+p
	zzsMIzPoCBzVdhR8O3r8bArMALljb2nrq+Tb2Xr5tFcbuFNReYFbKIh0DM60MukH
	YXpNazz4FD4oD3Vc+scCN0C1uA67v1UZOpGi1w+VpD5mJexhfQvgZUZQ4/2JC9zY
	jQtiWDYJf7xvUgb3RRR7P73Z2vpVZU5aVcrq1hHmcNR9ZEaEHveT7NIol8Z0yf/I
	KGJj4rvF3FuvP/0U9u4IMo9fubVaYfR+4EEq2+a6lpS7zgTmkbld5Kziw1nfuo/d
	0uHxw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795578417; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmc+;
	s=fm3:rsa-sha256:VBapPgr2izn5CWVYdz7byU+/JZ7wjTovNiskVVVWSyzve2B
	NJTHm2CDTF7MbLbqQKJ1E1ZYZePh4QdBC8RHnfU2FCdSvGYvPnUR1Ir7ZMcRfGwk
	+IZsE1E+EmMXDd9enCmToTmrNdSxcGsU241Sz9uijpnf0UYuqSKeCJXi70+wL46l
	u/lkHhrItwPIt8kpy0DJ5NeT1icGyZYQbxBHS6AyFcopioJ1nGx3BHtsTA5v3OFf
	zFItwqL39BN2tBgaeHKr4JEzu/ZVUBWzDYZ2YkjsYBeLcsZ1u8luf3J/7nJgjHGd
	tdle5OTqDrDH45ysgo1ZZq2hPJhqrcNCY0Bt4OQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to;
Message-Instance: m=1; h=sha256:20zyX+aJVxI6AdffA4cfGs+HiNU58mrbjTUKFbNNm2E=:GXqxxZ4nCPcItWLOjAOkRMljcoG+dv30mbjjfSpSE9k=;
X-ME-Sender: <xms:MVoGa9UT3ReJzgDm5mJCOWmgwj2XS1DwMjv6wScah8A4RNa7NuTkkQ>
    <xme:MVoGa0gtMtwQcyIZzskWsstVyR8Z9lNfmKrMguUzhgHM52bZF3VKAEs9OB-EBmYai
    aFS81Odg-LVZaioewKRZHbqnPnOtcWiOydpxcNz7oJVh1p9cg4>
X-ME-Received: <xmr:MVoGa-dJW7bs-11limHQgtdWvM0GDZiC0G5w1swfm8UWxKx37nuJ9M694ZaIyC2LI8gfADQzL_PsVoibTbk2RTbCj3NE2uo>
X-ME-Proxy-Cause: dmFkZTFR427OSMpMhBUq2c/PRD6RmqRpXHsHavEQEoZib45veoj0ON4Fee0fFpAMf6IRZD
    7ioshD0AaEWr7quPZ3VJk4MkgPxfK4VajmEfAasmF1N4QuQ1Nx4fAT27aU1zZmPYaReDqx
    rfP5UHReFgze/pUM1YUaeJAgJLGWSi2iJU/qcqRk+B4M1TsPMqQDofdX/Jn7SjcVJvCtNm
    zdB65WAuETFQQDYBDZIOHXvboBphMIm2vyy1TKs+e7zZqPSqTzzCVyEWo2arAfhj68hGFx
    kBzHUYnaQIV/eTYhsd/MgvSt0+AvaXUSwYNCdWWq7bBlwHpxfTlmsOfayzrTTRF9w5P7PC
    SeV47q2FuIOfIZMVMhjQJ/dV/n+UX7M13OfpguGdXETZW7FLzQD+0u8vOwdyWIeG/Rqfjj
    ldiwC3mEq+O4w6xJoCtCeoRdzm+TdpYlWciZU3Zr/spSi9hCkb2asl/hDkxdr/iBGpaEVc
    Wgjnk7v4NkGAHlXWLVLtVocs6pAuXej1OcPShJyoiefm39JjmByC7698NkQXBXMiK2UQBS
    b4VQwlpkDfgY4xj3/1Iu6AX+P4PEPegy0xCfQZo19Lh7HHwW3ATKqVwoxYXEs2EdjHUKNe
    BToL94ArJdkyJ35bnFMG0/y9neOegnqPekF7/+9nsevG0ndRJcVZ1HC4j9Uw
X-ME-Proxy: <xmx:MVoGa3c57kDACDFsxCkBg-qlZlZt_91HC9yabde746SqbBhsQsn3Ng>
    <xmx:MVoGayVWIvPmv-mcbj9goU5U7ww_0gj9iKrOhk5h4zN3894or7pH_w>
    <xmx:MVoGazfD8VsFGaOqfFkVzQG-xJYpixl1vVKq90dZ_orFPEE_IwKmJA>
    <xmx:MVoGa-_QUzdS0ek1aNZ4XXiw6p_2N3eJF5CG0dH6aBwsAN7v5WuGUQ>
    <xmx:MVoGayDbV5vJzu94SozIPPVYMOQQIzeqf0IYhjiRr_MCXHpvYz71KVXJ>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 22:46:52 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jan Harkes <jaharkes@cs.cmu.edu>,
	coda@cs.cmu.edu,
	Jan Kara <jack@suse.cz>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	linux-kernel@vger.kernel.org,
	codalist@coda.cs.cmu.edu,
	linux-fsdevel@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-afs@lists.infradead.org
Subject: [PATCH v3 08/11] VFS: use d_alloc_parallel() in lookup_one_qstr_excl().
Date: Wed, 25 Nov 2026 14:16:46 +1100
Message-ID: <20261125034543.4084039-9-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20261125034543.4084039-1-neilb@ownmail.net>
References: <20261125034543.4084039-1-neilb@ownmail.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_194658_482972_D6432629 
X-CRM114-Status: GOOD (  28.35  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Reply-To: NeilBrown <neil@brown.name>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: NeilBrown <neil@brown.name>

lookup_one_qstr_excl() is used for lookups prior to directory
modifications (other than open(O_CREATE)), whether create, remove,
or rename.

A future patch will lift lookup out of the i_rwsem lock that protects
the directory during these operations (only taking a shared lock if the
target name is not yet in the dcache).

To prepare for this change and particularly to allow lookup to
always be done outside the parent i_rwsem, change lookup_one_qstr_excl()
to use d_alloc_parallel().

For the target of create and rename some filesystems skip the
preliminary lookup and combine it with the main operation.  This is only
safe if the operation has exclusive access to the dentry.  Currently
this is guaranteed by an exclusive lock on the directory.
d_alloc_parallel() provides alternate exclusive access (in the case
where the name isn't in the dcache and ->lookup will be called).

As a result of this change, ->lookup is now only ever called with a
d_in_lookup() dentry.  Consequently we can remove the d_in_lookup()
check from d_add_ci() which is only used in ->lookup.

The caller must now ensure d_lookup_done() is called at an appropriate
time, and must not assume that it can test for positive or negative
dentries without confirming that the dentry is no longer d_in_lookup() -
unless it is filesystem code acting on itself and *knows* that
->lookup() always completes the lookup (currently true for all
filesystems other than NFS).  This is all handled in start_creating()
and end_dirop() and friends.
At present only LOOKUP_EXCL and LOOKUP_RENAME_TARGET might result in
an in-lookup dentry after a successful ->lookup, but that might change.

Note that as lookup_one_qstr_excl() is called with an exclusive lock on
the directory, d_alloc_parallel() cannot race with another thread and
cannot return a non-in-lookup dentry.  However that is expected to
change so that case is handled with this patch.

As mentioned, with this change it is safe for d_alloc_parallel() to be
called without holding ->i_rwsem on the parent.  This holds providing
that any filesystem which uses d_alloc() or d_alloc_name() and then
instantiates the dentry, only does so in a context where ->lookup cannot
instantiate a (positive) dentry with the same name without relying
on ->i_rwsem.
This is already the case. e.g.
 - some filesystem use simple_lookup which only instantiates negative
   dentry.  A race with d_alloc() will mean the negative entry added with
   simple_lookup() will be later in the hash chain and so never found.
 - some filesystems only use d_alloc() during fs creation, before
   ->lookup is possible.

Signed-off-by: NeilBrown <neil@brown.name>
---
 Documentation/filesystems/porting.rst | 14 ++++++++++
 fs/dcache.c                           | 16 +++---------
 fs/namei.c                            | 37 +++++++++++++++++++--------
 3 files changed, 45 insertions(+), 22 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index e41466904501..78df8842bddb 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1422,3 +1422,17 @@ helpers take a ``const struct mnt_idmap *``. mnt_idmap() and file_mnt_idmap()
 return one. The idmapping is immutable so nothing should have modified it
 anyway. References are taken and dropped via mnt_idmap_get() and
 mnt_idmap_put() as before, both accept a const pointer.
+
+---
+
+**mandatory**
+
+All start_creating and start_renaming functions may return a
+d_in_lookup() dentry.  end_dirop() calls the necessary d_lookup_done().
+If the caller *knows* which filesystem is being used, it may know that
+this is not possible.  Otherwise it must be careful testing if the
+dentry is positive or negative as the lookup may not have been performed
+yet.
+
+inode_operations.lookup() is now only ever called with a d_in_lookup()
+dentry.
diff --git a/fs/dcache.c b/fs/dcache.c
index ba17f49f8a63..2ad39c1515b7 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2472,18 +2472,10 @@ struct dentry *d_add_ci(struct dentry *dentry, struct inode *inode,
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
index 6d63a4c08495..cfd37044a516 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1785,13 +1785,13 @@ static struct dentry *lookup_dcache(const struct qstr *name,
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
+ * d_lookup_done() must be called before the dentry is dput().
+ * If the dentry is not d_in_lookup():
+ *   Will return -ENOENT if name isn't found and LOOKUP_CREATE wasn't passed.
+ *   Will return -EEXIST if name is found and LOOKUP_EXCL was passed.
+ * If it is d_in_lookup() then these conditions can only be checked by the
+ * file system when carrying out the intent (create or rename).
  */
 static struct dentry *lookup_one_qstr_excl(const struct qstr *name,
 					   struct dentry *base, unsigned int flags)
@@ -1809,14 +1809,24 @@ static struct dentry *lookup_one_qstr_excl(const struct qstr *name,
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
+	} else if (d_in_lookup(dentry)) {
+		/* We cannot check for errors resulting from LOOKUP_ flags.
+		 * The caller will have to wait for any create-etc attempt
+		 * to get relevant errors.
+		 */
+		return dentry;
 	}
 found:
 	if (IS_ERR(dentry))
@@ -2938,6 +2948,7 @@ static struct dentry *__start_dirop(struct dentry *parent, struct qstr *name,
  * The lookup is performed and necessary locks are taken so that, on success,
  * the returned dentry can be operated on safely.
  * The qstr must already have the hash value calculated.
+ * The dentry may be d_in_lookup().
  *
  * Returns: a locked dentry, or an error.
  *
@@ -2959,6 +2970,7 @@ void end_dirop(struct dentry *de)
 {
 	if (!IS_ERR(de)) {
 		inode_unlock(de->d_parent->d_inode);
+		d_lookup_done(de);
 		dput(de);
 	}
 }
@@ -3918,8 +3930,10 @@ __start_renaming(struct renamedata *rd, int lookup_flags,
 	return 0;
 
 out_dput_d2:
+	d_lookup_done(d2);
 	dput(d2);
 out_dput_d1:
+	d_lookup_done(d1);
 	dput(d1);
 out_unlock:
 	unlock_rename(rd->old_parent, rd->new_parent);
@@ -4014,6 +4028,7 @@ __start_renaming_dentry(struct renamedata *rd, int lookup_flags,
 	return 0;
 
 out_dput_d2:
+	d_lookup_done(d2);
 	dput(d2);
 out_unlock:
 	unlock_rename(old_dentry->d_parent, rd->new_parent);
@@ -4123,6 +4138,8 @@ EXPORT_SYMBOL(start_renaming_two_dentries);
 
 void end_renaming(struct renamedata *rd)
 {
+	d_lookup_done(rd->old_dentry);
+	d_lookup_done(rd->new_dentry);
 	unlock_rename(rd->old_parent, rd->new_parent);
 	dput(rd->old_dentry);
 	dput(rd->new_dentry);
-- 
2.50.0.107.gf914562f5916.dirty


