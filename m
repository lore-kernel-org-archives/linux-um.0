Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B3BD75E36
	for <linux-um@archiver.kernel.org>; Fri, 22 Nov 2024 12:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ab/arcOHLlcb8ltEz12OKbbcN0JNiSj2oQMVwfbb6cw=; b=D2K0pw1ihOrrsmVgsEpbzugmVf
	HuaiS9+qVs5qUrl0ErHO/J2Ql79bINZlAkCfKvKW0E6rmfaJKiF0WxIUOsaJkDEJRMtEO++uMdnbQ
	PtLG7IKuBGuSZ7nDE38KqJmRUA3Tefo2yAEMLqwCypqq07uMDHYPyZ2U2K3qazvIKtFzEccHgDVqD
	GUGdMpVpNZNldnh5e2oZnhSow8EZ04g20QLzvhNBTjlLY1tv96q5FXRzFlYaw30Pe9ZkLMX2A22Kn
	Cl5+tixg1G8yV4zwscpe74O3buipXDX4unpSRdPsEh0U+mDRw4XTlNvHHKJ/UrL2te4xc7jUFQLWz
	dsLUZTSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tESvm-00000002T2D-2nLf;
	Fri, 22 Nov 2024 12:38:38 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tESvk-00000002T1H-3eqg
	for linux-um@lists.infradead.org;
	Fri, 22 Nov 2024 12:38:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 48E5268D0A; Fri, 22 Nov 2024 13:38:33 +0100 (CET)
Date: Fri, 22 Nov 2024 13:38:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Johannes Berg <johannes@sipsolutions.net>,
	Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org,
	ricarkol@google.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	linux-mm@kvack.org, Jann Horn <jannh@google.com>,
	Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [RFC PATCH v2 00/13] nommu UML
Message-ID: <20241122123833.GA26432@lst.de>
References: <cover.1729770373.git.thehajime@gmail.com> <cover.1731290567.git.thehajime@gmail.com> <77ab71c7-3608-4636-a618-3044c2316a92@lucifer.local> <0930a0fa8e28ecaf92727229e6633278399409e7.camel@sipsolutions.net> <20241122121826.GA26024@lst.de> <d28480cc-2200-43bd-adb2-01bbcd8adb1c@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d28480cc-2200-43bd-adb2-01bbcd8adb1c@lucifer.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241122_043837_049344_0A8E9700 
X-CRM114-Status: GOOD (  13.64  )
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

On Fri, Nov 22, 2024 at 12:25:19PM +0000, Lorenzo Stoakes wrote:
> It's an ongoing maintenance burden, discussions about seeing whether it's
> feasible to remove it have been had in multiple places.
> 
> I have personally run into issues having to accommodate it on numerous
> occasions, as have many others.
> 
> I'd be interested to know which products specifically ship this and also
> require tip kernel, perhaps this is just a case of my not being aware of
> certain architectures?

I can't tell you the products I know on commercial basis.  Most of them
are arm based, but I also know about at least one RISC-V one.    They
all used the latest long term stable at the time of release and tend
to stay on that.  And the involved vendors keep spinning out new versions
of these every few years.


