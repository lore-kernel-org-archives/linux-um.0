Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB04CE79A9
	for <linux-um@archiver.kernel.org>; Tue, 19 Sep 2023 15:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:From:To:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FOgpx6WTTk+6kDTFs+k/R5GACLzmgBSzCsBYzKVp7HA=; b=lXXiKN+n+TfSjr
	m24RhZlGtLa2/deVW82sD9aJjtCO4rPpaIXY/XYhwKiMX56hQY5ORCUkJ+2qedlUXvIJktrcBnrQe
	2DMhbWHfncuHzIB1i+Jl6gnZow88pU2NEAok+u0rCdRVIifai1k7eTDiTHstUFEcXnHKAZKSSGTzS
	0gw1j7Vug7TOS4/9iRTWEsaQuAE7/0eiyn9kDuuKa8ZhtBNhNUZkSbkuTo7BlGxYDy5Mid0WPSELM
	94IKtN+nbSMUNxFtvEjmqV+ej5k27J0r23X4mDwsKj1+Vje+8ekWR5ujvR5HohdULKEPAeeaKrTrN
	NPSxAeCPHvPPSZMIjYJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qid7p-000oJV-2g;
	Tue, 19 Sep 2023 15:58:57 +0000
Received: from mail-4317.proton.ch ([185.70.43.17])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qid7m-000oI2-00;
	Tue, 19 Sep 2023 15:58:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=n8pjl.ca;
	s=protonmail2; t=1695139129; x=1695398329;
	bh=iQ70sqOuWy3+EASwFa0/309PrDQXmYm3GtUvJiKCnbc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=JLWZQZuHawh1kmZgERsEMV6LqT29GcKLho21jKqkgPF1sD5uLFx8MbQaN34J1I4p7
	 m4P68h8x4rYi2/a7K1ML+IcH+b1egMO9vVMZujHDO931fFajAvsXbs1p61rP5VH2aU
	 lfrbBRzXdoQl6hLJE/IyC7na/C0Px9G2LsB6odzXoj4TX4AGzH9v8z/HrpIcLfJ+Bn
	 77XAFrVcZvKoHBnmYVNTIfvfyWjli4k4Dr3fcc67nkjaKIoVsn029amWaWUYG2mke/
	 lcqdwSK9XpRY//BoHx1XHXdR9A3Ld7auTD+jhwsmMkmewEIWzNcmdzujAE444Ounxy
	 2CVfqDCByas5Q==
Date: Tue, 19 Sep 2023 15:58:41 +0000
To: segher@kernel.crashing.org
From: Peter Lafreniere <peter@n8pjl.ca>
Cc: anton.ivanov@cambridgegreys.com, geert@linux-m68k.org, ink@jurassic.park.msu.ru, jack@suse.cz, johannes@sipsolutions.net, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org, linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, linux-um@lists.infradead.org, linux@armlinux.org.uk, linuxppc-dev@lists.ozlabs.org, peter@n8pjl.ca, reiserfs-devel@vger.kernel.org, richard.henderson@linaro.org, richard@nod.at, tsbogend@alpha.franken.de
Subject: Re: [PATCH 0/7] arch/*: config: Remove ReiserFS from defconfig
Message-ID: <20230919155832.4179-1-peter@n8pjl.ca>
In-Reply-To: <20230919151630.GO19790@gate.crashing.org>
References: <20230918175529.19011-1-peter@n8pjl.ca> <20230918234108.GN19790@gate.crashing.org> <20230919000026.7409-1-peter@n8pjl.ca> <20230919151630.GO19790@gate.crashing.org>
Feedback-ID: 53133685:user:proton
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230919_085854_876274_000F4650 
X-CRM114-Status: GOOD (  21.07  )
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

On Tue, Sep 19, 2023 at 11:16, Segher Boessenkool wrote:
> 
> On Tue, Sep 19, 2023 at 12:00:34AM +0000, Peter Lafreniere wrote:
> 
> > On Monday, September 18th, 2023 at 19:41, Segher Boessenkool segher@kernel.crashing.org wrote:
> > 
> > > On Mon, Sep 18, 2023 at 05:56:09PM +0000, Peter Lafreniere wrote:
> > > 
> > > > ReiserFS has been considered deprecated for 19 months since commit
> > > > eb103a51640e ("reiserfs: Deprecate reiserfs"). However, there are
> > > > several architectures that still build it into their defconfig kernels.
> > > > 
> > > > As ReiserFS will be removed in 2025, delete all ReiserFS-related options
> > > > from defconfig files before the filesystem's removal.
> > > 
> > > This is essentially equivalent to deleting the filesystem now. Why do
> > > this? Is there such a hurry?
> > 
> > This is not equivalent to deleting the filesystem. The filesystem can still
> > be configured into kernels, and few distros use a defconfig kernel anyway.
> 
> 
> Most people who compile kernels use defconfigs though. Distros are a
> tiny minority if you look at builds.
> 
> Again: why do you want this?
> 

Because the filesystem is deprecated and rarely used. Those who do use ReiserFS
should migrate away from it or get ready to stop upgrading their kernels soon.

This removal from defconfig:

 1) Serves as a reminder to those that use the fs that they should take the
    above actions, but with the filesystem staying available should they need
    it.

 2) Stops building an obsolete and largely-unused filesystem unnecessarily.
    Some hobbyist targets like m68k and alpha may prefer to keep all filesystems
    available until total removal, but others like arm and UML have no need for
    ReiserFS to be built unless specifically configured.

 3) Arguably simplifies the removal of the filesystem when that takes place.
    This point is admittedly quite weak.

 4) Has to happen someday, unless someone steps up and volunteers to maintain
    the fs. I don't find it worthwhile, but you can if you'd like. Perhaps work
    towards removal will cause a user to step forward and keep their beloved
    filesystem around?

 5) Doesn't actually remove support for the filesystem whatsoever. I can't
    emphasize this enough: users who build their own kernel and maintain a
    niche filesystem like ReiserFS should know how to flip a Kconfig switch.

> 
> Segher

Cheers,
Peter


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
