Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E558606A31E
	for <linux-um@archiver.kernel.org>; Wed, 25 Nov 2026 03:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qBSEZXs4;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=MrF6e9+Z;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=TiS5M1sX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=7GW90Xebke1BO6VVD+3Eb+D/Pr8y2bvy00kHZFBZIWY=; b=qBSEZXs4SM1nXctpmpxIO3pWaX
	7jlpP/rhwo7NJwgZJnicah93OKv1OtY3lbS5BtHfsHeDc86OgCSePX1N5zMTKxLuz/GQgFugmQoPu
	WzIxMNKU+Psat2DA6tjbS4cOFJHpMQ/GUeh5/6220Efw7+xqcYi9rhnI9Yc1d5jXqcBWKzc7LBQw+
	PJwbVDkA+vvfigiPr7m4DEV9tLr2Fygs7sCjzxzJWgDj7FgUgB3x1RhjjpEwk1HmQ4JoU8SvAGKRj
	uJOgAPnG4Hiis159XGujJ6i5uZe28UuOay2tIWYRib7PPiHB2VLpTMb1ZZw0puL/MxYoGAIA3FVsh
	sAUp0vjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW3yQ-00000008Lf2-0mbI;
	Wed, 25 Nov 2026 03:47:10 +0000
Received: from fhigh-a2-smtp.messagingengine.com ([103.168.172.153])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW3yL-00000008Lcx-33r0
	for linux-um@lists.infradead.org;
	Wed, 25 Nov 2026 03:47:09 +0000
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E8D02140037D
	for <linux-um@lists.infradead.org>; Tue, 24 Nov 2026 22:47:04 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 24 Nov 2026 22:47:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1795578424;
	 x=1795664824; bh=7GW90Xebke1BO6VVD+3Eb+D/Pr8y2bvy00kHZFBZIWY=; b=
	MrF6e9+ZMBTZn/E8MbMazi5xiWgag5leKJkWRE3yJiRs3KF0cDsEu8CLxxqy4du+
	B5SPDpYwQkJZdR4omxRqKsYznywT9axCihKe2BmV3UuArLInERHrvbdwh1LIGEI7
	FBbWtRhIzFq51gfx1aubPoAFYLa8GrVUymBFV7SX2O8QY3Q2TwNEajuCriDn16Vm
	UeA9IxU9PFJB2hgx2vOzDp9vpKyTvfQ3VXpsbZUN6fLFySDSR+cs9McAUZQlZYOo
	0mxbpH9b8rugf0nvbmZzd874I7vEeSdbyAg51DQc3oyK/bKCnn6oAcy0ar4iL0nF
	OeKDVR44R14Fz8zRZ7/W/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1795578424; x=1795664824; bh=7
	GW90Xebke1BO6VVD+3Eb+D/Pr8y2bvy00kHZFBZIWY=; b=TiS5M1sXCm2z71YAv
	Rdi4q4SlJ7G6TVuL0xFGepax6Nb2Mh9/d1bErQT4vC7QKmW6PbPvWERrwDxPob8V
	I0VKLE+YhaZVRaPsm4VqUSynbziVM/qtO2knxlakeOqvP5HyXMUzsp5bkH8fh26C
	IqCFItT8+GG08H2NLrdwBui15uXc/neWHa55XkiIaJGmjj6Cn5xkK+A27mTk3TuM
	s5T8Zo1de3O1JIN1tL6cqV4ElIdm73nRmd8DmcrFwuNp0niSRL/XdpkzpLgyAdAP
	1bWIHFgZc9peeQEj7amO2Dr7pyNHPEOui66ykO/7/Fg4X/LS+719EYToLSbxXgHl
	R+x2A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795578424; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmc+;
	s=fm3:rsa-sha256:W1hiEas8aPovd8yCNDCTWw8udkQ47lX0J3LEpPkM/sJhxWx
	Z4ws3+rmyMGArOcoRWPrryn17qYk4990Smw29InJX1eV0MFoBOKxzosieXPwCKKf
	sjBDuqZMAXMZoDl86ZDD9jj6PpJ7fPwLxF7lAn2QHV2TzYVFrTSNYxTFGlA7c616
	1mxeNYuC5gCt0xpYXJ/FoJ0PlBs+UpOun78BJypc+RctltaQQNnAIjMJJAB7qglq
	fDbJfoMdSSZMmyOdQtlzjJ0vyttzTFAIcclsF6FKqKFRIC/Yx4vDIiMltnOJCMYj
	KfpNotoUEcp3XOlMtUOUKtQApFk0kV6h0p7oWPw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to;
Message-Instance: m=1; h=sha256:pLgtTQtuzOUYUx84zLKxXDCEnsf79PIXIsM+V8REFpk=:rKFIY2igCQNYJ/8KN9XbK5tFVEJagzy3L1EzWAznAQk=;
X-ME-Sender: <xms:OFoGazXKdCSkKTZCsM8ZxbCxn2aCGdRdB7YJyh8W5pRsfUgf7LlgwQ>
    <xme:OFoGaygUJefB43KaU-rklI6ZcAdwUwN_Gbryx1-aXrRNCf5EbxYtCpo0fPnsNGS8l
    ECqO8P7UoehIyDgUrhqQ3cm2Ma601Qm8f2oouzxA5VrgwimbFo>
