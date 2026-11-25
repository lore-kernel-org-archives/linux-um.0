Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5664B606A329
	for <linux-um@archiver.kernel.org>; Wed, 25 Nov 2026 03:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Umel5mbX;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=Q1+wqOY/;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=SsYA5V8Y
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=vhC5fsQg8d45Bifcf6O71h8hSOeLuwv1nI5aMDxT/f8=; b=Umel5mbXd4rEZAYiAKX6Zq0B91
	IYjDObjMvvJ45EtEjsi06M0KVlRoCcSCzUUH8xJjqmWwS7kfyJ/5wew4ZyecJfPm8BTW1/YUnCsw3
	YvtF1ktmk6XmckXnkdkO18aa9akk7Ujecc9ntsW0HFLn++r4+9h9CLbXxux6400jrkVaQyblBEU+c
	vN3tDsu2TRHGsL4ot7KrZd4+OzKJXvwRBEz45+1gywGV0Z4vCU9OcR/8exdjZoteg7ZhZna+xXEuT
	4WRUtmGKut10TSVA6GKKL3VoG3ulGUEBK891ruvIaNF54dqI6SpGqZY7myCbHLwvQu0gdGx9iyb2/
	KBth8UzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW3xS-00000008LEN-04Mb;
	Wed, 25 Nov 2026 03:46:10 +0000
Received: from fhigh-a2-smtp.messagingengine.com ([103.168.172.153])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW3xP-00000008LBk-0Uyo
	for linux-um@lists.infradead.org;
	Wed, 25 Nov 2026 03:46:08 +0000
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B6070140034A
	for <linux-um@lists.infradead.org>; Tue, 24 Nov 2026 22:46:05 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 24 Nov 2026 22:46:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1795578365;
	 x=1795664765; bh=vhC5fsQg8d45Bifcf6O71h8hSOeLuwv1nI5aMDxT/f8=; b=
	Q1+wqOY/nixv5edzYOqKmcnUuP0LQYY5P2oH1IwVEVjB0LRZuaVpoCrDw/OPtutm
	ESy9zcxe0ge0hIwSKCUH6d3riwFqN8cot44v6uaAlAtso3AnoUjCou+litdH/BEw
	T3uVRgHIn21e38FacsiolNx24xDyXkHVUPXVRd9eU7aNG7gajqBbPOflb3zY80t4
	aN5dpPwTEIFJLsejLj//9IAobyuTXpgOROeT8Ud2jlFPEdxtOeFgT05Yzrf+qI8g
	FOGuKIeQX/MEuTiFO6gJUXUUMMaqf0ZiRQnB2D15v5+SfpnOXpZLS1DYneMRDBP/
	ey4XudtplRoz5QpCBUOS8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1795578365; x=1795664765; bh=v
	hC5fsQg8d45Bifcf6O71h8hSOeLuwv1nI5aMDxT/f8=; b=SsYA5V8YoHMoCQkdG
	8aamsWHTJtXdx0K7dWFdeAdaTbCl6P2w78mlWckosu+QNT3pifuSD3rR4blfp3Wf
	60u9O2HdB3k8MbDAvVT/ghmgUFOgh4DqvTX04/nM8XAPxenJE5xyv0OTs/kc3dR+
	Gzll4uvsFANInENFbp7u4mRaCCYBq5AlsnbS72+b3/HuuABWNDI/Iqre3QEnks3w
	Ku89dr1wHL7ler7eXJvWV7S8urcSIuiCv5NRdUbRqKJMWWLTMu0EVSlOvnQfaOW6
	svwPhlbH7fBk4M8DOgkSHDBFaeQflhHNRjH90edd8CJkhcdQc8s8hToj7BW59fl9
	cFtdQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795578365; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmc+;
	s=fm3:rsa-sha256:PubyuGezwUL3gIkpz520FwohCD0ElGo0kJdpYH409bjNPQc
	ppM/dWGWZpdC4JwoPW2aXx7sROAg0VnGn4xRBYpejrWlSBPVpYAvast0sX3za5Ja
	z9453E81Y3q0qwp6ybyzR6EKLEWjLmLlmMQ6I551pTp+tj2s4xNh4yBWmK+JzTUa
	8Cfmsdokak28Wj5Qv2c1JRwmk67rzYeWssnNlTcRSWqGMH8T233IrimO22mxEjU+
	+TDzDGiSoKanAf8IeUsxQnVJHdua8+p7Q1Ar7QE3vMu7zBtsuqTmpXBWu/FPyDZG
	7RdfcWj/09Cv9HGo441ZNM4Z+7hU7HLreIKkTGg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to;
