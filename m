Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87303CA5FAD
	for <linux-um@archiver.kernel.org>; Tue, 29 Sep 2026 03:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EWrP5nNb8I3PjLtNlYNMtYoGZpi6j9B8G1WFvVNpccA=; b=SNVIvLOzdkNCujfgVlLyHBX8lE
	pTun3vlqOe4RE0ofXs92XzXp39F/UPPNDX5Z6YQ4NbnUrDX2zyitLlojY2wa2ezgLNbmP60zqsm4I
	d5XY/GqEzjN6GCIP5slZ9WyKmxKJ7IAiq+vXg1sNdv7sOoFl8EpHIB6nck2Kyfz7p0ArithaE18H3
	DZlnYaNRGufM/OjfildN/CAzxN5Tst5ClgO90+Y/8cBNxWZ5s4sDe2bAth+/88NPVfVJTRt+mKq+G
	lplenErfj+7/IlwASyBBLeY8IAR1Gqoc1NHlX/r5DpIb2z1BI/b0maoAFoPMcb8XSo1/dNHvHGhk/
	wJPC5QAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBOjx-00000002FY1-19qc;
	Tue, 29 Sep 2026 03:42:49 +0000
Received: from flow-b2-smtp.messagingengine.com ([202.12.124.137])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBOju-00000002FWi-1Wtl
	for linux-um@lists.infradead.org;
	Tue, 29 Sep 2026 03:42:48 +0000
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.stl.internal (Postfix) with ESMTP id B185D130192D;
	Mon, 28 Sep 2026 23:42:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 28 Sep 2026 23:42:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1790653364;
	 x=1790660564; bh=EWrP5nNb8I3PjLtNlYNMtYoGZpi6j9B8G1WFvVNpccA=; b=
	LzlYWz/xaQPHRAjmi2sc4x429GQsZ9jl9kghm5nuoZC3ftOXUrYzqMv6b6xSKENw
	9FpQOKBm7+FdakkdECDpmP50KW9Y8RXVXdZx+wMxaDF3rjlTpBHLCLgP4YJqBFBl
	EoZM+bpg/LJ7+dqED9WxZzFWO7fNrvE0BRhPa+zffFRrr/gRpnTzpTwCW30F6rz+
	ZoWmIiWVF0jH1LIrmZndKBKwha8ma/K7HHXjEkqxFhJtEEiy+NXoxuYV1hgC9syW
	AMCm2z4sq0HsOWqv4vgaVwenf+BbwZl/fj+rY9OEC5cpQKXRLworzhoDFEW9wHTp
	KyyoXOOr2qbUPM6hoiTA9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790653364; x=1790660564; bh=E
	WrP5nNb8I3PjLtNlYNMtYoGZpi6j9B8G1WFvVNpccA=; b=STfuHBhZIx2BJm7GO
	ufMkWZnPLmACNhxBlxxxA75f6CKA6nOuzG3LDX/TRS7CPQQdJfvs1zmNw5uZkrzA
	LMdaL94HgrlBOUIZbwhcVGP5fs9UPS0Ezsn83Mwnq4szOpSku3X4ABYPEeyE6UoF
	c/ea070aNr284RJnL0KAQn5YHS8F8AyYJDbEnEPDHVj82F4+iwUNGtKXPvsdF+FJ
	0TUyKXY5gLpTY3wSUSS3gnmKEvyAyG6w+CsUjpVklXQMx0AU90S1LK1otBptk78X
	XsPNxYT2kyfyL1HBdHRwZ5EXiSf7+NCV1TqHGyKTj6zEHrPzQWAVljMwWuwRs7cR
	gQ4hg==
X-ME-Sender: <xms:tDO7asQA2cQWsRp8ZT3D9HQqbqwlrk_XY7f84goV87Wr39FRRXMrLw>
    <xme:tDO7asuJxoMrZMEwS_r9d1WET4JhwZYCrv4IDpeSr3bOYaqr3wr5bz34NW-jdZZjG
    wjjzGmp0OvOhBp21ZciZZ_eSVpRnpddHiFosKnpyGjmBsmjTgZt>
X-ME-Received: <xmr:tDO7aiBiQelNcjPHqEEPc5kynT_ZlqvpqsovlQTa6GCSHuDgATpelJ_vzQeXO_cb2kjeLZIKVBn1irynuYAJyb2ZDuSjW0U>
X-ME-Proxy-Cause: dmFkZTGoJB+17Zq7ThrEPjmxn4ZGYu519RzWwVi/88aejzKjstMboztaed73ef7D6avpE+
    +4ud1a3y7i3orjwLfnXoctNyz4isc8MlqqkCj9w/LgYTxltRiENCW6GCIqrBIGfd6BoOtn
    3U4T9DnMQq0t334tHmkLT0tBGbfhvTaaBwaOBKtxwtl6WpY46qwankbHLMumQlIvXZxJZX
    MK4M+NdZABlSsm1lFGpu8Zoavf0+po6/QQ3FmqOSdXOPNwreWLw4U6EONlQdAFPuoTNGlS
    rFYPmLdcGE1rV4M0fAMpJKofG+st3+8PfQ+b7I9sMwGW86B3jq8HWH1QNmIbUmtd6GqsXK
    DC+GUtJHnyMmRkH4wFwirqcbuesm1+52cfp5olHBjWV3n8bdv8DMYag9MTP6cVmvbNKQsK
    bZmhQ+ixvel2oXc+5Pg3sPF6La15pWjbBX7y1xmjwy7R1ukYFOszkEG5j0Ke11PX5NOrwt
    v4BghLxi6SSbePPiPRav+EFRd3kGsE35BUZjCtg+fwu4e/KQOU5naQYTqVkpNkEi29Dlxh
    uPtQvGYB/mVqCYLfWgTv8ifIuRqPAI33Ue7gbl6QvWbBOj05uJueTVVCmnK0w6ZMeIfMXt
    nBtLmUS80WEftzMFv1h16932uEklpiV9CtNQaXniLVOLg3xA+FQJa1A55yXQ
X-ME-Proxy: <xmx:tDO7au0reeHtz0UH5rjn6MKQbrIpxtwfGYwZaEPqjAgkYwyBYeggpw>
    <xmx:tDO7akT_Xf9FblU-ZqQamsdNdZgAV6Cv2FbkrZrP3-sbpuNEqD_bUg>
    <xmx:tDO7atvdOfJMqooKYF8pI2Cuzq-jEtq5uSGz8PcNF-CY1v3gMA_whA>
    <xmx:tDO7ak5Vay2Se88fmS8TgJRDVPOdsvQKaGWZ1kAXTPiymvJ-_CrUBw>
    <xmx:tDO7asUzuJ8w5gku2jyQjTmAI5iEuEPWiZtoa6GPsX0a1qYBTXS34xVq>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 23:42:36 -0400 (EDT)
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
Subject: [PATCH 2/7] shmem: use d_duplicate()
Date: Tue, 29 Sep 2026 13:36:02 +1000
Message-ID: <20260929034158.1455429-3-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260929034158.1455429-1-neilb@ownmail.net>
References: <20260929034158.1455429-1-neilb@ownmail.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_204246_448731_967EA2DF 
X-CRM114-Status: UNSURE (   8.10  )
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
index 897fa2b61346..8fbab956466c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3976,11 +3976,12 @@ static int shmem_whiteout(struct mnt_idmap *idmap,
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


