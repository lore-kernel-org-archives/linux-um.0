Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD4FC9832A
	for <linux-um@archiver.kernel.org>; Tue, 29 Sep 2026 03:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2O/60FCivWhWCVVOfomZmHHuRxTPAq2UvXz2LKlNcDs=; b=Xn8ApEP0MoTcfbzj1BD6KC/3hS
	ZD68V8ZLdt/uUBzXinIcJlFj7Y1hq/Df5V+A2Wl/HueWF3UbDVW6gbuoTjaPM1lXJOKJsrHWFANT0
	OinjUHdxoiq7EH/VVkh0b7a05uGRLluaNH9jgBaZOgs2AjFO69D/oJJeeW2Wu94HHQuBjdG1B3RDd
	rBh7hWpraZhBIa8ZunhcJ5tWW0wtSZBNCH2oYtUpPDRGH6dM44RM48aSGJeq8mEIdeYt/qvxzQzRv
	fRld6r7wV5NmTPa78BSvXPib4TyTzDotKzIO5dZkzQs98bp5DHM6q+fzYWslwjCmlBGFptF4DBnjs
	0hDAybpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBOkF-00000002Fhu-2d7L;
	Tue, 29 Sep 2026 03:43:07 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBOkE-00000002Fga-0SUj
	for linux-um@bombadil.infradead.org;
	Tue, 29 Sep 2026 03:43:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Reply-To:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:
	Content-Type:Content-ID:Content-Description;
	bh=2O/60FCivWhWCVVOfomZmHHuRxTPAq2UvXz2LKlNcDs=; b=lr+1rq+Til0dwxGFhTa90kls5T
	aNAVD7QF5IvAW18DwKSzALwITIZqmXXSrPjDFBWcrN65A1Dw4ZzASaobX8j23uM046QyjZgGhsp2L
	KsWm2R6UdDRenysZyz9YeQlXYhPgKTcK/rR34M1WiLR8XCz0XoS9sJfrKsb+D1UcEPe1VVYU8pRdd
	v6KW3M2qTcZAbp4Q7Dqwmd2eXnZlYCDLZ/0MUpGPPRZat+1iGJDEeDGH1gOKgExRyo94PU2aqGxE9
	CwZgpV94/W/H4/YisJfPMO1IxTFLFk3bG5joxoR39LOSV4T7ncwZvN3COYAf6xH3Me10fGPDczb6U
	+hHhOGqA==;
Received: from flow-b2-smtp.messagingengine.com ([202.12.124.137])
	by casper.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBOkA-0000000AXq3-1ezG
	for linux-um@lists.infradead.org;
	Tue, 29 Sep 2026 03:43:04 +0000
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id 06FC41301935;
	Mon, 28 Sep 2026 23:42:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 28 Sep 2026 23:42:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1790653375;
	 x=1790660575; bh=2O/60FCivWhWCVVOfomZmHHuRxTPAq2UvXz2LKlNcDs=; b=
	IO9CGq0nVjFm8570ZyKM27IXYcKPj24uoV5oacziNQ3brhdDmFbxyT0nT2TVWOjV
	9U0LCv7x960dMNNFT2ZwoTfLJEtsb1b7WYfmjuny8+MJX3nhvfNZ5XAZrPPa7bjM
	cEmgOjmTYfjLoSTVWSROU1ABqE0dAu5U+eBwOt25CdVk0JsXX/MEHWa80YYGJydK
	Zlyxd4ROsv7AuTCMTefhDLOvS2kMIb/yw5Zkf0L13qd+X9MNrm5qrwlQZYwo/SED
	FegfyydBZa1ZriG9IpSMVPUehQop+SbMYFjR9q/UMK3bRec4tBNnpzx0VZQ1jtQY
	Z7A+zY5fpKZ6+eCJxaeTDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790653375; x=1790660575; bh=2
	O/60FCivWhWCVVOfomZmHHuRxTPAq2UvXz2LKlNcDs=; b=BUefSLyP/rkSO/ut2
	7b2if0LHKCGOmNT2Xrqx1RQrDE0UrwT6mWotfuWdE371Vs6k/5eTJlVORtjUlRl4
	vDen87HLen3IwDO9NWQhNqwuHPiWhKMvaf2Tms+/BFR49++jjfQ+tzdM07JJjfL/
	6oT3tCkzAmtZ6ZWnEHYXPPQEaMsDOlwjC6Ts9pUn1fSUrVTdah5aMI1Wgws/dKKk
	zTG5Fkn4lfcVp02IwhDdvy0x/99xU7QSWd9sgavNtpkQ2A39TP9Lldy6MhZJCfWD
	VG3kl0qc75kSEK8T0gEQiz8KV9SkL8SD3ZHTEeODVFecUaXNMXR0SSdRn52rKyc3
	bqBqw==
