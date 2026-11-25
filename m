Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16762606A32D
	for <linux-um@archiver.kernel.org>; Wed, 25 Nov 2026 03:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=tYb5UBL+;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=DC+u0VGj;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=XWfVsu7y
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=te+85rs6L0Tu1kg3pduPz/TdZSjogt/uQT+qd17wdHs=; b=tYb5UBL+Lk6XcQs49KuUE+qR8o
	3t1OQHRWmm0UMMHrrDlhgEHSK7RlSQ4zfwwVm5HDvNvHiRdh2iPvPGz3FujtNc7yv9U3xQiEnwcmX
	7vzOOctpPX/a4VLijYHtmjlDla94jJD/qaKmwm/3o7obFELQHGP8KRIREPNHZAuq6FrHBFE7AG7nZ
	gcT0CrB/jxO8plCiPUC/qFOQaCWnnHVdl/YFQIxarAZseuMLtzVTIrmwYwL2Os+joci7mg2cZwNos
	uDSqIF4PlG1G6Sh/uYKSvZohU69YinNXvmJ56cV+4wFlB0jGiUEw94GD2xjt23uL9e1+Ua/BPAwIM
	VY1oqwOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW3xM-00000008LB8-3jFQ;
	Wed, 25 Nov 2026 03:46:04 +0000
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW3xJ-00000008L8Z-15wS
	for linux-um@lists.infradead.org;
	Wed, 25 Nov 2026 03:46:02 +0000
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 95F13EC0AB7
	for <linux-um@lists.infradead.org>; Tue, 24 Nov 2026 22:45:57 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 24 Nov 2026 22:45:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm3; t=1795578357; x=1795664757; bh=te+85rs6L0
	Tu1kg3pduPz/TdZSjogt/uQT+qd17wdHs=; b=DC+u0VGjhueZqVxgfl8gwONxO0
	oBznNlhevQZAEAUu+r36xA99W9a9oR+jxpqC0ewn+eOrkywE/xQovHK/m2PhgbEt
	w/WqSmu/Mp/+NLdzQOcxqlnZktZ/VptSZIXPnic7A9VEQzydJHU8c9l9c0HXP8z3
	f1he6adItjEocphVGvzCUH+kIBRclWbZPbMkXnjAUjsuiCKHvNYFST0JZfXvg51+
	E3Kmnk9n2GVvrKFXB6b7QKX5lb4E1fU9uE94Kn2BHUjcVEZ04lX3LMz3+7lrs04G
	5NwUPM2ZDarNyDzQVAHVCnOk3z8yIAz2Sj7RLAYYnm+qAV03b9yERUvzt19w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1795578357; x=1795664757; bh=te+85rs6L0Tu1kg3pduPz/TdZSjo
	gt/uQT+qd17wdHs=; b=XWfVsu7y8NvcqBvkgx6AQvHsBOkiuzcZwrYGZAQC5Bhw
	vtE73miMY/vLyuOzg7Fzu4YU/9mYTRcY9IbDQoMFdLPz9gIU4Jb6C0GuVa50930P
	N47f5oHBminLjxjgiJrSvY/WviUSIwjgeioIxb7Ef8j5qMI5OMX+U7Uvl/uPut+c
	XNRI9jNeGdAAvDDR9ODf+8mtIlkxnXcXFgUVptDEny1wot8IIFIHeuH/H7K5dRnA
	qhD4TOLXn2+K/4QTaa7B6t+0ZsNAsx5UtxPBnU67byV4jDP7vT+gjyB5akeC8Fjx
	FRMlEZGvWGU+Pd6GWCo9JSO/Iy/DPLIUyCFvoS/xaA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795578357; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmc+;
	s=fm3:rsa-sha256:PKC2dOxo7RWcZXgmHVzo/Z9j6IQUPFZ4Fl62YX8huh8rK8E
	3BM7oaap1F4j11yyqdQpa0307Ak1cM+MkQWlKAUkHP0Ec6dY7VK/o2uF98P0ZsuA
	iGLz71rh67WF2G91ft7gfUIQfvaA7tQdSt6g3MigVAO3433hAze6b64X4CFdOjFw
	QAsRh/4qi7fXt+kE+M8T1VjlkELQXEsQmEJV4LwD0tbyu/crV0+ZbjNdyLXTGOaX
	GB+gZU2krudPEl1YiOM/9wtxQQnu+sy7fRGk835OpyHPZdvB7BNjL4H+Q4ZWJFaf
	ekCoPIOQcM4oREgFnJvjdlMl9ds8+Yk/KKxIWvA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,reply-to,subject,to;
Message-Instance: m=1; h=sha256:6gIgKmEK+V1m8xQeD9wAvM2W7KHH8KguQF7kcD8RfFw=:KIpdI8wXTkKfTbClohnjMMutdVqFsf8UXtyA3Nw66JM=;
X-ME-Sender: <xms:81kGawuuyqWvXHqmVqljAlQedszfwZO9EA5rtQ4yIqdPSULxXEBooA>
    <xme:81kGa0ZascAx2U54dKCZxqpgQPp59dWetNxPpwyHddGeX1TQjNJEVQxN93auHIoTc
    mgGiFiYYiADfxRvTjlS7giTm7NNr6TYs6fqN3vnSjRL6-VmnxE>
