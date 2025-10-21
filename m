Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 265C9CCD184
	for <linux-um@archiver.kernel.org>; Tue, 21 Oct 2025 12:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BUBEBpKpQ0dQopBT9LFZrxTolM9V1bKEMA7Drwquggs=; b=J6ZkN8Yjpo13flXwr00/fWQ0/Q
	EVixZj+qpLLTEnuJa/2R1+x7vRFP7/k/v1tPcpKY5jWabeQHCZsREn6INfv1HupKCdrBHkUr7gZr6
	tgq+wIcfK0N8RBjoBXs5rlfnyJG7sh41FDDXFbb8yZh+lMH/zVTPPA7XQdafIHaifsn3ByTh0w99e
	25B5N1rriH6n4vq8rKizyawpsr8FVrd8ub+UoaSvxxJUDSWZZXm2BxX/VIDCtgIlq3q3CG6rvyvSE
	1PsiGGQEVKowLqx9hLNr3WjrXKx5eMi0gF9fo8qRR7bAZIPA82wBD4PWVNNXJdBFSAMc17d38A9/A
	5gNHb6lQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBBIa-0000000GvvX-0gtM;
	Tue, 21 Oct 2025 12:17:08 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBBIZ-0000000GvvN-2YH7
	for linux-um@lists.infradead.org;
	Tue, 21 Oct 2025 12:17:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0BED660403;
	Tue, 21 Oct 2025 12:16:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B80DBC4CEF1;
	Tue, 21 Oct 2025 12:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761049012;
	bh=8JIExmKFL1e/CmjoJnRReujq8mU/REJBTwDG9/fjmkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pGLJZYWROnGvExmYkpXY4E+CrprIx+KCNr+WptCpQtmc/zHCY71hGPeLTZqIHT87x
	 v/YV85rpXuABPTl4JXzhFjH5acPF23vIYol4MGVUrky+415tynJPWA0PwyehSgsHIA
	 k/sU5EL38wzaIOMkn1Wl7ZNbsmcFuuHmk47VQ0DW3OhK9I8btaigTx6YRZBprK9hKT
	 8KXmHoCiFKSPTR6ut/kLClCRl1P+8shhu7kcD4BRNc8so6fNcST0gnUwBRNKGwnOhY
	 2JNUBbO4bSgsGm4JwmOQAmD+Tc652+AOL4595AsZnpzIb4nzwF9YIWEQ+68nBgqOfA
	 glAz4lV71Wv/A==
From: Christian Brauner <brauner@kernel.org>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	geoff@geoffthorpe.net,
	Hongbo Li <lihongbo22@huawei.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-um@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] hostfs: Fix only passing host root in boot stage with new mount
Date: Tue, 21 Oct 2025 14:16:46 +0200
Message-ID: <20251021-genau-erwachen-eb2436082486@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251011092235.29880-1-lihongbo22@huawei.com>
References: <20251011092235.29880-1-lihongbo22@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1332; i=brauner@kernel.org; h=from:subject:message-id; bh=8JIExmKFL1e/CmjoJnRReujq8mU/REJBTwDG9/fjmkU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR8r1y/Rf/WKsu3lzLW/rxiuPuNmvWdmRkNf8/PyvoQx fH8V0V0QEcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBENvkzMuxy8/t58cvkqFd/ jC/e/ZDk/ForQLvVsipfr83u1eZjq18wMhz2jlG7Esc2wVpER2xJCVOzlE588cq35fvMYwXnBX9 tZAMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Sat, 11 Oct 2025 09:22:35 +0000, Hongbo Li wrote:
> In the old mount proceedure, hostfs could only pass root directory during
> boot. This is because it constructed the root directory using the @root_ino
> event without any mount options. However, when using it with the new mount
> API, this step is no longer triggered. As a result, if users mounts without
> specifying any mount options, the @host_root_path remains uninitialized. To
> prevent this issue, the @host_root_path should be initialized at the time
> of allocation.
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] hostfs: Fix only passing host root in boot stage with new mount
      https://git.kernel.org/vfs/vfs/c/590a4c70008c

