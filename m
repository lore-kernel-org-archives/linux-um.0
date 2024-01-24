Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF73BC48260
	for <linux-um@archiver.kernel.org>; Wed, 24 Jan 2024 14:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SsCfmGxvbA7sxrxh086Ebk2iRnt1k0+Ezy4md1+KQQY=; b=u71n4nOkDAzGL03+x2zQvap1zZ
	JtS/12r3LxpjMFLLZnu8ujEVgEAS7Qq2NLcMWk3KHrS0MJ9QwtQlEUmuXFquGnVhq/cPKyq0Girq1
	ZfCyVhOCxuILrbl1saXNYIPvdPYKztyZ9d9tPLtE20nUpzPTm5mjjocUN+rdIGy44KwvSL2i21JmG
	k1D5P8nX01ZySXv3xHb7Yh6SU3EZPzYcMUxEA2Fg3LKwrz9xLI1KjwK25duh9L0PGc0EMe95iiSI4
	AP6mI76EaPs3NGAFRncoeFLa0RhDKLcu/7otVrhRGXbV3zH5MjRoNIPn31rBd+Ffz+52dr00ioew2
	qhbuGyCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSeF6-003fLW-0Y;
	Wed, 24 Jan 2024 14:28:40 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSeF2-003fI8-3D
	for linux-um@lists.infradead.org;
	Wed, 24 Jan 2024 14:28:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8093C61D52;
	Wed, 24 Jan 2024 14:28:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED76C433F1;
	Wed, 24 Jan 2024 14:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706106516;
	bh=wtfwbC0flSGPe7mDEkJ8Xw4cI7oiAV5gBbx/tJOQfFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I+JBlSEGHxRMB1DZ/n1Ti4HMxyI47dqi0JZ1GgJoL+M8YyUPfb97dGlW6utU9+jT6
	 8Ayqvln1zy4LRmO6AXtiCecG2XcNsVNqedeQECf22ypiKoArl4OC4drvn71iHk+HXD
	 2TbaAKs6YAjd7cSFAAVwzTraOBxbdVXarfAs4++9L2g1q4bHg9dc++1mK+bAOSr/eq
	 1jAMca0X04yFSmYAt9WOT+bx9TKdcVMZDryHLm11TgLD2ZVddyOWdvfcPzrfhEbZ2p
	 6hqhaRQUptLL/gHiEi6nzd9KF6oD5AUAK+/Y46RF6ovn23MKtUdKajqQaoM3uEuc7u
	 +DAH1xJYyoJNQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Richard Weinberger <richard@nod.at>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-um@lists.infradead.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.7 05/13] um: net: Fix return type of uml_net_start_xmit()
Date: Wed, 24 Jan 2024 09:27:58 -0500
Message-ID: <20240124142820.1283206-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124142820.1283206-1-sashal@kernel.org>
References: <20240124142820.1283206-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_062837_088991_1AE75090 
X-CRM114-Status: GOOD (  13.78  )
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

From: Nathan Chancellor <nathan@kernel.org>

[ Upstream commit 7d748f60a4b82b50bf25fad1bd42d33f049f76aa ]

With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
indirect call targets are validated against the expected function
pointer prototype to make sure the call target is valid to help mitigate
ROP attacks. If they are not identical, there is a failure at run time,
which manifests as either a kernel panic or thread getting killed. A
warning in clang aims to catch these at compile time, which reveals:

  arch/um/drivers/net_kern.c:353:21: warning: incompatible function pointer types initializing 'netdev_tx_t (*)(struct sk_buff *, struct net_device *)' (aka 'enum netdev_tx (*)(struct sk_buff *, struct net_device *)') with an expression of type 'int (struct sk_buff *, struct net_device *)' [-Wincompatible-function-pointer-types-strict]
    353 |         .ndo_start_xmit         = uml_net_start_xmit,
        |                                   ^~~~~~~~~~~~~~~~~~
  1 warning generated.

->ndo_start_xmit() in 'struct net_device_ops' expects a return type of
'netdev_tx_t', not 'int'. Adjust the return type of uml_net_start_xmit()
to match the prototype's to resolve the warning. While UML does not
currently implement support for kCFI, it could in the future, which
means this warning becomes a fatal CFI failure at run time.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310031340.v1vPh207-lkp@intel.com/
Acked-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/drivers/net_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
index 3d7836c46507..cabcc501b448 100644
--- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -204,7 +204,7 @@ static int uml_net_close(struct net_device *dev)
 	return 0;
 }
 
-static int uml_net_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t uml_net_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct uml_net_private *lp = netdev_priv(dev);
 	unsigned long flags;
-- 
2.43.0


