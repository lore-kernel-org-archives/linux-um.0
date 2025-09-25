Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E9BCAC5A7
	for <linux-um@archiver.kernel.org>; Thu, 25 Sep 2025 17:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WNtTvu+9Q6vweVUxKB9uQfFQ6ARdfoClLfibDKjLT4M=; b=qkj+4S4FMbeoyaGUWJIe6QUvSu
	q7v1SB2wFRZG46IXejOXP51YGrU9XkjHx0UUSPm7ruyaR2wCxsTuUjpx5ZkDq85xRjc8NtzPg/mct
	+h4P0egaQBm5olMBxVDWXontRsg/5A+RTZw4qqA4KD6HzdCjWrMJOSYisgrS1BqG42TvakrRnJQ9g
	AQV0mbhywh3JsFkI45WcEs5NnrlsyjVKF01W0hXFOZJq/ZG7XI53Dv2kWccdKmGeuzFA+odtYPCdr
	HNhU9mH7uAM+RkVdg+o173NLPgjJk8bI5k1xY0TbjQqN/UkhVsZdBeHuT3NPPnlHHQbPBOG9JgjBP
	3gGQZq5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1pSS-0000000BOda-032o;
	Thu, 25 Sep 2025 17:08:40 +0000
Received: from todd.t-8ch.de ([2a01:4f8:c010:41de::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1pSP-0000000BOaG-1SyF
	for linux-um@lists.infradead.org;
	Thu, 25 Sep 2025 17:08:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1758820115;
	bh=gLMNiUHz0jN+yB725jmooRejtzuPZZGG/vNIFpyP0vc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZyjK8nmtXV2dv9avk6p1jDrX3CNurghKoSpFMBpCb1Xzz/mYkGxXGrsoQpXWo0Des
	 QWnmbBNRscsjHW4+LhSsrLX7D2L3Ozqw+5hR2Jf42XW2RKeH6Zg4HkLorDDyR3kfv8
	 U8mLxEhnVUymS65Eipg0WhGmyrGbVmtlFVBPfdRo=
Date: Thu, 25 Sep 2025 19:08:31 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Tiwei Bie <tiwei.bie@linux.dev>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, benjamin@sipsolutions.net, arnd@arndb.de, 
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, tiwei.btw@antgroup.com
Subject: Re: [PATCH v2 03/10] um: vdso: Implement __vdso_getcpu() via syscall
Message-ID: <bfa3b5fe-ae5d-4647-a49e-b2b53a46de4f@t-8ch.de>
References: <1568f254-7963-4015-91ed-7630d5d87881@t-8ch.de>
 <20250922045020.48158-1-tiwei.bie@linux.dev>
 <495a5594-8ac6-4b7d-be6b-7c176b741c21@t-8ch.de>
 <76b5ba35f864764100c9a5a00d50d8fa4276cd98.camel@sipsolutions.net>
 <21755635-74d4-4fa4-8ffd-371c17630fdf@t-8ch.de>
 <366bb558c3fd23b9a80008d923f29ed0234e17b9.camel@sipsolutions.net>
 <61ae09df-d65b-4c9d-a0c1-7de915246590@t-8ch.de>
 <96ae8e726480a36a37d472106b761a141394e845.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96ae8e726480a36a37d472106b761a141394e845.camel@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250925_100837_532138_F6F0719F 
X-CRM114-Status: GOOD (  33.98  )
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

On 2025-09-22 19:07:27+0200, Johannes Berg wrote:
> On Mon, 2025-09-22 at 18:04 +0200, Thomas Weißschuh wrote:

(...)

> > > > > I mean ... on the one hand, sure, it doesn't really do much after this,
> > > > > but OTOH it lets userspace actually use that path? So might be useful.
> > > > 
> > > > What advantage does userspace have from it?
> > > 
> > > Right now, none? But it's easier to play with if you have the
> > > infrastructure, and I'm not convinced there's a _disadvantage_?
> > 
> > So far that hasn't happened. The disadvantages are the ones from above,
> > nothing critical. But of course it is your subsystem and your call to make.
> 
> Yeah, kind of agree, though I'd like to actually use it - especially in
> time-travel mode - but haven't really gotten time to add it. Having it
> maintained in-tree is a bit nicer in case of global updates, but yeah,
> ultimately it's not really all that important either way.
> 
> I guess we could get getrandom() pretty easily by taking the x86 one.

Yeah, the only architecture-specific part there is the assembly chacha
implementation. And that will be the same one as used by regular x86.

> I actually have half a patch somewhere that rejiggers the UM vDSO to be
> more like normal architectures, using lib/vdso/gettimeofday.c and making
> the build more regular etc. Maybe I should dig that up and try to make
> it work entirely - it was part of a previous attempt of adding the time-
> travel thing I mentioned.

Sounds good. And let me know if you want me to look at it.
Using the generic vDSO library and datastore is mandatory nowadays for
"real" vDSOs.

> > > Huh, hm, yeah I forgot about that ... 32-bit. Yeah, agree we should just
> > > kill that. I'm not even sure it works with the host kernel trapping
> > > there? Oh well.
> > 
> > Ack, do you want me to send a patch? This was my real gripe with the UM
> > vDSO. I want to enable time namespaces for all architectures but these
> > need to be handled in the vDSO properly. For the 64-bit stub vDSO it's
> > not a problem as the syscalls will work correctly.
> > But the interaction with the weird 32-bit logic on the other hand...
> 
> I guess? But I'm confused by what you say about it being related to time
> namespaces, the vsyscall stuff doesn't really _do_ anything, assuming it
> works at all? It's not like the host actually could be doing anything
> other than syscalls there, which are intercepted? If it were doing
> anything else, it wouldn't work in UML in the first place?

In emulation mode the trapping kernel will not actually trigger a
syscall but calculate the time in kernel space and write the results to
the respective registers. If I understand correctly the trap is handled
by the host kernel, so that would bypass UML completely.
My wording was a bit wonky. I stumbled upon this while looking for
potential time namespace compatibility issues. And with time namespaces
the chance for a clock mismatch between UML and the host are higher.


Thomas

