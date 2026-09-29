Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A70ACA5FA1
	for <linux-um@archiver.kernel.org>; Tue, 29 Sep 2026 03:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mN/2SSV8bIw24exSybjBxan284YWLD0YYt6t0Umtf4c=; b=yvXj2EdbOACwHF5XPTrjbQT8UJ
	BzPAFAEUVUnOoNAQQiLAPA6RUbJxclbuyHSgoFTRU7qR599pxBEzk+KCESr+Hr9ulXDoIf3GPZ2dz
	gYsOhUA8FfTyk4yCSHZbUf1VIPMGINV8ZQ+OXFDSyjcih43I6d501a+NoP87t9imbk7NA0K7wK+ne
	UGIK2hE35cG28Snap5Oo43gntJVsxjxgEoImqKeKrDeHcwaOofx6WRScL+9RHsgsQyxlDhlQZeNXS
	+A1xKnRtAiM0Hx3jXuqWInqVeHueW/knE3vnVcG9/6Gp0HOwyETTQ2Z2xII9y2AFPMWNXSF8MBcCq
	hJraOx5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBOkP-00000002Flo-3CUr;
	Tue, 29 Sep 2026 03:43:17 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBOkO-00000002FlO-2P5h
	for linux-um@bombadil.infradead.org;
	Tue, 29 Sep 2026 03:43:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Reply-To:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:
	Content-Type:Content-ID:Content-Description;
	bh=mN/2SSV8bIw24exSybjBxan284YWLD0YYt6t0Umtf4c=; b=FAU0Eg40nXd0AvMYlJAQJntEZ8
	s6MzGuuFN5nvVdqqb5JW/xvcXglBbUIUoxbWKtozyMEat175WmL74j/sAd3CHPr5LZRWpxY0lrYSf
	mPEhJ+4zhuzhe2laS8OgXBnkBbvuCj707mH40E4Je43/jfZH5vy1vEATGzoPVriPcZ2c0iQ9rHS9H
	HwKKzkH8jOJZKpYkYL0XPD7XcOZWOraaeUydFARFBLtVGrIkT3RQt5EEjuqBVw8VGQDntBF2QmhLj
	TIiX3IycKh0LhJ6bkbF4XRL2n0hwUaT5wMuJMOVNY6+6VD9iTNfySMNriLFZ2bfI4uGmHNodJhPzL
	46G38TVg==;
Received: from flow-b2-smtp.messagingengine.com ([202.12.124.137])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1xBOkH-000000029FJ-1kTC
	for linux-um@lists.infradead.org;
	Tue, 29 Sep 2026 03:43:12 +0000
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 51A15130193A;
	Mon, 28 Sep 2026 23:43:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 28 Sep 2026 23:43:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1790653387;
	 x=1790660587; bh=mN/2SSV8bIw24exSybjBxan284YWLD0YYt6t0Umtf4c=; b=
	m/bjmYXVAasRh0xyF47KEJG7Zmxn+6bI3gtqt6ip5j8TEoMZ9giVbJuvHbF32LqQ
	J1gB7diA96j64dY9ryX7i43LR5NE/GXc6xeEHLMIUsXaApdieqrSshs1tGV7eGIN
	cBUfQXA+T6z0cao/bSPqATRc0x9EDT8ldEERb05yMPmFLsMlN+L72e9O680wJRJZ
	zK7L9yLeSEqtGdum6RwlFdBIeS66RVKw4AAvBo6WoY8CFdqTosftV2pKqhxPvgit
	x2WTD0Y/SNSJJTWkGVgXjDNZ/Wzano1HkG4RwF+n94lSOkPGDOYxUrtjK2wxrbGE
	B8ypvNrW2u15OJmYsv/n/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790653387; x=1790660587; bh=m
	N/2SSV8bIw24exSybjBxan284YWLD0YYt6t0Umtf4c=; b=Pxstf1lIaYJ6It2Dt
	XYl09MKu5wXe6DyBDfDoIngstyuriZxvJ66IXljztAMGQlQaTTz8Wzp6hPdCF8bb
	+h2Py2iXvqZ3nuMfdPLVhtcxaefT9HM9QXlb4zifQPYLblx1Zo8b+xcBl4kW/7nt
	xsspas6tl2BRodH/Dz6SRFhmXjGiGpwVJPUrPxRshJibVDKdao9wBMfufPkOCJl8
	HEkWPmseCLuMoKx5AHjwkTeocSsqSAaVRicS/nEjoxk9yj3XlxsQg5q+0cF1F+Hz
	z3eVrnBAdkaSXew2JYNo9t8EW2OdRoRhPvgdaoA9HuZsIIVeu3BDFuWC6a8PCAhQ
	5E41g==
X-ME-Sender: <xms:yjO7ajkdZZgG_2FOAMT9VTx-gp96HOvHEGBSL12mminnsd-upM17rQ>
    <xme:yjO7apzF2ykKaWLA8Y41NVuT9lPJ2l3nvV2vICX5BP8s-bJT_YH6sRa3gc4JqrQcB
    N0bdEmnCNJf8HvNfuO76KNHNEgYu-xC-rjWq54fQ2KnAgXS6Cw>
