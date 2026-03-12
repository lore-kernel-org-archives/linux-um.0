Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA1C106FD60
	for <linux-um@archiver.kernel.org>; Fri, 13 Mar 2026 00:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K3IStrNmQd52sbuvLJgTXGgXoqLBL9Wr3QWVkKkzQVI=; b=qP97D44pd+bD4JWGG2Q7TQgjFc
	QXmXIFPsagq7VmichCwYXtrderMa+QKgrBy4VIDiB+2ck+BOAs+iwfCqwoU05ZFgeEbf8PckM7F2T
	w2cL0vigo1lzFPOZngzzZgyigCXOaKXCYXJEkBWamiC3ukpJnaLhQ4fQo64J/0C9aNzxe4cGc0vTO
	kA625avwCsyBT4gsUY2RPsMBwDUJ2STfu04O52j6q+LZTGExL8qNNPZy5MHynejdYUyJu7xXwyV0O
	iEw/E5CRykVmhhvbQdHwy6XZFqEpzDfvTIz/+fAVbB1pnZ/tJD8cSInjhUJ68UmeynKLmsBHIyacE
	/NmWjy9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0qg7-0000000Fynm-1eEC;
	Fri, 13 Mar 2026 00:46:59 +0000
Received: from flow-b5-smtp.messagingengine.com ([202.12.124.140])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0qg5-0000000FynF-0pAn;
	Fri, 13 Mar 2026 00:46:58 +0000
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 605B01300BDB;
	Thu, 12 Mar 2026 20:46:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 12 Mar 2026 20:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773362815;
	 x=1773370015; bh=K3IStrNmQd52sbuvLJgTXGgXoqLBL9Wr3QWVkKkzQVI=; b=
	RNXQe8RCRsLKMGTZv3GRKZahOC0IxxlJic/ko0MFy4a1ctyXK6vvz4ReaSk7Wtb/
	mAzGCuXrdmdZBQIRLvL9TgyL2qlc45O0kQ3l8qXW16jE7P6d9LqJCqRvPWC/uzxz
	Fg4Z9KDdzbQTjvMOHVIfVhzYLGcWWMkbkuEXMLMZZKzxUaOV6SPZtD3+P7r4CdlO
	YReiac+iMDhQdyLzaO6kSMLbrOxlDborVcCeQAMrmsrVMTfxIzMeSF5US+w16WfM
	ACO2ucwH/a+sdYpvVApyX2BOUWYS4NgQgEXOKZ4Urg3/g1TPjzQe8VBcsJ455SzX
	9KAVhZnChtKP/WL+6dyBwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773362815; x=1773370015; bh=K
	3IStrNmQd52sbuvLJgTXGgXoqLBL9Wr3QWVkKkzQVI=; b=wfskezN6avTEhR19Y
	nyFK8EjU0/MMk1mTZsKRrgviM3fKXxJNJu1JVFZMcMVBW/OhFGdzQV2zxrvMHOyI
	+wsRPzWoNSHHCaB3Uz6Z2Z50+4HPTAToivoCuItoC7GdStbUhlwIos6CNfKYetOs
	dtWj4+DVfGt5fqQnqBjG1Dqg+KH1ydv5G4O84e2/iXhc9Ryvf0hXvivBdRiWWVUz
	ln4nRLs8aYjEr1bv8aqsemzU1pcoJrsa+DX022p8AWsPy7cwqUau5yZRIa7kTqSX
	KkLiJjVMjxGllDLHldeMf1HfZBS49/IiohaDFc6csqGAyWyuyBEkdFBLfaeltNSp
	jBt2A==
X-ME-Sender: <xms:fl6zafe3S7X84lJOJFdshQFEOSrbddVEHmr1mw6S46GpGR2i6woJ8A>
    <xme:fl6zaczFa49e0KK0S015j6JpoR_5P68FmUDqY6WEQHX1cWMiUDEH-T7HQAfY5J6od
    qM5cWDNETWONPUtRpmNWTVHJCOl1xZ2rv7QmzJHE25REqnBVQ>
X-ME-Received: <xmr:fl6zaVfYsIubTYkOgpCpYFaYitUZ5oYFrWfnd5ZTirmi7nP4J0c0z79jLMuEwIr_H465ON1BCgxcqIa4aTJ0nwCIZ9blq-QRFlXrRlcGC-hU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
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
X-ME-Proxy: <xmx:fl6zae4dK9r668Qiw8CvZFQjfZ31XTfKNmbrp9eUDoDMrazoXyD0fw>
    <xmx:fl6zaVaKGWkKJVt8deNozJ9QBXJAphfRuD5nuPx9CFBo8ryZkkpqgg>
    <xmx:fl6zaTzrXRucFOWhgAsf8iS1wX5cATadJaq7iOpt6RIngHxauV71uQ>
    <xmx:fl6zaSQ4lRJXRVAygVyvKtYoYqFXXoBXTgOtSlESq2KNF1VJOQLY9g>
    <xmx:f16zaVIP2rSOzehLw3_PK25GCy-IcS721ulaHNjDv3drFOKshm3Pavwn>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 20:46:41 -0400 (EDT)
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
Subject: [PATCH 24/53] afs: use d_duplicate()
Date: Fri, 13 Mar 2026 08:12:11 +1100
Message-ID: <20260312214330.3885211-25-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260312214330.3885211-1-neilb@ownmail.net>
References: <20260312214330.3885211-1-neilb@ownmail.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_174657_277261_A5E79B7D 
X-CRM114-Status: UNSURE (   9.28  )
X-CRM114-Notice: Please train this message.
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

To prepare for d_alloc_parallel() being permitted without a directory
lock, use d_duplicate() when duplicating a dentry in order to create a
whiteout.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/afs/dir.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index c195ee851191..b5c593f50079 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -2047,6 +2047,8 @@ static void afs_rename_put(struct afs_operation *op)
 	if (op->rename.unblock)
 		store_release_wake_up(&op->rename.unblock->d_fsdata, NULL);
 	store_release_wake_up(&op->dentry->d_fsdata, NULL);
+	if (op->rename.tmp)
+		d_lookup_done(op->rename.tmp);
 	dput(op->rename.tmp);
 }
 
@@ -2175,8 +2177,7 @@ static int afs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			if (d_count(new_dentry) > 2) {
 				spin_unlock(&new_dentry->d_lock);
 				/* copy the target dentry's name */
-				op->rename.tmp = d_alloc(new_dentry->d_parent,
-							 &new_dentry->d_name);
+				op->rename.tmp = d_duplicate(new_dentry);
 				if (!op->rename.tmp) {
 					afs_op_nomem(op);
 					goto error;
-- 
2.50.0.107.gf914562f5916.dirty


