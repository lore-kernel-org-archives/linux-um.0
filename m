Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D56C07545
	for <linux-um@archiver.kernel.org>; Wed, 25 Oct 2023 20:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BV8Hbda150urOvVHef1hty41/AMR85+HSsaBO6JtC1Y=; b=Clq7tlrMxvNYeU
	bHMzwW/5HyU8Sg92P1+p+DekpPzxw34vTSf8VRpY4d2a/O8rmX/AUAnJyuJpStTrGnOhuUmb8zRBN
	9bXgr65AYMuIIy+ZXEiQyOa2TfcyRi0g7UkgFCJ6GdZMkOx7PBbgMkysRvnxW64SyL4iAqM2Q8sJC
	ki5Gblb7rmAeZ1L49mo7CoodRRA0i5ZD1dHVJwwG8ba3vNY6FskX+RnAxkKEu/XS/MLkAtge5V/wO
	cH2HXHyv40gcUoOTm7MaMvyYQKYmUq5yL1dW3+y4t455ze+UWbgXJbloAgZ2cs7mefF/jipasTHJu
	n3gBaBSZWdHPih+0NQhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvkhD-00D6S5-3C;
	Wed, 25 Oct 2023 20:41:43 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvkhB-00D6R5-22
	for linux-um@lists.infradead.org;
	Wed, 25 Oct 2023 20:41:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=DsYdjSLqGrd7t0Y6Nn+QoZo/dHfV0hHOlcoK0gUrZCY=;
	t=1698266501; x=1699476101; b=kDmH0azXB7nUe1H+herAA2UDWRUX+ophhZx0B/qZI10fFcl
	wxbN4rU9CMGW1Hpmv/coN6eQtR2eiKvlYlAiTsALBvaCFQENHYfDoYz48iykvVoHeuOnisI66Xado
	6yzAyqYZ/vivLBftlk6bfPBNpTmF2yH++JyWGxiWWBLK3sXH0fmiwLQp3x/8Eb4JwKf/tsIpE1bDf
	BFO1gaQT1DqQ2pwmj+iSTc3j0cRiDBPz05tune3yGbmBd8ofJ8g/IKNceJzzEB2ZJ/EjKuSKCK3iE
	AYvf3vReJNU0uEko972I+WQorf7i+hEnX+r0+ClA4J8NB+ag3ftJqJ5gfB3bf0nQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qvkh9-00000002iVb-0Mrm;
	Wed, 25 Oct 2023 22:41:39 +0200
Message-ID: <1f38d92435cc4f3a5e8d17dff3da9e34be2e6f24.camel@sipsolutions.net>
Subject: Re: [PATCH] um: time-travel: fix time going backwards
From: Johannes Berg <johannes@sipsolutions.net>
To: Vincent Whitchurch <Vincent.Whitchurch@axis.com>, 
	"anton.ivanov@cambridgegreys.com"
	 <anton.ivanov@cambridgegreys.com>, "richard@nod.at" <richard@nod.at>
Cc: "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, kernel <kernel@axis.com>
Date: Wed, 25 Oct 2023 22:41:38 +0200
In-Reply-To: <68b18065d8be905c25522bd3f5a9b46dbe3a976d.camel@sipsolutions.net>
References: <20231020-uml-time-backwards-v1-1-90b776fc6dfd@axis.com>
	 <4a75c40636be267163dc30b5a6a2442089628e57.camel@axis.com>
	 <4dbed8896c94a347dcb58b3a83792c52fdc1c04a.camel@sipsolutions.net>
	 <cc7d340e4e06e42cd67b46bfa95da6129b0010cb.camel@axis.com>
	 <a2f6e0cc8e498f72dfe1fcd5f2233ada8548a4d1.camel@sipsolutions.net>
	 <68b18065d8be905c25522bd3f5a9b46dbe3a976d.camel@sipsolutions.net>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231025_134141_672304_69743262 
X-CRM114-Status: GOOD (  14.98  )
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

On Wed, 2023-10-25 at 22:02 +0200, Johannes Berg wrote:
> On Wed, 2023-10-25 at 21:51 +0200, Johannes Berg wrote:
> > On Wed, 2023-10-25 at 11:55 +0000, Vincent Whitchurch wrote:
> > > On Mon, 2023-10-23 at 09:33 +0200, Johannes Berg wrote:
> > > > Do you have a specific workload that tends to reproduce this?
> > > 
> > > I've been seeing it when running roadtest, but it's easily reproducible
> > > without that by using the attached config and the following program as
> > > init.
> > > 
> > >   cp repro.config .config
> > >   make ARCH=um olddefconfig all
> > >   gcc -Wall -static -o repro repro.c
> > >   ./linux time-travel init=$PWD/repro rootfstype=hostfs
> 
> Ohhh.
> 
> Pure "time-travel" is actually something I hardly think about these
> days, we mostly use time-travel=inf-cpu (or =ext).
> 
> That makes sense, here you actually *can* get interrupted. I'll need to
> dig into what happens though.

I just sent a patch, please take a look. It does seem to fix it - at
least I got bored of waiting after running your test program for a few
minutes :)

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
