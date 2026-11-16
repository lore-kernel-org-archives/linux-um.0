Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED76606A31C
	for <linux-um@archiver.kernel.org>; Tue, 17 Nov 2026 00:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dKOMfPRH;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=kRzcoJ66;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=sxTVMqnc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=VclKIlHHA6sJRvKYQDUB0ymsoIETh0nxUoTC2xTBROc=; b=dKOMfPRH7Govte5eZfS2dkQ18l
	/qlyLciSwsbGsGGQBTYbdazbAkWAWhvX0aV9QfzYaI2Wisx8ktbDpO6kG2NiEZD0UQrWrgeLepSh/
	VoEI+b21m+Z2YgfTy9Z29DlA3LyQW94CzLSoCVASI1UE3pfTw/Krf7EO8L8vnFGwCkgXCp2bOblT1
	EbnODWonk7QMn5xwrrDSNK6jAJfSJaZdEkPcUSwXknG7C3qTm+N0WRiV/LvUbCE+MUdvjiHVPBfLR
	oihIlT66+5ybbFlwDnz6ERvUCs/06pLE2CoZ9pL817Q9q+SEq3bW93bdfSnXtkNYmtwz9bcA+gb2Y
	fF3qHh5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT6du-00000004E3f-0iNz;
	Tue, 17 Nov 2026 00:01:46 +0000
Received: from fout-a8-smtp.messagingengine.com ([103.168.172.151])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT6dh-00000004E1n-0rTe
	for linux-um@lists.infradead.org;
	Tue, 17 Nov 2026 00:01:41 +0000
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id DE63EEC087F
	for <linux-um@lists.infradead.org>; Mon, 16 Nov 2026 19:01:29 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 16 Nov 2026 19:01:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm3; t=1794873689; x=1794960089; bh=VclKIlHHA6
	sJRvKYQDUB0ymsoIETh0nxUoTC2xTBROc=; b=kRzcoJ667cUXvisSe1N6SZcN4q
	WnY09eXeCv+dtJ4kiKJdT9thSHgftISUXwwUr0WFuueS74+x21ZUpM97toG1DkzM
	9wA679dC0R89tzqXIfMF2s/PtfAG/78f0+gfRrC2jW551PHQku+jVzIzR5cgftQP
	li0HSIsl52Ckp/adATHQCRplZ2bGz/pGvqHggMF4VHkDrNyb8EdzdT1DmMj5RBxk
	/AZqTFlpzBwwKIEuJcZfekuU1ZVkRS6sTcdFlHEnvq+gZJjI3CygLtE8/Xx9arLh
	ALraIstQq/QEq4R9kGH9+Jz4M658Cn0JBWX7jDcn4UyKHUAMuIthigmjKRMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1794873689; x=1794960089; bh=VclKIlHHA6sJRvKYQDUB0ymsoIET
	h0nxUoTC2xTBROc=; b=sxTVMqncODQsJB3CdIxwydPijrkwtkL9GR+b2Fd5OM5j
	p57hYxuZfc8iJMiSS7wRl7ofwvljsbTNSuU7rnorRFL85aAecrcnF+UMBUx4BPlg
	YuHXMKrcYA600CjY+Nfuvqe2FtZX20G4HD80JVbjzrHeI4Lh6LnCzFDu7ZhtYeEy
	fUbCdynP1/ysBOv+bHvMAqZmo+7ITybhB9qT1BTQ/xS8L+Sqlb2e2LCkey9fQvpC
	YDTMfTozFCG5g+w/DHejGWiMHEkbITz6sYFFvXqudHmoeChW7yrgItSsCJZyelt2
	InZTMoS9XXCtbFdWIsLhUNnI5xK+bOEWJVAl776EPg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794873689; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmc+;
	s=fm3:rsa-sha256:yfzN8CtpSO1BiuIG9Qn+azN9jA/2KMyTvNNiikD2g+9jTOK
	zHyFTp1NfKShnc51PNpE5dxf2A8taiovo8zN+REzU6yNK+kPVsftyfcqlI+LOG4N
	WPfKKrHHsDoccMXySLxqD6rx4QfxiosKs61WTaQ0w/F9HlV35naVX+RSaFvk2bVd
	BRzCzD0SwocwnGBw7k7tOaJDr9pwws5Jf7b0Cj5kfqDO2k7UqRrqt9XPaaI7tArP
	lm+ITsX6OEk28/dwbnATZQbXX/jjLu0LxTSo/mi8P3MjrY0fTrZym7kaThoz/8Eu
	6MEYKbaIieDo5IQmd4z/h8ufr4aRuDgCXR2VDiQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,reply-to,subject,to;
Message-Instance: m=1; h=sha256:DHMeLMEDMgA1DsP9ifE/HQN9j5FDVtbY1HGX4wUdWKE=:rfa9m0UcUgaCLag8g7pw3/CotcToDQzfpQPsiR5Ld1o=;
X-ME-Sender: <xms:WJn7akNlHS6nh1LPAdeQ8mJieXw0dTqL30HtmkQ8WSKSwLh2gdBQPg>
    <xme:WJn7asQAFB1AaS9BVITpRd2Ma6qfnNP4h41W0GxyDvxI6B2a8mWoJbaKqbFHpooda
    eMMaqVh2ECpfY2a5hbCbUFZGlokquvgOkAolJvf2GIiOtpZUAs>
