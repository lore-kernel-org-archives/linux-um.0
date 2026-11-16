Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5972606A323
	for <linux-um@archiver.kernel.org>; Tue, 17 Nov 2026 00:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=MUU9dCU/;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=F+LoLdgJ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=e0uXZ6Tp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=iIAOm2lO6QpQNVOJTbL8Bgbw9WIRjtGNSHgIT3oLz3s=; b=MUU9dCU/olNpR7YgYl77Og5eMM
	qVUHgx5l4BdSOahuk66aTNt5VfzDrWxZPO1UHHCshTYKHpnFEWChPCOR5C3jXrpBIyDxsplXLx61F
	5iyQwC0HNy/xnCbz0iwgEBgyzg3dQjhG79ZrN32D2VP4sEbcJoUl3coYYMv0wdYhNB+5AhlbpHgwS
	cj3HXiao87ZMaM2OfKWCJrJM7teChmmbToqlt01vr65xSJ02+pUxeVfYfDAXmvjkC/gjRmwhuytPh
	eW9p+yi4OkU89aMJC7/q9TtZe/SbyukYhuAwHWXmva9nVp/xpSl2+EAwBO2QLnQJCa2spIjucGp8D
	p9Cgh3dQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT6e0-00000004E6t-2hj6;
	Tue, 17 Nov 2026 00:01:52 +0000
Received: from fout-a8-smtp.messagingengine.com ([103.168.172.151])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT6dw-00000004E4t-2vc5
	for linux-um@lists.infradead.org;
	Tue, 17 Nov 2026 00:01:51 +0000
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id D76BFEC088D
	for <linux-um@lists.infradead.org>; Mon, 16 Nov 2026 19:01:47 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 16 Nov 2026 19:01:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1794873707;
	 x=1794960107; bh=iIAOm2lO6QpQNVOJTbL8Bgbw9WIRjtGNSHgIT3oLz3s=; b=
	F+LoLdgJT6wgJNGy00Klf3LfXZvSmPoRA6FnIDNMYjAe86jj2ybM7VLvJrjA6fYm
	mswVk+69ROdPv6HsIY2RMrtrZOdY2OYbfT+PtUbYdJ2CjVxLr89gDUzjcwxiwXAT
	LRnizKiJWzOO05YBz+AqJ10kc0hRJl6p84VVJQOnnN0E9K4F2ixPbsHx211dYgZ8
	8BDFbKc3sBIF7L8cDMCqT/PD5GwmoWrFTAi6u7KBhN1J+p+27IrE8IOi1HobGFim
	WM9GUhAb52HghD7TFhE3uKTegmBl7/BG9OiWKqKkkUlDovqj9AFgvEIHubZsJLj8
	9vGaj1ZvueitlNXeBIkwwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794873707; x=1794960107; bh=i
	IAOm2lO6QpQNVOJTbL8Bgbw9WIRjtGNSHgIT3oLz3s=; b=e0uXZ6TpXVcXjwuf0
	ABzlVoX1hlcJbumEFfc8uNQ0CmbUkxu3TtnXFFDrOyDaFS+w0cSXFn3VgzIxGVv/
	rj2ar5d8adU3nHmoUDjfMInMIiORlYV585k3kThp+3eiioxa3WpVGzvUH+BziGXJ
	dSScSvM5arLMV/vmsdCvGH2V1CXKB5ADPHaVPhezToPEh9bw0zbYz0R4GkaOmX29
	DaL3I4T6Few1TQfzXODNLpUSYbSeK420RASszdo7poekuGAeEhZ/xPkMU/fSuRs6
	GjMOwPqcVZBpd+8Bn83HI1mLQN8a8ZSImo/YChb9MQzfXlfHsp57I77cg6TuJx+T
	tPLLw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794873707; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmc+;
	s=fm3:rsa-sha256:K2OEejJDXteT6qcl6VB0/fIIinm19jxD9w3gcx3gGg6fC1I
	x+ginylKYbiqu7x+O8pkPswY8fbkM5vmNVh0qWZiIwtiE6aYvl5hYJhWDTNFQGTC
	CtjKXDhzcHUijYxIFhOI4Upbci8JdLWhQYaZZgjq2RIKfYm5KuFXAvY/BE6TrIXG
	MXgNkitbdNN7rdHpfKEMEOSO+c4ybqV2PtE8eqekkUqxMLFHNRzSuAhnCk6h4Ajt
	zhw093w+LGLlwt22TvGkwXbQ0A9rtDS5AsQTGx7WiNnAvhkBVtWnHttsOfyp5p6X
	6J8EmbEqOSme+ktLpl0AJCNiwdkYW1JfwI65Bcw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to;
