Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 979D2106ACEA
	for <linux-um@archiver.kernel.org>; Thu, 12 Mar 2026 21:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IQfPF8qsPDD4y8gX0swga1hVwNgQjqyWwNEjHrIDNRM=; b=EafK08rOeKWOyWGLpZP3FPA6Us
	oQ5TgN1SI30Iw2SxrBbIvQ+seIS957ynvV9zpXu0mNf1+l2wFCnGJZ+VnQPUCpgJkLoSoJz/sYIxY
	R2ihfkJTy7HfZTZMJo4OTc5kqMEQwB1o1CvJY2CesR7TkLe5yYlk9S/vBtMEJkLY9oOQ7hbKb54B5
	4SqKacwgF3uP/ptca4JITDnc79ddj7Ndi638fDr2rPmdjaPVkVNT4J78sUuS50YnXRo9frvdCEzt7
	Jv5V/miil4ugRp9rgu+b/UmyFyAHVSfq3yLB0dJpybUdSF4lmoKNbEEIKlYrUzhObjB3ba8zvpodq
	vS1lMMzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0nsa-0000000FWsf-0MwJ;
	Thu, 12 Mar 2026 21:47:40 +0000
Received: from flow-b6-smtp.messagingengine.com ([202.12.124.141])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0nsY-0000000FWrv-0Uqi;
	Thu, 12 Mar 2026 21:47:39 +0000
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id E848C1301B68;
	Thu, 12 Mar 2026 17:47:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 12 Mar 2026 17:47:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1773352055;
	 x=1773359255; bh=IQfPF8qsPDD4y8gX0swga1hVwNgQjqyWwNEjHrIDNRM=; b=
	iPWOSxqZlSqyPdU6zTigaodUHhIuXMhwcY2p486hgesZ4N7bhchW/j7ATJHN9FBW
	oKMrqPBlqBMt3lkYCgSSFCKYXJmW9ODmThws66AtdxwYimzVfOz9cBugmFraUhdV
	YoO+Tg3MdlfJnhcIN9JfefQc+OGsJZ24NInAWQKWdb3ofc6nEyQw44fO+K1AQ1pL
	PckIAJ6PEuGLH3OUpr4l+1OppEhqfHtePP18EAfy8H3V1DfBdKsDc1LWDBmYxKsc
	1007QHUZL97zu3IXO53mSATagMEzl3Qlsr521UnNLtczRjXcqKEV2fA3ORrfY0a3
	MpOs5Xw5kf4wMfV1RUUcDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773352055; x=1773359255; bh=I
	QfPF8qsPDD4y8gX0swga1hVwNgQjqyWwNEjHrIDNRM=; b=unIU//e+8gYENP4K1
	FVVmPPrZh+cW9to8xynIOLL2gjLoSBNBWQceiEYqrtNCGzla1+3dWZUcITjMgi/X
	uuL46Ngko2u2uNp1O1vKehEFbTUjc4NkhiutBEF1BzxX5CZ/RVgo9uua3IfTb1U4
	NGa3YLqzHArKaIKtpRK98PwLIBxeoOcWX+A+OTTeQa5687EfcLW0m0JQ4OCHV0qj
	k505GHZtj/bSahn2aOVVCe3jQhaIxFFRjMcooWaTHAaqasI9A/H+N3+vQ1i3PxZy
	LueNtc+7viQ3EYAT0DTVcQn6YEP2Q1GLKATntEhtaDEKcbXPcerB8IzWARCsLvWM
	IvM2Q==
X-ME-Sender: <xms:dzSzadR1MAsZAitEgQpRqkE1Ohgad2kzGcH263o1t7TXTRgxjdqYeQ>
    <xme:dzSzaaddjVsxxqrJg6cd61V4ey9u8NiPzMREsyhWiuAlorEYRpPofNSDIMwtQieXj
    imi6hPyKXjSImt3TlbHBCxZzDmVo8J_ehFyBdBFkz1_tFAlXQ>
X-ME-Received: <xmr:dzSzad73mhvPgvYL751N9h1IuqZDC9qCfyFWvhd2UO8UNcD9DN87JGATxBceAdvuqD6UcBlC44Ws0fF9LuFEhaLI_3yzuN6FXCQu9kMzkMg6>
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
X-ME-Proxy: <xmx:dzSzaSfdzbvlo8FTUtQUSZHaX9m1SDibKD-faF9-7T1qyLf0BGRfRw>
    <xmx:dzSzacBQhEFOtMEi4Yv-yULYFv_4Nk0yU79ngB4PUfLkpukgxYwauw>
    <xmx:dzSzaWFpFURMotSUNpKLQepIDtDYxPIhrb9wtRHKaYgRNylCCa9-YA>
    <xmx:dzSzachcP-QQRCqfvyqvZXN2FVihxCh2TfPpAiVTFvwqP43nNdJpFg>
    <xmx:dzSzaUsQ6Hj2-q3E5VjcI00qQ9mNWzPtWkKoAtnPKz8E6T1iivMLl0S0>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 17:47:22 -0400 (EDT)
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
Subject: [PATCH 11/53] nfs: don't d_drop() before d_splice_alias()
Date: Fri, 13 Mar 2026 08:11:58 +1100
Message-ID: <20260312214330.3885211-12-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260312214330.3885211-1-neilb@ownmail.net>
References: <20260312214330.3885211-1-neilb@ownmail.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_144738_241950_F23088DD 
X-CRM114-Status: GOOD (  12.99  )
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

nfs_add_or_obtain() is used, often via nfs_instantiate(), to attach a
newly created inode to the appropriate dentry - or to provide an
alternate dentry.
It has to drop the dentry first, which is problematic for proposed
locking changes.

As d_splice_alias() now works with hashed dentries, the d_drop() is no
longer needed.

However we still d_drop() on error as the status of the name is
uncertain.

nfs_open_and_get_state() is only used for files so we should be able to
use d_instantiate().  However as that depends on the server for
correctness, it is safer to stay with the current code pattern and use
d_splice_alias() there too.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfs/dir.c      | 3 +--
 fs/nfs/nfs4proc.c | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index a188b09c9a54..f92ea11aea44 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2330,8 +2330,6 @@ nfs_add_or_obtain(struct dentry *dentry, struct nfs_fh *fhandle,
 	struct dentry *d;
 	int error;
 
-	d_drop(dentry);
-
 	if (fhandle->size == 0) {
 		error = NFS_PROTO(dir)->lookup(dir, dentry, &dentry->d_name,
 					       fhandle, fattr);
@@ -2352,6 +2350,7 @@ nfs_add_or_obtain(struct dentry *dentry, struct nfs_fh *fhandle,
 	dput(parent);
 	return d;
 out_error:
+	d_drop(dentry);
 	d = ERR_PTR(error);
 	goto out;
 }
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 91bcf67bd743..a4ee0c0b4567 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3099,7 +3099,6 @@ static int _nfs4_open_and_get_state(struct nfs4_opendata *opendata,
 	nfs_set_verifier(dentry, dir_verifier);
 	if (d_really_is_negative(dentry)) {
 		struct dentry *alias;
-		d_drop(dentry);
 		alias = d_splice_alias(igrab(state->inode), dentry);
 		/* d_splice_alias() can't fail here - it's a non-directory */
 		if (alias) {
-- 
2.50.0.107.gf914562f5916.dirty


