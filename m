Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DACB606A334
	for <linux-um@archiver.kernel.org>; Wed, 25 Nov 2026 03:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=tKdKRRKL;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=va1d3aw8;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=FW5JIddi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=dCHNhqHkrzrz2mDQOu+WPZ6RNgUvqMqCKviUggAFHfg=; b=tKdKRRKLABSJQu+dFzdR4AH9oj
	ib7PhhmiDS4hyUJhIuU0kQAHRWstlBZOx7ytz6Y5X9J8b0rC4vJky1Ooq4WcWU6tdCA60lsOQj1A8
	36mO9g3p+Daec142JgwAbh4d3KJCP8B+6ODbjQe5DoJH3HOg2Q80S3z0/EBl/MMj448gS75f6ja4l
	IfmXahLW3i39+cavNmfT3v16yUHkwhqWk0PgXcMy2lGPsmpawFmMiCku1OrUpfiDuh3DmQe8d8So6
	TfeV7ymjuDcjag5w35ZJo5yBDJcQO5mrfDwJgN4XokGFjICMB/QVSVcXdiZACPiOB4suN5ppWoDWI
	UB/3kJ9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW3yc-00000008Lk1-3W8e;
	Wed, 25 Nov 2026 03:47:22 +0000
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW3ya-00000008LiO-1dut
	for linux-um@lists.infradead.org;
	Wed, 25 Nov 2026 03:47:21 +0000
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 9BA26EC0A77
	for <linux-um@lists.infradead.org>; Tue, 24 Nov 2026 22:47:19 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 24 Nov 2026 22:47:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1795578439;
	 x=1795664839; bh=dCHNhqHkrzrz2mDQOu+WPZ6RNgUvqMqCKviUggAFHfg=; b=
	va1d3aw84KksXRSBIx4FJ2okx4+klG2QAdorkc5ywg1CK+o7Qu71/nyD343nA0Jc
	dhr/Gc90CmS3WDRIJN/+eJ2HjH8lpBtDy3BslQii0YxQQvx24BuOQY8eF/EK6DGc
	jDE1+VL+Qy169Ckh4wlxJ5XHGxY7aT1G7QqgHS9uQGNYEpiVlmszXuS3LgTAKY8T
	WNqTn/xVoLZhoIR2yL3uiJZA0zptePeCkXFR/Ty+Hwu0aClyvqGsJVXBhtUjBGGU
	WZ0peyBkgLxzMqtS0Mrypt8cS6/53Toj4vzEwYNgWV8vkPkm6r2NCq04xQ5NpQA1
	N6Y4LJ+8u2tyKeEito65IA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1795578439; x=1795664839; bh=d
	CHNhqHkrzrz2mDQOu+WPZ6RNgUvqMqCKviUggAFHfg=; b=FW5JIddiieTGO+cqe
	hcQkgxBGwppM9POYHLDt6pG/23xq02TJyjltZpK+6g/2X9uWjYRCsbp4f3iqIVku
	XV9SpPLQl2GWRApWr1/DWppdhsWVm9uNnYTqA9on3sZnvfQ/W+jXsr+InIWbefUS
	8o3tnuU01nkB024NTzpwJODIdMGT9lMLwokFmu/XQiPTWRVeIuPiu6ehsTCEiwGW
	mNBXyw7aWiriP/TDPPS2DLtLz7SqTEWd2DkbOS17DrL2rv0F5iFLDf2hHnKL+udl
	FYipxENZCJAAjWmfndXsTtnziTard3IO/fuQCw/g6hI2OYH0vAZQCF0c7a3tVCzw
	JYGOA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795578439; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmc+;
	s=fm3:rsa-sha256:uHgqfhxG+6esve3LUk/1S5sR6Vy0kgULSa6T8m3Tw1NzU0G
	OEHWLiSiiTX6WkoGvBOPb+PzIo+geO0YiscIEu1VtQnpC2ZhlYfwKrxuyGgtAbTD
	IMFFCFj3Lyb+HbhCLv0Bt1ptt0UvEHynMeQoAyd7Jw8ejyR6Wd//3u6nq8i4CFZW
	Y1qqsa6QDEILozgb9dVa0Gw7AFrJ0o55Agt5ikhMeAT7uesBarhc5tjrRbwqFF5j
	ldE2Qq5jDROMmoAq/ygQheCCY1vQrq0vKaS0P6n5X9ILxpfO01MOCTrmd3e44GEi
	3gF47Lz5kV7DoTKgNp8lWomfed8eBpDXRdUkqMQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to;
Message-Instance: m=1; h=sha256:w7IvvJbIcnCTYqHB4sNx8kYi67Yq0w+ucVxZGu+sY4Y=:gMYcM06M86YJ9UdGbkaR2cCHQB6Y0einrDMBHpb3ffE=;
X-ME-Sender: <xms:R1oGa2GWIhPFFgR0emympFg5thHmpkZ04X7oHV2p0PHgddxncdllHw>
    <xme:R1oGa-SKJA3XOQaXzRv4vqCxAgtgUW7YanUpSleGoHkRAJgEuLAQ8toJiwSWeGvvo
    -QzyT8S_bGR3cxKikVjUjrW9pwNgmp3PMP7JmLK5w_T70BV0AU>