Message-Instance: m=1; h=sha256:gmiRStICROQAPeEHtzUrO1Osv21BjjsgukamHKPkV6A=:TnYk6Us2qwHOQ7ZbL7drRjEiRjFRhnkzrlnE9ZTXkBc=;
X-ME-Sender: <xms:a5n7au7tZIU0ELbSk7_02uku1eLe8y9q7QtSDDhP2P_DK9ObYPNvEg>
    <xme:a5n7apPT9tKsWMJnfJC2CcthEjaz-WKVRHzW2ZQK_xYZm_l-ARa5XQUgq4YdqHOiA
    areO-q-4iWq8Ef98vLbHyLdvLtBfQctPYfTNWoXucFt5MBN8Cg>
X-ME-Received: <xmr:a5n7aiEs4bUBEyEzk3Y5kDUDkVoP1467SdOz1Co-MB4yLenWUc2DQLd33Z9GEph1BEMOpOiVXqIVEvcnU4AZyXfXMVtvorA>
X-ME-Proxy-Cause: dmFkZTEWLllwmZbCQ7cO93As6sGHtjiFdYj9k/VSqMvUwk1xfk9pKn/ZCX7mnpLkIaqMef
    K/82szmVYemJN/I0DCAIOCHeaPZ7/Xa2GnBqk902ewdx8hjF22LzMBgW8kwMwZuhDEqmG+
    fRzfUtzcgzHNqdnt0hptgxxppIMFQUfVlAsIvg7fvTNv54Da321pj6NeCTNh6yP98D0Rix
    0qUujhXor+6vA1uX99KaZah7Remd9bF8xjGXqzB2MsscQiqTyvs6dLxlge9fkMF8nj1I3u
    +RSOpU+TvlDvjmsK8NtReLJ34nN/1FLS6YOAknIb84eISWftGKSVwY1LnVjpVMr2cR7DpO
    Y0h/zKtwlxM0uvEfa7g8Jx/Ey/3+ldN6Sjz2mRXqaEZ2hmLY4820tj8fL6lwjN21CoBYQz
    GIWLW9iEBzj59lwXb3i+Nhfzpzq83E74pbh7inCaF4yKQsKw0NTRW4w1npTfrI0VHN1QqE
    TVzGrFEbQJb6Whs732iR6GGZBw3CAbBgUgj3CmiR11QFLXYe79wKSy6nV74BTgcaF8aSbT
    a7ZjNFSH6+6cXY3bpNxdzkUL0tqfa4vfmJ9LR6x3TELkcnAkrPqDG1f7kYWfQg/LoXiaoN
    YyZbJUcgZsmsXk8ZyJSwLI9Mvtz8pgPOqDpFIdIYh4Q1qZqMw0LFsciurKQw
X-ME-Proxy: <xmx:a5n7at0XrbVLqROgcupNhRbriS5O-bsjQ_2AG5f8yklDRjEhSqsN4w>
    <xmx:a5n7apFUBcquhGw9aw-1KfPVB996xWjWf8QHc2-7pB9HgjXwcCeACw>
    <xmx:a5n7auwOWJ3i-UqOdxUfBRaHyMEOb3SPf7VRuc7f2eJ5DQO53LRFpQ>
    <xmx:a5n7agmmNFpZlhDsOqDxcM6F14WY5mmhLliXtb-C8oLmRlOXJOWj6w>
    <xmx:a5n7atwtnaAGimM0pNoecCnJ7u-xKm05MYFmHVEyVOPN7lmS6VEW874k>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 19:01:41 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>,
	coda@cs.cmu.edu,
	Jan Kara <jack@suse.cz>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Carlos Maiolino <cem@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	linux-kernel@vger.kernel.org,
	codalist@coda.cs.cmu.edu,
	linux-fsdevel@vger.kernel.org,
	linux-um@lists.infradead.org,
	ntfs@lists.linux.dev,
	linux-xfs@vger.kernel.org
Subject: [PATCH v2 2/4] coda: don't d_drop() early.
Date: Tue, 17 Nov 2026 10:54:59 +1100
Message-ID: <20261117000115.1433875-3-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20261117000115.1433875-1-neilb@ownmail.net>
References: <20261117000115.1433875-1-neilb@ownmail.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_160150_079296_D43AA558 
X-CRM114-Status: GOOD (  12.39  )
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

Proposed locking changes will mean that calling d_drop() could
effectively unlock the name allowing a parallel lookup to proceed.
For this reason it should only be called *after* the attempt to create a
symlink (in this case) has completed (whether successfully or not).

So move the d_drop() to after the venus_symlink() call.

Doing this also means that if the upcall that handles venus_symlink()
happens to look up the name being created, it will get -ENOENT rather
then a possible deadlock.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/coda/dir.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/coda/dir.c b/fs/coda/dir.c
index a85be5962e62..b47299527b65 100644
--- a/fs/coda/dir.c
+++ b/fs/coda/dir.c
@@ -249,13 +249,13 @@ static int coda_symlink(const struct mnt_idmap *idmap,
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


