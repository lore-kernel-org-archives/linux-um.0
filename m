Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 939CE106ACEC
	for <linux-um@archiver.kernel.org>; Thu, 12 Mar 2026 21:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V1Hs5eklgfQn0H62/n/RsRquBHKKGkv3SWjXFgqWxeg=; b=AnpCvrPs9WRvpGqItAHRHkZkzd
	XSiUX7v6vxYQG93GgYxWaFpLnJ0nXYxDpuOcPAVBiuBYwiFzt0hLUeaxD0ogrXFce50JwCK83TKiG
	pM4g7E5vhBkF2ojzWUVe8ZSVuZKWM/Ig8lQ6aMZDmT6PQ7eWMCZAWQ4dSnDJdMO+F4Flry/6J4dKP
	MhbakJ6g+ziw8cXBqDmcu4sxfn/3APZlFPgY5p2hPIHnF3jBiyhIVxLt2uLcwHyhyyKzDa16zNT3u
	C611LEe7fKpXz2qP97sV15FBWVWTT233JPhqOzovmaJQTknSFfCdM5ISStvf1Qx+ddy/N8Qtkv7Wj
	Rd82jSIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0o1C-0000000FYhB-1Amn;
	Thu, 12 Mar 2026 21:56:34 +0000
Received: from flow-b6-smtp.messagingengine.com ([202.12.124.141])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0o1A-0000000FYga-1gCr;
	Thu, 12 Mar 2026 21:56:33 +0000
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.stl.internal (Postfix) with ESMTP id 84D321301BBF;
	Thu, 12 Mar 2026 17:56:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 12 Mar 2026 17:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773352590;
	 x=1773359790; bh=V1Hs5eklgfQn0H62/n/RsRquBHKKGkv3SWjXFgqWxeg=; b=
	BjVQ7Tij/z0cXHesrQNauBD40mf05TL+Wj6m1LoIvu1L/NzpAqGZ5cLMMYGVnhHH
	5qpQy4Dpm9bq8Pb3bQ7SLoPEAN90xLCEzbpDBw32FsuGAR+9EIQaGhiqQ98SwOaT
	QOjIC4JQ26O0nUw/gfHxixp9O2LeLOAfcv7ko1la8I/jwje3ZAcm/+yUWtQegekd
	SEaAK9AahEsg1k6Lo05tjFqkn7nUv2p2kEM2DQJCJhauy4winthpmj9pCKsDjw+g
	LbL1Ut73HTaiBOaqfNeCA2hdtVcLqDwM9vhFb2A/Gp+vNDKEnvCIcGUBnuRQC5w4
	c1vlq/YTLJZHkxtZdNo3ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773352590; x=1773359790; bh=V
	1Hs5eklgfQn0H62/n/RsRquBHKKGkv3SWjXFgqWxeg=; b=YpiNzHFW7/D9ZPSMi
	cZJKUNBZwgvwypUiNaP/NJM1ssRQhwagO51x7MSYiJEweucl/LQJMa2SKCpn9TMY
	zKHk3Y1z+6lpK6TbV+SLBojRbVgzqxTumBjH8yjZlwb/Pw05pMeeuDj3VQASKNMH
	JI1m/tgCDLltyQqPzDgUlE9fDYaQup9pOGAFgK5F8pGZ2h+PJQKg0JYnhCf6Anpd
	cMP+lNg8R98vHR1s3CC4zCU3o+z2qTy8ZvFno6N0EEpF2DC7MXEjoQhGkqR0/QDv
	RkF1A/8dkZ52tjjo3Ye102S9dNRb2q+2o8wsWe6EZ9KjKj0zQND+rl+xPCwoT4um
	OVbAw==
X-ME-Sender: <xms:jTazac6FLGNVN6mYXBnDf9SGBJ-5AaLarvcOU8zCdKM-rgD0nm37qA>
    <xme:jTazaXkaZi6_Q0Jm-lBvOu9zaiUvR22nAfEL3fp-sBQlrI8G_kmh7gL0ayaRInKRk
    XZIxzM9PotaAMQ3cBeWj4acBkT0vf9SDWm_3_E5WG_nMyTpIg>
X-ME-Received: <xmr:jTazaSbbRo76-Cc2ogkQrvL-OPYQ5JCvn2bqCYzr6nvGNZAfbGpbGDH8PFUEvXXPdJaMLQJOCbVZDerV-oar65urrK5fVyegZAnq-kIPqB6X>
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
X-ME-Proxy: <xmx:jTazaVOQT9zD4viTQ4xyy0f0WkaSFD_ev8WbCWz_uPQ12WavoQ_H4Q>
    <xmx:jTazafiMQd2syhHGHNy8Myu4LisMaLIGGQkEyIGzYQ1rYsquHpExpA>
    <xmx:jTazaRMuOIUcjmRzCMyCCRij3jggwxOGlKVoNhuEHX6MGQkKuIhy1w>
    <xmx:jTazafqGIcE8OMyW4BiXoDHDYQOqT2BRlWtBkIn0WX7qznzvPQMgOA>
    <xmx:jjazaRA3wD6VQKs5bEA6Zod3_QakbUuuwwdoM7KaYYhvXHRdFmZWbWeV>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 17:56:17 -0400 (EDT)
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
Subject: [PATCH 45/53] efivarfs: use d_alloc_name()
Date: Fri, 13 Mar 2026 08:12:32 +1100
Message-ID: <20260312214330.3885211-46-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260312214330.3885211-1-neilb@ownmail.net>
References: <20260312214330.3885211-1-neilb@ownmail.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_145632_543225_FD5D3F61 
X-CRM114-Status: UNSURE (   9.94  )
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

efivarfs() is one of the few remaining users of d_alloc().
Other similar filesystems use d_alloc_name() in the same circumstances.
Now that d_alloc_name() supports ->d_hash (providing that it never
fails), change efivarfs to use that.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/efivarfs/super.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 1c5224cf183e..232d9757804c 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -189,26 +189,6 @@ static const struct dentry_operations efivarfs_d_ops = {
 	.d_hash = efivarfs_d_hash,
 };
 
-static struct dentry *efivarfs_alloc_dentry(struct dentry *parent, char *name)
-{
-	struct dentry *d;
-	struct qstr q;
-	int err;
-
-	q.name = name;
-	q.len = strlen(name);
-
-	err = efivarfs_d_hash(parent, &q);
-	if (err)
-		return ERR_PTR(err);
-
-	d = d_alloc(parent, &q);
-	if (d)
-		return d;
-
-	return ERR_PTR(-ENOMEM);
-}
-
 bool efivarfs_variable_is_present(efi_char16_t *variable_name,
 				  efi_guid_t *vendor, void *data)
 {
@@ -263,9 +243,9 @@ static int efivarfs_create_dentry(struct super_block *sb, efi_char16_t *name16,
 	memcpy(entry->var.VariableName, name16, name_size);
 	memcpy(&(entry->var.VendorGuid), &vendor, sizeof(efi_guid_t));
 
-	dentry = efivarfs_alloc_dentry(root, name);
-	if (IS_ERR(dentry)) {
-		err = PTR_ERR(dentry);
+	dentry = d_alloc_name(root, name);
+	if (!dentry) {
+		err = -ENOMEM;
 		goto fail_inode;
 	}
 
-- 
2.50.0.107.gf914562f5916.dirty


