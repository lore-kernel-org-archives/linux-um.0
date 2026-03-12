Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD96106ACEC
	for <linux-um@archiver.kernel.org>; Thu, 12 Mar 2026 21:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CijUCx3yISxMWTDbwuIO0Uj8qxE5ByzXHAuT2ll77Kc=; b=US9/wr0hBcbKwUsapFrdz1fx2T
	czblU25wN7qr3uFq5FYg3Lco2Ry+hona6CHI3NAZS/c08mAWvctJQMCrKI+Zl53mZxXHo3U+SqHCh
	JBxDBJ0TyOkny/BUPOE9FVt68cD2jSVRxhx1FtNZlE1HZstUyy3Wt0wZYbDAFfpO3I/VR1kZGPGni
	cpMbsJHAAgoVPxAwKNN4dASWfJRYMQ+3MmE3ExoT65hRhNxLqTGPLD4zrSHpFfZFy4Sh5FglCeQPH
	mtNRPDslu63hxQZhD5YtXyFDCHo/oG1AFfjlt4BRUs61onssG9WK9Y7bQXMLIcm0ipOa7nCxjPW2D
	fSwFPUQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0nsJ-0000000FWoJ-0VZ0;
	Thu, 12 Mar 2026 21:47:23 +0000
Received: from flow-b6-smtp.messagingengine.com ([202.12.124.141])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0nsG-0000000FWn4-30VK;
	Thu, 12 Mar 2026 21:47:21 +0000
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailflow.stl.internal (Postfix) with ESMTP id CED9C1301B67;
	Thu, 12 Mar 2026 17:47:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 12 Mar 2026 17:47:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773352038;
	 x=1773359238; bh=CijUCx3yISxMWTDbwuIO0Uj8qxE5ByzXHAuT2ll77Kc=; b=
	M0GFvqkQA+hh9nwu7mc7JuOVZVPu+x8oqWAW5Vi1Rx0ZNPsVz7iMxZxDKcq92CRt
	w1O4ZA75sGW4LDIVw7O6OPJ5TEFeAuGPKTPe/7jj0ItCruKb1FNYdY27SqhvZ09e
	HQrUKDXLZ77hpZ3f5jgYHX/xKT6j73t2fG+qbzqf9J3oUiSlH08UW2HJtPZBZl4E
	tb3S6pnqBRQMWB5MJD7qakzz5t5Vcq4FHeC8JYwtac3CNO2XjQ3o8C+nf5JuyF16
	FWLn2uA9VJxGu8LE7GwMewr9oJgdxJqtHJVrIkPAFUUXTRPZzAathqukS9KRqNd8
	vGX+vFOH13CMrNdF9lzRxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773352038; x=1773359238; bh=C
	ijUCx3yISxMWTDbwuIO0Uj8qxE5ByzXHAuT2ll77Kc=; b=1/GE6Q4GOoKKny+rE
	1MCv0IvGJwFowq3gK2WpQpCuceE0cpvuxFjvXlb6EWJLNxDdvDBFb7JWso2W7Kz4
	mFFTfrB+C2ASTh9NC4SgG3HoHN43zfAxCmix5d+G+qZ+aEyNCsl3rNvSascyx4YJ
	TB8rxgDNbRLT7LoeFH5Cme9Q6tNfrxg9HzWUSDPszzVoCrORESTfN4bOq6nwEjj6
	nETza6aQ5uv45gJWXn54lpcHJOjI6XXdrUFqpLGzMIRfCqkIT7j6Cl0tgJg0F5Yf
	GNRULcF7xFfRRsuAOZ9mhJL0pTFa5+J27A43M+te1whUV4b+qPS2w84fsWgiX6kO
	OBj6Q==
X-ME-Sender: <xms:ZjSzaanPigQdEoCutGAwIPxjO8apJNgRPefGRXqMCTROMvJ-f8X8DQ>
    <xme:ZjSzabhOyplIVQ6rFZewl1y3_RfXqh3eikEEiZBZfSrWJrvLm1V846OM6sJqVJyze
    2tvhJt1_Y42OeZfOQjkdH8Fuai5DfHI5e8YlVpv-rEo2fY5>
