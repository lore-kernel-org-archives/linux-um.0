Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A981F606A326
	for <linux-um@archiver.kernel.org>; Wed, 25 Nov 2026 03:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JtafZSsQ;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=BtwNj/hh;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xP6G8+wN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=A+0PFuwkqqPencm2Jt4IcFZklnJtpqqJm/NUrmwEwvU=; b=JtafZSsQbHU469aGSlpTp2XVZl
	pU0uLmmiPE/YEcTDuUrn9jpXCVEdpW52sJH2zB64WQQaoXt8tRaLIG6c3tnX6DhqYg1KHEZWaIrYk
	6s9HfYZ7CvK0OO+/A+9RE52Dv2IfmE8intb47ZlmJnrMN5jRN/Ly/a43MA0O2xXvqJ0+PhY7yquT4
	WfKEj6d5P4TKdE6wFbB0N5mB7m0n25aJKNR6kALslPDK/U1NDU7DwvW+HzR0YSjgrSRMWsbdwvGey
	/746obxVbr8fdlR0MZXFFMAI8Q2IO1HvNtxnLii8ffelKjKgqfRCaDxjbE5ebCdgOxRYeITmzQPxb
	n+17e8gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW3y5-00000008LVM-1i68;
	Wed, 25 Nov 2026 03:46:49 +0000
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW3xz-00000008LTf-3nK1
	for linux-um@lists.infradead.org;
	Wed, 25 Nov 2026 03:46:45 +0000
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 1F6DAEC0A49
	for <linux-um@lists.infradead.org>; Tue, 24 Nov 2026 22:46:43 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 24 Nov 2026 22:46:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1795578403;
	 x=1795664803; bh=A+0PFuwkqqPencm2Jt4IcFZklnJtpqqJm/NUrmwEwvU=; b=
	BtwNj/hh2MlaZjgdppKO3bdR55bK5HB/BK0JQQAE/lBAPGbJnL7/GWGAi5isu7k1
	60uWwkYNTQsL4z2eyeFOPYdvD8pZZinpbziXSFchxNnr5S0QFPdhJbmrLvq64dl5
	kH8XT2abW2rp4TxwCrioOljMA993AAtre8XTGUPwGxVYyJ2c64bpI0dqxoLr2oGj
	agyrAmD+kwdT3vuPaksX32S5UIHu4XuZdS1EJ1Bb/FjqcLceyWTqvceihwmUvn09
	AFdKBu0p9DlvATbxVn7Y5az+CpjCmbweD2y1g3G5svEfNzYKSTyOGcKjWP32e2Mv
	1g+ktL0b3wqOhAgVDJ+oUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1795578403; x=1795664803; bh=A
	+0PFuwkqqPencm2Jt4IcFZklnJtpqqJm/NUrmwEwvU=; b=xP6G8+wN6Xxne3+cn
	c4iTtUi8ToNZD8P3gAn6ygQXx2b5axXyBnwcYU91FeWbjx+N9OAZhUZQP83KJvzP
	kyG8oH3D3nGpjayLDu4niwdf3GOY27qpZQ1IgxvF0WEtxHY9kMYL0JrdYyufCEeL
	WBF4PobOonbZAbFfmid03wDwXIFzZIEcxqsowBi73jZChgM+Rryi5DINmrVptQ42
	2lsCxSCUXSx9ly9vxEYnph1BzRXpihEM6Vq7413CooxDe+UyVU5RM3HyvCf9YOQU
	K/ljCpYtbqC13X3VSzDlGe6qUOMAGbmssWIxsoegN2d7PAySxPZ2izLdnpUQzMDf
	Cussg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795578403; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmc+;
	s=fm3:rsa-sha256:b56c/uHU1nCyPw11ldOHIy4ooN3NiqjWOZsSXwUa+q8Md7E
	X4rtCyVyxVmtfhHAmF8lS0INt/rwLxJ7lT/NG1ut9zsgq28N64FWthsrFA7k592u
	3mqvj+VVCR6raF7ooSxmYsjd3pJVnh0q82RJhsjiRpmxZDPaUNZ47FXPMtHaaWBe
	w6Mx4T9o+fEoVDZo3aekKWe+76znLoiXRjCk83xV0LBiUkPF7iyxC9rRobZks8Hv
	1y6nYFruEDYJg+WmCCHdGPTFu8HNJCcYzsLnfT2e9nGIrW5AyXibKpGFfU0WLQPs
	K4XcjnIkXxXTae4AOy1Y8D7yKS+Q1uUsTrRRNNg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to;
Message-Instance: m=1; h=sha256:kZWkqxM0YzamoA/klqsXonuHvTXNCZymcsHe+eOx7rk=:IKMx6k9vO6LY/IhFGyD2yzimZSa28WztvdL6DQli46E=;
X-ME-Sender: <xms:IloGa-hz6kW1riDRZlWPsvc-VQjWm1N4YBntEIjvw0Mo02vzAsLErA>
    <xme:IloGawccxSQHvD_nMo06BmODN1lzs8a_nf-UUWlO4mFqT5OIxmDzbwjCodrX_q-5o
    5V_5MSExe7Q_cS12KVDZSY9JJZIT89zFrM61T2Ast0LstNsYw>
