Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334A3C9833F
	for <linux-um@archiver.kernel.org>; Mon, 28 Sep 2026 11:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W/VZm44XzSsz564iDu6yls171Wz+1fQyfbWB7NPC/qE=; b=SxCd3f85rMn48qEcDYBEfQNGUD
	OmQDG//uBW0wgK6dekU8hbco/H+Pd72/O8/mvetyKd7nOHEF9CHvViBsHfWKuo3bBt0YbtH3rPkZa
	u6aYbVXNabH60wNTs6AqSxJOIGjgXiE2M6ghM01faWf6TnMh7DA9JLZwvYi5PuX67oKtt9oNKgoiE
	LRPgQJ9D4BhDnuY/mZocm4GXSS3j5pUon7AlBU/eEfp4r6R+6COGQ4gwwJm0KuKaxI4yz3eTbLIgk
	+8hTZg9b8kfHqgTZ//tBxQ/Wiy3pGJhp2pgC5ThEKX6u65GKkoSifwSptEVtKkdLhZNBRhQBBXRNE
	mmTs+YlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xB95x-00000000PVw-3lC5;
	Mon, 28 Sep 2026 11:00:29 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xB95x-00000000PVl-0RF0
	for linux-um@lists.infradead.org;
	Mon, 28 Sep 2026 11:00:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 39D83600D1;
	Mon, 28 Sep 2026 11:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852161F000FF;
	Mon, 28 Sep 2026 11:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790593227;
	bh=W/VZm44XzSsz564iDu6yls171Wz+1fQyfbWB7NPC/qE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YCMQw9cX13xqhIwBzSMliTFI1BR50NKpER6op4F/axoQCrr9l0XXf6aKT61a2MYnZ
	 5capFidkNb48gSEu2nhvuhjUmkOoDQEfunJtlKE33rLoPt/132APCimNjZZlyAnfGo
	 BgCXLAb9ZOJGA+56e3kydME3r/Rqy83Tazx1Hgk12gMgLAooFzIbdO92+wgszDwoI7
	 0wcOm97VS0aIQkcxex3zRx0W1YJhM3LnzW3wvpPufqpPdX1MU9kssrpgnzzKDjtoez
	 tU76c1ClWcl1zqN9EOl4Ujjk7ElqmJTjv6Z92YxS/B01A0Me3ruXGE38icwJuqHZhX
	 mysf0URYpxqRw==
Date: Mon, 28 Sep 2026 12:00:19 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Hajime Tazaki <thehajime@gmail.com>, linux-mm@kvack.org, 
	liam@infradead.org, rbm@suse.com, akpm@linux-foundation.org, luto@amacapital.net, 
	brendan.jackman@linux.dev, david@kernel.org, liuhangbin@gmail.com, corbet@lwn.net, 
	kees@kernel.org, broonie@kernel.org, mhocko@suse.com, rppt@kernel.org, 
	shuah@kernel.org, surenb@google.com, vbabka@kernel.org, wad@chromium.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-um@lists.infradead.org, 
	geert@linux-m68k.org, daniel@thingy.jp
Subject: Re: [PATCH v3 2/3] selftests: run tests on nommu architecture
Message-ID: <arpIi5QBG1_MuZzJ@gremlin>
References: <20260926010819.604346-1-thehajime@gmail.com>
 <20260926010819.604346-3-thehajime@gmail.com>
 <04259a99ed91f8a527b255951a6f626310728170.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04259a99ed91f8a527b255951a6f626310728170.camel@sipsolutions.net>
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

On Mon, Sep 28, 2026 at 09:44:49AM +0200, Johannes Berg wrote:
> On Sat, 2026-09-26 at 10:08 +0900, Hajime Tazaki wrote:
> > Architectures lacks MMU doesn't support fork(2) syscall and only
>
> nit: Architectures lacking MMU don't support the fork(2) syscall ...
>
> Not sure where this should be merged? I guess selftests would make most
> sense, but you can't actually test it out before the UML nommu changes,
> so that doesn't work too well right now?

I seem to recall Hajime saying he tested this on an actual nommu
device/virtualised equivalent so nommu UML isn't strictly necessary (though very
nice to have!)

I think I saw something fly by that implied it might be coming in 7.4 is that
so? :)

>
> johannes

--
Cheers, Lorenzo

