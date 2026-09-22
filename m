Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26231C982FF
	for <linux-um@archiver.kernel.org>; Tue, 22 Sep 2026 08:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C95bRAv5IkFCsxK5LjzncGYLGpBLHTNK6JTZFhyWW0M=; b=1BgHDxfzFWDapDiSJCnryGHITz
	A/cJstkV4rNArbP4oSnuCnq0eTjr2BduxVaOhT8H5B+SGaj7LHAhFrO34DMUIk1UFiG7Za9IPbGfq
	u3QBtxtYV+fLfSacFr/MYXNiUfxo4MHhqyTJmFmYJivrbzlehhzYWvJMwpZl1nniQ+I8XM7XsGKng
	BulC9dHdFh8ytMNtigINmmR4+WUdIGcPJX2/X7Ws9Dvd/JGF/KrqT5YRagP0OoRH4tESPefdKSwqy
	ytQErna45ef3jREfBe/QwJE19pmMWWGe6uQx9D5Mq9mMN+QHTSyJo9AqfHex/4oj4uDV0x2bD8J/a
	FCs5IR6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8w9a-00000004kuV-1fwA;
	Tue, 22 Sep 2026 08:47:06 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8w9Z-00000004ktf-1BAY
	for linux-um@bombadil.infradead.org;
	Tue, 22 Sep 2026 08:47:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:In-Reply-To:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=C95bRAv5IkFCsxK5LjzncGYLGpBLHTNK6JTZFhyWW0M=; b=LEupw2b5OQhhLSBZZ44jo7fnpH
	6Jcuqc2YXIq5fSE+djKo1x4AaPka/CnuSRF/zusyWttbnC+/D5NUb480e3HCc0GWXaYPu+Z8Ukslb
	iboyX/9zB3gTvGFdORNfR3mRv9Cvzrjjei7F/3Etl9hvjMyVvCkdgGZVzxD+0oho00yrz6nR6WZ3X
	A/zUFvBJy8HJhNYPMXUlDwbAgzlnn7OS8yrmgDB168ZwuaIsl7iTpLWjNx9e7WGttNG8uNpFNF2UN
	pVRyAYaf/banVxAijD6DxN5BXMKK0+gCR1lXG6pDFqqQ4gFpHyjxh2VBopCASTHfrQ+7TcmFn6PyP
	7U28+JVA==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x8w9T-0000000DID1-2vqK
	for linux-um@lists.infradead.org;
	Tue, 22 Sep 2026 08:47:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790066816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C95bRAv5IkFCsxK5LjzncGYLGpBLHTNK6JTZFhyWW0M=;
	b=PPtBm7O5J9SD12HP/tRvqumwwKrb2GaMHrA1THD7uzs1uzeGdvT+YtVVEomkLiG+dmdnUl
	jMQ6cThAO/9QcQBExBWKDP0pkDcUHbQqp0Hx6aFCf7mea7dtzs7QripU8kfQdra1V5pEjx
	tDxHqO04AyNKNOpa7C07D8vut8NCW+o=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790066816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C95bRAv5IkFCsxK5LjzncGYLGpBLHTNK6JTZFhyWW0M=;
	b=PPtBm7O5J9SD12HP/tRvqumwwKrb2GaMHrA1THD7uzs1uzeGdvT+YtVVEomkLiG+dmdnUl
	jMQ6cThAO/9QcQBExBWKDP0pkDcUHbQqp0Hx6aFCf7mea7dtzs7QripU8kfQdra1V5pEjx
	tDxHqO04AyNKNOpa7C07D8vut8NCW+o=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790066816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C95bRAv5IkFCsxK5LjzncGYLGpBLHTNK6JTZFhyWW0M=;
	b=PPtBm7O5J9SD12HP/tRvqumwwKrb2GaMHrA1THD7uzs1uzeGdvT+YtVVEomkLiG+dmdnUl
	jMQ6cThAO/9QcQBExBWKDP0pkDcUHbQqp0Hx6aFCf7mea7dtzs7QripU8kfQdra1V5pEjx
	tDxHqO04AyNKNOpa7C07D8vut8NCW+o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-xG00lOfVPsePFzj7gmQdpQ-1; Tue, 22 Sep 2026 04:46:54 -0400
X-MC-Unique: xG00lOfVPsePFzj7gmQdpQ-1
X-Mimecast-MFC-AGG-ID: xG00lOfVPsePFzj7gmQdpQ_1790066813
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49e6c17ec1dso50113525e9.2
        for <linux-um@lists.infradead.org>; Tue, 22 Sep 2026 01:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790066813; x=1790671613;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C95bRAv5IkFCsxK5LjzncGYLGpBLHTNK6JTZFhyWW0M=;
        b=nhyLxgo9W7x/JJo4IJ2NQw/55+5N8xGenTibWHhg2ggEhSxsK+a9VujvvtZ3BTeeE2
         r++5eHY2ccVVdWwA/dGNcrXa0OQLFVJAWCk3M+I8ZMP/gbUq18PETWAmVs5Pn6M0JiRT
         k3aH/7Vk4aDqTHmDmw1/jLhqVLZH9H/+Kp3tIZEYrrCbhFtz2FQ/Nk5AEAjizc60PxFk
         DBJD4mgV8AD3ukQ9ppa9ZEOrz9yNK1xNoJrQF6FSJzptDPa84ShwdNmdUvonwdGp6vIu
         Kje4FXX3qSSYYxkopRmWreDYx54r2leTAi05otuYtH2LbH1Hd2JkZKxZiZR5Pk1BJj1/
         27HQ==
