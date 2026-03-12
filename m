Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25BD2106ACEC
	for <linux-um@archiver.kernel.org>; Thu, 12 Mar 2026 21:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4WJg8BesAO2r3vZCyn8Qj6EvQOGiM+109I5YGqS1b9I=; b=H0VWtAnertw+6mRTHVASWVzag5
	AFPp2ctwuFHvcJpJI1QccafRXI2UZ4Mk0OK0/F5lnzJNHkMjOG8fUnEB00JfkMMK4K/svBNFo+lJv
	iB6nMuMgWwC1vqA3WuFo8QrfAnfwHTaEjrMJzSQwudupgAj61H7Ao8Sbr5EFWCSwmHgMDRJJ1YORC
	hkwdWNggrmHLloN55bfwq66MqV1V4SAz3mBKc4E4UFpQuP88IYVHWzMhv1vp0O9JLlTHtmLrH6Ejq
	Pu+Ocuomqb/U/M4uatQ5Inq+M/oam3P90HTvYlE8NChZCMHsjIOqGtNX4Lmo57vzcstg8Vw2WE0ws
	I+tW9aRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0nrk-0000000FWeI-3jvz;
	Thu, 12 Mar 2026 21:46:48 +0000
Received: from flow-b6-smtp.messagingengine.com ([202.12.124.141])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0nri-0000000FWdA-0rcF;
	Thu, 12 Mar 2026 21:46:47 +0000
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id 293E41300F6C;
	Thu, 12 Mar 2026 17:46:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 12 Mar 2026 17:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773352004;
	 x=1773359204; bh=4WJg8BesAO2r3vZCyn8Qj6EvQOGiM+109I5YGqS1b9I=; b=
	SerCWqLIgdWRLB6BFLBdqn2eI+vI5/t4G8+IU7QLeE8wYOrdHBw5HU694Zz4gf3W
	M6tCB5+ksA0SG/bjn4x5w9+oyXipICRWoxM0ehBTavuD1xt02fz2Jdhcbs1AqGB1
	xcXbISL1jLJEABmTYnW/lMs2oqr2ta/3BNNWvrocKOn9gK+6mf47WNMrpBl592kJ
	FzscqO6u6qq4PnC9NiqFVwTPOrfVhOWBGK14bw6NESRrWKqV7Dl4Dco4/LE+hFbo
	HixqPSoOkkx2VI5A/uT1KJd7g0Oc5t/uavVuNubv5KUOz1eH1PyEG3UIsGNvyorv
	2b/dfxvPTHpC0RdBiGo00g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773352004; x=1773359204; bh=4
	WJg8BesAO2r3vZCyn8Qj6EvQOGiM+109I5YGqS1b9I=; b=bz1e/OlnsMyj6akRb
	IxeYS9L2jvkQo8W89blCf+xp6yfqMO3SMeerllq7Ios+b+V5zIhfXemg6fgMmsA7
	7ncn1BKA1nPjv9DXPEyTjhjjPbyzrQyvwa8Z4FIdur7w0pFW/P7SpKZQC1bNqVjG
	SQJ0LVU3ABw9muOjKVl8UHKkptWCo66BsQtjh8/a3tjtMpHJh3m3w6A/vrLCKGHr
	Jdm/2cEgZFqV81SboGMySRQNjqSXtpMWuMHpMv+gnZ+/tGg6J8nD3annX4j4KTaR
	/8dnRk1YiNlPOc2j5fyVdgnPf2yKQJ48BLw6M2c1qifsRF7kXNb3OXfFmGkRd5M/
	CdYig==
X-ME-Sender: <xms:QzSzae-_RUJ_LKPLY7mTewAt03A9YptxJHuSuQh6s8V5C963Umhc5g>
    <xme:QzSzaSYtFquQUsIXw34mTZMPK68O3unTDICtNAsOTtaTjgJBV9ne7dzdLLwm4iHMD
    nAag40mLhUJDzkqTeSs1EbAWXE_Iv3YEgye_MqkYzeH_0JLyg>
X-ME-Received: <xmr:QzSzafFqW05biJiriNkrPeJzdA72U4phWYPTkM_iqNiw4h1VTOa1Y7AJabIMIMN9QcRiToQNYKh0zkj3B26JHpQC8Pn8EAq1lCNUKFiRSzAG>
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
X-ME-Proxy: <xmx:QzSzaT7upc63WACrikUPcBWBCgsP_sRT-FWHYJea2_6zxpV1hC2ESA>
    <xmx:QzSzaYtBEhpWJVTEZrCewe5RuYo_PChA-ijEHPGqS2typBwFVUlitQ>
    <xmx:QzSzadBR_wPJIKcv4DNN4povDMSTO_zB-Bfw0w7J21L3Uqn7KDQY4w>
    <xmx:QzSzaQsO_0k-M4QIiH9Pfs2OdTOZ-CXVfoXnRl2Bt2Pbkhmo6mzdxQ>
    <xmx:RDSzaQgf2GkDuAkTHdg5V2lbXPP1GGvaWrpMh7oNhgYYYnYWDVESZTtS>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 17:46:30 -0400 (EDT)
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
Subject: [PATCH 08/53] VFS/xfs: drop parent lock across d_alloc_parallel() in d_add_ci()
Date: Fri, 13 Mar 2026 08:11:55 +1100
Message-ID: <20260312214330.3885211-9-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260312214330.3885211-1-neilb@ownmail.net>
References: <20260312214330.3885211-1-neilb@ownmail.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_144646_310885_E812B83A 
X-CRM114-Status: GOOD (  17.29  )
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

