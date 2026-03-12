Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3091106ACEF
	for <linux-um@archiver.kernel.org>; Thu, 12 Mar 2026 21:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MvjNqMKuVfQXHETrd+SGIKnCs3zts7xUVvm6x+LJmMI=; b=2wFwxJU3VGSb3Zr38PPBMmUCW4
	RmPNWwQQhqDDZSztML4dwP/Ry455u8bZQJfSfTBhh7EllZb2jbCuruRJklB6GwBhv5xaAdcywV9vh
	PSpXPb36+yR0YY8qN9nvRMMhfmIzZ5IJ3fweilABYrieOeQ0MU7l1S3zaBbQhHKtlsfXsLjo+WGWJ
	Wsn83aupt6GchDp8IWoQ0QuFFQsDngm224ix2ri4oD6+dNSeFsVhE9qGSVSjGigZsOK3If0tmP2q7
	6361ttoatSUU2/4VOKUugB2d6CGDuvhvZpCGOSM0od1z0vEIa5ZI2wAXLH4TA5AnUtNzTRgNLZr6N
	+wGZn/tA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0nt9-0000000FX29-2F4s;
	Thu, 12 Mar 2026 21:48:15 +0000
Received: from flow-b6-smtp.messagingengine.com ([202.12.124.141])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0nt6-0000000FX1B-1PvP;
	Thu, 12 Mar 2026 21:48:13 +0000
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 8543F1301B73;
	Thu, 12 Mar 2026 17:48:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 12 Mar 2026 17:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773352090;
	 x=1773359290; bh=MvjNqMKuVfQXHETrd+SGIKnCs3zts7xUVvm6x+LJmMI=; b=
	gWllsYQz3mEA2jMLnm1iwaOv8Tt2H4rwH82GHyjMfv6YepkAwC/O+UlfXVfbC3Gh
	ueXZPPOdpP3xulQmdZxxRVEkFxYyxx1ToDvVC63ek4y3nTDYVvkpfStMyiWXmkRd
	fkV9Df1xtegee+SYwTvZ8ujcV1aIlaL/awlKX+BcG0Qy+E7hBOfTsK1E2FpVwfZb
	Vw3yFQe7/OT8j6qNNCNsEA/sLbaT6S6m75UO8zkReU+Ny1GbWgEtJhfqf6Uy/dYX
	f6TIaZrP86TA/nECvJCJGfBvL9fVuJt+rupymlKEQmgPDG1sUGlgOyjvy4Q7yJGg
	N49aWqF3TFatF7EmhXk2xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773352090; x=1773359290; bh=M
	vjNqMKuVfQXHETrd+SGIKnCs3zts7xUVvm6x+LJmMI=; b=1QbTSibCpARDuoZ6a
	qBXGjBjG605a1kHrNXvGK2EDNgsNPebEmS0LCdfNycqiJW6y0XS72nIolK0QQgb3
	avki+yt5b3Qw4JQ5Aiu5A0r9FpQyj53k7GLhjZjlDieFxsRZhCYDzg/XlL36uRAz
	xHyrzP+wM7hlc8pcCvwvMYp8CZN7trtMnqEYqlMPs//4+h82amOGnS6lWFiXkTCr
	uH4ivBpDr4UYvERMqaIkvGkFoY5bBABprE0gB8RiuuaAyw17fvhlnIQvyWkqA0ag
	/3wU+iBXcux3YEyHDjuwWxUXZCSejGgN90VfAIrEWw8qHqZlW0e+7y9VpWl90OSn
	VpvHA==
X-ME-Sender: <xms:mTSzaTMq5K60rU6cQKTE4ltFtN0CJcOAU6zQzi5FuWd3zaaUn8RVIQ>
    <xme:mTSzaRqEsiyGu_hKT-Fp2oH51ktCB8pg4nqZq6zxhvYljhmAyjh5J9f9dIMGkeGv2
    XhGgZfdjmaVokbdcWDzjqGbrjfWU0eZqx_S6nQbxd1mtn9bwA>
X-ME-Received: <xmr:mTSzadWo-7RKkvLyBkFudwvdVKVHK4isFSTvkGvotGQXacqyRVCvVfvu1NEU9OE_VDIArw0nEtiNv8ybgnlfLu1_gela1Nklf26-X-ak6hPh>
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
X-ME-Proxy: <xmx:mTSzaVIgqz51Nm5JsM_w7hIEuFEq9JdQ8WgB1rAT7sGtr91W5_9HsA>
    <xmx:mTSzaQ-MtvnKnY3GHEDxVW_5M8jtI1V_aFkLJg1Rag302qusRR447Q>
    <xmx:mTSzaQSklQHpcX-ckFXWIpQpzolsE76loXqaTnlY_baq1jY3gl55Ww>
    <xmx:mTSzaS_GyjBaWwliRP4yLwwkikJ21AjNWue41eWkCymfbB5MYkDNWQ>
    <xmx:mjSzaSwzj3T804JPxGf9ZWy1K_G4E3_ytYG6PGglCn7sLvYucJECySvG>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 17:47:56 -0400 (EDT)
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
Subject: [PATCH 13/53] nfs: Use d_alloc_noblock() in nfs_prime_dcache()
Date: Fri, 13 Mar 2026 08:12:00 +1100
Message-ID: <20260312214330.3885211-14-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260312214330.3885211-1-neilb@ownmail.net>
References: <20260312214330.3885211-1-neilb@ownmail.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_144813_000606_5668A5AB 
X-CRM114-Status: GOOD (  12.58  )
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

NFS uses the results of readdir to prime the dcache.  Using
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
 fs/nfs/dir.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index ffba4de3df01..4b73ec59bbcc 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -750,15 +750,14 @@ void nfs_prime_dcache(struct dentry *parent, struct nfs_entry *entry,
 		if (filename.len == 2 && filename.name[1] == '.')
 			return;
 	}
-	filename.hash = full_name_hash(parent, filename.name, filename.len);
 
-	dentry = d_lookup(parent, &filename);
+	dentry = try_lookup_noperm(&filename, parent);
 again:
-	if (!dentry) {
-		dentry = d_alloc_parallel(parent, &filename);
-		if (IS_ERR(dentry))
-			return;
-	}
+	if (!dentry)
+		dentry = d_alloc_noblock(parent, &filename);
+	if (IS_ERR(dentry))
+		return;
+
 	if (!d_in_lookup(dentry)) {
 		/* Is there a mountpoint here? If so, just exit */
 		if (!nfs_fsid_equal(&NFS_SB(dentry->d_sb)->fsid,
-- 
2.50.0.107.gf914562f5916.dirty