Message-Instance: m=1; h=sha256:aczLsbyhzVPdHm5hCYK/zgEeHJCzlj6C0j/IjR6R0rg=:m48h43R0vdMJ5ex7CmVr71oScc25CmsJQRrS0xAhUYk=;
X-ME-Sender: <xms:_VkGa3XNZsA8sjsM7inap5z3ze_gk-PSa5yKma-bKWaAs3VMZbDWEg>
    <xme:_VkGa2j2Gzt8zihI0AVaxToN6vnGmUYtkc8PTqd26uLIr1KsSeYOwpzTRKgfqeppd
    ak9fyDXyY2hsJy5YXVUoFLUAZTCWrMHsbyaTJjtzmT_9uPbPw>
X-ME-Received: <xmr:_VkGa4esGFR6IpgSNmR-vc-hw1fFRJHcjHY0AJheq5JYp3hUFWpep130K0fwKap3lMYYBK8OuoLvptp69g2A66DMkAyJNjo>
X-ME-Proxy-Cause: dmFkZTEynqFP7J5CyP864zJ/XBXUDXSwXypje4KQHx8Td74dpnR0VUtokV1VIo6Vx6RvWY
    OwcUpg/bo5jA9DF1nhHbEWSmkeBRQExzYYNm6zYQ4OlhmT8++hv04QLhCP77UTRa+ts0Zn
    emG1u4CBc9EwIQZMHpuGtkFzNaPM0COhHCVGi+vUdiGKTo3oTFKBSdfX5nxIKQZvHQpAoR
    JpPaJpl8D3VaaEmf1HZfBeZUeFh1WggTkTCrotD4I8diURcXOaSBUF/YM1mWjxdOr0yho5
    GSRzb/bSajGZoPtTNw69mn1JgOv5z8FPk55EPMBJOvn4tHIN4QhGRcsvm9DrK4aqK7Nvow
    DrAExY6fCjhjyduW1b4R0elDpafecHvbKjpUrCh0g0ItLBmPYbvPVjZ/0n7RGqaufRYwrH
    oTSs5dtRdzGKtq6JegF8loWZ5jMeBZcnt1u2yAFRE34iK4JTdIxD3wpXap0Pi6CZpqpYrl
    J2l1iDMDe22XNIIOuy/yIvICSj4dxDrehZMImxgpFhk36FFRsuJmVXQGwxf/2ZAWiBD911
    tB+KuUcOhG4fpwyB6fJlQ8zNl077zwWva407aPXe+syOf1bUYH/05vX6jKExKB13eEh+iz
    iqjfHEYoRTcScfABjAYp0KUcH/Y2eCddrCymhmPviXcxj5BTJE4BC8ABVfaw
X-ME-Proxy: <xmx:_VkGa5f3rDylbpUBvj7qwzcaxK8odyWGjEJMHBZ33C3C90-xLybVHg>
    <xmx:_VkGa8UJqofeOKYFFHnRbb7vy6hH7X4Q7x7KVenCgu57VNkJ2yVThQ>
    <xmx:_VkGa1f-mtyrbRqCl2H05BNF1imdZEP5lWLIUuqWKbLOnQ3vh0hSDg>
    <xmx:_VkGa4-9AEyb-EdOlbOq5lYxFwvKj_hbQajmw8lUnhylDF13jmuQ1w>
    <xmx:_VkGa0AUR5cuNet8qktnqnqBGQh723XJ7fitRDrJYocl03dPkz7OumyN>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 22:46:00 -0500 (EST)
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
Subject: [PATCH v3 01/11] coda: don't d_drop() early.
Date: Wed, 25 Nov 2026 14:16:39 +1100
Message-ID: <20261125034543.4084039-2-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20261125034543.4084039-1-neilb@ownmail.net>
References: <20261125034543.4084039-1-neilb@ownmail.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_194607_255730_DF7705B0 
X-CRM114-Status: GOOD (  12.49  )
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

Acked-by: Jan Harkes <jaharkes@cs.cmu.edu>
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

base-commit: 4843f6873f7c4835e62f2c73ba0fd538e57a2f22
-- 
2.50.0.107.gf914562f5916.dirty