X-ME-Received: <xmr:IloGaxdxRcwHnTL0mAv-Z4tL05J2K3-REyopkrUBw1sD7w3oDoZERnpnn0i0MTi6F-SlQMjXACI02GmbZ-Mik8lgQwYDG8U>
X-ME-Proxy-Cause: dmFkZTFR427OSMpMhBUq2c/PRD6RmqRpXHsHavEQEoZib45veoj0ON4Fee0fFpAMf6IRZD
    7ioshD0AaEWr7quPZ3VJk4MkgPxfK4VajmEfAasmF1N4QuQ1Nx4fAT27aU1zZmPYaReDqx
    rfP5UHReFgze/pUM1YUaeJAgJLGWSi2iJU/qcqRk+B4M1TsPMqQDofdX/Jn7SjcVJvCtNm
    zdB65WAuETFQQDYBDZIOHXvboBphMIm2vyy1TKs+e7zZqPSqTzzCVyEWo2arAfhj68hGFx
    kBzHUYnaQIV/eTYhsd/MgvSt0+AvaXUSwYNCdWWq7bBlwHpxfTlmsOfayzrTTRF9w5P7Qw
    0NrG9O0v3tN2Xh0lMTSQeVHonl1+7ZwSbnD4kBDyPus1/+yxGd1GZ3kB8GMxyV/4cErIle
    ZSvxxtsz4HlnyRFV8QtlLpH6bnYTRYY2id+lW7mCK/x9tsrSygRQZzMy20mBpcV1/0m012
    BXPkjFw7zOPv1qouh6iG6tKHz35wrCsIwR447EFWOQSvuPi5s6DlWdR7IuT+yK39NCkfJe
    gqhWAQBh7kE9a0cUXRSMevkQjrjZ2edpU61U8BJnZO4kx07an5eRga1Y7oxeNY+IzPBwu5
    0eiLDM5blqzLpgGYjKO6YufP2dkaKge+h8Sf+WESzTPkvq6Sx1xmxFfMEvdg
X-ME-Proxy: <xmx:IloGa0XFvqrxgNVDGd015Fty-pLbT2PLvdU-j7nbSXVs-XOzEVvIbg>
    <xmx:IloGa9fT40ZUJNjyybqJFCncEOsrJuyRtOQMiVTS55pn4rmNm2ViXw>
    <xmx:IloGaw-l1M7Bwt1J0LcHtTwlQowJH4-5dtZooiz4GNXA5HuO7E4urw>
    <xmx:IloGa0kQrSRv_h8fXYTzwhb_bJQ4TmEmjKPpJGipg1XX0veOcem-cg>
    <xmx:I1oGayK2Z0ZpVC6kxKN0jjlgvtzO_hFMOQmnpJqhokI4p4rYqAAU0jDp>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 22:46:37 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jan Harkes <jaharkes@cs.cmu.edu>,
	coda@cs.cmu.edu,
	Jan Kara <jack@suse.cz>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	linux-kernel@vger.kernel.org,
	codalist@coda.cs.cmu.edu,
	linux-fsdevel@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-afs@lists.infradead.org
Subject: [PATCH v3 06/11] afs: use d_duplicate()
Date: Wed, 25 Nov 2026 14:16:44 +1100
Message-ID: <20261125034543.4084039-7-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20261125034543.4084039-1-neilb@ownmail.net>
References: <20261125034543.4084039-1-neilb@ownmail.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_194644_040055_E8F9939C 
X-CRM114-Status: GOOD (  10.75  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Reply-To: NeilBrown <neil@brown.name>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: NeilBrown <neil@brown.name>

To prepare for d_alloc_parallel() being permitted without a directory
lock, use d_duplicate() when duplicating a dentry in order to perform a
silly-rename.  This creates on in-lookup dentry which will contine to block
concurrent lookups after the original dentry is silly-renamed, and until
the final rename happens.

As the resulting dentry is in-lookup, we need to call d_lookup_done()
before d_put().

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/afs/dir.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 672bd83ff112..bc90b30d8b57 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -2060,7 +2060,10 @@ static void afs_rename_put(struct afs_operation *op)
 	store_release_wake_up(&op->dentry->d_flags,
 			      op->dentry->d_flags &~ DCACHE_BLOCKED);
 	spin_unlock(&op->dentry->d_lock);
-	dput(op->rename.tmp);
+	if (op->rename.tmp) {
+		d_lookup_done(op->rename.tmp);
+		dput(op->rename.tmp);
+	}
 }
 
 static const struct afs_operation_ops afs_rename_operation = {
@@ -2190,8 +2193,7 @@ static int afs_rename(const struct mnt_idmap *idmap, struct inode *old_dir,
 			if (d_count(new_dentry) > 2) {
 				spin_unlock(&new_dentry->d_lock);
 				/* copy the target dentry's name */
-				op->rename.tmp = d_alloc(new_dentry->d_parent,
-							 &new_dentry->d_name);
+				op->rename.tmp = d_duplicate(new_dentry);
 				if (!op->rename.tmp) {
 					afs_op_nomem(op);
 					goto error;
-- 
2.50.0.107.gf914562f5916.dirty


