Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72805CA5FA1
	for <linux-um@archiver.kernel.org>; Tue, 29 Sep 2026 03:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i1h0p2e7++gwnGP3KptyQMr+okjQyilzEhg1TYCoO3w=; b=jU5MxPkv8U74DeVoo9b1YmbibA
	6ydvJ8wqdaCZQX8n+UrWVVR4sbadbc8MpvomK0vY71qTmg+QLw06ga8WV0Nk7HnJ5z2erhjITBgUQ
	nzwgF5BfXzdYEJxedILInRNuJy2YWcNvK9PIRgMlkJiKYDNycT6RkP3yk8uuG8CBN+yEyaOhUqB9U
	M+Wn13Thu0msUrf8w+joF4j9AT1Av2poCcLkQIP6GFQ6xjXHTRYOvVstv64hSOQut1BRKVprlMqbF
	quuLgNOPNhpHYTObkZqckx3NreDnhfpx/WEle9DuNbHigsuJD4jsq0Ic6Fn8HQCRYYGwV8xXRCb68
	8GyegR0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBOkq-00000002FtE-0g9T;
	Tue, 29 Sep 2026 03:43:44 +0000
Received: from flow-b2-smtp.messagingengine.com ([202.12.124.137])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBOko-00000002Fsn-0KYc
	for linux-um@lists.infradead.org;
	Tue, 29 Sep 2026 03:43:43 +0000
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailflow.stl.internal (Postfix) with ESMTP id CE76D1301955;
	Mon, 28 Sep 2026 23:43:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 28 Sep 2026 23:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1790653420;
	 x=1790660620; bh=i1h0p2e7++gwnGP3KptyQMr+okjQyilzEhg1TYCoO3w=; b=
	ENz0LQ8UiLytL9lxt2KLIu/JNlkCZgQg5KbWdIfShIfvXN4eiMi1oOV6uaWVsSaw
	7q0g0qWVASWqp4Yp/KTNwfQSA3h0cOHcxTz7RyjwNqlGWiUDJS1GAgPSrb/wBHGr
	mTqKik/rvyE6Hjkq8mF3ayKb86dVK9xrmyD0R3lcUVEx5T3eBsinJANz3c0kf7Rb
	FSliw6iT0xXXrPOMxToToJmFmN4706WbEaG6FbJoRwBeO4d5eFLKGG1WwVcsgyOS
	uN4pfVfZnL76h+QN3GdfFkhZ/+BiUmW21ulm2Lh/C18UpTMU6B+8wnp1O1BdwZai
	Sb735Bd6K7Se9wZQuV5xMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790653420; x=1790660620; bh=i
	1h0p2e7++gwnGP3KptyQMr+okjQyilzEhg1TYCoO3w=; b=MBqEHp1DGEc92QRHP
	mEyLf8MBy8u3uSRt3Wmm+6ljMc7tpYqKju8ufrZIGS+2Px2FyF4z7y26rzlGHscV
	k1/VNf13ydunNphWNAmABkXMi/SNk4WObEZ+b00Sz30BCH1klrtbI0tD9soHaXmf
	8Czb81FkK/uNcQC8GR8QPkP312sJ1JeV/UF5em3yLmpuDlcY+0MdGgU1Wm1PBnKg
	mGEnrOmWrDJnPCmGZs/NJzu3btV7Fpm3Vobj5ZhQTNxmtdHKGfcD5GXjiSsju0ie
	OQ/x1gn/JgFiqHKD5OciQ+DhV9qQ8etMRbmzDxv5adBXTzdTzjjWm+m5SRlMIrI+
	Hfwgg==
X-ME-Sender: <xms:7DO7ahHAZEi-pepqf3MJNQOw2CubXU7pOlpQaONtAIRVr5bea8Npmw>
    <xme:7DO7apQrIjW9l1JqUMAmP4g9Y8kLQs7y-vdFmmvloyjV-UnJgi6cTnBnO7URAFUxB
    sW_usVk5FHdbcnZEx04GtjLwvPqVhCNteVThQ9rPC68opAJTKQ>
X-ME-Received: <xmr:7DO7arXa6zMudk8WwOv8NgR-Aex29IvcHdFyOdbT5GB-bBril_20BQ2vFUchRBLOxBhxGFpWyjVlIUzWrSl0qLeRmzglQi0>
X-ME-Proxy-Cause: dmFkZTGoJB+17Zq7ThrEPjmxn4ZGYu519RzWwVi/88aejzKjstMboztaed73ef7D6avpE+
    +4ud1a3y7i3orjwLfnXoctNyz4isc8MlqqkCj9w/LgYTxltRiENCW6GCIqrBIGfd6BoOtn
    3U4T9DnMQq0t334tHmkLT0tBGbfhvTaaBwaOBKtxwtl6WpY46qwankbHLMumQlIvXZxJZX
    MK4M+NdZABlSsm1lFGpu8Zoavf0+po6/QQ3FmqOSdXOPNwreWLw4U6EONlQdAFPuoTNGlS
    rFYPmLdcGE1rV4M0fAMpJKofG+st3+8PfQ+b7I9sMwGW86B3jq8HWH1QNmIbUmtd6GqsrP
    W5DEzAjl8MzRdbpR2RjUySxpkFifkTYA4HtUzAozr33P7xxEhulDMO4Vuyht7+pxV2ybSP
    JYC5qfcc1bajC548ieTni/xNlOrLA0ulGdRzvMr5I5O/80no2OBjM2tO72eJ0ppQFNY3p4
    y223n3aGNuk7lcg29mHuvCm2DT0nk5zQvihiqGq72NwvikkdPZQzPIiU9sISkq+KAFQj1O
    lB1vaJ+/hD0gmX6ZdXcK6c+jU9+h7ARfmJ6jVckDlNQ3ui+02FwkiVqCHeucbEWrG2Slvb
    e+pvTNkLQO/+XqNqxqB4VQ6dsAUSeRjqoL7T48qDuKx9jFLdUe5vfDp/fA4A
