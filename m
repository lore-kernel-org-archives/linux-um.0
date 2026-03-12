Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8296106ACEF
	for <linux-um@archiver.kernel.org>; Thu, 12 Mar 2026 21:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I6CnyQAkwuxPKlDMQnXc9c5lwIeZ633Jm64d8FHO8OQ=; b=dBPoQsMo1Z9hY9+tJADUmlBwJE
	Y1EXAocRP9azSbaZk1NDbHKUyhwjg37Byr9zO2/3pDHgZvOnCd089Ab8s8+VSpDSULz9w1HRAbb3Z
	cOi1ryQ0Ytp53Q2qlePDobEX7bmH6kQLSweYSHD+61Oz2Q+Hyou9uTIwyFUbI8z1AgnvamvltBQ8m
	GvdfQtLQ7Cmv/lMYtELz63wFFEJ0BUSta/3UNE0ZOqqAG7kK//WeTlsfUVmU5vJIn8Z+aJ9UbSDMJ
	G7fLoMzXv2f1RfVN58g47dkvgN6EhDdw1xNwUAwZwmLAmiqwfgiZRS9+q+OyBFVEsMDR7VAWLB5P6
	zghOT2xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0o0n-0000000FYZX-2J9w;
	Thu, 12 Mar 2026 21:56:09 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0o0l-0000000FYYs-1CHw;
	Thu, 12 Mar 2026 21:56:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Reply-To:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:
	Content-Type:Content-ID:Content-Description;
	bh=I6CnyQAkwuxPKlDMQnXc9c5lwIeZ633Jm64d8FHO8OQ=; b=iErH8ghZtwb8FdR0qv4Plzjk6m
	zwuhESyxo0MYxpu1OQCFtN+XoTS2J1S5MTh4jEusX47eh+Dvj/RKXDdDCXVT3VYG01tp65mAf9L/0
	ztI7JwVEMzPVY5PHIDVNfx/0A2UXSzEm4gcgajsh23sCyZAmttNSvXAA0GpDvrnbwhaVjddzsw9qB
	CZN1NC69tVe6n8jGzYkSMZObiqJzltGvjVW+j52IL88Fpw3PLLWdEYV3Os4NCiekp6Qjl6hoUIRSE
	usDw64/9otPRLi7eFpqKoo19RMQSN0JfE2gQF2QfjfEnR3EfHBqWiyAtjiCJYS2e92B+dBJobx40P
	HB5oA9JQ==;
Received: from flow-b6-smtp.messagingengine.com ([202.12.124.141])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0o0d-000000029GR-1CmU;
	Thu, 12 Mar 2026 21:56:02 +0000
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 0347F1301BBC;
	Thu, 12 Mar 2026 17:55:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 12 Mar 2026 17:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773352556;
	 x=1773359756; bh=I6CnyQAkwuxPKlDMQnXc9c5lwIeZ633Jm64d8FHO8OQ=; b=
	V8DLV4wcDGzhYebZPH4WK6E6cnXp1js2ckOETA/mb3gtKYUj8AtiU53pW8X5+uwx
	xh/Uo66CpTtUtZ4jmkXHAQhGC4g6P4sRJXtaWRNrdNLwnuZ5n5RNAsWDL4ky8tBQ
	w/VWSQ8ARbp+TTDBFg1VsxOtUfZiPyg4tlmEPKgESKCF4WIdXQ7cNpBcnaZg18/r
	NbDqlQl08OCTnlmB7CBOXZ+sKDVWJoDSNdAUKfQorFSUOlBf2VJ63I8JUboZYz4y
	sYVGOC28gblJ6pAGHKCTtDhMiB3lAojFXsfrVjP9t/rpcJ8NBgxsTkxpogTSS/Jk
	NyUn2RHykhm1Zeb6v7POLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773352556; x=1773359756; bh=I
	6CnyQAkwuxPKlDMQnXc9c5lwIeZ633Jm64d8FHO8OQ=; b=4sXEIXuXZzpHdzsHY
	PI2r+pAeLO3D1p9t181hTerhmfrg1ujOX7AFVzgJlZAcUkevJbGyuacKaowYC42F
	kdrHTycOi5y9e88M4rq8+FOkXdbfBVGkRwOttka4u9t3gG9suHxbCZlzQ4HZf/fX
	cMzdXresl/Tkvk+CBFO67YH8oWWSjLVZfiA8dtQvrx+Pl1/0kBZJlHs++PpApXtf
	RkpDy4SrMA7h42gvYoK3MPokpoC5AnexXDVLyOxJsVhsRP4aCVl63NbiK/xmBzYP
	UsHcxRBRy/yDgJXHMafRUDiKl/NYzkWF4nJppx9bDb/T5j5kpS9zlYtGSAwheDR+
	c8bMg==
