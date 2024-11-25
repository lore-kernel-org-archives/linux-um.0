Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0186D58D71
	for <linux-um@archiver.kernel.org>; Mon, 25 Nov 2024 17:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i1zyTvm0SiQ2Og0Kpt6UMawusjwfmCj5SiNgpCOF4PA=; b=KmZWuTkgICbnfUmGdD3dKBQZi1
	4lnRgENAJnIpnpnkchfKSWWmOypxCDmgNLDTqzMzrOju8KLmD8JEgdwz7YE0FkXczjR3xk5gkPFyM
	nbBR4sqlPQeTLwBSur4f6PHT69NCEipAb7sWeq0GCykfFG0tjYqB12QCvdIruFcEXU6fswWMo2BQU
	accZrpq74wsWMs3kH3lQMEnTS2jwvop4BM4E0exxYEnAEoDlwqdZGTmQ/CkHwE8/8XJa34QMllq2S
	zA42U8zwSQb3QxwiHI+r9IuuBbuMCa4o5IwHLwqD4hnFYDH+Ux30WDAiv2snRgBsys6KMXD2HOUvK
	PSDeirzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFd88-00000008mLf-23pe;
	Mon, 25 Nov 2024 17:44:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFd85-00000008mKl-29oP
	for linux-um@lists.infradead.org;
	Mon, 25 Nov 2024 17:44:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732556647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i1zyTvm0SiQ2Og0Kpt6UMawusjwfmCj5SiNgpCOF4PA=;
	b=fPcFwinTAiZe/dWXQwl3sFi/j0pLCgIb+N2il78P7jnVoJ+eOJMMjJ/V7QwPr8rxrM9m2T
	TOp+NQA3Ob/HbgySOc+rbcl7uOELPm8dfzZNfmy6fp4dc936mNU9WRs3N6glzx1t1Ndmu6
	GW+mkJrcVs7MUW4B0kdoz/H58nNdhpg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-ADs_7fLGNtuo0lix5HnpqA-1; Mon,
 25 Nov 2024 12:44:02 -0500
X-MC-Unique: ADs_7fLGNtuo0lix5HnpqA-1
X-Mimecast-MFC-AGG-ID: ADs_7fLGNtuo0lix5HnpqA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C6D531955F3E;
	Mon, 25 Nov 2024 17:43:55 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.223])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 395981944CC9;
	Mon, 25 Nov 2024 17:43:52 +0000 (UTC)
Date: Mon, 25 Nov 2024 18:43:49 +0100
From: Karel Zak <kzak@redhat.com>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-um@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Benjamin Berg <benjamin@sipsolutions.net>, 
	Johannes Berg <johannes@sipsolutions.net>, rrs@debian.org
Subject: Re: UML mount failure with Linux 6.11
Message-ID: <ykwlncqgbsv7xilipxjs2xoxjpkdhss4gb5tssah7pjd76iqxf@o2vkkrjh2mgd>
References: <093e261c859cf20eecb04597dc3fd8f168402b5a.camel@debian.org>
 <3acd79d1111a845aed34ed283f278423d0015be3.camel@sipsolutions.net>
 <0ce95bbf-5e83-44a3-8d1a-b8c61141c0a7@huawei.com>
 <420d651a262e62a15d28d9b28a8dbc503fec5677.camel@sipsolutions.net>
 <f562158e-a113-4272-8be7-69b66a3ac343@huawei.com>
 <ac1b8ddd62ab22e6311ddba0c07c65b389a1c5df.camel@sipsolutions.net>
 <b0acfbdf-339b-4f7b-9fbd-8d864217366b@huawei.com>
 <buizu3navazyzdg23dsphmdi26iuf5mothe3l4ods4rbqwqfnh@rgnqbq7n4j4g>
 <9f56df34-68d4-4cb1-9b47-b8669b16ed28@huawei.com>
 <3d5e772c-7f13-4557-82ff-73e29a501466@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d5e772c-7f13-4557-82ff-73e29a501466@huawei.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241125_094409_623491_6A8FEBC6 
X-CRM114-Status: GOOD (  25.06  )
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

On Thu, Nov 21, 2024 at 09:53:06PM GMT, Hongbo Li wrote:
> > > The options has been always parsed by mount(8) and it's very fragile
> > > to assume that kernel get as in the original order (etc.).
> > > 
> > > For decades, commas have been supported in mount options. For example,
> > > SeLinux uses them frequently in context settings. All you need to do
> > > is use quotes, but be careful because the shell will strip them off.
> > > Therefore, double quoting is required.
> > > 
> > 
> > Thanks for your reply!
> > 
> > If I'm not mistaken, we should add double quoting explicitly if we need
> > commas in mount options. However, it seems different for hostfs. For
> > example, with hostfs, if we use "mount -t hostfs none -o
> > /home/hostfs,dir /mnt" in the older interface, which can successfully
> > mount the host directory `/home/hostfs,dir`, then we should use "mount
> > -t hostfs none -o '"/home/hostfs,dir"' /mnt" in the new interface. If
> > that is the case, we should change the mount command which is hardcoded
> > in the original project.
> Sorry for the disturbance. So am I right?

The old interface (mount(2)) sends all options together as one string.
This means that if mount(8)/libmount does not modify the string in an
unwanted way, then you are safe.

The new interface uses one fsconfig() call for each option, so parsing
is required to split the "-o string". This means that you will always
be affected by options separators interpretation. This is the reason
why I have suggested quoting.

I see a different issue (and I apologize for missing it in my previous
reply). mount(8) only supports quoting for named options, which means
using the format NAME="v,a,l,u,e". This is not expected if you do not
use NAME=, for example "/home/hostfs,dir".


I am not sure, but there may be another issue with your use-case. "-o
'/home/hostfs,dir'" means that "/home/hostfs,dir" will be used as the
key (variable name) in the fsconfig() syscall. I have doubts that it
is designed for long strings like paths. At first glance, kernel uses
only 256 bytes for the key (and since it is a variable without a
value, libmount will use it as FSCONFIG_SET_FLAG). 

Maybe Christian will know more details.

For now, my suggestion is to use the LIBMOUNT_FORCE_MOUNT2=always
environment variable to force mount(8) to use the classic mount(2)
syscall.

The long-term solution would be to clean up hostfs and use named
variables, such as "mount -t hostfs none -o 'path="/home/hostfs"'.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


