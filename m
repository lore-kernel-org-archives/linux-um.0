Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6520ACD37B0
	for <linux-um@archiver.kernel.org>; Mon, 18 Sep 2023 14:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:From:To:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0fUzcvVS2KRr+xQ1CNolJxMbnI9BleS2wfcJOdWRoHE=; b=JVMg4fP+tPp2g/
	P+2AvuhtDmtW3qrwxsjnfxwIcwt+nrtH7Ri3BoPnD85An7CgDbUHXDE0iqxH3cPyImYOccQDf8pJ0
	UCsnIR8lEYTUEBhCmbEUFJFAqeRcFseimufcuM5H/PQP83aFf2d3W+qLRlwwL/bMAJ2kL/g4TyKt9
	jx6/RfCDnYYmIcafHHAo26E6OPmUxbGrlvb8oADlGQpNGHTQj1x95anyAVufqf9TakbZjkzs8wBVi
	kgexauiyxlQL7f0xKNqAZ+WuVG9h6nQlKtMlbEDKuRIosuuj/ubuclGq+Ur3oAI99dVlJNRP5uzgm
	iK+FTMZQOusLACFpDiIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiF1V-00FdIG-2V;
	Mon, 18 Sep 2023 14:14:49 +0000
Received: from mail-4018.proton.ch ([185.70.40.18])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiF1S-00FdHH-0e
	for linux-um@lists.infradead.org;
	Mon, 18 Sep 2023 14:14:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=n8pjl.ca;
	s=protonmail2; t=1695046482; x=1695305682;
	bh=Km91J5JZrnd7URdpT5rh0YawCfFvdMqpbXm9xOXQn1s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=s58EZzuaw7picVWTRX+/V8Pt6XW9FVjJurAT1S3a3Quz+v++x4AqaBChG//SSRq4E
	 C6YmeJzLFS4YD5HbeQNxSxxfoVS8rMDEVPSaPF0/6w/fr4g8Mhv2qyYw0fEeqBSViI
	 wNNHg6iMiebglnBPXFBHRXtWP0P2uxKPeC3JT7vXnijFAxx6IlEYGV5JYE3giyN5Il
	 10cmybDZ3aJSgHJnQl9aBYlfWY1+3p4iOJedy4iIUb3T9nmtfKDkIvnkObtHCm8CTZ
	 LRH17HwP0oj4oVS26INgpzpeVfqFny0pAxwyLm3AzAyKfoicxxNWhP4ZmUo3rwmtPE
	 zdgznI8lt8ofQ==
Date: Mon, 18 Sep 2023 14:14:21 +0000
To: jack@suse.cz
From: Peter Lafreniere <peter@n8pjl.ca>
Cc: Peter Lafreniere <peter@n8pjl.ca>, linux-um@lists.infradead.org, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, reiserfs-devel@vger.kernel.org, richard@nod.at
Subject: Re: [PATCH RESEND] um: Remove CONFIG_REISERFS_FS from defconfig
Message-ID: <20230918141359.11097-1-peter@n8pjl.ca>
In-Reply-To: <20230918132614.zmmuc72purc2psik@quack3>
References: <20230910232640.113938-1-peter@n8pjl.ca> <20230918125744.4342-1-peter@n8pjl.ca> <20230918132614.zmmuc72purc2psik@quack3>
Feedback-ID: 53133685:user:proton
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230918_071447_598115_862FDD3D 
X-CRM114-Status: GOOD (  16.66  )
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

On Monday, September 18th, 2023 at 09:26, Jan Kara <jack@suse.cz> wrote:
> On Mon 18-09-23 12:58:26, Peter Lafreniere wrote:
> 
> > ReiserFS has been deprecated for a year and a half, yet is still built
> > as part of a defconfig UML kernel.
> > 
> > According to commit eb103a51640e ("reiserfs: Deprecate reiserfs"), the
> > filesystem is slated to be removed in 2025. Remove it from the defconfig
> > profile now, as part of its deprecation process.
> > 
> > Signed-off-by: Peter Lafreniere peter@n8pjl.ca
> 
> 
> Makes sense but I've noticed there are many more architectures that define
> CONFIG_REISERFS_FS in their defconfig (sh, powerpc, mips, m68k, ia64, arm,
> alpha). So perhaps we should do this for all of them when we are at it?

I agree. I can send a patch series for those arches except for ia64, which has
already been removed from linux-next.

> 
> Honza
> 
> > ---
> > Fixed invalid DKIM settings causing the previous patch to be rejected.
> > 
> > arch/um/configs/i386_defconfig | 1 -
> > arch/um/configs/x86_64_defconfig | 1 -
> > 2 files changed, 2 deletions(-)
> > 
> > diff --git a/arch/um/configs/i386_defconfig b/arch/um/configs/i386_defconfig
> > index e543cbac8792..9c9c77f1255a 100644
> > --- a/arch/um/configs/i386_defconfig
> > +++ b/arch/um/configs/i386_defconfig
> > @@ -61,7 +61,6 @@ CONFIG_UML_NET_DAEMON=y
> > CONFIG_UML_NET_MCAST=y
> > CONFIG_UML_NET_SLIRP=y
> > CONFIG_EXT4_FS=y
> > -CONFIG_REISERFS_FS=y
> > CONFIG_QUOTA=y
> > CONFIG_AUTOFS_FS=m
> > CONFIG_ISO9660_FS=m
> > diff --git a/arch/um/configs/x86_64_defconfig b/arch/um/configs/x86_64_defconfig
> > index 939cb12318ca..03b10d3f6816 100644
> > --- a/arch/um/configs/x86_64_defconfig
> > +++ b/arch/um/configs/x86_64_defconfig
> > @@ -59,7 +59,6 @@ CONFIG_UML_NET_DAEMON=y
> > CONFIG_UML_NET_MCAST=y
> > CONFIG_UML_NET_SLIRP=y
> > CONFIG_EXT4_FS=y
> > -CONFIG_REISERFS_FS=y
> > CONFIG_QUOTA=y
> > CONFIG_AUTOFS_FS=m
> > CONFIG_ISO9660_FS=m
> > --
> > 2.42.0
> 
> --
> Jan Kara jack@suse.com
> 
> SUSE Labs, CRi


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