X-ME-Received: <xmr:yjO7ah2gtRaeh_TqjyDFtWhQyl-uwEL1TCwk8RLpVcQb7_44HnpYW7Nw4nlhQaJ-BF6VLQljZa9aHL9AdC59N5IVaTebT4s>
X-ME-Proxy-Cause: dmFkZTGoJB+17Zq7ThrEPjmxn4ZGYu519RzWwVi/88aejzKjstMboztaed73ef7D6avpE+
    +4ud1a3y7i3orjwLfnXoctNyz4isc8MlqqkCj9w/LgYTxltRiENCW6GCIqrBIGfd6BoOtn
    3U4T9DnMQq0t334tHmkLT0tBGbfhvTaaBwaOBKtxwtl6WpY46qwankbHLMumQlIvXZxJZX
    MK4M+NdZABlSsm1lFGpu8Zoavf0+po6/QQ3FmqOSdXOPNwreWLw4U6EONlQdAFPuoTNGlS
    rFYPmLdcGE1rV4M0fAMpJKofG+st3+8PfQ+b7I9sMwGW86B3jq8HWH1QNmIbUmtd6GqseK
    WXBUUBpFFgHeK9liDg6OqtGpj503qSZRpKFKN80ywKozzDLGfTIpNSRIpB0J7X9j9kdDFo
    NfP0M85lsYUf++BKyCpxcDEiYTPrJoAH8DW5zTa5+tEaGnTn6IQGdE5otaXfk/OhUSHo+d
    QtS1DlHqPu5wnj79Rv5/H8vkxZKWrTFKnHex9Nm3oRCq/HyRSwEmRvgSr1/p+Cr6f7cDut
    lLam5cR2VTzEn2u/ohPNQCHnE/CPKmlmMgCBKphlenALV49psp5KqhSOhI3YnTVHwZ8CPq
    nywlxVlrO0ModMzqKT8z8ZRgDn5Mr5lMOd5yuzk4bhk/SVJdYTVGY/z5TZwQ
X-ME-Proxy: <xmx:yjO7aqbe5DZ8VxR2MCiDyHlEgTOcZIGl1vO_C7cku3RsL4dsa-hY7A>
    <xmx:yjO7aglOV1FYf8Ar4JRQeL1p1eSJDh2_lHjeA5rZ1-qC73jVVm0xnQ>
    <xmx:yjO7arxlwUmw6RkQ7TkEf7ADdVOl3hHllm94VCEYOBw80dbS6Ojbcw>
    <xmx:yjO7ahtWoJe1UDGp4lXvnGnpsSzrSZDqPvF8q4COOagGVNGE_IqCDA>
    <xmx:yzO7as8EEG9-dULRWNj307nfRVakTfkCssSFq__PckHsvznEEqvj2UFg>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 23:42:59 -0400 (EDT)
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
Subject: [PATCH 4/7] configfs: remove d_add() calls before configfs_attach_group()
Date: Tue, 29 Sep 2026 13:36:04 +1000
Message-ID: <20260929034158.1455429-5-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260929034158.1455429-1-neilb@ownmail.net>
References: <20260929034158.1455429-1-neilb@ownmail.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260929_044310_405845_2B0E03D8 
X-CRM114-Status: GOOD (  13.03  )
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

These d_add() calls cannot be necessary.  The inode given is NULL so all
they do is attach the dentry to the hash table.

If configfs_attach_group() fails, then d_drop() is called so the dentry
will be detached.
If configfs_attach_group() succeeds, then
 configfs_attach_group -> configfs_attach_item ->configfs_create_dir
must have succeeded, so d_instantiate() will have been called and the
dentry hashed there.

So the only effect is that the dentry will be hashed-negative for a
short period which will allow a lookup to find nothing without waiting
for the directory i_rwsem.  I can find no indication that this might be
important.

Adding a dentry as negative, and then later making it positive is an
unusual pattern and appears to be unnecessary, so it is best avoided.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/configfs/dir.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 3c88f13f1ca2..145a092171fe 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -715,8 +715,6 @@ static int create_default_group(struct dentry *parent,
 	ret = -ENOMEM;
 	child = d_alloc_name(parent, group->cg_item.ci_name);
 	if (child) {
-		d_add(child, NULL);
-
 		ret = configfs_attach_group(&group->cg_item, child, frag);
 		if (!ret) {
 			sd = child->d_fsdata;
@@ -1901,8 +1899,6 @@ int configfs_register_subsystem(struct configfs_subsystem *subsys)
 	err = -ENOMEM;
 	dentry = d_alloc_name(root, group->cg_item.ci_name);
 	if (dentry) {
-		d_add(dentry, NULL);
-
 		err = configfs_dirent_exists(dentry);
 		if (!err)
 			err = configfs_attach_group(&group->cg_item,
-- 
2.50.0.107.gf914562f5916.dirty


