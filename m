Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B6E6106ACEC
	for <linux-um@archiver.kernel.org>; Thu, 12 Mar 2026 21:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YL+J72s4jM/IFD83vUlKIIKhuJuEonEWtkSdhku4yoI=; b=TEFacjderg2eJc5//Y8NpuX/7C
	SM63WfBMh/wuMM5+ZNXmJrLbHQzAp8a4uZOHdhLNFdJNkm2da62lT1Fa1Ki3nY1iGYMDHAckUKZbl
	sIKSzAeZB+RYc1z7BYQbA0R7VRK1E7OtvcDzhA4K8qpjOoX6vxFR65YV2TmcwWwX8BEE13c5lxjCY
	Cjf4dlAFpcxRUB4h8st6+1p1Ykmt0yIWk5kANhbkEHESs/1L2PmslJRVeHu+r5cYKwMo3112ayS5Y
	IS2NZt3yJIBpZ/iNyG83VUR+DJSf+Tbu/mKpup/bDWXPSvL5yvsakkHUgoIat/9O3GIQ456hXDDXl
	Ev/OnX7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0ntx-0000000FXFw-3vVj;
	Thu, 12 Mar 2026 21:49:05 +0000
Received: from flow-b6-smtp.messagingengine.com ([202.12.124.141])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0ntw-0000000FXFQ-02ap;
	Thu, 12 Mar 2026 21:49:05 +0000
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id DEB981301B8E;
	Thu, 12 Mar 2026 17:49:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 12 Mar 2026 17:49:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773352141;
	 x=1773359341; bh=YL+J72s4jM/IFD83vUlKIIKhuJuEonEWtkSdhku4yoI=; b=
	gaAhEBPAdZ3kN0WV16+ugt1A/74DzdGxG8GEh+e+EQn0LxokiH00tux1d8sBHRcY
	Vg+7f+AOVRuHjhznqBd0sk41zkY9Vx4MFt96H29HY4RyG9/tLfLooU+qOjqy3Ip7
	IH8RP4puRqDzsWiVR9OJNaF5F8IkaIv8EKzwUABlX5z0SXc9f3oqyE6HyxoBMDDS
	pc/vRkKXd+xwK5xh2M7mb3cTBfa30Q4hfYmSYHp47InunZ8s/qXNmlFjFULmHD7w
	3+DbNHr3E7SKmihSlBhgNVVkp2v/H1cc12RtWmoaSN4ONlLZ4DcnjXpDPs4R6LkU
	ns6xJKqBdYIvZ4hcjjUj7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773352141; x=1773359341; bh=Y
	L+J72s4jM/IFD83vUlKIIKhuJuEonEWtkSdhku4yoI=; b=PYzTveHy9RbMJRFOG
	+aOYTisnLh1GssROIXjKgytZ4YxU9i+aq6o6xyI+wA2qQQ3phZD+7w9a+2oxR9sd
	MeqUQsL4Pikanpl6RF2Vlolwt8nVrrSGXImQw1AiavtrMeOHQp80gmJWpbwF2FLc
	nH2rodwDYZ8UVeQnQ/vcXJ7K/d1UnY3kPRC6+afOMbKrlwwk46kzWD211KuXsuNA
	OuNxbhRGhgyAjKWcJHaW4LaMvWUKu+JboX31okwJgjFqztHXyiMO5KvAJdk0mEfr
	nvn4Mqxg7kmCNIR8KgMyimzGJdQGOGVz0Rta8y6idYVjE7mud+m4qGXXI8tSbQc7
	PLcCw==
X-ME-Sender: <xms:zTSzaVmwZixCGdoX2erYF0lP235WWzGm_ytqUU29xWcEeK7L0VW-wQ>
    <xme:zTSzaUjG04C-wM5lql7c8WfFKDjRHXkGA04C2snp0wQn_m27cVZPK_uDtD9jQYXU-
    iK7vr13E-btv_v6m9oHI9tCXM4q9Zw7H-3yQldyhMRQJcTA>