X-ME-Received: <xmr:81kGaw2mFQG2xymvtRzybD_q0_b4KW8DdRwXRcAvZXOxbkcp-qjpqpXXz2uPS4v5lw>
X-ME-Proxy-Cause: dmFkZTGHTDLHrhSdcFVSltAhItO5CQcE/TjFbuhiumOu22/hJvNr30J77pkfAtY26o2DMg
    VSD3uY+/cuaDJ4Sh2bWyrrkqZBASGKCdjQbH6pMHWkkbOYJMg5HQITRhPlC6KnXFgzK1io
    I1b2u1NNTXTg/nkeE00xO7eBghnrtGEl7S/Rn5evCukV0GkFGzbkDSZAXnsLIpDwTTZ6bD
    TJMeI+IavU+KlNcB+hcEpXWHmEnj4UwjAz83EM4764K87HVhTIQ+CSy4s3TFg2j0TXM1eZ
    QVHK8rdWI846K2nUNW9gZUmN1pKfh+FdDUZxf2KFlC+9FBLtsS+qj3sdT5Stx/bTFOO0IX
    q2V4lTFYErE5TfSXc249mMlVKib+slQADVsyE+fJ38+pWN3L/9jBGZV7687vBrpIz+shzY
    bbPYsXQHsP+JSxeCQtQFGLBK2XK5r99hpxQzRfWuMqs2sdH1L00+aJXV3VTnSH96fP0qhs
    9ZJwyCNOH1dTJdSqthybpeDIaCydF8GMHm7UDWxXVYcCwuy43S0CZQRLQROy40JUa6Go2m
    H0oo/eT2fYlff7D3LTvaO9jt7PJKUBLZWWzfngmG5PQ06bP2f86MBc+pcEK3LfV/dE9nd0
    89wPPfXq1YcsILR/jFv3tqMVus8/YqE0wtK5YaZ1LttvH40YoChtPmCo+Rjw
X-ME-Proxy: <xmx:81kGa6WZGWgAoyTx_rB0U6xCgY_RO7sCFffzTnybvXOgXC7HreJn2A>
    <xmx:81kGa7udaydsCniw3bdpJEdSckm6DO_jRFs2PacG2UL_RGiWvRKacQ>
    <xmx:81kGaxUCvoegXUpv2RRc4kkXsnG5Ce32qXDxBS90PBFrvEj5G1uvfg>
    <xmx:81kGa3UJbtZmsHlTig2b9B6lM4eldHbONHWbgqNQBM966-au78wlfQ>
    <xmx:9VkGax7pJjaB4qXIZwDpaWUtfa98NSvU5HEyDycAnKopGiGBuoisihSY>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 22:45:51 -0500 (EST)
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
Subject: [PATCH v3 00/11] multiple-filesystems: prepare for changes to VFS locking
Date: Wed, 25 Nov 2026 14:16:38 +1100
Message-ID: <20261125034543.4084039-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_194601_453038_3483D901 
X-CRM114-Status: GOOD (  11.82  )
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

(ACKs for hostfs and afs still sought).

For this version I have included the AFS patches, included
"use d_alloc_parallel() in lookup_one_qstr_excl().
The latter patch is needed to make it safe to use
d_alloc_parallel() outside of i_rwsem.  This is, in turn,
needed for the three patch which drop i_rwsem before
calling d_alloc_parallel() (which is preparation for
inverting the order between i_rwsem and d_alloc_parallel()).

I've also reverted the LOOKUP_SHARED patch as I now see that was a
mistake.

Thanks,
NeilBrown

Original description, updated.

I am working on changes to directory locking.  The medium term goal is
to lift d_alloc_parallel() locking above i_rwsem, so d_alloc_paralle()
can be run unlocked, and consequently cannot be called when ->i_rwsem is
held.

This patch set makes small changes to a number of filesystems which each
require just one patch.  Patch series for nfs, cifs, fuse, cephfs
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

 [PATCH v3 01/11] coda: don't d_drop() early.
 [PATCH v3 02/11] hostfs: don't d_drop() before d_splice_alias() in
 [PATCH v3 03/11] afs: don't unhash/rehash dentries during
 [PATCH v3 04/11] afs: use d_splice_alias() in afs_vnode_new_inode()
 [PATCH v3 05/11] afs: use d_alloc_trylock in afs_sillyrename()
 [PATCH v3 06/11] afs: use d_duplicate()
 [PATCH v3 07/11] Revert "VFS: Add LOOKUP_SHARED flag."
 [PATCH v3 08/11] VFS: use d_alloc_parallel() in
 [PATCH v3 09/11] VFS: drop parent lock across d_alloc_parallel() in
 [PATCH v3 10/11] procfs: drop parent lock for d_alloc_parallel() in
 [PATCH v3 11/11] afs: lookup_atsys to drop and reclaim lock.

