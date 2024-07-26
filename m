Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B27C3DA63
	for <linux-um@archiver.kernel.org>; Fri, 26 Jul 2024 07:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QwwEr0sP3JYuVFZ17EDdbmD/jq5j735x4DaF/DrNGkE=; b=GSOaGMtDniIvumGXxgxccw/CQH
	/ORXrJID73oD010WdCOCyNsxQhIr38fuP67tC5SqW4m/FuQ+kGxvBVdiUJ0aN9+B3/qeyyQEAkuHL
	4EcQHBhtB9+ScUqgWn0l2cQOnC3ncJHV3VB5obOjMOYknpgAmh8XPf3AXspsX+LFSF3rTVSzHnCAJ
	zk0nKzaE1bvXbQAGaKb9um6QspOmqM9Sxad5SzLuMVnXIoyZuKDmkcfpmkbsqIYsbW6QFKe4YWbjC
	w4d0arICwrjRqpbJmHz8Q/1+nbASxAvb6xTs+1LtYwKS3TJjQTAtSC3fu6URrJRlT9j43Qm6+nTfb
	84CBoyXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXFpu-00000003FSw-1wk4;
	Fri, 26 Jul 2024 07:57:58 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXFpr-00000003FRh-3WM3
	for linux-um@lists.infradead.org;
	Fri, 26 Jul 2024 07:57:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id AB13BCE1745;
	Fri, 26 Jul 2024 07:57:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE4AC32782;
	Fri, 26 Jul 2024 07:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721980673;
	bh=8jTXfsrcnJXENs/Y0Aq1k8+dlxRjaFtrHUhzQhG6Mhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SDojCTwUuj6WrevadK2nRu+jFz62+W2UUXvdI0GpNUYwx7GZJrsgHUahGUq4KraBT
	 jR61xVmTKHYvEU3t7kHUz5UsQF2tXV5pUGsV2NsbXiuI2SIxSwjqWLp41UGSyD3Cpy
	 RwY0kRzL1qTDUY9hDpOQfFwoFa5SQh7MqgNn+FmxskIFJyLqCn3dPq8x3oAVKj8G+F
	 cLXpdnl63OfVAPuYT989VtYBH6N4ocaCTl2BVv7SL92SzwfOEOpr+eaOR96ZEg79Fo
	 cn2VK1InrLNs+I9QysWVaMxboedoa9L0ozCWv1ScPPRu+riK0RwMYZt2pl2h8/eh6W
	 7dzwzLr+OegVg==
From: Christian Brauner <brauner@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	maze@google.com,
	linux-um@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Subject: Re: [PATCH] hostfs: fix the host directory parse when mounting.
Date: Fri, 26 Jul 2024 09:57:43 +0200
Message-ID: <20240726-bearbeiten-inkognito-0392543e5743@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240725065130.1821964-1-lihongbo22@huawei.com>
References: <20240725065130.1821964-1-lihongbo22@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1321; i=brauner@kernel.org; h=from:subject:message-id; bh=8jTXfsrcnJXENs/Y0Aq1k8+dlxRjaFtrHUhzQhG6Mhs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQtDvvlkZMZmmtudF3F+oD0PtMt/G6G8jcv3X13xjk64 GJgwIeZHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABN5Kc/wz+SWo6A621LN78m1 kfurf/+offzhQLzA2wPesh77piaWb2b4ZySpbjyxqvLt1yk7nl5dvtWZ0yNB0rd3n7Xxfe2nyy+ 2cgEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240726_005756_076121_15F4A2C6 
X-CRM114-Status: GOOD (  12.35  )
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

On Thu, 25 Jul 2024 14:51:30 +0800, Hongbo Li wrote:
> hostfs not keep the host directory when mounting. When the host
> directory is none (default), fc->source is used as the host root
> directory, and this is wrong. Here we use `parse_monolithic` to
> handle the old mount path for parsing the root directory. For new
> mount path, The `parse_param` is used for the host directory parse.
> 
> 
> [...]

As mentioned somewhere else the check for param->string being empty needs to
check for empty string, not NULL. I've fixed that up.

---

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

[1/1] hostfs: fix the host directory parse when mounting.
      https://git.kernel.org/vfs/vfs/c/3ab8d61f1e4a

