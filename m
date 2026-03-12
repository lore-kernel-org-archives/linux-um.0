Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 717E8106ACEF
	for <linux-um@archiver.kernel.org>; Thu, 12 Mar 2026 21:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=puUX/onZj/vaXC+2Vk95PLkQLCVwPSvUkX77dKofgTQ=; b=inapIJE1a+7KDFOfMC8VJr4N8E
	FIPt11qcUYQ6En+cDzHKmMp/Rb7b+QDdxwnQ4QWckQKbd12WkczslTSDkW2sYCn9MEI8cVY7wNw/5
	oThXMPbNyAKby97qgcuybrF2wwzpyVBb4mPt7NsMzNaSzWstCr22DJU4Jc3yBkFKE6S1DaMNC38FX
	FKc8eYnOzfVkYbNCQ/ikSgSRRFrh99XPeAgfRuhtmYZuIhzJHzTBN+2eZGJVusSQuBP4ZQEPKdYB6
	JRbiWjGkEaIuVvKCQRb1X6BqoFnpBc504Pd3ffijqpvSosObZMH6Ikno8TSll2wwXd630UImwwn4A
	sfTOC9Zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0nuX-0000000FXPF-0g0l;
	Thu, 12 Mar 2026 21:49:41 +0000
Received: from flow-b6-smtp.messagingengine.com ([202.12.124.141])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0nuV-0000000FXOY-1HXX;
	Thu, 12 Mar 2026 21:49:40 +0000
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id 304841301B9C;
	Thu, 12 Mar 2026 17:49:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 12 Mar 2026 17:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773352177;
	 x=1773359377; bh=puUX/onZj/vaXC+2Vk95PLkQLCVwPSvUkX77dKofgTQ=; b=
	Xccu7BqGG8E2NDVZg/N4GFdwY2oD8s3CZ2ec6I8noK+y1khNNKwdQa3qSaE8p3ck
	0l50JSAYQMZ5XRGqZ6Bm/NAd13BsbRhSkEdg7tqZU6lqcf02dFEy2EcSjKuts/ie
	93Y1uP4EFwJeTb8r7VZMByZxlZdqGEPpizVdBZMUA2mImhfkLWcTIYnNYeFDeLsv
	5FU2zkjTsrw3bSzl+CIzFJGHS1tbUaCwV+5sD1boXsVdn68Nb5W86QGVNW3kz1dO
	ZBA29VXiDgjJht9QJK+RFCH9oZopsofcKUpnEEHU0+MgBQGEzMOp4Bq2C4HkdvRc
	lnP0iuRl+qvkLgnss8CbMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773352177; x=1773359377; bh=p
	uUX/onZj/vaXC+2Vk95PLkQLCVwPSvUkX77dKofgTQ=; b=m/gQSpd72bOeZbbIs
	bt9p9HVZaVD6pf8ZLbR/liTkCv6KLk37Bwr8ICPhs7HK1JpcdmbvRz230O5ZCVWm
	bL1vRCv8aa/Xm/OpaO3WA7ztqdqawHLsbn96Qsi2daFjSCddFwzLvvwz4NQtqelr
	jJiohG5ZcJotwPQPUQg4NyRCl/Tlv1u4/GXgV4jKWFBH0UUA+Mqw1kR51FO2ihPR
	sv9Bl9N1dEqbD5ZMaW3p4mZ8SyUtMM0xpWUs4C7GXuaqyzfvyS/u1YLmjyB5CADx
	iwjOJR50j2ZM6njft50LG+J5rhWP3t9qo6Wg405WgsbPq6uZnUmaMgGVQl7jGsRk
	+xLJA==
X-ME-Sender: <xms:7zSzaRVK2ld2mjFEAplQJYa3xj2B5fXBRT5y0o0EdVsnun8GWGj7QA>
    <xme:7zSzabR2Lv5FmbF1j0P4TzJuP00xer94lt3X-Grr0Tb7TbVDJgf4Jx5IwpC9MwnwJ
    P4t_lKZRwAwLN1n9mgh-b1sfmG9SoeU2JQMiLlb4i48l8ScJA>
X-ME-Received: <xmr:7zSzaUUi1znV28haYsZWa146WyJbSjqBMqzMN7HUYQ0_ezVgi0z1HHys1ytelS5qeuiqw3N9ZonF1PHm-rXrsrwIwgZ4NLTmc8x48k7FJUbX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejledtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:7zSzaYayN_tA3ZkrIRtpJ_g6qClkPs2v_4yuR5WOe7mTaUdMhUxu9Q>
    <xmx:7zSzaa_u1VUCAlV12vbpEUyTKc2zx_hwL4IwQMPrbjyh4r_ouPPtxQ>
    <xmx:7zSzaf4y5PLi3r_Ggqqc4UxN7B9yxtAOERfWRtN6w0IgVtlfwvZ05Q>
    <xmx:7zSzaQnBblIZERJYN1PXUQ5V96-8KEp8KPLi_5CcVcuQa04y7G941w>
    <xmx:8TSzaZmH5TF4DiiBHGfn2CzS1n4UuyybOJqjIgTLw_TmHyJHXgibp5sQ>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 17:49:22 -0400 (EDT)
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
Subject: [PATCH 18/53] shmem: use d_duplicate()
Date: Fri, 13 Mar 2026 08:12:05 +1100
Message-ID: <20260312214330.3885211-19-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260312214330.3885211-1-neilb@ownmail.net>
References: <20260312214330.3885211-1-neilb@ownmail.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_144939_446905_1F5177A9 
X-CRM114-Status: UNSURE (   8.05  )
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
 mm/shmem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index b40f3cd48961..6b39a59355d7 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4030,11 +4030,12 @@ static int shmem_whiteout(struct mnt_idmap *idmap,
 	struct dentry *whiteout;
 	int error;
 
-	whiteout = d_alloc(old_dentry->d_parent, &old_dentry->d_name);
+	whiteout = d_duplicate(old_dentry);
 	if (!whiteout)
 		return -ENOMEM;
 	error = shmem_mknod(idmap, old_dir, whiteout,
 			    S_IFCHR | WHITEOUT_MODE, WHITEOUT_DEV);
+	d_lookup_done(whiteout);
 	dput(whiteout);
 	return error;
 }
-- 
2.50.0.107.gf914562f5916.dirty