X-ME-Received: <xmr:WJn7av5vE6I4wSNgOH9D42nCte-LZAFL_IHJiaUlLsZQUDR_wQSajghF6BLBsmdbULCMhJAzYKTQ9IjAtLJA4s6bVJvtKQY>
X-ME-Proxy-Cause: dmFkZTEasDYJk7gUKjj95qJVCDLZ9z5UC3lFOr3mxXp2NqpnduBj0huNRvY2bKuTgCo4S3
    /ya8LB3Lk1oB3klihdJ8BJX7HvucoWWfwxXQGZVCiOL7v1xyZ9E98HqZfATW3DsfVt7Buf
    HDDi7kdFSz9V0lrnyG8NHXxthuyOZNaaxSoPUxOpn/Lx6gss1jQ90vOmLNUrp6zNAp1xK/
    E4mh4beTE7vRnNF/4JgosJzZk15qzccfwiemAiZKTwiIk+j4r/xWrb9oLBME2rnW+IoIvW
    0V/qJU0eecbujgkGwVUDIsxD3Y6lpRQk5PP5i06J9n0ZK3tSwD2jlIApyzfnpXecO0aekI
    YP7JC9DDnt1xRq9JFMoLPhAYpZkAtVNVNSH5gEoZIi7C0aPBBsQBMIViGuIiKDao50lB9F
    p6tN48LqvrHWNcKcaWmtCOeMnAkIkfTTnVk9/JKz/eYXPvTAtHz5Mvx5G2IUqqpw7j5cte
    OB/XPM6N/K5BcHWjLoCm5nM9RVsNCib50G3J2xslJ3/rzsBiKDyfUjfU+8KsQEsWr1Ur/t
    gHkZmHuiiGV4Uc4653RVdjM/u8Tw79N1YjLfxU/d6QHtzCJrdCvtEZ5UzyiMIVlPeCsmol
    fRQfVzoheGRV/H6KdXDBWV8edCUkBEw3bhvtVjD8eIAhz4kEOMh3VLZBCI5A
X-ME-Proxy: <xmx:WJn7avaKyKXmKVjcLrcBrlYWOhs0GdLqhy2PEMb0vkme78mxFeL_4Q>
    <xmx:WJn7ajbMKXjXNIp0U6ft9ml21M-9hQPLEi8q6uLIIA94zBBqbhzD5g>
    <xmx:WJn7ai0-eejyGrgasRnIdMps7wNS0XmZWgUdbySiZaLmd17dG8K2Qw>
    <xmx:WJn7arYqthUhGb2DFEgLfdNlRGKnc-gg5Cs0osnHyattF9CnN6zuFA>
    <xmx:WZn7ahWueiiJZNMoiG7ULnt1omal0J4HlDPfylQ0ZSRLnwPdbysG7_i2>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 19:01:23 -0500 (EST)
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
Subject: [PATCH v2 0/4] multiple-filesystems: prepare for changes to VFS locking
Date: Tue, 17 Nov 2026 10:54:57 +1100
Message-ID: <20261117000115.1433875-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_160133_678763_862E03C2 
X-CRM114-Status: GOOD (  11.74  )
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In this v2:
 - shmem patch is dropped - it isn't necessary and the is a problem
   with it which isn't worth fixing at this point
 - configfs patch is dropped - Al didn't like it and it isn't 
   necessary
 - ovl patch is dropped - I probably need to solve that a different 
    way and it is significant enough that it deserves to be separate from
    this series
 - slight renaming of bool var and goto labels in first patch

Original description, updated.

I am working on changes to directory locking.  The medium term goal is
to lift d_alloc_parallel() locking above i_rwsem, so d_alloc_paralle()
can be run unlocked, and consequently cannot be called when ->i_rwsem is
held.

This patch set makes small changes to a number of filesystems which each
require just one patch.  Patch series for nfs, afs, cifs, fuse, cephfs
have been posted separately

The main requirements are:
 1/ that d_alloc_parallel() not be called while i_rwsem is held.
    Places which currently do this can be changed to use d_alloc_trylock(),
    or d_duplicate(), or change to drop and retake the parent lock.

 2/ a dentry must not be d_drop()ed while an operation is ongoing, as an
    unlocked d_alloc_parallel() would then be able to create a new
    dentry with the same name.  d_splice_alias() can now work with a
    hash dentry, so often the d_drop() can simply be dropped.  Other
    times it can be moved to after the operation has completed.

I think it would be best for these to land in the VFS tree and would
appreciate Acks from relevant maintainer.

Thanks,
NeilBrown


 [PATCH v2 1/4] VFS/xfs/ntfs: drop parent lock across
 [PATCH v2 2/4] coda: don't d_drop() early.
 [PATCH v2 3/4] hostfs: don't d_drop() before d_splice_alias() in
 [PATCH v2 4/4] procfs: drop parent lock for d_alloc_parallel() in

