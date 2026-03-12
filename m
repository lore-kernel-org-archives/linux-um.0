Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 109C5106ACEA
	for <linux-um@archiver.kernel.org>; Thu, 12 Mar 2026 21:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W/Ak1KPwTmCaYgI05wA4foboiqmq4A6jkZq9iOG+AdU=; b=MVxirdIPMih8n3Pbdp2Ea5uM9g
	tidLUDSNNX6axIeFk+7wZMRYPcjm7TahDzRUcHqIXNXwM0aj7upf1Xevj7XSmvXlFBMhxJuS09Xmh
	rAxktbrr1oJ/15Zq4jp7JBa0xWvO0t6ZVldxmH83VlAUlmieiZh9h+yVhWYKnPWd+vjxVNpXK2gu1
	TuL16hrhvYtrbGG6DyLRqFywljwG0sTr99lrwaE9fwqw2xuL0Wuq8yKYQJ1kg7o96vx1xRew8EAYy
	pvrGWaHnFoSR6YTX4eBnsdGSFRCmUle/Qk+EYuc6qfvrA3WUj8KNgKsUYX8eTjJxvRYCDxkZbz5lj
	h8WCgPgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0nsr-0000000FWxK-3Nlp;
	Thu, 12 Mar 2026 21:47:57 +0000
Received: from flow-b6-smtp.messagingengine.com ([202.12.124.141])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0nsp-0000000FWwQ-1h46;
	Thu, 12 Mar 2026 21:47:56 +0000
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailflow.stl.internal (Postfix) with ESMTP id 3C2BB1301B70;
	Thu, 12 Mar 2026 17:47:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 12 Mar 2026 17:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773352073;
	 x=1773359273; bh=W/Ak1KPwTmCaYgI05wA4foboiqmq4A6jkZq9iOG+AdU=; b=
	c/pw77uhzQwtu+x2rfy8YAQ8ODHIH6TqF5gjkDP3PnFVgS1yE39XzRUPiB7FP2sc
	RbT2SpGQkTPfjMjryKRQmCrUB49ETvDmOW/QLdaS3hsyuXpnCKPp4KpaG/88uh2b
	ZXJ9+VfUjmAlAqwi0KyMt/q9CW2hdecgqwGPYM6ENHXeNa2d3fgGwlvb8qBCnbPl
	x8pPfpV5ACsdJEY+vFgnJ5ttUL/vZ5lzs0FJW0pNjeM98B1mNj3S1TLDNNkpQ85G
	mrIMwkNyGULMNnaoWm3wi2W8zO4ZyGTiZJ5fNsPnxumyHNOH7BM2cdOc/C+ceQbo
	7ROxYdy3UdkLgEgWoNY5Lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773352073; x=1773359273; bh=W
	/Ak1KPwTmCaYgI05wA4foboiqmq4A6jkZq9iOG+AdU=; b=MVii9L11GlwWtMhzZ
	n7iyDbPToR7JKb8T+MC59sZyBmXHZlJqZHj7ZQZrD1S9ZmYRwTLXpkBTfH/AH0ql
	XbK/noTmtQpNxvag+selT8UbNrzr/8IJl3kNxMvGZTLR+moT9KOT8al3IGiwNRoX
	j8ioh/jBUoLeJqAxmuqIyXvmtjLlIL56VrRHOV7H7mbB6T8HJiTueMd0tykadvXM
	ZaBajRtT7ugnSgBwWXivnDrJCmaH1qiDVbS3t+bJW+z4Vbk9MiVqyz7miWcV9qju
	MqrU8tjGSX+VM6REOR8up7aRz4q4674wBNNCUAlZBuJh49XTJzmrGGb3vo1RiPrw
	yZczg==
X-ME-Sender: <xms:iDSzadf1MovIDDvvqQ6m703oltGBhRnngp3beiLGJSJZjewqpRJxtA>
    <xme:iDSzaU7kFxhIoJWxE1RTDf2t8oqexnxdhjkbXG5N5FUMS8uwy6w-AM73SOEtbiuBF
    uOE7IwJJi0kM5W5JqOt7ALX4wYtbeJh1HFlYN-92h_1c4Q>
X-ME-Received: <xmr:iDSzadcoq5CrRqaaWti1CkFPSfX6M4RqKzQeN0yflSVg43UjwueDpXwh5Ys-4gY0lPdS2gJL-7qQvNFXh932_SMPRpiOg_iMtCeNxLYNWhUq>
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
X-ME-Proxy: <xmx:iDSzabCq_RvYJXtjKj-mxXj8cgaSwK2kgE6I7mhCH7RkS1KGGqql6Q>
    <xmx:iDSzaZFUzlkcAnxW7y-rWbMhjamfWq-Vptqs2x39yx-7jXjO5-Yr2Q>
    <xmx:iDSzaTigiLe8tZx1JISL5ztxucDTqZ8xpdT2bkQm4n8qOh17tO6pbw>
    <xmx:iDSzabteC8QKWKodA79F8ezpVRGSzyCRtk90G-w-YL6UtlIT-rMcpg>
    <xmx:iTSzaXvLLx8QlN8PNoj_x62VFUWwQFufxUedui_IHwRwfAfxnUhgOhIG>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 17:47:39 -0400 (EDT)
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
Subject: [PATCH 12/53] nfs: don't d_drop() before d_splice_alias() in atomic_create.
Date: Fri, 13 Mar 2026 08:11:59 +1100
Message-ID: <20260312214330.3885211-13-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260312214330.3885211-1-neilb@ownmail.net>
References: <20260312214330.3885211-1-neilb@ownmail.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_144755_522817_2FA79ECD 
X-CRM114-Status: GOOD (  10.32  )
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

When atomic_create fails with -ENOENT we currently d_drop() the dentry
and then re-add it (d_splice_alias()) with a NULL inode.
This drop-and-re-add will not work with proposed locking changes.

As d_splice_alias() now supports hashed dentries, we don't need the
d_drop() until it is determined that some other error has occurred.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfs/dir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index f92ea11aea44..ffba4de3df01 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2179,7 +2179,6 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 		err = PTR_ERR(inode);
 		trace_nfs_atomic_open_exit(dir, ctx, open_flags, err);
 		put_nfs_open_context(ctx);
-		d_drop(dentry);
 		switch (err) {
 		case -ENOENT:
 			if (nfs_server_capable(dir, NFS_CAP_CASE_INSENSITIVE))
@@ -2188,7 +2187,7 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 				dir_verifier = nfs_save_change_attribute(dir);
 			nfs_set_verifier(dentry, dir_verifier);
 			d_splice_alias(NULL, dentry);
-			break;
+			goto out;
 		case -EISDIR:
 		case -ENOTDIR:
 			goto no_open;
@@ -2200,6 +2199,7 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 		default:
 			break;
 		}
+		d_drop(dentry);
 		goto out;
 	}
 	file->f_mode |= FMODE_CAN_ODIRECT;
-- 
2.50.0.107.gf914562f5916.dirty


