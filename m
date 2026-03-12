Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D6F106ACEC
	for <linux-um@archiver.kernel.org>; Thu, 12 Mar 2026 21:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8hxhCnV9U6zmeL8OYJrlmY7rj/yQGmrUt+8UFBTzKtg=; b=zfZagxDxFrhfzk1Fe7OGYzMuTj
	NYyzlumrTelFjl892kfN9VXwo/37SFJ01f0hGgW3I6Nj+9FG0z8vuZWehB/KpN/9kFgVQlUQTrRUm
	DCQFGl05EdlNRd7btp4C9p9pt+q9M4Tgg5I5mH720Jjj7V1YIMW1XOER/T/u1ni5ny1xaRq7cdqXv
	KI5UdQNlszifXtg7W5Oh7oGBYdy7hvUfqfGiIcpMT8BN+yI6eCWGpyTw3hk0dFA8FN25pOftShQtb
	gQIF2QcQK+dePUlSxHGhVEg+dpkATQgSAf8h+jYGrgeUTj+X+jKdscQcxtE1QMa5iw8YHTb7ZeiVM
	217Bbj6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0nth-0000000FXBn-0vQM;
	Thu, 12 Mar 2026 21:48:49 +0000
Received: from flow-b6-smtp.messagingengine.com ([202.12.124.141])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0nte-0000000FXAs-3cJL;
	Thu, 12 Mar 2026 21:48:47 +0000
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 0865D1301B8B;
	Thu, 12 Mar 2026 17:48:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 12 Mar 2026 17:48:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773352124;
	 x=1773359324; bh=8hxhCnV9U6zmeL8OYJrlmY7rj/yQGmrUt+8UFBTzKtg=; b=
	YiFgW3M9c4+BqqZQJA+22GBvrn30b/igbH0adx0uC69vr1gxmtdnWHTXSLtGZ1v7
	vE8AO38ThUJuxgrxw9XxjwQUNmiEN3pJjN9OptD9mzSioPXADb7E1O+EsYDpyNTc
	YdDide8ZPwAVPNcdbMUJdPj3GrpsmnSxGlz6tNKTziSuxrFzDgABnzqIvg48Uo5A
	d+Pl4wmzy+RLHOf0e2eeJC2r9wTFiefv+UodRNLArqD91vyLKqd55rcnDT1x1RVd
	s0tzcQj3gWkhnCx3w8SwRX6n2lcgXO77X8jg7SxXoy33jHmIl7FwkDml0cUSuTSS
	EUcVXtbPpLAzS1r4NI//NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773352124; x=1773359324; bh=8
	hxhCnV9U6zmeL8OYJrlmY7rj/yQGmrUt+8UFBTzKtg=; b=nvhsCJHiqZ+mas8ml
	KbZ0MpLKNgbhychg1yEE0z+mDKaZ2xC/Z7ex8NS3Ayigl2vn3dn2DpixzvgNyWGH
	EtAcbXjLqI2hmLhCVkKnPvjB54+2sXL4B6XMRBWvZKYbXubc412AfpNsT3mA+43U
	9Zc3xeIA762Ej5UQeJiKcrkcCl3qndb3Gi9jhKAZgYkOw0NKm0d14b/+/q3UHC85
	Woir5+CeVR+o8DsbEdUD74X/kDfbBBoEnKHDbeSqDsPRMT71BYUZsJw6dIverl2S
	rUDX4MtqSOexyOlIIikP62Ve4xks0MbrKiHi7RLjhMX9Ddqib31JGdw7vkM0IgnX
	h9mRA==
X-ME-Sender: <xms:vDSzaeDRyHvMRzUJWeuFDLL_WpOWPxBidorFlsg7ALzZmVszVsxKAg>
    <xme:vDSzaSOq4tHLpHuRcmav09_mZPCLNoF4Uc5mLwMrpCBzar6Dl-HMFwvWm3c9dheOo
    3W3YgS2dEkZDq94WZiSquFEfjyu2xJ94E0Vmks4wW82zuB6CQ>
X-ME-Received: <xmr:vDSzaYjCGvA38LnK2J6PAiSb_W8ESyLdOp5PVn-ZmxcaXJ4ZIZQMWiin3OzYsWa75kclwTovgBRdTVeFxHXoX4VNK6LoSLyhTyiUDp0CQJ7D>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
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
X-ME-Proxy: <xmx:vDSzaQ0hwy_nS5OU9CELIkn0gcmn64b1OAlxyFVAiK_80ro9S9zTKw>
    <xmx:vDSzaSpI9fB4vLdI48ydxjjYlM77m1eKi9dRSOVd-S4yOArH-Z-npg>
    <xmx:vDSzaV3OBVEQpPW5BZTS6MXEYj0n0naIhj6vGBp0FNbSdStZjiYsPg>
    <xmx:vDSzaXxC6TVqo_2nLdQP6jL34HDW5eWNS2ZFDt2SctkLTmtwjxOpkA>
    <xmx:vDSzaVpN6CMMUybH5s849JM1MXURYcAp3Q_A3QG4DxV0RatYQMVsmUEu>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 17:48:31 -0400 (EDT)
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
Subject: [PATCH 15/53] nfs: use d_duplicate()
Date: Fri, 13 Mar 2026 08:12:02 +1100
Message-ID: <20260312214330.3885211-16-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260312214330.3885211-1-neilb@ownmail.net>
References: <20260312214330.3885211-1-neilb@ownmail.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_144847_004121_EAAAA8CD 
X-CRM114-Status: UNSURE (   9.96  )
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

As preparation for d_alloc_parallel() being allowed without the
directory locked, use d_duplicate() to duplicate a dentry for silly
rename.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfs/dir.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 4b73ec59bbcc..655a1e8467f7 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2781,11 +2781,9 @@ int nfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			spin_unlock(&new_dentry->d_lock);
 
 			/* copy the target dentry's name */
-			dentry = d_alloc(new_dentry->d_parent,
-					 &new_dentry->d_name);
+			dentry = d_duplicate(new_dentry);
 			if (!dentry)
 				goto out;
-
 			/* silly-rename the existing target ... */
 			err = nfs_sillyrename(new_dir, new_dentry);
 			if (err)
@@ -2850,8 +2848,10 @@ int nfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		nfs_dentry_handle_enoent(old_dentry);
 
 	/* new dentry created? */
-	if (dentry)
+	if (dentry) {
+		d_lookup_done(dentry);
 		dput(dentry);
+	}
 	return error;
 }
 EXPORT_SYMBOL_GPL(nfs_rename);
-- 
2.50.0.107.gf914562f5916.dirty


