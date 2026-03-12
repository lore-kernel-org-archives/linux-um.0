Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C27106ACEF
	for <linux-um@archiver.kernel.org>; Thu, 12 Mar 2026 21:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fpyBzrNDFKyBNYiy64/Yla5qtyKgmTDryIXyDQiUsjs=; b=L/QSdxbQFPCniMZMVt8EtIJDdL
	oZ1yNKLaQc/N6WrnKelNGtAUB2MOi+27RtZQeOCWvpB+S9+u96c23C8cSojReEx+09aL15S2kmcsK
	IBHKpaZlWZKL8gMO0z4mdYpjbKxW0E7fTqtinYWJBn2FLTGwnTcK28yty9p3SrU7/EBcj4Eysxlob
	+df5ove6LMRJc/C3TtF/rBhWDAmK8osukwwTRBbt72HrgjwyXFwjFMOmxgBTZiu/7KWuZPDbDXTeU
	nagb4zonbZKXELhRgNduW+WP3c4ykKGCOAo3v1GrSHFYWc0d/016dX3LrQkGw2ZgM/ghIPqTIHCIp
	cUkpfHpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0nzY-0000000FYCh-174A;
	Thu, 12 Mar 2026 21:54:52 +0000
Received: from flow-b6-smtp.messagingengine.com ([202.12.124.141])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0nzU-0000000FYBu-2sN1;
	Thu, 12 Mar 2026 21:54:49 +0000
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 897D11301BB1;
	Thu, 12 Mar 2026 17:54:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 12 Mar 2026 17:54:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773352486;
	 x=1773359686; bh=fpyBzrNDFKyBNYiy64/Yla5qtyKgmTDryIXyDQiUsjs=; b=
	R9VPv/ziHvarZw/AQGr9s/6SlcupzBGjtLFg1jEyRvdzFV/RJz3QlbiVW9PogxcB
	uq19ftZqv/w/QB+pWd/PtWQzykeuu9rN81RyybCP7p3uOes5ycCdcxkqVLcaFgPt
	GbQUYu/U5zZS8o5E7pQfGKiz957WUj9u86OrYOiA2bVJEDZlUx7NES0TytyApQGj
	x/jLnyCWW18lBbJSw9b8gm5gl/mwwM9pz1Dw/lA9mL8IRMxgFcmDqjLK7IMbs3Gc
	bPfTT5o+RFQFgP29SGUNKI8B7dY5Gskl7wM8hscfVf6RYD+N5EHvFqkJI112v06w
	cZ0Y3KvOZIJXTgIefJVRXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773352486; x=1773359686; bh=f
	pyBzrNDFKyBNYiy64/Yla5qtyKgmTDryIXyDQiUsjs=; b=lvCNqQrxDQEkh9EE9
	DHdnoLQKJXZuHP0lw6gbA/RNYrUbKF152er2Ht3nW70QAjga1J49zCLwHjK2p/Y7
	BJswoCBt0LZR+bUq+QMqYPbhP8R3Xp09DwafNs5xNgE3kD5ZV0k+BJq98zKU9Zqj
	sFQJ2d+d7F/KRlK06Vfv/0SRfilvI/OTiBSxO0HngUIpIhxrNM9wM/PFIIuR7uOL
	15ONu6WzjQxb92eSo1if9CPu6HIkyIhlPYQFlroJS4Yn9zoLdn+2uv3griNSBuSn
	VQ+9fPyb/vhGnCvTBIdeahqB7kgmyUz0Xfp3NYe+xhSZqP+PK8CIlW8j2sDwrak8
	c88vA==
X-ME-Sender: <xms:JTazaaLTXPY0lW_r5GxWLpYSTzZ5XIG-MUtCmLGSJalAt0Jxt-kyJw>
    <xme:JTazaV1ioHfFOkoiSkUr_kki-xWQBmOgK0GpLQQ7JwYno7HKD4ZqE1m0UTqHQY5i2
    BikshymDZavbsnTX2xSE1OYswjqxBYqIrl1x3oSfq7smMuCiQ>
X-ME-Received: <xmr:JTazaVx9t1HsoGNgk8X-449EYfPcde2N9cnjcQzToEYKYavNbdKMFm75TaYUFpRbM_tgRnvf4IFotsd1JHwWkuMEGOEvbTp0lKedo3rUiPKc>
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
X-ME-Proxy: <xmx:JTazac3nCbojWLHfcxWBM7ihJmqwG17cby5TrKLcC_09xB10S5Rc8Q>
    <xmx:JTazaW79rTcZoSvXrQoLretwFpAtB_DfWpj5iEv7u5-3O75zoLz2zw>
    <xmx:JTazaXdDYJlOMSReScUwwg6IU3z-cDWKKve-4kemj4-Cof71M6Nm-g>
    <xmx:JTazaSb8VZWu5_vRWHgPSmkV8kGIrlJa9-c-i9_vxto0G-p2SRPELA>
    <xmx:JjazaaU3cuTt1axgUaJnB0tCd7dxg9-0mSMffoYD0j9ht90DvG8qbNQg>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 17:54:32 -0400 (EDT)
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
Subject: [PATCH 39/53] ecryptfs: stop using d_add().
Date: Fri, 13 Mar 2026 08:12:26 +1100
Message-ID: <20260312214330.3885211-40-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260312214330.3885211-1-neilb@ownmail.net>
References: <20260312214330.3885211-1-neilb@ownmail.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_145448_826530_D402394E 
X-CRM114-Status: UNSURE (   9.47  )
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
function.  d_add() often works and is not incorrect in ecryptfs, but as
it is planned to remove d_add(), change to use d_splice_alias().

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/ecryptfs/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 8ab014db3e03..beb9e2c8b8b3 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -352,8 +352,7 @@ static struct dentry *ecryptfs_lookup_interpose(struct dentry *dentry,
 
 	if (!lower_inode) {
 		/* We want to add because we couldn't find in lower */
-		d_add(dentry, NULL);
-		return NULL;
+		return d_splice_alias(NULL, dentry);
 	}
 	inode = __ecryptfs_get_inode(lower_inode, dentry->d_sb);
 	if (IS_ERR(inode)) {
-- 
2.50.0.107.gf914562f5916.dirty


