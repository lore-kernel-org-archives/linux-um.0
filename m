Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E494C61DC7
	for <linux-um@archiver.kernel.org>; Thu, 27 Aug 2026 11:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6AAqqY4OkNSdQHM1gwmpJ5lzM2oTtRJv4IBEa3HgW1Q=; b=Y4Y+p0qK75gxXRCMWxPvKYCNB9
	Zon1o62eFNT4sE5LAwzRE0+NYO8nzJJR6diYZxVaja8oJke6Y61gLvVin1xd5WEyhiQO4eXtEHD9+
	B862ByysHtjwMAen/XOVUchWeMbjd2t53aNAOI62SUSDrKBXJy5L1swQcvMY1Dv7hycIVGU9aNrBo
	UuLPmy4FFx868wsZuFUp49RNr2KMe8e0BZNCZU6f8EnCQP+A15AWjCVLVagVBjWEa6AdQDUQBsyfU
	VqkY/bPP/75PjYGHNB5HAK6TMdZQ/rdE+m+/T/0SbmhG6rgJG82hpCXSdULK79uFUK5B8GXqny65J
	is/2xOtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzYLc-00000003ti0-49Nb;
	Thu, 27 Aug 2026 11:32:44 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzYLb-00000003thk-1oJK
	for linux-um@lists.infradead.org;
	Thu, 27 Aug 2026 11:32:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 84697600D3;
	Thu, 27 Aug 2026 11:32:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0F01F000E9;
	Thu, 27 Aug 2026 11:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787830362;
	bh=6AAqqY4OkNSdQHM1gwmpJ5lzM2oTtRJv4IBEa3HgW1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YCitKwHdBmmXQATMfnf96emOBD0bNGuTQZCIGvu0mBP5yiU9dwKhEi7E5dIgZLcHH
	 X1avs/xMwSZysmmH0oRRdopxhqfq2dOk4RJ+9AJXuoKQr2EqIy8AmdX1z5HoO44WyW
	 K7hlAi6SMU+M7ZQN+RKm5BJCPeWL9QuDyF8tKg7WTPSjvTVzg/ydhecanXaRsHHNu9
	 +16jjMxfS6oKmZWvHz3diEiPMxOmv7LpcWhg9bsaekG079iYr0x8HSs8S6uoE5Cizg
	 D4FriUW44WmRsndIj5Z2ZGPEI36T5HvQ/OKTQSCa6fsV5xiWP1N/ghqXAx+mRdhEug
	 CETbX5v1Hinrw==
Date: Thu, 27 Aug 2026 12:32:35 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: david@kernel.org, linux-mm@kvack.org, liam@infradead.org, rbm@suse.com, 
	akpm@linux-foundation.org, luto@amacapital.net, brendan.jackman@linux.dev, 
	liuhangbin@gmail.com, corbet@lwn.net, kees@kernel.org, broonie@kernel.org, 
	mhocko@suse.com, rppt@kernel.org, shuah@kernel.org, surenb@google.com, 
	vbabka@kernel.org, wad@chromium.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-um@lists.infradead.org, geert@linux-m68k.org, 
	daniel@thingy.jp
Subject: Re: [PATCH v2 0/2] support kselftest on nommu platform
Message-ID: <apAgQJ5p8LEDj1c5@gremlin>
References: <20260825015945.141739-1-thehajime@gmail.com>
 <f2ac9432-4fea-4007-aab0-ad80597b284c@kernel.org>
 <ao2Tl9CLL7WjHYun@gremlin>
 <bb9a3add-4849-4928-8b6a-0afc0c73b112@kernel.org>
 <ao2l9Ao7BQI6uRKC@gremlin>
 <m2y0dsuf1d.wl-thehajime@gmail.com>
 <ao_541nBaa3SJS9F@gremlin>
 <m2v78wueir.wl-thehajime@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2v78wueir.wl-thehajime@gmail.com>
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

On Thu, Aug 27, 2026 at 05:57:32PM +0900, Hajime Tazaki wrote:
>
> On Thu, 27 Aug 2026 17:49:58 +0900,
> Lorenzo Stoakes (ARM) wrote:
>
> > BTW did
> > https://lore.kernel.org/all/20260723093633.140989-12-johannes@sipsolutions.net/
> > go upstream? Or another UML nommu mode? I've not been keeping track of all
> > that.
>
> The current consensus (IIUC) is above Johannes's patches are in
> progress.  Another mode which I was originally proposed is postponed
> in order to minimize the impact to UM tree.

Ah ok cool, thanks! Is that headed to 7.3 or more like 7.4?

>
> -- Hajime
>

--
Cheers, Lorenzo

