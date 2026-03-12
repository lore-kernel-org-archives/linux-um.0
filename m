Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC89106ACEC
	for <linux-um@archiver.kernel.org>; Thu, 12 Mar 2026 21:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z+7QufvNN3q8n3hkdBe3X5vN3xc/nhZLNzYG67Syggw=; b=Sr/PIwifgjPP/xbBnn+Q+2+q0E
	1ZZ0k5U8aDf4Cp+kUcpVUPUtaFfLnj0lhpIOq6Xy3YvCAvy3XX31Wptv7qz2IcL27ZxnmbJ2J70pV
	j3v8Dt2WBZ/RzoEmQIny+IOk4C2HS81by8Sben/gqNwGDr5T+/WvSRvs+Ksfcl4Ep8H9T3IcJL3cK
	f4HDCF1qLSpCCwpjXpr6PUuvLE7S8AUtt1bH68bcoCMjlCv8gkDC18EIzFbifb51cPcuM0Fyr/jbZ
	R235c5N/fPyxZS0D33GgqLXgR8qKMbsgk8CFwFeIuu3FIddYgUrrx9817y51Q70R/UsJSjq4XcH5K
	YlTXaCMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0nuF-0000000FXKZ-1tZ8;
	Thu, 12 Mar 2026 21:49:23 +0000
Received: from flow-b6-smtp.messagingengine.com ([202.12.124.141])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0nuD-0000000FXJv-02kr;
	Thu, 12 Mar 2026 21:49:22 +0000
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.stl.internal (Postfix) with ESMTP id 204861301B98;
	Thu, 12 Mar 2026 17:49:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 12 Mar 2026 17:49:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773352158;
	 x=1773359358; bh=z+7QufvNN3q8n3hkdBe3X5vN3xc/nhZLNzYG67Syggw=; b=
	TgyoTat174eBaw3Mh4geA333otferDz8BBQPH1PgKmD7FJaHSr6GLkuhr2HlpJDw
	cVzZ84rQMihNKez8G7vGAleKuhXA4W5y9KIyFD4XN8Wb5z4C/GkUjuKskb+kJrR1
	lC/yoVH9xfJudFAZY9VkxvQRWgVEaIklFmqwqosxDL5m24ZZf8ALkvi5+8kTNaRg
	JaI5ac5o4PkCD/awH8jjlvbtcksBwP/UrAs/wyTtRe9wh5vZIiq43rwWfSf23iAN
	ZvxN48yBCgh6KULlPPnNa2Bf7IuYhYgs2ho1t/OJA0HAv6x9x5aQGqJdst5665hw
	AUEGVu0PRgJJYV2cz8wi4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773352158; x=1773359358; bh=z
	+7QufvNN3q8n3hkdBe3X5vN3xc/nhZLNzYG67Syggw=; b=obUK4rxuvN2EEYhNI
	NtE674q93iVvjy5WR4fSqUmy8AHVYgkz/UxLyEHzkbsGA1QeFwYFB1iwCX/S2SXG
	/IPa6UfL54oQSq7sTP8Jf1YUCeNn82kWlW2yVSo7McnrgmZEJtbc4KeiMeYoKXAK
	BAY1RBx4D/DMmwFaIDCZXvTM+ujGQnIUM50S3v5o/1a4uwQV6C+pc0s9z8zOjwKh
	Wd4hbA4HdhrJjvqf1rT4/pg+E3TEO/wK8a/Md5olMOwIGDS9ErEvKobrJGJQZ9BD
	2OjvflQ2QmT9rRSnyWJm3cSWLappWt7B0uGl9SqswPjgzsIGfheQXhEqfjP+ehhn
	ijVCQ==
X-ME-Sender: <xms:3jSzacmiHA-T5A5AEGCAPRisYfRepw7X9MhO968O7F0fHUoyPbCqcA>
    <xme:3jSzaTbFNkRfJHGcu0SKNCrv8iRuKLvhnNF3nBYgiuCnV1F_HFX8PqbyTJlPBR7EI
    4nY2MMg5jusbnpid8vE-XkSsP2UrTIeAEbJx63CCA63L69C>
X-ME-Received: <xmr:3jSzaSOZgIZGoIIXYg2PoswHVWMT6XVQxqzKNR_HkotMxbkbupsyYrBXG_wfSZcnLvqER2WU-paPU6OI3-WxvGt0sPfdw2Tvz0bIZ6eNC-Bs>
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
X-ME-Proxy: <xmx:3jSzaYgtzeEu3P-KvNjuCtUPl42_DEzVT8HvuUimvBjWAblXlqrttA>
    <xmx:3jSzaWPrrMtwf1k_IiFBhtUZYvH9CuY0ZgnbQX6ifw6H5zUoX4qeyw>
    <xmx:3jSzaQoCrIiXp_IcrtspyfbsmXuloL81TRtB9bP7hiNmOCQtMAkDlg>
    <xmx:3jSzaULSuxRvndu5dd7u3ObmqYkIhunnkgWc-gpUCX-Sm0mvcKAJGg>
    <xmx:3jSzaWCk7Y5VsPadqok3seJ2hWjvt7O7dzBc5fbocDIx6aKo4dQz-DrH>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 17:49:05 -0400 (EDT)
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
Subject: [PATCH 17/53] coda: don't d_drop() early.
Date: Fri, 13 Mar 2026 08:12:04 +1100
Message-ID: <20260312214330.3885211-18-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260312214330.3885211-1-neilb@ownmail.net>
References: <20260312214330.3885211-1-neilb@ownmail.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_144921_154195_BF9B06C3 
X-CRM114-Status: GOOD (  11.82  )
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

Proposed locking changes will mean that calling d_drop() could
effectively unlock the name allowing a parallel lookup to proceed.
For this reason it could only be called *after* the attempt to create a
symlink (in this case) has completed (whether successfully or not).

So move the d_drop() to after the venus_symlink() call.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/coda/dir.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/coda/dir.c b/fs/coda/dir.c
index c64b8cd81568..70eb6042fdaa 100644
--- a/fs/coda/dir.c
+++ b/fs/coda/dir.c
@@ -244,13 +244,13 @@ static int coda_symlink(struct mnt_idmap *idmap,
 	if (symlen > CODA_MAXPATHLEN)
 		return -ENAMETOOLONG;
 
+	error = venus_symlink(dir_inode->i_sb, coda_i2f(dir_inode), name, len,
+			      symname, symlen);
 	/*
-	 * This entry is now negative. Since we do not create
+	 * This entry is still negative. Since we did not create
 	 * an inode for the entry we have to drop it.
 	 */
 	d_drop(de);
-	error = venus_symlink(dir_inode->i_sb, coda_i2f(dir_inode), name, len,
-			      symname, symlen);
 
 	/* mtime is no good anymore */
 	if (!error)
-- 
2.50.0.107.gf914562f5916.dirty


