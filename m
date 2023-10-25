Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB63C0032E
	for <linux-um@archiver.kernel.org>; Wed, 25 Oct 2023 20:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+mrf4afshksFohsKnMlMpXZLe+Y0l7OWEiqoAg2X4LI=; b=A3hfrjhc14qnYr
	KltNIfSx5AGfzhkoKgj0s0t/weBBq2wDgceQTYViqeCug4GK07yjcnEjl6t/QnVDIArRiUJfL0yX6
	IbxmIlPLdhxcROiL7dN78PerHHQrKu9/380pyoNNQpeIVdqVll4HWX+LiPm/uUtmvoRQKP9Yxgs5s
	ryGfuvbz+t8mDSgXY6doJXc/wcqGn/tbU/1bBqCAM7XCEkkV+uOXcavagPzis7P6el6D3xhNnXcXc
	myUaYMdSUihodpff3SjVTiFxCQt9pu/jaEkKfDf3ETlxgeKGYharA5pcEZIwL4Niku3ZMcXPYNF5f
	hQyE+KcX9/FyQ/HoC0jA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvk5P-00D0Q5-2R;
	Wed, 25 Oct 2023 20:02:39 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvk5N-00D0NJ-1A
	for linux-um@lists.infradead.org;
	Wed, 25 Oct 2023 20:02:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=djw/RRwrhOxPrgNjShiS6oN+TeWC1Dv3drvGlxrWCb0=;
	t=1698264157; x=1699473757; b=SlfArgRyZWQBTEg4hcaxsS/v9ZJFFsZE8IKXqk212vAR+RR
	WMiU6uoyAKaVj7ns0sOcKmNmQLHgMNOJoZzG5U0flbdFbjjfJnRclPEpnu+NVo7kxwl4esr8+BZrY
	9/6jQr8VvAf/s4e2nd2o9Br1n4nl8JOJtip7ARsEfyBLFyJs8AVC6csxdnQ7K/Cr7qJ4zZ1D9xQx9
	FCcyn9MqWHRuUU/77HEw06SUsVtF/R0co3LFAU0g9FsjHY3HQXH0ewtTWvtIxxTxC+oqRePol4TcO
	D0mjNB8Q9h40m5zvHdP4vfYmvrDFuwGHtBahIStIQv5r3nftBHNlEtm0nioUp4hw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qvk5K-00000002hhp-36fu;
	Wed, 25 Oct 2023 22:02:34 +0200
Message-ID: <68b18065d8be905c25522bd3f5a9b46dbe3a976d.camel@sipsolutions.net>
Subject: Re: [PATCH] um: time-travel: fix time going backwards
From: Johannes Berg <johannes@sipsolutions.net>
To: Vincent Whitchurch <Vincent.Whitchurch@axis.com>, 
	"anton.ivanov@cambridgegreys.com"
	 <anton.ivanov@cambridgegreys.com>, "richard@nod.at" <richard@nod.at>
Cc: "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, kernel <kernel@axis.com>
Date: Wed, 25 Oct 2023 22:02:33 +0200
In-Reply-To: <a2f6e0cc8e498f72dfe1fcd5f2233ada8548a4d1.camel@sipsolutions.net>
References: <20231020-uml-time-backwards-v1-1-90b776fc6dfd@axis.com>
	 <4a75c40636be267163dc30b5a6a2442089628e57.camel@axis.com>
	 <4dbed8896c94a347dcb58b3a83792c52fdc1c04a.camel@sipsolutions.net>
	 <cc7d340e4e06e42cd67b46bfa95da6129b0010cb.camel@axis.com>
	 <a2f6e0cc8e498f72dfe1fcd5f2233ada8548a4d1.camel@sipsolutions.net>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231025_130237_397280_9EF9BCC8 
X-CRM114-Status: GOOD (  11.29  )
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

On Wed, 2023-10-25 at 21:51 +0200, Johannes Berg wrote:
> On Wed, 2023-10-25 at 11:55 +0000, Vincent Whitchurch wrote:
> > On Mon, 2023-10-23 at 09:33 +0200, Johannes Berg wrote:
> > > Do you have a specific workload that tends to reproduce this?
> > 
> > I've been seeing it when running roadtest, but it's easily reproducible
> > without that by using the attached config and the following program as
> > init.
> > 
> >   cp repro.config .config
> >   make ARCH=um olddefconfig all
> >   gcc -Wall -static -o repro repro.c
> >   ./linux time-travel init=$PWD/repro rootfstype=hostfs

Ohhh.

Pure "time-travel" is actually something I hardly think about these
days, we mostly use time-travel=inf-cpu (or =ext).

That makes sense, here you actually *can* get interrupted. I'll need to
dig into what happens though.

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
