Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263CA106FD63
	for <linux-um@archiver.kernel.org>; Fri, 13 Mar 2026 00:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yta/ONG6ZSj6rRZhdNMJVWJN5o8jH9bKyVShEpbtcv8=; b=QaoYre1w/EZ6rwpxrgA2g4MYXD
	EVHnYjrcDpXFo0jTlS67t2lQzzVs87ns6pL4/fF3dvDMaPIZFTn9WJXn60ayz1KDI/k2BGKeBJrGS
	r+g08doJiXrIiBnFcdmKaqduEg8Dcu3mlGmo/faEXfwlS+ZGPNsmJLHUOlHDxZL3E7abOPUEaaEOO
	CRl8HNUI3VVGUkCPzCMQ8Pv1+Lhf9fTxgNiBS9VVLRV3MVrnBkOOFGeGiPscZEr87uzH3vmSfk/gx
	vIgpU4FdPD+rwfv/3Ky5NpjvOuHh18EhT0zNzDtDHjg9oKwuHaEUZmszw4qWhwFExgUpYB5Cu9s+6
	9rEcNQqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0qf1-0000000FyYA-3mAc;
	Fri, 13 Mar 2026 00:45:51 +0000
Received: from flow-b5-smtp.messagingengine.com ([202.12.124.140])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0qey-0000000FyX3-2vMl;
	Fri, 13 Mar 2026 00:45:50 +0000
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailflow.stl.internal (Postfix) with ESMTP id B728A1301B4D;
	Thu, 12 Mar 2026 20:45:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 12 Mar 2026 20:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773362746;
	 x=1773369946; bh=yta/ONG6ZSj6rRZhdNMJVWJN5o8jH9bKyVShEpbtcv8=; b=
	cE1Lg/xFP0Sm6V6om+xiR/woiTWX3KvncecIx4H7TAb7iajTj5fptF2VjhZpgpd0
	ysGa6UL0ZOe44vo9fTWe2s1758oiXSmJXRDbStoiiOYNb+G9/etnJNkRra4M5omW
	o64ruAeKGRLUYzLPoIZ9aCSyQPaC5Ukxh1B1OhK7z2H5FJQQw9ASMVBMD25RzYzi
	q2TOTwjNXuXCv/Bq5muEBZJ+JHbO9mmaH/rWBsYqQZb5lD4v4JbjoJpiPNi3odoa
	yTtnxM4U1DcBgoK/KMObBZDwPj5ll6Js8Ek3NeZ8y4iE/SaV+MfJX23XtPecVIsU
	NOB8quAvQHVIeMvGkWnN0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773362746; x=1773369946; bh=y
	ta/ONG6ZSj6rRZhdNMJVWJN5o8jH9bKyVShEpbtcv8=; b=jM9+cNGiMa0yJ821j
	XIe2hxjc7cs5JRvyn7N6B5ZpVJXWj9HHAS2ZvHu3CkvqpXMjLDtwMJjFOi9cFMEu
	Rk3aQr6q4AX5TkjM0iTuRxCSwHdBERW3BTGo/GzfF9O7hqF5xllNf3j+JQ9BIm07
	BbbnxSIgg3jKpkp1rl9gnujcjR/h+SycfQQ2Aw1zeb/bZoETR8Ln24k6bNqXqhDn
	VXaDWsXcHn0IhZaz4RAdBSwoKuRcFM2Mxtmju40VQ0Dgbsb2r7ZjKEACZ8XG5vki
	bQ08kv/ZDmo/me5yB8dh9Bl0ipZV5O9Pr21Ssej5wEjMd91ZsFHSDNQioqUwGP1e
	xMYwg==
X-ME-Sender: <xms:Ol6zafPTAh5iyfKfObdIwIIH-DPAEO7RXCgCvuqj6Da3srDy1XhGGA>
    <xme:Ol6zadpKQwaE3kH6vbdGP6vttjjONeS6m5VhBK7bJTqWFALTEkh1lbvTUPZyvkh3L
    c5nUsGss7B3w2sBdKcdiPO8AQ5u7lMIdWr935HG9w9ruYpm>
X-ME-Received: <xmr:Ol6zaZXIMCP7jQVVc1TpWWXWFdCJ9_xWjYal3FO7bSh1BX4J7XxZbzm9NO4TfQfGr1R8k9N34NzPcFgEa7JZaGgixP73NGG-CUrB3Jl2a3YH>
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
X-ME-Proxy: <xmx:Ol6zaRIl0KrKDlVxTc8vmm6gZul2PScXU5ABlFGkUYVvXSMb28vcUQ>
    <xmx:Ol6zac8Rvij0TR8ZUGKR3kDzk8UBJDuVvSIDUOU6pJOqukWtmu8R3g>
    <xmx:Ol6zacQW9JaMS68T7EYQbCnpG2MF7XL0b_qisHQFa-6E5FDrFzNdFA>
    <xmx:Ol6zae8hGu7rw4bI2RmmgVv0xWuZnZpmTNu22dJWI8wu1e2hliOHUw>
    <xmx:Ol6zaQbLe1NIHq5gZjw_a_2f7LdxW9ue9XSvnCyYnyPKZ2m58iuovPm3>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 20:45:32 -0400 (EDT)
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
Subject: [PATCH 28/53] smb/client: Use d_alloc_noblock() in cifs_prime_dcache()
Date: Fri, 13 Mar 2026 08:12:15 +1100
Message-ID: <20260312214330.3885211-29-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260312214330.3885211-1-neilb@ownmail.net>
References: <20260312214330.3885211-1-neilb@ownmail.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_174549_383244_4E0A49F9 
X-CRM114-Status: GOOD (  11.50  )
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

cifs uses the results of readdir to prime the dcache.  Using
d_alloc_parallel() can block if there is a concurrent lookup.  Blocking
in that case is pointless as the lookup will add info to the dcache and
there is no value in the readdir waiting to see if it should add the
info too.

Also this call to d_alloc_parallel() is made while the parent
directory is locked.  A proposed change to locking will lock the parent
later, after d_alloc_parallel().  This means it won't be safe to wait in
d_alloc_parallel() while holding the directory lock.

So change to use d_alloc_noblock().

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/smb/client/readdir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/readdir.c b/fs/smb/client/readdir.c
index 47f5d620b750..dabf9507bc40 100644
--- a/fs/smb/client/readdir.c
+++ b/fs/smb/client/readdir.c
@@ -104,7 +104,7 @@ cifs_prime_dcache(struct dentry *parent, struct qstr *name,
 		    (fattr->cf_flags & CIFS_FATTR_NEED_REVAL))
 			return;
 
-		dentry = d_alloc_parallel(parent, name);
+		dentry = d_alloc_noblock(parent, name);
 	}
 	if (IS_ERR(dentry))
 		return;
-- 
2.50.0.107.gf914562f5916.dirty