X-ME-Received: <xmr:OFoGa0fXtLGdWr3KOYl32QJS10vao9AriisE_RaekH0wMFiJcTWhQLp7NIE13nZgyuMMe3Tv94YPXajkXFdHXvx4bh5CXO4>
X-ME-Proxy-Cause: dmFkZTE4HtNMS82oETeKxjFsMonchsNmutSXRF8P4Wz/gL5NuR+PmnhI7BdBjNpxinbAbR
    gE9fr8C0GNc0SnxE2B+IXDaaoddndfcEJfJtcWeI4ytNiRF08hWb9RlxFjA1qgM4oFyoJi
    /AdIhJNfEVO0oVTJtQVCvv+X67aNRews2LQwnM5uAbOmmoGahsFhP1aXSbisfk+ds7cJJ0
    OsFbDOPt7ZICh4tniydbOvMlt1+f+7jVXUCHPaOJHWPFgfTUvPivbmMoJSDdfil0VmV1q/
    2QMjPNE1ltm0/CAvjxy3k0MqWfenoOEUWjyOM0HmgbohwH+N/2hScfzSSITnIBzePDS5oC
    YFHOQAnyEuAqnfgBtSnnYtOgAjzsJ1IwaGTozxClzxjIqWdOYHSG2ZsI/tZG4wAeX3eMfc
    uJ/8/Rcsdctsd3B45F/OegSCjYq/aOokBPrWswWQE/p5+P4uAExV5ufFMfgf2APnWeThom
    amUcpiyHxktVYgGYGNuRcWn2NXITXMXNo13y5gmT2jl+YvZrz9VOZhwDLVNHmWqit/cdsW
    G1FIxC2vMuUI2zWvy702UXXJotPnVh2hCwxYjLg69wHIC4s3wx67DJLjXEbBdBMAgkBthE
    aatYGNh8qBvSofBxsnjcg2GXutvcXGcrdWMNPpZ9x1pgi3lPC8HzTx5+SqWg
X-ME-Proxy: <xmx:OFoGa1erk08EpG2rvWQ3wIGT0wqicS8EncSh-h9jOyVDL1Ev9JdPqw>
    <xmx:OFoGa4USYw4TfrasH9puRXJqVgeY6IXH-lkUaC8OBX01xZI2sGA-8Q>
    <xmx:OFoGaxc4QAjUwuRuwLfus1jabxKEz_RHTScQLHv0zR5MxJJtTYk1uA>
    <xmx:OFoGa0_UPBBMM0zzmwKx4HTMp1zc26gS_liWppS6ET0YJtUo7CTbdA>
    <xmx:OFoGawBS7Sk13OXr7cbbeXnA7xi6jSxiyyhN7gKhcJ-Hn1tN5KNfdg8j>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 22:47:00 -0500 (EST)
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
Subject: [PATCH v3 09/11] VFS: drop parent lock across d_alloc_parallel() in d_add_ci()
Date: Wed, 25 Nov 2026 14:16:47 +1100
Message-ID: <20261125034543.4084039-10-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20261125034543.4084039-1-neilb@ownmail.net>
References: <20261125034543.4084039-1-neilb@ownmail.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_194706_628359_5CAAC847 
X-CRM114-Status: GOOD (  12.75  )
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

A proposed change will invert the lock ordering between
d_alloc_parallel() and inode_lock() on the parent.
When that happens it will not be safe to call d_alloc_parallel() while
holding the parent lock - even shared.

It is already *safe* to call d_alloc_parallel() without holding the
parent lock - providing any filesystem that does so doesn't d_drop or
d_hash in the middle of an operation.  Those filesystems which use
d_add_ci() don't d_drop().

We don't need to keep the parent lock held when d_add_ci() is run - the
VFS doesn't need it as dentry is exclusively held due to
DCACHE_PAR_LOOKUP and the filesystem has finished its work.

So drop and reclaim the lock to avoid future deadlock.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/dcache.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 2ad39c1515b7..ed957f090247 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2472,17 +2472,30 @@ struct dentry *d_add_ci(struct dentry *dentry, struct inode *inode,
 		iput(inode);
 		return found;
 	}
+	/*
+	 * We are holding parent lock and mustn't wait
+	 * for a d_in_lookup() dentry.  We can safely drop the
+	 * parent lock and reclaim it as we have exclusive
+	 * access to dentry as it is d_in_lookup() (so
+	 * ->d_parent is stable) and we are near the end
+	 * ->lookup() and will shortly drop the lock anyway.
+	 * We cannot retake the lock while the new dentry is in-lookup
+	 */
+	inode_unlock_shared(d_inode(dentry->d_parent));
 	found = d_alloc_parallel(dentry->d_parent, name);
 	if (IS_ERR(found) || !d_in_lookup(found)) {
 		iput(inode);
-		return found;
+		goto out_relock;
 	}
 	res = d_splice_alias(inode, found);
 	if (res) {
 		d_lookup_done(found);
 		dput(found);
-		return res;
+		found = res;
 	}
+out_relock:
+	d_lookup_done(dentry);
+	inode_lock_shared(d_inode(dentry->d_parent));
 	return found;
 }
 EXPORT_SYMBOL(d_add_ci);
-- 
2.50.0.107.gf914562f5916.dirty