X-ME-Received: <xmr:ZjSzafmz9RonKmSNFfPH-dDOoa1QQGeiKhudw1UDzdYzMUA5Fc3BHX9kxXc_Sk2W3JBwTQ9H7Y3ZB7JrVYGMX9luIkDKR407R11gkaq_hOgH>
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
X-ME-Proxy: <xmx:ZjSzaSp0E7bCqhcaSLkDbXNvvVFmD7gUjnaNvUJOeX2vs7zX4V9-oQ>
    <xmx:ZjSzaYO5kBCdqp08nn4s_kXmKCJVGkMzjkaXTd4aedH0KeQwN5YUBg>
    <xmx:ZjSzaUIHFxoYyKS25kJy7Qe-qFUsXUbKwQ1EfsvP5PspEUHlN7QptQ>
    <xmx:ZjSzaf05eFRrd1TCPNgoqXTI8E9qgZ7T1shFouSbVvlykGys3nYvhw>
    <xmx:ZjSzaT0ug1PB_DkmSY_fL7qirQdXDoPs16TB-jUayMEjlp2kG9qwmOKO>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 17:47:05 -0400 (EDT)
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
Subject: [PATCH 10/53] nfs: use d_splice_alias() in nfs_link()
Date: Fri, 13 Mar 2026 08:11:57 +1100
Message-ID: <20260312214330.3885211-11-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260312214330.3885211-1-neilb@ownmail.net>
References: <20260312214330.3885211-1-neilb@ownmail.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_144720_862836_CAC947C9 
X-CRM114-Status: GOOD (  15.32  )
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

When filename_linkat() calls filename_create() which ultimately
calls ->lookup, the flags LOOKUP_CREATE|LOOKUP_EXCL are passed.
nfs_lookup() treats this as an exclusive create (which it is) and
skips the ->lookup, leaving the dentry unchanged.

Currently that means nfs_link() can get a hashed dentry (if the name was
already in the cache) or an unhashed dentry (if it wasn't). As none of
d_add(), d_instantiate(), d_splice_alias() could handle both of these,
nfs_link() calls d_drop() and then then d_add().

Recent changes to d_splice_alias() mean that it *can* work with either
hashed or unhashed dentries.  Future changes to locking mean that it
will be unsafe to d_drop() a dentry while an operation (in this case
"link()") is still ongoing.

So change to use d_splice_alias(), and not to d_drop() until an error is
detected (as in that case was can't be sure what is actually on the server).

Also update the comment for nfs_is_exclusive_create() to note that
link(), mkdir(), mknod(), symlink() all appear as exclusive creates.
Those other than link() already used d_splice_alias() via
nfs_add_or_obtain().

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfs/dir.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 3033cc5ce12f..a188b09c9a54 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1571,6 +1571,9 @@ static int nfs_check_verifier(struct inode *dir, struct dentry *dentry,
 /*
  * Use intent information to check whether or not we're going to do
  * an O_EXCL create using this path component.
+ * Note that link(), mkdir(), mknod(), symlink() all appear as
+ * exclusive creation.  Regular file creation could be distinguished
+ * with LOOKUP_OPEN.
  */
 static int nfs_is_exclusive_create(struct inode *dir, unsigned int flags)
 {
@@ -2677,14 +2680,15 @@ nfs_link(struct dentry *old_dentry, struct inode *dir, struct dentry *dentry)
 		old_dentry, dentry);
 
 	trace_nfs_link_enter(inode, dir, dentry);
-	d_drop(dentry);
 	if (S_ISREG(inode->i_mode))
 		nfs_sync_inode(inode);
 	error = NFS_PROTO(dir)->link(inode, dir, &dentry->d_name);
 	if (error == 0) {
 		nfs_set_verifier(dentry, nfs_save_change_attribute(dir));
 		ihold(inode);
-		d_add(dentry, inode);
+		d_splice_alias(inode, dentry);
+	} else {
+		d_drop(dentry);
 	}
 	trace_nfs_link_exit(inode, dir, dentry, error);
 	return error;
-- 
2.50.0.107.gf914562f5916.dirty


