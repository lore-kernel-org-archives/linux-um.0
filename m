Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC232C27C4F
	for <linux-um@archiver.kernel.org>; Thu, 13 Jun 2024 12:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LGjGDZJ+oK0bsfV0wugxbiOxTRoQHBa8hRKPPyoKoB4=; b=kWR4u1fzkvKaj8ZMmrnFE175Pw
	49ueEktj2w0OPbtWXKnOXYFYhIjflHtxy4h81KS1g7wFpi5cMGNVo3J3WQiMfylYIWym/xYTJrepW
	7l0TzRHHcu/Oy0G+X1auWfBHc792gdudroL9Q+esvKh64m24Ov8F6QXECgxv+PwywVaFXt844G8jf
	EDeYzP/RGcjdepHwkK0AayUKvDzXJ8O/ryQ/bkyP1SFmZpe//ns/59rv56e3iWbdkHOaBxqQ9ReQh
	RPys0UZJReGeAn+c7Bu8OxUokMkv067DkzS+u/YHRLbGENQOlF6hq+IetU0eo60Rw4acnXWgTP+55
	wC1BI5EA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHjJz-0000000GSYU-04NV;
	Thu, 13 Jun 2024 12:12:51 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHjJv-0000000GSXF-0UnF
	for linux-um@lists.infradead.org;
	Thu, 13 Jun 2024 12:12:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7C7A361B14;
	Thu, 13 Jun 2024 12:12:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB9BC2BBFC;
	Thu, 13 Jun 2024 12:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718280766;
	bh=VL0D7Z1u35TJY1+wnfk182tojLh6CXU2VOnnleoOGPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ai5pawwHc9j0icjq4pAa4AjjNnJZc9FqaRoZzQ0npzN2KgSn4p98y+PlfaOUYfJ8q
	 MiHZkxDgeKTwKMdeb94ZuWvvHjJzbYbkWgyFCmfK4vu+gSxEe2JKouHd+20qcS5EmL
	 2D+b2AsI0/EOTLomxPi9GbZQaPEgvMkd9repImwqs1nCvQu/ewYc42cb30bmjMPIVE
	 8cxGSpaMEplkHnt1ms9x//IYOJooxZYglX9lSOEF74ZmHa6H0exHTPfZGcnMPgLKmX
	 GoqRlJkxuuWEwrdRkqrf/IvimYLufFY7IuheLdO7NhDkgMWHvnQujkLbqpNDtoRsUM
	 eo5p7kBXuPE5g==
From: Christian Brauner <brauner@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Hongbo Li <lihongbo22@huawei.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hostfs: Add const qualifier to host_root in hostfs_fill_super()
Date: Thu, 13 Jun 2024 14:12:35 +0200
Message-ID: <20240613-saugt-hebamme-d4c3ce553856@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240611-hostfs-fix-mount-api-conversion-v1-1-ef75bbc77f44@kernel.org>
References: <20240611-hostfs-fix-mount-api-conversion-v1-1-ef75bbc77f44@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1319; i=brauner@kernel.org; h=from:subject:message-id; bh=VL0D7Z1u35TJY1+wnfk182tojLh6CXU2VOnnleoOGPo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRlPTJl7Lx9xSXxXb9yu8pj2Z/nCqc7aanzPg2cw3ju2 MfjE8/YdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkZhjD/6CIcu9Iid/76itk z7yIyQ3mCVozyUd+3nfxH2+rbUPX/GRkaL6YaCTI0Vpr9XFtuGPRn+uKU/Tm5DT+ar60P+R+ofg jFgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240613_051247_219548_02BA8C94 
X-CRM114-Status: GOOD (  10.71  )
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

On Tue, 11 Jun 2024 12:58:41 -0700, Nathan Chancellor wrote:
> After the recent conversion to the new mount API, there is a warning
> when building hostfs (which may be upgraded to an error via
> CONFIG_WERROR=y):
> 
>   fs/hostfs/hostfs_kern.c: In function 'hostfs_fill_super':
>   fs/hostfs/hostfs_kern.c:942:27: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>     942 |         char *host_root = fc->source;
>         |                           ^~
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

[1/1] hostfs: Add const qualifier to host_root in hostfs_fill_super()
      https://git.kernel.org/vfs/vfs/c/104eef133fd9

