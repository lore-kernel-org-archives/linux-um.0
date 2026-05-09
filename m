Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C114CD3447
	for <linux-um@archiver.kernel.org>; Sat,  9 May 2026 19:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=apx2itl6ido/GDl3BMcfRXwcHiMC7anhmX6nWBT36b4=; b=eQSyGlzG9+9iV8RiImMQvEYxjn
	DLobKLHVxz493OV2VBkcnV8N6dIKMb2SlnYtcmhWFDbs2UwSLlwYVz/scIWHC6B5bjTwkpprDtBgU
	/1rbzW7XFiU4W57rFATs8ypf20HXCB+IN3CCj9kO0NnsJY6zCKNVB9SBj87zzRqhZC9ZneI4iM7Lt
	+CDPQLlbmbqB7pQyY+hMPC+KKi1JYoDMBgONgPD1Isz1MJvFZOHk5wxQdsDjY2G2Ebpc/r2k+gcu3
	RcgR0s9fHp22UtOa4Yn/Y1/sE7KfDfuvsTa0FeVgBjBNCnCswXbs4WJiK6MrGNLt/E6tFKouBoCRk
	pK4Kl/Ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLnX1-00000009YU6-1Tqd;
	Sat, 09 May 2026 19:40:11 +0000
Received: from vps0.lunn.ch ([156.67.10.101])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLnWx-00000009YST-1QYJ
	for linux-um@lists.infradead.org;
	Sat, 09 May 2026 19:40:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=apx2itl6ido/GDl3BMcfRXwcHiMC7anhmX6nWBT36b4=; b=FvLj6KOMbWMxDi06MfXhf1T4Db
	gOGH3pxNNBEqVPUNxs+pZzjJdIqkGaamay5kH9Bu3yRxyIHMTOW9/T1sHDUn8uZURXPvaH9WElPm8
	rmxQam/srjIgPv1mISpW8wJ7NA2Ld/bmhZERgs2DwA8rT7TmcJGBuOwyYBTckIrB3pLw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wLnWa-00287z-6L; Sat, 09 May 2026 21:39:44 +0200
Date: Sat, 9 May 2026 21:39:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Adrien Reynard <reynard.adrien.08@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"open list:KASAN" <kasan-dev@googlegroups.com>,
	"open list:DOCUMENTATION PROCESS" <workflows@vger.kernel.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
	"open list:USER-MODE LINUX (UML)" <linux-um@lists.infradead.org>
Subject: Re: [PATCH 4/5] docs: fix repeated prepositions across documentation
Message-ID: <3b4357a7-f70d-41b0-a75d-c30f9fb7dd98@lunn.ch>
References: <20260508163804.16267-1-reynard.adrien.08@gmail.com>
 <2b771350-0562-4cb1-b9b3-cc3ce59b1a63@linuxfoundation.org>
 <3c6cde1a-9ce0-4d63-ba89-820c596cff3e@lunn.ch>
 <27c61395-f04f-420c-9a84-7e27773f2027@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27c61395-f04f-420c-9a84-7e27773f2027@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260509_124007_381714_0E6CA8CC 
X-CRM114-Status: GOOD (  14.92  )
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

> > Can we get the tool changed to add a warning, something like:
> > 
> >   WARNING: This tool uses very simple pattern matching to look for
> >   repeated words. It does not understand the complexity of English,
> >   and will often result in false positive reports. Please assume it is
> >   wrong until proven otherwise.
> 
> There was no commit log and no cover letter AFAIK.
> Do we know what tool was used?
> 
> Adrien, how did you discover these repeated words?
> 
> (If it's my script from 2021, I'll gladly update it.)

Thinking about it some more, i think the warning might actually need
to be different.

If this tool has been around since 2021, all the real problems have
been solved, leaving only the false positives. So the warning probably
needs to be much stronger, saying that it probably only reports false
positives, unless the code is new.

Maybe we also want to extend the tool to have a list all the known
false positives?

      Andrew