X-ME-Sender: <xms:vzO7apxeKOwB8960HYdX2wEZWf8hG0-b0MbfQJ0aurUbwjvyI0HzFA>
    <xme:vzO7asOOAWJcXkwvlKVQXpREg9_qmIKZzWHOIvgEjnwXoG7B1i31JKALzdI4yj5Oo
    1bbCdGocJhKM-AcU6pYzkAKXcLqLliFiCc7zRfmjVJeLeUVrGHD>
X-ME-Received: <xmr:vzO7arhPeTMucOaOkGJaNMh7xWd1QqaIqlSfiSJZLYmqsVNY5ZHy6VIrkdBhPOm0xbLK6cTecsAUGGrmVT4Rvqux0QyHwfI>
X-ME-Proxy-Cause: dmFkZTGoJB+17Zq7ThrEPjmxn4ZGYu519RzWwVi/88aejzKjstMboztaed73ef7D6avpE+
    +4ud1a3y7i3orjwLfnXoctNyz4isc8MlqqkCj9w/LgYTxltRiENCW6GCIqrBIGfd6BoOtn
    3U4T9DnMQq0t334tHmkLT0tBGbfhvTaaBwaOBKtxwtl6WpY46qwankbHLMumQlIvXZxJZX
    MK4M+NdZABlSsm1lFGpu8Zoavf0+po6/QQ3FmqOSdXOPNwreWLw4U6EONlQdAFPuoTNGlS
    rFYPmLdcGE1rV4M0fAMpJKofG+st3+8PfQ+b7I9sMwGW86B3jq8HWH1QNmIbUmtd6GqsIx
    3DVTTK3c2J4I5ksQ7YyAt2ucbNF9r0AlsngiXh1ZkIv7thtpYXLNnTUIfCDQfndn444S46
    l1dh51qZhsKVnaNR6bMarDeu5tNsrUujIGjUBidPSanYSk6e7/kUoJs+bjRxMxsvdwHgj6
    HKnMlgAbD24F8kSuVHwT2UZSNIiB+cS4WDZI9tUzhwFoGRd2lPAtPEJSXm1Pe2LV9JNLFp
    GZDEgrMbCuznyjBU1tR9RO271343XCEitk5ltMl9yuFi2TNY/8BLoMaBLR3qdeiu/TBDeh
    6iPoZ0/BmrQucexrf8RUmMuStwUqtHfY0fumNrXcrDExj9+GXZGQyED/sRAQ
X-ME-Proxy: <xmx:vzO7aqXl35KyDtNVZqU_B_sQXFLoZTfUk79lE_WKdImBnUegDQoaFQ>
    <xmx:vzO7apxilpgaIJQYhGoMG4yYHtVRxYaJH9kAPyhtX_q4bwPNHp2G6g>
    <xmx:vzO7alM6nb3XkoPNmncM9IB5zYXVqe-DMzfNyLu93kgkQQBmjM6Low>
    <xmx:vzO7amaEbVoai8n90Tg8O8x-BOqC1HBtSTvCGT1QDh-AkxtgxloLIg>
    <xmx:vzO7aqpmPFgEKPq0kHh564-Ucrq4-XCv4BztJZdZfouHRpbhNK6oprBI>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 23:42:47 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Breno Leitao <leitao@debian.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Jan Harkes <jaharkes@cs.cmu.edu>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Carlos Maiolino <cem@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-um@lists.infradead.org,
	codalist@coda.cs.cmu.edu,
	coda@cs.cmu.edu,
	linux-mm@kvack.org,
	ntfs@lists.linux.dev,
	linux-xfs@vger.kernel.org
Subject: [PATCH 3/7] coda: don't d_drop() early.
Date: Tue, 29 Sep 2026 13:36:03 +1000
Message-ID: <20260929034158.1455429-4-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260929034158.1455429-1-neilb@ownmail.net>
References: <20260929034158.1455429-1-neilb@ownmail.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260929_044302_540291_13BF56DA 
X-CRM114-Status: UNSURE (   8.01  )
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
index 67148edfadee..bcbc9d058303 100644
--- a/fs/coda/dir.c
+++ b/fs/coda/dir.c
@@ -249,13 +249,13 @@ static int coda_symlink(struct mnt_idmap *idmap,
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