X-Forwarded-Encrypted: i=1; AKwUvBzo601t0TPZYB4CaUm6l1Lilekw/VfSKO+AEieWWbwvp63uBuKd3sONYEmIGkBCysVgNhFbI1tgxg==@lists.infradead.org
X-Gm-Message-State: AFuF++kDV+kSk2zL640oUe+PdP3Yigx3NJEaTrZOdY9jYfFiZPWGUhui
	uh24Vc4OJLCKnUTYS/Lf4Nv5C/mDAqQ4ASDqVwZeOakLBaCbEsfXFiwFPriPFTDLk68ouObmbfz
	A6McdIqKTdOyN9xj6HfmrM1Gc0+3OPwL/X2u8b1fL9+TD9ZX2GsRK/+VpA8IP2sLCEQ==
X-Gm-Gg: AYBFou3bwhaghfzTcDN2x+DDBvzJVectOEQ1cP3qpG1f8bA/1i/DZvcHo8rlm0YLfdg
	W6e4onSBCWd3ApZ4LcLat90xATNpqKKfMixFL/GuP2tZPy0Z/r6MwqphTKVI8prwztrRV7M1NOS
	HReDVlCIT+oKPFoa/4B1mOY4HDKqXXvwXfDYZe1k8ALTqqRIAtCsom0MOP7fSY6bPWPTp9lDG1E
	oQ6rFJE5HDowg/nhfVXWAXYN9/eHp6L/AIfHXQ/eHmEROqctxWr5mO/BXHR1icTnCCSUNlNFPx1
	KgJNI/nlKkQuxHaoDQqCWVsdNY9PfY45OTSEbD1H0kPOu5CxRTcMMLijW7YGboxjfeUn7wiu18b
	g551uQANk68LyDDwKe/KGg5Q=
X-Received: by 2002:a05:600c:19cd:b0:499:7a15:fcec with SMTP id 5b1f17b1804b1-49fc5695861mr190094765e9.13.1790066813163;
        Tue, 22 Sep 2026 01:46:53 -0700 (PDT)
X-Received: by 2002:a05:600c:19cd:b0:499:7a15:fcec with SMTP id 5b1f17b1804b1-49fc5695861mr190094445e9.13.1790066812661;
        Tue, 22 Sep 2026 01:46:52 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd8ccd185sm65246905e9.8.2026.09.22.01.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 01:46:52 -0700 (PDT)
Date: Tue, 22 Sep 2026 04:46:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Paulos Yibelo <habte.yibelo@gmail.com>, netdev@vger.kernel.org,
	richard@nod.at, anton.ivanov@cambridgegreys.com,
	willemdebruijn.kernel@gmail.com, jasowangio@gmail.com,
	eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
	andrew+netdev@lunn.ch, pablo@netfilter.org, fw@strlen.de,
	phil@nwl.cc, razor@blackwall.org, idosch@nvidia.com,
	dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	linux-um@lists.infradead.org, virtualization@lists.linux.dev,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	bridge@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v6 1/2] net: validate virtio checksum start after
 network header
Message-ID: <20260922044627-mutt-send-email-mst@kernel.org>
References: <20260922030310.8684-1-habte.yibelo@gmail.com>
 <20260922030310.8684-2-habte.yibelo@gmail.com>
 <20260922005353-mutt-send-email-mst@kernel.org>
 <aa560d2d2cbf94e50397740159c12e24e0ecf820.camel@sipsolutions.net>
MIME-Version: 1.0
In-Reply-To: <aa560d2d2cbf94e50397740159c12e24e0ecf820.camel@sipsolutions.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: anZXH03adItIY_Jj_O33xQOtER4B2gGK-m-5Gpq6xVk_1790066813
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_094700_023889_0003972A 
X-CRM114-Status: GOOD (  14.81  )
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

On Tue, Sep 22, 2026 at 07:56:23AM +0200, Johannes Berg wrote:
> On Tue, 2026-09-22 at 01:14 -0400, Michael S. Tsirkin wrote:
> > 
> > >  
> > > +/*
> > > + * Return the L3 offset and protocol of an Ethernet frame starting at skb->data.
> > > + * The offset is unused without NEEDS_CSUM, so avoid parsing and return zero.
> > > + */
> > 
> > for networking code multiline comments:
> > 
> > /* always
> >  * look like this
> >  */
> > 
> > /*
> >  * never
> >  * like this
> >  */
> 
> This, for the record, is't really true any more - we dropped the special
> rule a few years ago.
> 
> johannes

Oh good to know. thanks!