X-ME-Proxy: <xmx:7DO7al5hwDNCW7TEj4z_Vz0XIzH8IWkZERl08e0c63_0yjxko1P89g>
    <xmx:7DO7amFG30MoCf0PW1RMMg0W51xjdLOvLLXN8GPq2Y5urMY1AQ-ckw>
    <xmx:7DO7ajQz5ffRarsm-qSyfp-XWWeOgNGZKKvgGnc3q9qMPPNq6WPNnw>
    <xmx:7DO7ajOiGGIJBon54IWtCwW3CvWFM9QSCs7GsV16xX5GDG8lKCIBFg>
    <xmx:7DO7amehbzF3LBUlRg2h5TxJyigFtAfQ2KW-F6-2xRNbYijnrA_WpSCk>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 23:43:32 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Breno Leitao <leitao@debian.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Jan Harkes <jaharkes@cs.cmu.edu>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Carlos Maiolino <cem@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-um@lists.infradead.org,
	codalist@coda.cs.cmu.edu,
	coda@cs.cmu.edu,
	linux-mm@kvack.org,
	ntfs@lists.linux.dev,
	linux-xfs@vger.kernel.org
Subject: [PATCH 7/7] ovl: stop using lookup_one() in ovl_iterate().
Date: Tue, 29 Sep 2026 13:36:07 +1000
Message-ID: <20260929034158.1455429-8-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260929034158.1455429-1-neilb@ownmail.net>
References: <20260929034158.1455429-1-neilb@ownmail.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_204342_211505_59710C72 
X-CRM114-Status: GOOD (  20.17  )
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

lookup_one() is expected to be removed as it does not fit well with
proposed changes to directory locking.
Specifically d_alloc_parallel() will be ordered outside of i_rwsem
and as iterate_shared() is called with i_rwsem held it is not safe
to call d_alloc_parallel().

We can instead call d_alloc_trylock() and then call the ->lookup, but
that can fail if there is a lookup attempt concurrent with the
readdir().

ovl cannot afford for the lookup to fail as that could produce incorrect
results, and it cannot safely drop i_rwsem temporarily as that could
introduce races with handling of the directory cache.

Instead we rely on the fact that ovl_iterate() has an exclusive lock on
the directory, so any concurrent lookup will wait for the ovl_iterate()
call to complete.  We allocate a separate dentry and if the lookup is
successful, it is hashed with the result.

When the concurrent lookup gets i_rwsem it mustn't do its own lookup -
it must use the existing dentry.  This is found, if it exists, using
try_lookup_noperm().

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/namei.c   | 12 ++++++++++++
 fs/overlayfs/readdir.c | 26 ++++++++++++++++++++++++--
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index ca899fdfaafd..f56e33fd4d6b 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -1385,6 +1385,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct ovl_entry *poe = OVL_E(dentry->d_parent);
 	bool check_redirect = (ovl_redirect_follow(ofs) || ofs->numdatalayer);
+	struct dentry *alias;
 	int err;
 	struct ovl_lookup_ctx ctx = {
 		.dentry = dentry,
@@ -1399,6 +1400,17 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	if (dentry->d_name.len > ofs->namelen)
 		return ERR_PTR(-ENAMETOOLONG);
 
+	/*
+	 * The existence of this in-lookup dentry might have forced
+	 * readdir to do the lookup with a new dentry.  If so we must
+	 * return that one.
+	 */
+	alias = try_lookup_noperm(&QSTR_LEN(dentry->d_name.name,
+					    dentry->d_name.len),
+				  dentry->d_parent);
+	if (alias && !IS_ERR(alias))
+		return alias;
+
 	with_ovl_creds(dentry->d_sb)
 		err = ovl_lookup_layers(&ctx, &d);
 
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index e7fe29cb6028..bc41da4bace8 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -574,8 +574,30 @@ static int ovl_cache_update(const struct path *path, struct ovl_cache_entry *p,
 		}
 	}
 	/* This checks also for xwhiteouts */
-	this = lookup_one(mnt_idmap(path->mnt), &QSTR_LEN(p->name, p->len), dir);
-	if (IS_ERR_OR_NULL(this) || !this->d_inode) {
+	this = d_alloc_trylock(dir, &QSTR_LEN(p->name, p->len));
+	if (this == ERR_PTR(-EWOULDBLOCK)) {
+		/*
+		 * Some other thread is looking up this name and will
+		 * block on i_rwsem before it can complete the lookup.
+		 * We will do the lookup in a new dentry and when that
+		 * lookup gets a turn it will find and return this
+		 * dentry.
+		 */
+		this = d_alloc_name(dir, p->name);
+		if (!this)
+			this = ERR_PTR(-ENOMEM);
+	}
+	if (!IS_ERR(this) && d_unhashed(this)) {
+		/* Either we got an in-lookup or we made our own unhashed */
+		struct dentry *alias = ovl_lookup(dir->d_inode, this, 0);
+
+		d_lookup_done(this);
+		if (alias) {
+			dput(this);
+			this = alias;
+		}
+	}
+	if (IS_ERR(this) || !this->d_inode) {
 		/* Mark a stale entry */
 		p->is_whiteout = true;
 		if (IS_ERR(this)) {
-- 
2.50.0.107.gf914562f5916.dirty


