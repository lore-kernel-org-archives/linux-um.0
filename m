Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298A6CD37B0
	for <linux-um@archiver.kernel.org>; Mon, 18 Sep 2023 13:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oJ3giEy9fL6PkLfO3PERCu0WihovpktmHIIiJC0J4RY=; b=rE41GGMAfkpPiY
	/1X8Bzm54l/bv6IAL3kVlzDCFB1fA+MZn1ZCzpT6xbwWw3xD0fP43pyZj9HagXCyt2AXVBnnjVm4F
	HdOa3gbSspfAEIdQb6aUaY/os70Rasd5VxhSDAjtZfYkSv2p26kyF7a6yJtvt+9cyOo71TXDD3dC5
	lcf8foOPyHEkbDUkyVybo7r6CK2vEXkS7yE9wulxR26ts2lkrRUe+WGoGuB3iHBvzJVI9VcU7BS6Q
	bVJaWc0vNwOecQzUSZ7MF+AUdaVT7Dtozme5K3qISpaD+xwQ1icN5cLMvT1mO1sIgKt7BRgGZezEI
	mJss7ZluKNPV1vnN1Wqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiEGa-00FZN8-1p;
	Mon, 18 Sep 2023 13:26:20 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiEGX-00FZMZ-1N
	for linux-um@lists.infradead.org;
	Mon, 18 Sep 2023 13:26:18 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3F9831FED9;
	Mon, 18 Sep 2023 13:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1695043575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CptKVtlJsn1lzDDkoAwpgGBZfa1qJH+GKj8YGELD9pE=;
	b=pgW55TSiIzxpbssBsNVF2lC+9A7nQfP2VLFIdBOjbI419ZxOHAODbOQkpl1JzLcbGAKROa
	cqRK0rcs9MUFhffVbsxV603nZklMWr7nHEWABvvbknPKslNnqTPMgaYdLPmEH5l3UhMgAe
	6ZY8HnFG+xx6X/iI05kn8AzNwdOaYsU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1695043575;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CptKVtlJsn1lzDDkoAwpgGBZfa1qJH+GKj8YGELD9pE=;
	b=jtw/3Mcp80MGTZv4eCty+vRjAu4Oloz+0t+B28GaA3b7kXi6AHoUvpWIFFJ+qEhg4tj4AY
	YbbyfgYelATWggAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2E0B013480;
	Mon, 18 Sep 2023 13:26:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ujE0C/dPCGX9FgAAMHmgww
	(envelope-from <jack@suse.cz>); Mon, 18 Sep 2023 13:26:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 99B59A0759; Mon, 18 Sep 2023 15:26:14 +0200 (CEST)
Date: Mon, 18 Sep 2023 15:26:14 +0200
From: Jan Kara <jack@suse.cz>
To: Peter Lafreniere <peter@n8pjl.ca>
Cc: linux-um@lists.infradead.org, richard@nod.at,
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
	reiserfs-devel@vger.kernel.org, jack@suse.cz
Subject: Re: [PATCH RESEND] um: Remove CONFIG_REISERFS_FS from defconfig
Message-ID: <20230918132614.zmmuc72purc2psik@quack3>
References: <20230910232640.113938-1-peter@n8pjl.ca>
 <20230918125744.4342-1-peter@n8pjl.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230918125744.4342-1-peter@n8pjl.ca>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230918_062617_641394_2B05251A 
X-CRM114-Status: GOOD (  17.40  )
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

On Mon 18-09-23 12:58:26, Peter Lafreniere wrote:
> ReiserFS has been deprecated for a year and a half, yet is still built
> as part of a defconfig UML kernel.
> 
> According to commit eb103a51640e ("reiserfs: Deprecate reiserfs"), the
> filesystem is slated to be removed in 2025. Remove it from the defconfig
> profile now, as part of its deprecation process.
> 
> Signed-off-by: Peter Lafreniere <peter@n8pjl.ca>

Makes sense but I've noticed there are many more architectures that define
CONFIG_REISERFS_FS in their defconfig (sh, powerpc, mips, m68k, ia64, arm,
alpha). So perhaps we should do this for all of them when we are at it?

								Honza

> ---
> Fixed invalid DKIM settings causing the previous patch to be rejected.
> 
>  arch/um/configs/i386_defconfig   | 1 -
>  arch/um/configs/x86_64_defconfig | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/arch/um/configs/i386_defconfig b/arch/um/configs/i386_defconfig
> index e543cbac8792..9c9c77f1255a 100644
> --- a/arch/um/configs/i386_defconfig
> +++ b/arch/um/configs/i386_defconfig
> @@ -61,7 +61,6 @@ CONFIG_UML_NET_DAEMON=y
>  CONFIG_UML_NET_MCAST=y
>  CONFIG_UML_NET_SLIRP=y
>  CONFIG_EXT4_FS=y
> -CONFIG_REISERFS_FS=y
>  CONFIG_QUOTA=y
>  CONFIG_AUTOFS_FS=m
>  CONFIG_ISO9660_FS=m
> diff --git a/arch/um/configs/x86_64_defconfig b/arch/um/configs/x86_64_defconfig
> index 939cb12318ca..03b10d3f6816 100644
> --- a/arch/um/configs/x86_64_defconfig
> +++ b/arch/um/configs/x86_64_defconfig
> @@ -59,7 +59,6 @@ CONFIG_UML_NET_DAEMON=y
>  CONFIG_UML_NET_MCAST=y
>  CONFIG_UML_NET_SLIRP=y
>  CONFIG_EXT4_FS=y
> -CONFIG_REISERFS_FS=y
>  CONFIG_QUOTA=y
>  CONFIG_AUTOFS_FS=m
>  CONFIG_ISO9660_FS=m
> -- 
> 2.42.0
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
