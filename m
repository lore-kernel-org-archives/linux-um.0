Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E96F5106ACEC
	for <linux-um@archiver.kernel.org>; Thu, 12 Mar 2026 21:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hNooXh8tukAy53X73o1gk7dQ7zysETg4G5i0zUIVsso=; b=NSyJ0JdzgYYyNqpEnC3ppdnQB6
	7sLZINIDk2tiSdaEvPZrT306eBzUqg25r0E+SCi9BoQWP8n0akrgYIbG5pYxK7HkU4Kj4WrMuZ3oY
	QcgdDFI6UY/4Dncs9TbvvjWS4/RMoXel4fjQ2ZdPwoajpVJk7cuq0CmmO3+N3fwyKHuR9zJArvLVt
	yracK8QMAr8hsEaiBDYh3ZQ0WjaCcdu+F5TEheV60WYNGkrbPm2ZAfcdPkCTqu1Vt4zqqFWgP/duU
	xTSJDKJH/TKTFoUf5J8+/K4n1M8xmT+e/mNMD5I1JG+9lrJdQ2DytJLmVUNj7FWA2gDAyxDL1GRGu
	1LO0IYFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0o0w-0000000FYci-23ei;
	Thu, 12 Mar 2026 21:56:18 +0000
Received: from flow-b6-smtp.messagingengine.com ([202.12.124.141])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0o0t-0000000FYbc-2E76;
	Thu, 12 Mar 2026 21:56:16 +0000
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 8DFA81301BBC;
	Thu, 12 Mar 2026 17:56:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 12 Mar 2026 17:56:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773352573;
	 x=1773359773; bh=hNooXh8tukAy53X73o1gk7dQ7zysETg4G5i0zUIVsso=; b=
	U98BFMApU8sYPYQ7CogFDzIo34fTbwL3/llQtmzYPZfV0pgMqsNO+ST5FrQoK5D4
	MoEqSp37f3Ei/nvhh9gnzQ0Vj/dJ+HGBU1MPmSCSms/pLVOoHo3pYMHID/m1+mT6
	9aGOMWmkzPKRnfmBMXDMCQwGUY3khdFrwEnVLosiNx0qu0sFoGPySVfbV3/3hJpW
	VyBVlf2kOBR/TXmXdeKGHAcYZkzvQi1I4xDgBdvOz8abEkZU06o2QQM70xCkKIH0
	Nw0rDMrPWZhx2wVPJUKPNXNp6cRn7jvsDB+AcIp52fzIkt6gcOhQ2zcmMdBhejxQ
	zm50aAYFzBWFIWO7hUiU6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773352573; x=1773359773; bh=h
	NooXh8tukAy53X73o1gk7dQ7zysETg4G5i0zUIVsso=; b=Uq1hO5IhWegU28BI8
	tdXhi/CPmkZ7mOz+LkShu1oU2Xm2IdFVdV4/D9Cyu9c1dhFr6h1RwH8jyC39NHe9
	qWOS6s9Ci7FAcAYKjUGYJMM1qhTr7ZgUE8IQMq5yMA6kvK9cth7XAx8hSg8Hy/6O
	k8Gcv3JWxxdyfq6ZTwBlR8gmACl9067HX6Fr7XX0c1f2F9RYRFIRgdSedLKqQK4m
	bp2TDf5cQZsusRq5sp6pLqDfjaTZYakjOcWktAW4cJWMVPfXhQszFLr1NOsdh8dz
	p3Cb8COwX/iQRC5GlV6uaTyYfCvVeH10Fyw+vNSnfAsjFuzFbMTASPxaaKt8yEh3
	en+RQ==
X-ME-Sender: <xms:fTazaQCvKcgOfPynB2vf2syc47sQUi2N9jdtJmrJM51J6B5sgGFB_g>
    <xme:fTazaWM9mJfHxSvtWo8a2w1VRBJQjDxKJoImPoKNo68DwB56LTEqeGxvqYDzGPbuw
    vsyDoYLMaQJABne1iik5He1UY_vg3gahZXR4SM2cqZlRmCCoQ>
X-ME-Received: <xmr:fTazaeoij7oInvObC8rUmBYgYIJGpebYDqRsuuvwdJ1yQ9pNnase93-zXmbllRm9ZNS8J6ffsfpojXwGL3AAs6RWhUXb64ImzsbftBjg7AvM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejleduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:fTazaUP5gN-D4lirA6LzmVOxfRZGzc8xsfDoXI4j2DA06LwGD9K3Vw>
    <xmx:fTazaaxw2JFlHPp2G5UFctx4YbNX13W2oSSzCLuF5kZ31EyaL7jmkQ>
    <xmx:fTazad0IJSKp27f5u7czcE8bAcKqoY3ohFQ7Mceoya3vC3gwqf_nzw>
    <xmx:fTazaZSsfwh--nJBWI6X4a6YKlJKFc9VFs4ZjV-kDQLuqpQDRWNbIg>
    <xmx:fTazaeOsjXzpD9DbHcSr0M06EtmY5_eqE1q4W6iQ7ZsyUg4g1i2_xqDY>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 17:56:00 -0400 (EDT)
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
Subject: [PATCH 44/53] hostfs: don't d_drop() before d_splice_alias() in hostfs_mkdir()
Date: Fri, 13 Mar 2026 08:12:31 +1100
Message-ID: <20260312214330.3885211-45-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260312214330.3885211-1-neilb@ownmail.net>
References: <20260312214330.3885211-1-neilb@ownmail.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_145615_652448_7C82ED20 
X-CRM114-Status: UNSURE (   9.29  )
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

hostfs_mkdir() uses d_drop() and d_splice_alias() to ensure it has the
right dentry after a mkdir.
d_drop() is no longer needed here and will cause problem for future
changes to directory locking.  So remove the d_drop().

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/hostfs/hostfs_kern.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index abe86d72d9ef..f737f99710d5 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -700,7 +700,6 @@ static struct dentry *hostfs_mkdir(struct mnt_idmap *idmap, struct inode *ino,
 		dentry = ERR_PTR(err);
 	} else {
 		inode = hostfs_iget(dentry->d_sb, file);
-		d_drop(dentry);
 		dentry = d_splice_alias(inode, dentry);
 	}
 	__putname(file);
-- 
2.50.0.107.gf914562f5916.dirty


