Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9ADBD6ACC0
	for <linux-um@archiver.kernel.org>; Wed, 27 Nov 2024 11:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EAuGY7uo2VzmKZwEMUSolagvh7kfqhqchgraIgCqyKk=; b=euyHn/G2481itJ7GpilrSvVW+h
	g0UUdq/dbWPpkyigct2+aLMkmOo0SANTQepUTg2AwjW6xksWJHFFFXx4rs3RFNaIIjwLxAWbvdc03
	2bNyHOpRSRXY9S47Cj7hhV5dnz2DcCRMADUBGc+ZSA34NTs/im0UUYYbdNvX1bbzEP7p00m7rGWNz
	wsYSpxysTKNpsJAa3UJAfbiFtsny++YSxsYMZjKwrAtQInLz/4jy6mYEBZigry4txaNV0a4Fb05Qj
	b9YfjpwNyBD4287iDjwziz7+B9pp39RzcHDyilL9V7vSHV0UqhdP3bEp+1mLX6OXuAq9pqCQ+Guik
	mFysNY/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGGeH-0000000D4Hm-2LlH;
	Wed, 27 Nov 2024 11:56:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGGeF-0000000D4Gl-0OiZ
	for linux-um@lists.infradead.org;
	Wed, 27 Nov 2024 11:56:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732708557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EAuGY7uo2VzmKZwEMUSolagvh7kfqhqchgraIgCqyKk=;
	b=b2R4VYZhvRhzdlMCn8Nd+BnqifvNjdTBGDKFMxHCemeUjN6NqdMgfVlYLVONc+XqgjQ8kD
	djT7GMAgEjyLGokd69Klj304GYagV9NysgoXt71YQ4Rz23QjY6f/8VL62GkBMJ1IrQHxmu
	etHDuv3+FHuN1NggVgfDdB9FFQJEqJo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-IvGzQ0E8Nua4bG8MX5F6qA-1; Wed,
 27 Nov 2024 06:55:55 -0500
X-MC-Unique: IvGzQ0E8Nua4bG8MX5F6qA-1
X-Mimecast-MFC-AGG-ID: IvGzQ0E8Nua4bG8MX5F6qA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C0B9B19560BD;
	Wed, 27 Nov 2024 11:55:53 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.12])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 194B11956086;
	Wed, 27 Nov 2024 11:55:50 +0000 (UTC)
Date: Wed, 27 Nov 2024 12:55:47 +0100
From: Karel Zak <kzak@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Hongbo Li <lihongbo22@huawei.com>, linux-um@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Benjamin Berg <benjamin@sipsolutions.net>, rrs@debian.org
Subject: Re: UML mount failure with Linux 6.11
Message-ID: <dywzjfeburew25fitcwspay7i4ckynhehpuvtmsi2k6b4ip7wd@xfcbztze47q6>
References: <0ce95bbf-5e83-44a3-8d1a-b8c61141c0a7@huawei.com>
 <420d651a262e62a15d28d9b28a8dbc503fec5677.camel@sipsolutions.net>
 <f562158e-a113-4272-8be7-69b66a3ac343@huawei.com>
 <ac1b8ddd62ab22e6311ddba0c07c65b389a1c5df.camel@sipsolutions.net>
 <b0acfbdf-339b-4f7b-9fbd-8d864217366b@huawei.com>
 <buizu3navazyzdg23dsphmdi26iuf5mothe3l4ods4rbqwqfnh@rgnqbq7n4j4g>
 <9f56df34-68d4-4cb1-9b47-b8669b16ed28@huawei.com>
 <3d5e772c-7f13-4557-82ff-73e29a501466@huawei.com>
 <ykwlncqgbsv7xilipxjs2xoxjpkdhss4gb5tssah7pjd76iqxf@o2vkkrjh2mgd>
 <6e6ccc76005d8c53370d8bdcb0e520e10b2b7193.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e6ccc76005d8c53370d8bdcb0e520e10b2b7193.camel@sipsolutions.net>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241127_035559_204639_7A2446C1 
X-CRM114-Status: GOOD (  26.59  )
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

On Tue, Nov 26, 2024 at 02:50:38PM GMT, Johannes Berg wrote:
> On Mon, 2024-11-25 at 18:43 +0100, Karel Zak wrote:
> > 
> > The long-term solution would be to clean up hostfs and use named
> > variables, such as "mount -t hostfs none -o 'path="/home/hostfs"'.
> 
> That's what Hongbo's commit *did*, afaict, but it is a regression.
> 
> Now most of the regression is that with fsconfig() call it was no longer
> possible to specify a bare folder, and then we got discussing what
> happens if the folder name actually contains a comma...
> 
> But this is still a regression, so we need to figure out what to do
> short term?

I will add support for quotes for unnamed options, so that
"/home/hostfs,dir" will be treated as a single option for libmount.

I am unsure how to resolve this issue without using quotes, as we need
a method to distinguish between a path with a comma and other options.

> Ignoring the "path with comma" issue, because we can't even fix that in
> the kernel given what you describe changed in userspace, we can probably
> only
> 
>  1) revert the hostfs conversion to the new API, or
>  2) somehow not require the hostfs= key?

The hostfs= key is likely the most reliable method to use fsconfig().
The goal should be to get from userspace:

    fsconfig(fs, FSCONFIG_SET_STRING, "hostfs", "/home/hostfs,dir");

I can add a temporary workaround to libmount for hostfs, which will
automatically add the hostfs= key for unnamed paths. This will allow
you to receive the expected fsconfig() data from userspace.

If we will go this way, then it would be nice to update hostfs docs to
motivate users to use hostfs="" in configuration, and I will probably
add later a warning to mount(8) to force users to use hostfs="" key.

Does it make sense?

> Fixing the regression fully (including for paths containing commas)
> probably also requires userspace changes. If you don't want to make
> those we can only point to your workarounds instead, since we can't do
> anything on the kernel side.

I am open to temporary FS-specific libmount workarounds, but I would
like to see a long-term solution and plan on how to encourage users to
use it.

> I don't know the fsconfig() API, is it possible to have key-less or
> value-less calls? What does happen 

The key is always required; otherwise, you will receive an -EINVAL error.
https://github.com/torvalds/linux/blob/master/fs/fsopen.c#L369

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


