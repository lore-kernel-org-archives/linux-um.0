Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5BBDD6ACC0
	for <linux-um@archiver.kernel.org>; Wed, 27 Nov 2024 12:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5XuurAi60ovgVG4u4UNaWnG8aq075t+aiuMPD1bhYEI=; b=es/o7FolYz/ggP0at2amkax4qJ
	HyntBq6P1iWc2uE0lRVhvs5Py5q0elXbaQq7ddij6Txrw5DJpDXqGACTWau05ilPMNt+5uKYeYNbU
	taUDcac8ZclSTtgoLkQUKmu/VOO6LrbpbJGLfpgOmmCYWuzfT10ypStOGasfX0+RMxh8nlkISJyG5
	+OMPyzE5JoJor+ypzCmnh8OBuQG1AsNqhEr3c7QEuJIAwB51uj8/DMCCziGYZtpL/EcxtgAR63X4Z
	F3BQVMXNng+0gOa+/Hodw15OwiTzzKvhbOGG5isBCL2k58+dhxAu6s2NgVLBdvubzoLxHdbygZGUX
	gKsjL9WQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGGl6-0000000D58K-1KwX;
	Wed, 27 Nov 2024 12:03:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGGl4-0000000D56B-0l4m
	for linux-um@lists.infradead.org;
	Wed, 27 Nov 2024 12:03:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732708981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5XuurAi60ovgVG4u4UNaWnG8aq075t+aiuMPD1bhYEI=;
	b=Zoa4Aonk8OWYttowdvVGwtYsTp0owaKWNw5oia6Vtfw4U9NjPhIPGss/ewcuHT4PGWpebp
	kgAzkNHKjNuf1uoRhLLVj2SdPwuOqS2hZfEmJrjMjLfQ90zUrJz5k4BrKU0xYQiGfMZDDE
	VqR3SsA7hp3zzOi6Yc6k0ZkjNISl42c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-nOj8QUA_NWaMT_4AY99rkw-1; Wed,
 27 Nov 2024 07:02:57 -0500
X-MC-Unique: nOj8QUA_NWaMT_4AY99rkw-1
X-Mimecast-MFC-AGG-ID: nOj8QUA_NWaMT_4AY99rkw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E96EA195604F;
	Wed, 27 Nov 2024 12:02:55 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.12])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 98A94300019E;
	Wed, 27 Nov 2024 12:02:53 +0000 (UTC)
Date: Wed, 27 Nov 2024 13:02:50 +0100
From: Karel Zak <kzak@redhat.com>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, 
	linux-um@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Benjamin Berg <benjamin@sipsolutions.net>, rrs@debian.org
Subject: Re: UML mount failure with Linux 6.11
Message-ID: <uppzc2p5bn6fhrdlzzkbdrkoigurkii5ockigngknm4waewl5z@z2a6c6iivu7s>
References: <420d651a262e62a15d28d9b28a8dbc503fec5677.camel@sipsolutions.net>
 <f562158e-a113-4272-8be7-69b66a3ac343@huawei.com>
 <ac1b8ddd62ab22e6311ddba0c07c65b389a1c5df.camel@sipsolutions.net>
 <b0acfbdf-339b-4f7b-9fbd-8d864217366b@huawei.com>
 <buizu3navazyzdg23dsphmdi26iuf5mothe3l4ods4rbqwqfnh@rgnqbq7n4j4g>
 <9f56df34-68d4-4cb1-9b47-b8669b16ed28@huawei.com>
 <3d5e772c-7f13-4557-82ff-73e29a501466@huawei.com>
 <ykwlncqgbsv7xilipxjs2xoxjpkdhss4gb5tssah7pjd76iqxf@o2vkkrjh2mgd>
 <6e6ccc76005d8c53370d8bdcb0e520e10b2b7193.camel@sipsolutions.net>
 <5e5e465e-0380-4fbf-915d-69be5a8e0b65@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e5e465e-0380-4fbf-915d-69be5a8e0b65@huawei.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241127_040302_308650_2B83FC27 
X-CRM114-Status: GOOD (  20.14  )
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

On Wed, Nov 27, 2024 at 09:26:46AM GMT, Hongbo Li wrote:
> 
> 
> On 2024/11/26 21:50, Johannes Berg wrote:
> > On Mon, 2024-11-25 at 18:43 +0100, Karel Zak wrote:
> > > 
> > > The long-term solution would be to clean up hostfs and use named
> > > variables, such as "mount -t hostfs none -o 'path="/home/hostfs"'.
> > 
> > That's what Hongbo's commit *did*, afaict, but it is a regression.
> > 
> > Now most of the regression is that with fsconfig() call it was no longer
> > possible to specify a bare folder, and then we got discussing what
> > happens if the folder name actually contains a comma...
> > 
> > But this is still a regression, so we need to figure out what to do
> > short term?
> > 
> So for short term, even long term, can we consider handling the hostfs
> situation specially within libmount?

Yes (see reply to Johannes ).

> Such as treat the whole option as one
> key(also may be with comma, even with equal)

There could be userspace specific options, VFS flags, etc.

  -o /home/hostfs,ro,noexec

Is it one path or path and two options?

> in this case, libmount will
> use it as FSCONFIG_SET_FLAG. We can do that because for hostfs, it only has
> one mount option, and no need for extension.

We can automatically add a key (e.g. hostfs=) and use FSCONFIG_SET_FLAG.
The goal should be to get the path as a value, because key is limited to
256 bytes.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


