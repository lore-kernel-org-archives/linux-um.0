Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C315106FD60
	for <linux-um@archiver.kernel.org>; Fri, 13 Mar 2026 00:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qz44r/cI/H+P66r7rjgQTu2SyU7wjlJxbU1IwzedCr8=; b=WqHlpVVmUqbNAJtfvV3uniguNb
	eWfNQy3TQTW0c6qlj+Cx/x4E5iHtkeJKn3bzjoYBXRctVjWl4CF1nF3Im/06P8nqZasPA34R6eKNq
	qOt/KZKMZ8U1qMPe38PZGwX6fXBA0YqJY61G/nUeHVHqSQog6g9upWKRMwFe/OL949I/1dtMV9Yjj
	Lx5qKAQjyQ6kXxMEVE8BEOZHniIwaTIYP4EscWmKhr3RxAjlPsDzleP0wrIDBucPKe735DqvLR4mE
	Jr8OcsHc+8kJNCR40qB+89S7zJwY58eL3OxGo9NoW1jrv8pvifBUmuVZdXphcOWA2Y1n0YBgDPJQk
	X10mZvwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0qgO-0000000Fysh-3E3N;
	Fri, 13 Mar 2026 00:47:16 +0000
Received: from flow-b5-smtp.messagingengine.com ([202.12.124.140])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0qgM-0000000Fys0-35fS;
	Fri, 13 Mar 2026 00:47:15 +0000
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id B9F1C1301B6E;
	Thu, 12 Mar 2026 20:47:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 12 Mar 2026 20:47:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773362832;
	 x=1773370032; bh=Qz44r/cI/H+P66r7rjgQTu2SyU7wjlJxbU1IwzedCr8=; b=
	IpsMpfFevA+mEhkdruCUf1Vu9FEmLzrEWAtb4IDHjustVcc660x5nQzIEH+zM7+n
	F7xem84KPhj9hWFRzoN31Jzl2kLAcLz5C41k8KF8DDc2o4mfWEEH6308fDzSejrk
	AorOd82znIkjc2rhRbi8CcLttXgvES5I5n9aRJa1sym6k9LnaGvmiOPtg4JaoClH
	E0GZdfUMmErgqYA2F+MxWkHZOVdGxA5gC99x4eWzvtHdwM3bSZVia7h1wLflwgGX
	KQHLoziyxbJHp75VC9zMqgFzhJDRW4bSOVnZITlnR83AmG4HdVrOomHAmHpQJLkD
	HBP2qOLbjyiF5zP3BpxzQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773362832; x=1773370032; bh=Q
	z44r/cI/H+P66r7rjgQTu2SyU7wjlJxbU1IwzedCr8=; b=G8JHmFu5KQLBpNeDN
	zld/gBCZXli4GS4wIem/PbJqdIIhih3tiaKE/N90l8FUrwJW8+gU2YeDvGTUBthJ
	rkgMGcdPlD1fIWMo1biHaQo9/WLjEYSr4vVAu27PxvDXdpU++7hfY7L//0Jwh1vH
	tzV6BPqgVS3EsG8sXh4xhvpy93GmQMFAKAaTw03Y5NAL6DAPPg5Wqs5sjjStPu0f
	cLxuKrZDYNCr9qnEHNk94ODc/hUxWL67t8Fh7zQzN0r9Wm/zV2Yq30KwIEHJu9yc
	t/JWWAUZfgxJ26ZwGO6uIfjpuQTO8vMuyP8XPTU8suyyC2YPRzT8hE/YRgFJTBwT
	ND/vQ==
X-ME-Sender: <xms:j16zaYNqiENq37Q88rVFgJaCOvTJoUm1h2SEBH6kM7EqWOTDRHmc2A>
    <xme:j16zaYoZ3REtyM9VfSMjEIDxBMUKaiHvdWMBpAfpNKCvDvCxoo2Qze54PpjQVZobJ
    WRkvp_JemW5lzrlTb4vGsMKrrdw7teaVORNkzNbZ_AH4lnd0A>