X-ME-Received: <xmr:zTSzaWsqAk9yDmJdbanEpvmBeyBlj7d_0-LcKSmgHHotctU1rSIGew6MWReJM1dGsftssvq89mEj9JIvBq67daOHoQnwV4TX_7ghL9A09Cwh>
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
X-ME-Proxy: <xmx:zTSzaTARJTYpvXl42P8fW7lTXo4Lj2wXGnHid5oDSRvhe_yZolChkw>
    <xmx:zTSzaZWOsXczAf9XJmzQY_cdxcxLTv20bO6dyIAvbZru0n0FgBFW6Q>
    <xmx:zTSzaRIbQrG4Do27wKl9Wfg5Nj0cHKP-bxR-i9E9XHdvomQxuGhoBw>
    <xmx:zTSzaSULGNWJZjGpBUM3QAt6gABNWwr6kRRnFzPn2VEFH0VbT_nXjQ>
    <xmx:zTSzaczB9cOVBaPVl5IKIF-TP6DKqW7SwY2Aj9X3Uh4e-1ZgrGKRQC_t>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 17:48:48 -0400 (EDT)
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
Subject: [PATCH 16/53] ovl: drop dir lock for lookups in impure readdir
Date: Fri, 13 Mar 2026 08:12:03 +1100
Message-ID: <20260312214330.3885211-17-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260312214330.3885211-1-neilb@ownmail.net>
References: <20260312214330.3885211-1-neilb@ownmail.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_144904_113318_B9981562 
X-CRM114-Status: GOOD (  15.66  )
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

When performing an "impure" readdir, ovl needs to perform a lookup on some
of the names that it found.
With proposed locking changes it will not be possible to perform this
lookup (in particular, not safe to wait for d_alloc_parallel()) while
holding a lock on the directory.

ovl doesn't really need the lock at this point.  It has already iterated
the directory and has cached a list of the contents.  It now needs to
gather extra information about some contents.  It can do this without
the lock.

After gathering that info it needs to retake the lock for API
correctness.  After doing this it must check IS_DEADDIR() again to
ensure readdir always returns -ENOENT on a removed directory.

Note that while ->iterate_shared is called with a shared lock, ovl uses
WRAP_DIR_ITER() so an exclusive lock is held and so we drop and retake
that exclusive lock.

As the directory is no longer locked in ovl_cache_update() we need
dget_parent() to get a reference to the parent.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/readdir.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 1dcc75b3a90f..d5123b37921c 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -568,13 +568,12 @@ static int ovl_cache_update(const struct path *path, struct ovl_cache_entry *p,
 			goto get;
 		}
 		if (p->len == 2) {
-			/* we shall not be moved */
-			this = dget(dir->d_parent);
+			this = dget_parent(dir);
 			goto get;
 		}
 	}
 	/* This checks also for xwhiteouts */
-	this = lookup_one(mnt_idmap(path->mnt), &QSTR_LEN(p->name, p->len), dir);
+	this = lookup_one_unlocked(mnt_idmap(path->mnt), &QSTR_LEN(p->name, p->len), dir);
 	if (IS_ERR_OR_NULL(this) || !this->d_inode) {
 		/* Mark a stale entry */
 		p->is_whiteout = true;
@@ -666,11 +665,12 @@ static int ovl_dir_read_impure(const struct path *path,  struct list_head *list,
 	if (err)
 		return err;
 
+	inode_unlock(path->dentry->d_inode);
 	list_for_each_entry_safe(p, n, list, l_node) {
 		if (!name_is_dot_dotdot(p->name, p->len)) {
 			err = ovl_cache_update(path, p, true);
 			if (err)
-				return err;
+				break;
 		}
 		if (p->ino == p->real_ino) {
 			list_del(&p->l_node);
@@ -680,14 +680,19 @@ static int ovl_dir_read_impure(const struct path *path,  struct list_head *list,
 			struct rb_node *parent = NULL;
 
 			if (WARN_ON(ovl_cache_entry_find_link(p->name, p->len,
-							      &newp, &parent)))
-				return -EIO;
+							      &newp, &parent))) {
+				err = -EIO;
+				break;
+			}
 
 			rb_link_node(&p->node, parent, newp);
 			rb_insert_color(&p->node, root);
 		}
 	}
-	return 0;
+	inode_lock(path->dentry->d_inode);
+	if (IS_DEADDIR(path->dentry->d_inode))
+		err = -ENOENT;
+	return err;
 }
 
 static struct ovl_dir_cache *ovl_cache_get_impure(const struct path *path)
-- 
2.50.0.107.gf914562f5916.dirty


