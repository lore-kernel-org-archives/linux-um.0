Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30459CD5BDD
	for <linux-um@archiver.kernel.org>; Tue, 19 Sep 2023 15:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Mime-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XSTBneXKidC4BTIGvqoLJxkx5VUwA6PrFjh5pcnAIzE=; b=MJ1kFECY6IxAJN
	9O/biUTRzSFXH2eyibcApHUzFBo/aDMhvqGtVdYjEeUuCRyCK3GR9LP9fiPH+uxKbLC8E/t3Pzn7K
	RJerYb/YUwLUeGM1FXHCEvJX72mk43TFB7SIM5PSumrKv+9epK4Rr6XSuoOcxTSRRifqhJzqgiNJp
	X1IYl4KEgq5jJuxlRGhFpPSvQKBZH3Pid+S1k5dsywByTe12FLBWkC4EPN9J/45wfcQmWiFvyR8wV
	yFTqGXM2OAlSpuKflkjU1PDPbHO2cp5jNw+EGkzcxWiCruLxCuCPdDo2yvdp6woLNN2y00d2JPd7H
	7i832EkfTKFCjJnITvtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qicZ5-000krp-2X;
	Tue, 19 Sep 2023 15:23:03 +0000
Received: from gate.crashing.org ([63.228.1.57])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qicZ2-000kr7-02;
	Tue, 19 Sep 2023 15:23:01 +0000
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 38JFGXnW031198;
	Tue, 19 Sep 2023 10:16:33 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 38JFGUOK031195;
	Tue, 19 Sep 2023 10:16:30 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Tue, 19 Sep 2023 10:16:30 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Peter Lafreniere <peter@n8pjl.ca>
Cc: anton.ivanov@cambridgegreys.com, geert@linux-m68k.org,
        ink@jurassic.park.msu.ru, jack@suse.cz, johannes@sipsolutions.net,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-um@lists.infradead.org, linux@armlinux.org.uk,
        linuxppc-dev@lists.ozlabs.org, reiserfs-devel@vger.kernel.org,
        richard.henderson@linaro.org, richard@nod.at,
        tsbogend@alpha.franken.de
Subject: Re: [PATCH 0/7] arch/*: config: Remove ReiserFS from defconfig
Message-ID: <20230919151630.GO19790@gate.crashing.org>
References: <20230918175529.19011-1-peter@n8pjl.ca> <20230918234108.GN19790@gate.crashing.org> <20230919000026.7409-1-peter@n8pjl.ca>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230919000026.7409-1-peter@n8pjl.ca>
User-Agent: Mutt/1.4.2.3i
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230919_082300_355901_1A41B545 
X-CRM114-Status: GOOD (  15.24  )
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

On Tue, Sep 19, 2023 at 12:00:34AM +0000, Peter Lafreniere wrote:
> On Monday, September 18th, 2023 at 19:41, Segher Boessenkool <segher@kernel.crashing.org> wrote:
> > On Mon, Sep 18, 2023 at 05:56:09PM +0000, Peter Lafreniere wrote:
> > 
> > > ReiserFS has been considered deprecated for 19 months since commit
> > > eb103a51640e ("reiserfs: Deprecate reiserfs"). However, there are
> > > several architectures that still build it into their defconfig kernels.
> > > 
> > > As ReiserFS will be removed in 2025, delete all ReiserFS-related options
> > > from defconfig files before the filesystem's removal.
> > 
> > 
> > This is essentially equivalent to deleting the filesystem now. Why do
> > this? Is there such a hurry?
> 
> This is not equivalent to deleting the filesystem. The filesystem can still
> be configured into kernels, and few distros use a defconfig kernel anyway.

Most people who compile kernels use defconfigs though.  Distros are a
tiny minority if you look at builds.

Again: why do you want this?


Segher

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
