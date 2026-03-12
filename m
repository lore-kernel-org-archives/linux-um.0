Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43013106ACEF
	for <linux-um@archiver.kernel.org>; Thu, 12 Mar 2026 21:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QdLbzmw/KSDnf0Z+kMRVM204bGIQfGT5DsH4LYpn9rk=; b=tV2OfnkLlrZkIQ4NS5DE6Pdogh
	rGGAATUwhP1R1DCKXnWJKjx5L3FrVNzehBiB0a3YLgJbplTuAkYN+EVjfmEw58lDcGiUxzouw0tEo
	fHVIIixAgnf8am88sylKTfWzW/ndR3YK6HzH364rtj+6Ob27eCclhw2h53lgJT/j4gKjIQ3d/5Sb4
	DmjoSlxauA13sOkL1TS190aAkS44CFrPA0Ho+kOqG5N/6n4g7r+6xoUczk9IVVbWwiY/pGtN0c/UB
	8X+abZsN7EHw59kgx5m+e+FhRMiIze5Ktv21Rp10Hli1JntLv/FXsJjhFhOtD3cfBXy+X+c8vTbsN
	Amd+wDOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0o04-0000000FYKe-04EX;
	Thu, 12 Mar 2026 21:55:24 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0o02-0000000FYK4-3kx3;
	Thu, 12 Mar 2026 21:55:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Reply-To:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:
	Content-Type:Content-ID:Content-Description;
	bh=QdLbzmw/KSDnf0Z+kMRVM204bGIQfGT5DsH4LYpn9rk=; b=UkGhtFx5WCDbvp7f41B9P0k14e
	UFzG1lQ1/zlx7iOgsUziVwt0UrfARPbaH2rC8wQe6+hp8eMk7EGYoga5wYqcEcLvQZPGvdWhDWCDv
	F09LihOetZqCsuPuMmxI6KwwiKSECZWmtCQbsYs+Odhc7+dZhyXj8bVc4wal75WYMJZtbN/BDpZvY
	vt+NBUQ5ONk0Aacfwu4rX2EwYB2I8DouX4Y5UGDMrCkT5r2EakgaHSQ08nYKU7C7EGUjsyk+YG8A8
	cqRJ6Z2KPvGNQs9OQV+HrxnMmKpHNUPb9KLwPaomTE5D11r5Ebb1C8/y9Q1pCot8wjcQjYd+kUynL
	ct4ithOQ==;
Received: from flow-b6-smtp.messagingengine.com ([202.12.124.141])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0nzs-0000000295X-47AD;
	Thu, 12 Mar 2026 21:55:16 +0000
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id A5B1B1301B6A;
	Thu, 12 Mar 2026 17:55:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 12 Mar 2026 17:55:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773352505;
	 x=1773359705; bh=QdLbzmw/KSDnf0Z+kMRVM204bGIQfGT5DsH4LYpn9rk=; b=
	LvUkteWZCDaoWYqvI6Uisnfitx8+ggZ7C+jDVARmw4MfgDHjnDypqJJX1nPL95Es
	Nag0d95y4bOlXv5m+pKizu4jWh5ahcynJTeDGkIUolBj+IgzzhsyXjFo2bfH0Qyv
	tKaQT582rw+TPUHzjlFD/YzofmzYyhPIuVAyhZa+ANuqDH7cXjyaGIOgEiIAmPMj
	/yBD02o3rX20ddAj2X9Lja60A73KqNH7Vbumy6bJPWqkV/J7oJhkcQE+7e0oY9oj
	8yrxJYAMSoJ2oQnH4ii8XAtCwFXq0JdtQ+OZyBx9LBztC94estrJlQ7Fb2RpHNci
	j9HTBYX57sNFqJtdD257YA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773352505; x=1773359705; bh=Q
	dLbzmw/KSDnf0Z+kMRVM204bGIQfGT5DsH4LYpn9rk=; b=FJNskYCqOEZkh+b+X
	kjQKFHwDK4nlkiMOH79i49kx6oyszytp/7cRmbQdR4TG6i+WX1zSfAfDFSj2Y1NX
	urfJRQbAe2/ZivP8ZlFzYw5Xx4Tjt0gBM+SYtqpX6Kgsv306S8wBnJ3NPxRIo8Gr
	U5NJ5syIF6Ijl8lBWd3BsfXtGZ4Xp0xg+1uBM5qufDdgQAu95mr5nsWl6MMtoXlQ
	/0yyYgynJbthg1j1IiLBfYq1sU6SKAay8XiDekf9/sJ9Swz/so6Zcq4L7c2DgnYV
	ED/qOoO5zm9sFslZ6prlPbvaBfLftMXMK7/uaBYc2tOu/H1h5F+TOPuSFUXn/JDI
	t0ykw==
X-ME-Sender: <xms:ODazaQF7k1KATwaGFlcBZZKpfc2WG5qJMk5fnlfxm1Vi7B8CBF9F0A>
    <xme:ODazadD_2IL7856JUXB5PVFIBNMwA3rDwgll_qpc4ZhOz7e-JQ0NuRoov0eB42WUc
    EF3bvsNaNg3qYNH_6PwXS9evSOT0CwL1GdwzFrQraqer4PE>
X-ME-Received: <xmr:ODazaVPZS9YqF9ZefzQt107DROar1zD2G1yJvDbPvT3o3mATZ6mSjon75F5jB5LVrojnzHvcAo4afzSenxq3zbhqdyMRDGucrx4hX3BDj38C>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejleduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:ODazafj5iHEVaQbQL9xUSPUswOF968qjB-7fYOVT8Wqivk1HLaeLDA>
    <xmx:OTazab1bv4yDY87VbPr_S6wN9LMoF8mSMxvCKipOcZJol4AgbiLq4A>
    <xmx:OTazaRplVN--MsA_JdAYXWXr-dyaNK_CIRfy2b-VOFGs-cHK8Mzl1A>
    <xmx:OTazaY3AxBB1DDvGyksBA06N9SqB_ZPRuIzdc1Nf4sBn6Jnxpg8YxA>
    <xmx:OTazaQQzPhe-KJWsJjAclLfJeMdfP4VJ_ZU2q5xz2RTb5aOEmQxLEFQB>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 17:54:50 -0400 (EDT)
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
Subject: [PATCH 40/53] gfs2: stop using d_add().
Date: Fri, 13 Mar 2026 08:12:27 +1100
Message-ID: <20260312214330.3885211-41-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260312214330.3885211-1-neilb@ownmail.net>
References: <20260312214330.3885211-1-neilb@ownmail.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_215515_106959_FD69FEF6 
X-CRM114-Status: UNSURE (   9.35  )
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

"Best practice" is to use d_splice_alias() at the end of a ->lookup
function.  d_add() often works and is not incorrect in gfs2, as the
inode is always NULL, but as it is planned to remove d_add(), change to
use d_splice_alias().

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/gfs2/inode.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 8344040ecaf7..9997fbc1084c 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -988,10 +988,9 @@ static struct dentry *__gfs2_lookup(struct inode *dir, struct dentry *dentry,
 	int error;
 
 	inode = gfs2_lookupi(dir, &dentry->d_name, 0);
-	if (inode == NULL) {
-		d_add(dentry, NULL);
-		return NULL;
-	}
+	if (inode == NULL)
+		return d_splice_alias(NULL, dentry);
+
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 
-- 
2.50.0.107.gf914562f5916.dirty


