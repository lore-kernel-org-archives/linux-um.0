Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 764DCC25B75
	for <linux-um@archiver.kernel.org>; Mon,  3 Jun 2024 14:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BxWlkWcsDy/eoSCSnK+cTkZ5UFIZV593cKPAyj+V1B4=; b=E8jxOBahFXQWH/LIW9KNI/6CkJ
	iUCQzA/taSVhYk0EIFQxZWLWBd2eZ1O8dtBS2SzKVPfBQ7r6+msq4gq55GRQ6Ysef5vOv+XvSYYEd
	zZim3cyX+dXq9lDw1zm55S1ZuKbQKw5Fk+qeJPXXKDzxsRBPSU49haLOAfB2oRP0QXDYHec3uQhf5
	cRrm9ocDB9Qgnn6HsIGl6+0IZf9A+jBRk5+QkkhwIm9AbT1aYG1m249F7MB4KErbACh0vQ3xkrNfI
	RcjV8/pQRj7g1JB1XaBBP6s1OhlGV+Y4wqqSOdwqZtj7nBGcxQHQky/9unnMJscFu4TbIci6UUISo
	GpVK7oMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE8hT-0000000H4iq-0ujj;
	Mon, 03 Jun 2024 14:30:15 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE8hQ-0000000H4h2-09bl
	for linux-um@lists.infradead.org;
	Mon, 03 Jun 2024 14:30:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 514C5CE0CE3;
	Mon,  3 Jun 2024 14:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE2CC2BD10;
	Mon,  3 Jun 2024 14:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717425007;
	bh=ilP/mqfminFIlL/9jrVY6neS/CASV0S8jeIG1imK2Z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SOUaAi1xXGHSyy/rlD1HUDAyHs9dC0Lx8iSP2YfHHmW42T5/f6kpJWZgv6+Frblt3
	 vT1M6mHyqooUYneH4d2q2PGWBVkleqxNimOZGnBg2ihwKVECFcSWPxMNej1Nyuy4/D
	 NZWY1INWnnzXVAfMM/mlbM6pV7UtP17AjQ2mwc6JGxtBq20Y5rq+T7cf6+S8wsVCHv
	 7H71i9p70n4REHuC55bFd1Wyp9Wf/AqK76FVsmDgA0Tm5wO0BzunobTWqlQl4V2Qyq
	 hg9yDdpAqijewZqMwf6Pa/uhIepp8SixlcRNtrm8WQpMk1iywEP2/p3FAffZGkzIik
	 GIaXMAnorwJ0g==
From: Christian Brauner <brauner@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	linux-um@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Subject: Re: [PATCH v2] hostfs: convert hostfs to use the new mount API
Date: Mon,  3 Jun 2024 16:29:52 +0200
Message-ID: <20240603-abklingen-zutreffen-1bc4c642168b@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240530120111.3794664-1-lihongbo22@huawei.com>
References: <20240530120111.3794664-1-lihongbo22@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1149; i=brauner@kernel.org; h=from:subject:message-id; bh=ilP/mqfminFIlL/9jrVY6neS/CASV0S8jeIG1imK2Z4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTFXk4PFwi+9HLBfoUs/j9XBXONXbh+2ec1TLm73/3Bu ZXVHJquHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOpYmH4Hyi90DLxY4tmUQXD U+kTd6ty2pdP37TT3vpr+Krrs5d/qWdk+Mp5tcb6/Kd/66Vsk/6HN+xncH8ie80ui0/BTeBCz2J eDgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_073012_383033_32064B26 
X-CRM114-Status: GOOD (  11.38  )
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

On Thu, 30 May 2024 20:01:11 +0800, Hongbo Li wrote:
> Convert the hostfs filesystem to the new internal mount API as the old
> one will be obsoleted and removed.  This allows greater flexibility in
> communication of mount parameters between userspace, the VFS and the
> filesystem.
> 
> See Documentation/filesystems/mount_api.txt for more information.
> 
> [...]

Applied to the vfs.mount.api branch of the vfs/vfs.git tree.
Patches in the vfs.mount.api branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.mount.api

[1/1] hostfs: convert hostfs to use the new mount API
      https://git.kernel.org/vfs/vfs/c/cd140ce9f611

