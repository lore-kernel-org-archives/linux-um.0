Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BA9106FD62
	for <linux-um@archiver.kernel.org>; Fri, 13 Mar 2026 00:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EchxTXDSTALGT/SYRwTZVf/wCe3kGgvEe9z67tw1N/I=; b=m1ybix3MSwvV3OrKiIMQglqH+S
	AXC7y8twKA+hdGBO9LbjKCStsLdpfNCXZLmtU2bigvxSZLEFhX1zlSHkqrm1cqzkMEUxtINb+sBKz
	M50v0daq3OiECmBkq3KsIgmr+8marhQ1gnEjPJUTRx8CnfsNohuq7kgt8UZ5sgDbGEj3jOzrFXmIV
	GcB0DTTixS9Ye+hHOpKL8cMdWy7aUhq6L5Dde8tv88AD0Qg5G1oR3MFAh0nj2ntaHkZA1Ukl6DGyh
	5sn39vdsbzKx3f88uoa9HjcUxds+qs0xx0tw8TWjUh7DniTgsJuaTy6fASqWFXQDW2l24rbbNKLEL
	qLGAmPXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0qdc-0000000Fy8U-2yUH;
	Fri, 13 Mar 2026 00:44:24 +0000
Received: from flow-b5-smtp.messagingengine.com ([202.12.124.140])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0qdb-0000000Fy7i-00jx;
	Fri, 13 Mar 2026 00:44:24 +0000
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id 1C1651301B36;
	Thu, 12 Mar 2026 20:44:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 12 Mar 2026 20:44:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773362660;
	 x=1773369860; bh=EchxTXDSTALGT/SYRwTZVf/wCe3kGgvEe9z67tw1N/I=; b=
	HtGyc6qG86oz5kPvVFKloxRAiiPrdOpKU8L6wLUUYdjZZtzmK8nkkRoRc4Ob/zDE
	ygWeDDQ7jByf/H36cgdfqD2YT8xrlT5AnRfqLG6YYDduADlVEQcPZKFCOFEq7efp
	W0PV4tzGLYO7R7+Bi8QoTHgftdcdAbG2cmbRdSq7IiPJrej/xGh8Sis7vcSb5NUp
	8p9RKdBEfwd8U9POVkTHLrI8JD7f/jqhMlJETvpWzrtU+xKrqH6+DdkWl9BZAf3N
	0STPIxH4lQraZKks4fXTtb9nzvy+JFzG89W3Fsfemen70/tWjCFitTexXEMl+aF6
	MdwcnBbmpBgBWkwcmrlWrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773362660; x=1773369860; bh=E
	chxTXDSTALGT/SYRwTZVf/wCe3kGgvEe9z67tw1N/I=; b=cGZE7jMy2SV9uoVbT
	q+IZzNuzXM+hYp7X/7RyEelmnM4UrPJGwKgU90XEnptRogSnhLgrodnjWWKRdW6V
	AQ2OpzAPnuid/OLVu+UcDPlHx8xARolg4F09VwR1VkrdXcXUZU3U5Q/ecPnnrOZf
	SYXSxRBpzCG7sc8smUlxY8lKJ6slf1JpRJFSI4EJH5Sn6FJIQ9W0S72D+0grR2eW
	eRAGsh4DDkSU9EgUFpYcUsAr3jEhGPLkD/lIXTiZxQR15ET1AfwNhG2Uyk8kFZEA
	eJf1QWHbL/Mhmx2NzRvIensmEAwQ5KJ9/ygKBb3mV2toMoGumq2oOmUfpqyuBCg1
	QIv+A==
X-ME-Sender: <xms:5F2zaVHI984ELvb6xSRaFU9eCeKsAQjeZVnzdbb6spa-5onhWibOxw>
    <xme:5F2zaUAed5wK-zCYjIohFxTpHOZodN1QK5v6gSu9aBbq6YkW49INvwK2H8WSlxuUj
    0AINAGwpWxmYYyrWgs6QEljfIuLf1lidnihAI7NxZBlett3>