A proposed change will invert the lock ordering between
d_alloc_parallel() and inode_lock() on the parent.
When that happens it will not be safe to call d_alloc_parallel() while
holding the parent lock - even shared.

We don't need to keep the parent lock held when d_add_ci() is run - the
VFS doesn't need it as dentry is exclusively held due to
DCACHE_PAR_LOOKUP and the filesystem has finished its work.

So drop and reclaim the lock (shared or exclusive as determined by
LOOKUP_SHARED) to avoid future deadlock.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/dcache.c            | 18 +++++++++++++++++-
 fs/xfs/xfs_iops.c      |  3 ++-
 include/linux/dcache.h |  3 ++-
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index c12319097d6e..a1219b446b74 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2225,6 +2225,7 @@ EXPORT_SYMBOL(d_obtain_root);
  * @dentry: the negative dentry that was passed to the parent's lookup func
  * @inode:  the inode case-insensitive lookup has found
  * @name:   the case-exact name to be associated with the returned dentry
+ * @bool:   %true if lookup was performed with LOOKUP_SHARED
  *
  * This is to avoid filling the dcache with case-insensitive names to the
  * same inode, only the actual correct case is stored in the dcache for
@@ -2237,7 +2238,7 @@ EXPORT_SYMBOL(d_obtain_root);
  * the exact case, and return the spliced entry.
  */
 struct dentry *d_add_ci(struct dentry *dentry, struct inode *inode,
-			struct qstr *name)
+			struct qstr *name, bool shared)
 {
 	struct dentry *found, *res;
 
@@ -2250,6 +2251,17 @@ struct dentry *d_add_ci(struct dentry *dentry, struct inode *inode,
 		iput(inode);
 		return found;
 	}
+	/*
+	 * We are holding parent lock and so don't want to wait for a
+	 * d_in_lookup() dentry.  We can safely drop the parent lock and
+	 * reclaim it as we have exclusive access to dentry as it is
+	 * d_in_lookup() (so ->d_parent is stable) and we are near the
+	 * end ->lookup() and will shortly drop the lock anyway.
+	 */
+	if (shared)
+		inode_unlock_shared(d_inode(dentry->d_parent));
+	else
+		inode_unlock(d_inode(dentry->d_parent));
 	if (d_in_lookup(dentry)) {
 		found = d_alloc_parallel(dentry->d_parent, name);
 		if (IS_ERR(found) || !d_in_lookup(found)) {
@@ -2263,6 +2275,10 @@ struct dentry *d_add_ci(struct dentry *dentry, struct inode *inode,
 			return ERR_PTR(-ENOMEM);
 		}
 	}
+	if (shared)
+		inode_lock_shared(d_inode(dentry->d_parent));
+	else
+		inode_lock_nested(d_inode(dentry->d_parent), I_MUTEX_PARENT);
 	res = d_splice_alias(inode, found);
 	if (res) {
 		d_lookup_done(found);
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 208543e57eda..ec19d3ec7cf0 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -35,6 +35,7 @@
 #include <linux/security.h>
 #include <linux/iversion.h>
 #include <linux/fiemap.h>
+#include <linux/namei.h> // for LOOKUP_SHARED
 
 /*
  * Directories have different lock order w.r.t. mmap_lock compared to regular
@@ -369,7 +370,7 @@ xfs_vn_ci_lookup(
 	/* else case-insensitive match... */
 	dname.name = ci_name.name;
 	dname.len = ci_name.len;
-	dentry = d_add_ci(dentry, VFS_I(ip), &dname);
+	dentry = d_add_ci(dentry, VFS_I(ip), &dname, !!(flags & LOOKUP_SHARED));
 	kfree(ci_name.name);
 	return dentry;
 }
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 2a3ebd368ed9..a97eb151d9db 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -251,7 +251,8 @@ struct dentry *d_duplicate(struct dentry *dentry);
 /* weird procfs mess; *NOT* exported */
 extern struct dentry * d_splice_alias_ops(struct inode *, struct dentry *,
 					  const struct dentry_operations *);
-extern struct dentry * d_add_ci(struct dentry *, struct inode *, struct qstr *);
+extern struct dentry * d_add_ci(struct dentry *, struct inode *, struct qstr *,
+				bool);
 extern bool d_same_name(const struct dentry *dentry, const struct dentry *parent,
 			const struct qstr *name);
 extern struct dentry *d_find_any_alias(struct inode *inode);
-- 
2.50.0.107.gf914562f5916.dirty


