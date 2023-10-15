Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4522CDB482
	for <linux-um@archiver.kernel.org>; Sun, 15 Oct 2023 10:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:Message-Id:Subject:
	References:In-Reply-To:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=L4F610QRxl8mZs50KASTrLQS1m/OZujcI5wx70TVTaM=; b=gxz8EaTLy4ucMk
	gBv3TGbz5vBT9I9jWnIi2utEUHtXl8fDsozJQTRd2FoyP6Mf/1FOg4tzB06T7k51XDZdvDlgFlN6Z
	vdHc4Pw/4CbNS0mBPNIYMNfQNydvUnc2+n4ND8obdAZgsPzIy+7LbeUj/BEIFNAt7BfTl4IP1Fo/5
	Zcje6JUpylulhjOXj1AIslQWfdzhusbC8Tcwd0ZdEyvHb157aG6WxQfkcZD5WY9fcUA2TQlMI7onS
	l+nNfmiPjJXNd+B2RKWDYhi4HpkNZPwQJ/cuTS43s47FKw7tSrGf1UoOy1vbdYkzhY2VPKK03LatN
	xQhQh4FTQGxyS1We4kbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qry12-006rcf-1Q;
	Sun, 15 Oct 2023 10:06:32 +0000
Received: from gandalf.ozlabs.org ([150.107.74.76])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qry0x-006rbG-0k;
	Sun, 15 Oct 2023 10:06:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1697364383;
	bh=lQ471ge3JT3D/IyXiBK6OqZg4gy00/Wz1cpF1NMX1CI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Jgv8/cUxgQM27y6U//UT8VctmRJrqlUlqIr1QQTvvhugWnDzvcBYSj+SLZifK2jTQ
	 owmdqqRmmp8iY6chJq2Mlnpjbq6RAj8jt0kTavOSSUm2KQgIWHKXgDY5hnkI1rXRb9
	 NIdVXDDuIe1rtwQ5evX8B8s9Peo+r//MyCvLnEJu3WQv7amCnhXoAL+d5jvpc0YjYY
	 35406tFs9oyMdUOOMphj3mCWt3yUm5zVp0ckK6CxgcejWbG+0vkHDPW3MGFNsWQ5DX
	 tEUDQT8EKLC+kMhx0X8thKh1EhRV8sMxpXYvKiRh1qX2qbrIMTQ4XvICpOiJdoeKvz
	 ZQx5NpTCbYS3w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4S7bVc4t2xz4wnw;
	Sun, 15 Oct 2023 21:06:16 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: reiserfs-devel@vger.kernel.org, Peter Lafreniere <peter@n8pjl.ca>
Cc: jack@suse.cz, linux-kernel@vger.kernel.org, richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, linuxppc-dev@lists.ozlabs.org, linux-um@lists.infradead.org, linux-sh@vger.kernel.org, tsbogend@alpha.franken.de, linux-mips@vger.kernel.org, linux-m68k@lists.linux-m68k.org, geert@linux-m68k.org, linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk, linux-alpha@vger.kernel.org, richard.henderson@linaro.org, ink@jurassic.park.msu.ru
In-Reply-To: <20230918175529.19011-1-peter@n8pjl.ca>
References: <20230918175529.19011-1-peter@n8pjl.ca>
Subject: Re: (subset) [PATCH 0/7] arch/*: config: Remove ReiserFS from defconfig
Message-Id: <169736429854.960528.1442206910501555108.b4-ty@ellerman.id.au>
Date: Sun, 15 Oct 2023 21:04:58 +1100
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231015_030627_411481_0246CC59 
X-CRM114-Status: UNSURE (   6.41  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Mon, 18 Sep 2023 17:56:09 +0000, Peter Lafreniere wrote:
> ReiserFS has been considered deprecated for 19 months since commit
> eb103a51640e ("reiserfs: Deprecate reiserfs"). However, there are
> several architectures that still build it into their defconfig kernels.
> 
> As ReiserFS will be removed in 2025, delete all ReiserFS-related options
> from defconfig files before the filesystem's removal.
> 
> [...]

Applied to powerpc/next.

[2/7] arch: powerpc: remove ReiserFS from defconfig
      https://git.kernel.org/powerpc/c/c945e6f453a361b0e9daddd2be9c099d1b80d6f8

cheers

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