X-ME-Received: <xmr:j16zaWO7xjK010jo-nA47C_4dYeAJwZ_N6uvslo1KsUNxaUr2oh3YspcqtKGGcTzoVpio9l4SKeKi4FzhdaorN2yMS4jRgR7n5YPp67PZbLn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekvdehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:j16zaUzYdGgFWNlQYTElED9rnjSSFh5w-f45gvQomTKe5mqutsfuIw>
    <xmx:j16zaf3nVk-q_uhqBESJnPqXZCkqcke1PsMYuH1SmSZD0xMezqCrmA>
    <xmx:j16zaTRtsoaSs1r-htZVOscRdBLq7DVWFnEqHhe2Q1hzILsaqY_XHQ>
    <xmx:j16zaQcOUgemLNPo4bCCmDOXDChgryenKb1HF8fIilO_1ferY7gLGw>
    <xmx:kF6zaedyr8sLQAReYz8TwH3TKulUCUC0YXzRK_d6K-utN3FzIFWDtrCh>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 20:46:58 -0400 (EDT)
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
Subject: [PATCH 23/53] afs: lookup_atsys to drop and reclaim lock.
Date: Fri, 13 Mar 2026 08:12:10 +1100
Message-ID: <20260312214330.3885211-24-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260312214330.3885211-1-neilb@ownmail.net>
References: <20260312214330.3885211-1-neilb@ownmail.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_174714_840292_1368F6A5 
X-CRM114-Status: GOOD (  16.37  )
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

If afs is asked to lookup a name ending with @sys, it needs to look up
a different name for which is allocates a dentry with
d_alloc_parallel().
This is done while the parent lock is held which will be a problem in
a future patch where the ordering of the parent lock and
d_alloc_parallel() locking is reversed.

There is no actual need to hold the lock while d_alloc_parallel() is
called, so with this patch we drop the lock and reclaim it.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/afs/dir.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 1e472768e1f1..c195ee851191 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -908,12 +908,14 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry)
 /*
  * Look up an entry in a directory with @sys substitution.
  */
-static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry)
+static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry,
+				       unsigned int flags)
 {
 	struct afs_sysnames *subs;
 	struct afs_net *net = afs_i2net(dir);
 	struct dentry *ret;
 	char *buf, *p, *name;
+	struct qstr nm;
 	int len, i;
 
 	_enter("");
@@ -933,6 +935,13 @@ static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry)
 	refcount_inc(&subs->usage);
 	read_unlock(&net->sysnames_lock);
 
+	/* Calling d_alloc_parallel() while holding parent locked is undesirable.
+	 * We don't really need the lock any more.
+	 */
+	if (flags & LOOKUP_SHARED)
+		inode_unlock_shared(dir);
+	else
+		inode_unlock(dir);
 	for (i = 0; i < subs->nr; i++) {
 		name = subs->subs[i];
 		len = dentry->d_name.len - 4 + strlen(name);
@@ -942,7 +951,10 @@ static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry)
 		}
 
 		strcpy(p, name);
-		ret = lookup_noperm(&QSTR(buf), dentry->d_parent);
+		nm = QSTR(buf);
+		ret = try_lookup_noperm(&nm, dentry->d_parent);
+		if (!ret)
+			ret = d_alloc_parallel(dentry->d_parent, &nm);
 		if (IS_ERR(ret) || d_is_positive(ret))
 			goto out_s;
 		dput(ret);
@@ -953,6 +965,10 @@ static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry)
 	 */
 	ret = NULL;
 out_s:
+	if (flags & LOOKUP_SHARED)
+		inode_lock_shared(dir);
+	else
+		inode_lock_nested(dir, I_MUTEX_PARENT);
 	afs_put_sysnames(subs);
 	kfree(buf);
 out_p:
@@ -998,7 +1014,7 @@ static struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
 	    dentry->d_name.name[dentry->d_name.len - 3] == 's' &&
 	    dentry->d_name.name[dentry->d_name.len - 2] == 'y' &&
 	    dentry->d_name.name[dentry->d_name.len - 1] == 's')
-		return afs_lookup_atsys(dir, dentry);
+		return afs_lookup_atsys(dir, dentry, flags);
 
 	afs_stat_v(dvnode, n_lookup);
 	inode = afs_do_lookup(dir, dentry);
-- 
2.50.0.107.gf914562f5916.dirty