X-ME-Received: <xmr:5F2zaeFAXsLgutzseRttIHJSIZrQBg4HQsn-pgvOFbN2jRZuZJQaVAifygamFXGvvWGzpvACE4zAmDQPT3U028PwiKjFjFm6UlAj5yjyJwko>
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
X-ME-Proxy: <xmx:5F2zafLiDwJI8AsohNmCqUWhx66u5JznxXNAP9db1X9x-LHxraRvUQ>
    <xmx:5F2zaauU88YwyeOeYB86_WfHys66FW-d63rSeocswtoECd66SdtGHA>
    <xmx:5F2zaUpH9EvuwjTwbaCT-kN4TE4nurgxpwZqmfL5VKPrPKKsZvNp0w>
    <xmx:5F2zaWWtk05otDk_d1bqcAfIJnfbAsyYAIR11Xd5Jqwl9RmTh_ZPSw>
    <xmx:5F2zaZWxNVGF8w3Grc8V634dTGW1lFtEASW9xYbi3dSM4mcL6-JNsBIK>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 20:44:07 -0400 (EDT)
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
Subject: [PATCH 33/53] ext4: use on-stack dentries in ext4_fc_replay_link_internal()
Date: Fri, 13 Mar 2026 08:12:20 +1100
Message-ID: <20260312214330.3885211-34-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260312214330.3885211-1-neilb@ownmail.net>
References: <20260312214330.3885211-1-neilb@ownmail.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_174423_104406_FEBC6EB1 
X-CRM114-Status: GOOD (  14.97  )
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

ext4_fc_replay_link_internal() uses two dentries to simply code-reuse
when replaying a "link" operation.  It does not need to interact with
the dcache and removes the dentries shortly after adding them.

They are passed to __ext4_link() which only performs read accesses on
these dentries and only uses the name and parent of dentry_inode (plus
checking a flag is unset) and only uses the inode of the parent.

So instead of allocating dentries and adding them to the dcache, allocat
two dentries on the stack, set up the required fields, and pass these to
__ext4_link().

This substantially simplifies the code and removes on of the few uses of
d_alloc() - preparing for its removal.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/ext4/fast_commit.c | 40 ++++++++--------------------------------
 1 file changed, 8 insertions(+), 32 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 2a5daf1d9667..e3593bb90a62 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1446,8 +1446,6 @@ static int ext4_fc_replay_link_internal(struct super_block *sb,
 				struct inode *inode)
 {
 	struct inode *dir = NULL;
-	struct dentry *dentry_dir = NULL, *dentry_inode = NULL;
-	struct qstr qstr_dname = QSTR_INIT(darg->dname, darg->dname_len);
 	int ret = 0;
 
 	dir = ext4_iget(sb, darg->parent_ino, EXT4_IGET_NORMAL);
@@ -1457,28 +1455,14 @@ static int ext4_fc_replay_link_internal(struct super_block *sb,
 		goto out;
 	}
 
-	dentry_dir = d_obtain_alias(dir);
-	if (IS_ERR(dentry_dir)) {
-		ext4_debug("Failed to obtain dentry");
-		dentry_dir = NULL;
-		goto out;
-	}
+	{
+		struct dentry dentry_dir = { .d_inode = dir };
+		const struct dentry dentry_inode = {
+			.d_parent = &dentry_dir,
+			.d_name = QSTR_LEN(darg->dname, darg->dname_len),
+		};
 
-	dentry_inode = d_alloc(dentry_dir, &qstr_dname);
-	if (!dentry_inode) {
-		ext4_debug("Inode dentry not created.");
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	ihold(inode);
-	inc_nlink(inode);
-	ret = __ext4_link(dir, inode, dentry_inode);
-	if (ret) {
-		drop_nlink(inode);
-		iput(inode);
-	} else {
-		d_instantiate(dentry_inode, inode);
+		ret = __ext4_link(dir, inode, &dentry_inode);
 	}
 	/*
 	 * It's possible that link already existed since data blocks
@@ -1493,16 +1477,8 @@ static int ext4_fc_replay_link_internal(struct super_block *sb,
 
 	ret = 0;
 out:
-	if (dentry_dir) {
-		d_drop(dentry_dir);
-		dput(dentry_dir);
-	} else if (dir) {
+	if (dir)
 		iput(dir);
-	}
-	if (dentry_inode) {
-		d_drop(dentry_inode);
-		dput(dentry_inode);
-	}
 
 	return ret;
 }
-- 
2.50.0.107.gf914562f5916.dirty