X-ME-Received: <xmr:R1oGa1NNd-EoKNVfdkDi4ggicxB4RUQLj4nz0vzEr7yKghWoRMPaj8ciZKkaGVnWJn-l3nMDpP29AbK5pwrUpM8Um2v8n-Q>
X-ME-Proxy-Cause: dmFkZTFR427OSMpMhBUq2c/PRD6RmqRpXHsHavEQEoZib45veoj0ON4Fee0fFpAMf6IRZD
    7ioshD0AaEWr7quPZ3VJk4MkgPxfK4VajmEfAasmF1N4QuQ1Nx4fAT27aU1zZmPYaReDqx
    rfP5UHReFgze/pUM1YUaeJAgJLGWSi2iJU/qcqRk+B4M1TsPMqQDofdX/Jn7SjcVJvCtNm
    zdB65WAuETFQQDYBDZIOHXvboBphMIm2vyy1TKs+e7zZqPSqTzzCVyEWo2arAfhj68hGFx
    kBzHUYnaQIV/eTYhsd/MgvSt0+AvaXUSwYNCdWWq7bBlwHpxfTlmsOfayzrTTRF9w5P7E+
    NhwDTVyxSr56UGePiE1r6hEUm4rr62pt0ea1crZBNCZZ3iI5npQNpdqKexwLE2ey5zPQVT
    kDhkVCmNPqxKgalPyvC2iQjnNVaXgdGBhj7v8CWR4NKmycHqHQEput8fYFsOTUivOijkd/
    C7WmEDTTEDydJUKJW7nxu2LiMovm6yLdR5YhhMqM/S4XNtznI8gHyXT2wyiXDgmPbfr/hb
    I2RDigEYftuQLDbApMxygEBRb/yjHao/gw/eOEnlNiIU9+mBBu2A7WIxyoMNXYtPZkjjt1
    QxiRJEhoblSgSdCJokLOY/H9/3MPCto/MK3arCn6QkBj6Fyz8ygF2suOcrVg
X-ME-Proxy: <xmx:R1oGa3O2fpbpCsTARlOuVg0NnavpbZEL2-aFG55og_QXkWbY8JEoYg>
    <xmx:R1oGa3H1QfK6v0Dbn27qqEhWQ1CmUScikM3Zr2XG4Q8cHIH-55BV1Q>
    <xmx:R1oGa5Pelic14_ayqIwY0DjQCUd_Ggg1CXUR28uIxq4C1P7Lnek_Mg>
    <xmx:R1oGaxsfBUQHWNeYcwSDv3DRdYfBrAsciAzU4jESmw7oXOgY-Cs_8w>
    <xmx:R1oGa7wqWlJ5rmNRv9gfnvyM_oJXD96fN3FJTTsN-1oGR9hSUDlVUkDS>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 22:47:14 -0500 (EST)
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
Subject: [PATCH v3 11/11] afs: lookup_atsys to drop and reclaim lock.
Date: Wed, 25 Nov 2026 14:16:49 +1100
Message-ID: <20261125034543.4084039-12-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20261125034543.4084039-1-neilb@ownmail.net>
References: <20261125034543.4084039-1-neilb@ownmail.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_194720_634958_9BB428D3 
X-CRM114-Status: GOOD (  14.21  )
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

If afs is asked to lookup a name ending with @sys, it needs to look up
a different name for which it might need to allocate a dentry with
d_alloc_parallel().
This is done while the parent lock is held which will be a problem in
a future patch where the ordering of the parent lock and
d_alloc_parallel() locking is reversed.

There is no actual need to hold the lock during this nested lookup, so
with this patch we drop the lock and reclaim it, and use
lookup_noperm_unlocked().

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/afs/dir.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index bc90b30d8b57..7ed5ff63c90e 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -938,6 +938,12 @@ static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry)
 	refcount_inc(&subs->usage);
 	read_unlock(&net->sysnames_lock);
 
+	/*
+	 * We need the directory to be unlocked so we can perform other lookups.
+	 * We don't really need the lock any more. The in-lookup status of
+	 * dentry gives us sufficient exclusion.
+	 */
+	inode_unlock_shared(dir);
 	for (i = 0; i < subs->nr; i++) {
 		name = subs->subs[i];
 		len = dentry->d_name.len - 4 + strlen(name);
@@ -947,7 +953,7 @@ static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry)
 		}
 
 		strcpy(p, name);
-		ret = lookup_noperm(&QSTR(buf), dentry->d_parent);
+		ret = lookup_noperm_unlocked(&QSTR(buf), dentry->d_parent);
 		if (IS_ERR(ret) || d_is_positive(ret))
 			goto out_s;
 		dput(ret);
@@ -958,6 +964,12 @@ static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry)
 	 */
 	ret = NULL;
 out_s:
+	/*
+	 * Cannot take parent lock while we hold an in-lookup dentry so
+	 * must make sure that lookup is done.
+	 */
+	d_lookup_done(dentry);
+	inode_lock_shared(dir);
 	afs_put_sysnames(subs);
 	kfree(buf);
 out_p:
-- 
2.50.0.107.gf914562f5916.dirty


