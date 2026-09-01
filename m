Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85888C61DD3
	for <linux-um@archiver.kernel.org>; Tue,  1 Sep 2026 14:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fAIsm/HteRf3YKYFv2nKHjUIchlu3eaENoAxwWG8aEY=; b=KEsKK9ZGmGP84vvM/mKvyRdLTq
	0BBhJbxklkJHyh3BjFJ9VEOF+hCDxI/rkGJl5rM4yhjPEvJaHvxw0RZnO1T3ZhbtCLgRpHB5Igl/b
	Xf+k5Sbt0H1Rtp0ZoNgcCcf/B75UsoYePUv7rkqLVwpjKI51LlcdJmkIHwb/es7g4twkzPa+4ZTbB
	ZN9KVvUKOSdz3+Ds4L7cU0eNaOb0Z8rWjuttFbmVFzinKqZtHMbYWTgYo7Dp/ySG6sz+RF4+nF+zx
	GsjzR7SA0QhuKFczkeX1xAcW8T4gejN6vtgUYchKrp+eFh9BUkNijFq3KjIMVntgmZ6EOEOmNKare
	7gPII1Jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1PjR-0000000CNTR-2ps0;
	Tue, 01 Sep 2026 14:45:01 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1PjQ-0000000CNTA-3nbG
	for linux-um@lists.infradead.org;
	Tue, 01 Sep 2026 14:45:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3FDE6602C2;
	Tue,  1 Sep 2026 14:45:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D871F000E9;
	Tue,  1 Sep 2026 14:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788273899;
	bh=fAIsm/HteRf3YKYFv2nKHjUIchlu3eaENoAxwWG8aEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JbQsYQQTryTJccngjQ6sMGW5kFfCavhUFjLzV4MjqkHi+BCzDmSYL5sVMBrrEt8h6
	 ktgB1GV43LZv/WsX/Cvn1eGJsTE9h2i0ss//1pzBa8nQq1CuANiviKerSRkcVhQ368
	 rVsBLyMjr6sQfWasTsIczZFZPpDR0E3U3SjQOi98KqMhYvzEWFqzVAw9aN7vDSnLRS
	 pgLTqQXL/riVvYdkKcamGBovzkNxn9/95svzBrkDubdasz4HNTM3W9B/ZIb/xeIBIb
	 jut2js8skF45pnqjTJ/o6Vr4ukAjg6/C6XVq9xmOMilcFlaTnMQn19gUcg6KHB5gPx
	 PbkOK5Iq8sWoA==
Date: Tue, 1 Sep 2026 15:44:52 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Hajime Tazaki <thehajime@gmail.com>, david@kernel.org, 
	linux-mm@kvack.org, liam@infradead.org, rbm@suse.com, akpm@linux-foundation.org, 
	luto@amacapital.net, brendan.jackman@linux.dev, liuhangbin@gmail.com, corbet@lwn.net, 
	kees@kernel.org, broonie@kernel.org, mhocko@suse.com, rppt@kernel.org, 
	shuah@kernel.org, surenb@google.com, vbabka@kernel.org, wad@chromium.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-um@lists.infradead.org, 
	geert@linux-m68k.org, daniel@thingy.jp
Subject: Re: [PATCH v2 0/2] support kselftest on nommu platform
Message-ID: <apbknMd-vv6jliZu@gremlin>
References: <20260825015945.141739-1-thehajime@gmail.com>
 <f2ac9432-4fea-4007-aab0-ad80597b284c@kernel.org>
 <ao2Tl9CLL7WjHYun@gremlin>
 <bb9a3add-4849-4928-8b6a-0afc0c73b112@kernel.org>
 <ao2l9Ao7BQI6uRKC@gremlin>
 <m2y0dsuf1d.wl-thehajime@gmail.com>
 <ao_541nBaa3SJS9F@gremlin>
 <m2v78wueir.wl-thehajime@gmail.com>
 <apAgQJ5p8LEDj1c5@gremlin>
 <40e95edb8dafd88fd13c3003c0e76df6a2f124d9.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40e95edb8dafd88fd13c3003c0e76df6a2f124d9.camel@sipsolutions.net>
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

On Tue, Sep 01, 2026 at 04:28:49PM +0200, Johannes Berg wrote:
> On Thu, 2026-08-27 at 12:32 +0100, Lorenzo Stoakes (ARM) wrote:
> >
> > Ah ok cool, thanks! Is that headed to 7.3 or more like 7.4?
>
> Seems everyone was on vacation (I just got back) so I believe it missed
> 7.3 since -rc1 is just out.

Ah damn! But understood.

>
> I hope to have enough time in this development period to the merge
> window to figure out all of these things and get stuff merged - UM

Ah that'd  be great!

> wasn't on my priority list with all the (LLM) security(-ish) stuff going
> on in wireless.

Yeah entirely understandable, I think we're all being pummelled by AI
lately :)

>
> johannes

--
Cheers, Lorenzo