X-ME-Sender: <xms:bDazaZrV28pidytb2CYdFve-dYh4A17kCWOK2uAL1o4fmx--K3xe7g>
    <xme:bDazafUIGe5MYqXQD20ERLM0fjljLJS1qLyRBTW1m1z7XOTTBabu4SUJ7K4f5F3ag
    UlNbuIMnuD6VD0QNIHGQEP5HYfEuFFkMrQuosAE9lik0RuvSg>
X-ME-Received: <xmr:bDazaRT84owQtzmu1E0sWlHYeRbIptXgWxDzjLQfhyeWsMzpDUz0FxZfOYGz-by_i908pb9VVQdmsTc4utEjIGAT_GSE4xivjUQziUP-OuUx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejleduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:bDazaSUsCGEjzBteuH5vkHe0hneFVXDir_IRGQ5mVK1VCyydF7QpDw>
    <xmx:bDazaeYmeBRieWGQHtvJip14aHkEz2FCB_NvPB9keh2Yshf6AzVEDw>
    <xmx:bDazaY-7VYc2D1GPJaWbiimtqzocm9ZyVp3WLpcNsYY3sAaV8eu4Ug>
    <xmx:bDazaV6u3_amBzfCr8zxdPKXl0rmxXcDwGlJnKOJ4bx25fBZdOe-8Q>
    <xmx:bDazaR3pE1IGQUmm0mhqqjDrKLG1FXrx_IG_1fXiekIIHnyGeXtkG-Ex>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 17:55:43 -0400 (EDT)
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
Subject: [PATCH 43/53] fuse: Use d_alloc_noblock() in fuse_direntplus_link()
Date: Fri, 13 Mar 2026 08:12:30 +1100
Message-ID: <20260312214330.3885211-44-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260312214330.3885211-1-neilb@ownmail.net>
References: <20260312214330.3885211-1-neilb@ownmail.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_215601_031114_BCCD9C63 
X-CRM114-Status: GOOD (  14.75  )
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

fuse uses the results of readdir to prime the dcache.  Using
d_alloc_parallel() can block if there is a concurrent lookup.  Blocking
in that case is pointless as the lookup will add info to the dcache and
there is no value in the readdir waiting to see if it should add the
info too.

Also this call to d_alloc_parallel() is made while the parent
directory is locked.  A proposed change to locking will lock the parent
later, after d_alloc_parallel().  This means it won't be safe to wait in
d_alloc_parallel() while holding the directory lock.

So change to use d_alloc_noblock(), and use try_lookup_noperm() rather
than full_name_hash and d_lookup.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/fuse/readdir.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index f588252891af..400a1a24f659 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -12,6 +12,7 @@
 #include <linux/posix_acl.h>
 #include <linux/pagemap.h>
 #include <linux/highmem.h>
+#include <linux/namei.h>
 
 static bool fuse_use_readdirplus(struct inode *dir, struct dir_context *ctx)
 {
@@ -192,14 +193,18 @@ static int fuse_direntplus_link(struct file *file,
 	fc = get_fuse_conn(dir);
 	epoch = atomic_read(&fc->epoch);
 
-	name.hash = full_name_hash(parent, name.name, name.len);
-	dentry = d_lookup(parent, &name);
+	dentry = try_lookup_noperm(&name, parent);
 	if (!dentry) {
 retry:
-		dentry = d_alloc_parallel(parent, &name);
-		if (IS_ERR(dentry))
-			return PTR_ERR(dentry);
+		dentry = d_alloc_noblock(parent, &name);
+	}
+	if (IS_ERR(dentry)) {
+		if (PTR_ERR(dentry) == -EWOULDBLOCK)
+			/* harmless */
+			return 0;
+		return PTR_ERR(dentry);
 	}
+
 	if (!d_in_lookup(dentry)) {
 		struct fuse_inode *fi;
 		inode = d_inode(dentry);
-- 
2.50.0.107.gf914562f5916.dirty


