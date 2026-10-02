Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E03CA5FC4
	for <linux-um@archiver.kernel.org>; Fri,  2 Oct 2026 11:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JmxZmAkX7sFWhZEhSwoTFCk9Ly0sqzCLy0ifziPCklE=; b=H77Rm5RtZSGPq5FfFwEWDBVWfZ
	AimqHg5gahEb54jZDYxVEnbObXWNGldmM+Rrfdccv6HxtIRNbIWrj7zzDzISEhZ0rb90TRD47WMLp
	5Lyp8k+0Owp76gwPBKoMtvl09v17TxJM+AdzIdvnZ3DwljuJ19kzGN3KoaHd451LYzqBJDSAZ08zp
	fsSaq73bZg2Ze/IUp9OZX5cB5M+Y80vuFnjCjFo8ylLsAViXGnQeGoWENJ61YzYTu5IIfRztF8d5z
	v/uwbFQgC9lxK98ZN7GmLQDMK3JxUBQqtCrRjJLfHnHbxi77Hi/v8iIFiQIn6fP/1KkAJheJA0ihD
	oTMeIL+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCbpc-0000000BWIm-0BD1;
	Fri, 02 Oct 2026 11:53:40 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCbpb-0000000BWIf-1hU0
	for linux-um@lists.infradead.org;
	Fri, 02 Oct 2026 11:53:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1BD5240093;
	Fri,  2 Oct 2026 11:53:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51911F000FF;
	Fri,  2 Oct 2026 11:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790942019;
	bh=JmxZmAkX7sFWhZEhSwoTFCk9Ly0sqzCLy0ifziPCklE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LrjaOiT0/kgKG5xJcHuIQQl96aDNH27jEWYo6/eukxIaqQwYL0Yi2fb+zu/vFRBId
	 DV/PZj2ePkgKFhE9/F4nvTYUADBF7H7T9RJOwDn3NIgMGlyMKcDuTAtoTIIkUsgDb6
	 x1URYwePs3Vebu4nOuyyzGzHW5Vn2MCe8aXxTi+YGMS6b0csgZWtq74p7c08jB9xPQ
	 ZpKgg9fwiync7utyBiMm2bPjVpvUOrU7S6mG7pstrUJvNj/jPcuRO+yDhhTGtADvXL
	 1IZ7ntsJFFvW9x/WXyQUNm7oAqTFgJ+zZzw2Hn0ou+zpclpaPwQJ68poxNuVNU2M6q
	 o+8PkQiPxtQUA==
Date: Fri, 2 Oct 2026 12:53:31 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	Hajime Tazaki <thehajime@gmail.com>, johannes@sipsolutions.net, linux-mm@kvack.org, 
	liam@infradead.org, rbm@suse.com, akpm@linux-foundation.org, luto@amacapital.net, 
	brendan.jackman@linux.dev, liuhangbin@gmail.com, corbet@lwn.net, kees@kernel.org, 
	broonie@kernel.org, mhocko@suse.com, rppt@kernel.org, shuah@kernel.org, 
	surenb@google.com, vbabka@kernel.org, wad@chromium.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-um@lists.infradead.org, daniel@thingy.jp
Subject: Re: [PATCH v4 1/2] selftests: run tests on nommu architecture
Message-ID: <ar-bIzYDdlOKUqla@gremlin>
References: <20260929235711.2287931-1-thehajime@gmail.com>
 <20260929235711.2287931-2-thehajime@gmail.com>
 <bda5eeaa-7868-4d4a-9026-9e99347afd7c@kernel.org>
 <ar4br2vW7yZGd3gt@gremlin>
 <94759bed23f00d2044005e36be6f72f297e092f0.camel@sipsolutions.net>
 <m2se2o3jyc.wl-thehajime@gmail.com>
 <a65f4431-d225-4535-b921-00319ceeb2a2@kernel.org>
 <ar9ldn036SgT-bq1@gremlin>
 <CAMuHMdUKcUxHZKhTEF1gwWrU1o8O6jt6N3r90V5hynrLFdwY0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUKcUxHZKhTEF1gwWrU1o8O6jt6N3r90V5hynrLFdwY0A@mail.gmail.com>
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

On Fri, Oct 02, 2026 at 01:38:31PM +0200, Geert Uytterhoeven wrote:

> On Fri, 2 Oct 2026 at 10:10, Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:

> > But fork() -> -EINVAL or -ENOSYS = nommu, then just have the child quit and
> > etc. should do it.
>
> fork() is not strictly an MMU-feature (you can implement fork on nommu
> if all memory accesses are done relative to a base address register),
> while I think mprotect() is an MMU-feature. Unless it can also be used
> to change the protection using the one or two BARs most MCU haves?
> Anything else that is a real MMU-feature? Non-identity mmap()?

Does any nommu arch implement fork() in linux?

--
Cheers, Lorenzo

