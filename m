Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13BA4C79F99
	for <linux-um@archiver.kernel.org>; Mon,  7 Sep 2026 22:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=doPvstU0jM+pOnprTuHLt3cRtMawGYtbfNsIMqB0F1s=; b=DOYdWigxEgHkRXm2zZhVrSr5JJ
	sKoUHVWOUcNJpfwAbGKLsKTRCa2A/FHIBPQ3SwC5J1BOkx6rp5FY/E7HJaqayuGhdMrrh4GG51eOo
	KWP8oiApgoX9kqMNYvOZLB6+CcRr99XVTBvxtvE63mG1s28BENtdXF3GfIygOE6I7aeC3FRp3X4Wt
	0y22a28WijiyNaZRw666d8R7dgOrwvd6pR8GHaaQpMxSUE6nN0pgyq0mMbZb4+QEk3VbU9LQ5kET0
	Yso5R/yqzJcbRzNuf1p4eHnZJyeq541MBB+FxxQ/2s35AP0EJCFmU6ZyweljB6eQYs8bQK7uueISo
	qGRUmVtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3hjK-00000007oCo-0dC8;
	Mon, 07 Sep 2026 22:22:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3hjH-00000007oCT-2APq
	for linux-um@lists.infradead.org;
	Mon, 07 Sep 2026 22:22:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788819738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=doPvstU0jM+pOnprTuHLt3cRtMawGYtbfNsIMqB0F1s=;
	b=RunJ71fr2IxVMo/9E1aqsBMn8eYWGidYJT16ZpiZUXmtqOzeE0YiLqOhY+cJSHkZ2AfObL
	qEjm6AQPaMyVg8v5QUceAam9dA78xo3WKfJ5cmoRO/99D5u4GQXYR7mX0yLSBrPMUuJiqG
	gR+TWM9FYjCfcG0WSV0T1eKLMs+fOn4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-rulU_Yg6PEOzgQgCX8_QEA-1; Mon, 07 Sep 2026 18:22:16 -0400
X-MC-Unique: rulU_Yg6PEOzgQgCX8_QEA-1
X-Mimecast-MFC-AGG-ID: rulU_Yg6PEOzgQgCX8_QEA_1788819735
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49554715277so38813075e9.1
        for <linux-um@lists.infradead.org>; Mon, 07 Sep 2026 15:22:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788819735; x=1789424535;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=doPvstU0jM+pOnprTuHLt3cRtMawGYtbfNsIMqB0F1s=;
        b=Fe9iXSGfPST0ocj5naABH5bDn4u+r8MFbtZOJSvc3SbfAkqAa5TCHiiYwgaTE4MD39
         2zirlMp78ASeLAbkHQW4/Qr1r9/OmQao/7TKPrMD1vhy9K/kSTxsDdLPUbmvmtO5IX0T
         D3CoHnYv5/BygF3ht5zOxPcxgufHs2YvAhUydciTATpD7r+4SW0b5eZPLMyerG1reNNL
         o4fMWf4f8WeMxD8Wo9t/9gg4heCZsbtiOA/Lsm9p6pK370JqVGr6D7NvZMT1wD2GkD/R
         zIlYRJ4j9Qbt2FXaI8k0Aq/pFm7KYxHkDhOItWV1rvNeelqr5YEIx7FauOiaTzjcxExK
         /80A==
X-Forwarded-Encrypted: i=1; AKwUvBxXWeaL3xOBPnDhfw0/FqfU0VKkceR8An7EWz12qpcmgX0DuB15nr+Ut2424mkeZj4HPE3T5zw8/g==@lists.infradead.org
X-Gm-Message-State: AFuF++mg0Ah+c87z7qLQcGUCwcgyaNQ5xCf0Jpb+5Zdgw2Uh1SRxDkni
	FljdX2ot+y7aGqN6SkOIzbDiendMZnRpx/SFxnOIhf+U+/DoYG1mFqBFZT9k8JXeCekLUF3vv5P
	aWX3gsrfaRyXk7ZdD2ZkRz+36YtoDLyxM/+kMYM+Fe07RBCryh6FvG4uGtSCzLoKnxg==
X-Gm-Gg: AYBFou0HAOGBSXLCs4WdrbwMyYz05Trc+nUZxxfbiRM9xppviQCSU6RCIIph9nIq/Ax
	JTWJAbpDeUsyiNaN0UHRspzRgpjRtxxKT1tPRPlMbWGihG9oOHDwwmE6B38AJOkjq898Awu+V0n
	zGL6v0fVEY59UceIP1Z3iMFAFqLPWjtXqkdbmlE0cnrsPHFp+aqaIvA+MxdDMMZZ4C8dtX1LDyY
	W5+bZdBvT2iluCctkFBsCVawfuRMMpVPoRw2H1JycbbQiMMhAoNraxEZTZ+LNxtw6GOk1ivhpFh
	nCx3FpK423QUtHlgMyDutiwoXjIdjlHwQyynRDhlQzX+cOFdzGZnPe3vsMnA/A93+dA=
X-Received: by 2002:a05:600c:8715:b0:49d:17d4:aff2 with SMTP id 5b1f17b1804b1-49d17d4b01dmr47086915e9.1.1788819734852;
        Mon, 07 Sep 2026 15:22:14 -0700 (PDT)
X-Received: by 2002:a05:600c:8715:b0:49d:17d4:aff2 with SMTP id 5b1f17b1804b1-49d17d4b01dmr47086385e9.1.1788819734435;
        Mon, 07 Sep 2026 15:22:14 -0700 (PDT)
Received: from redhat.com ([187.15.128.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4859162f354sm24030241f8f.20.2026.09.07.15.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 15:22:13 -0700 (PDT)
Date: Mon, 7 Sep 2026 18:22:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Jason Wang <jasowangio@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pawel Moll <pawel.moll@arm.com>, Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	virtualization@lists.linux.dev, linux-input@vger.kernel.org,
	linux-s390@vger.kernel.org, kvm@vger.kernel.org,
	linux-um@lists.infradead.org, platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] virtio_input: stop callbacks before unregistering
 input device
Message-ID: <20260907182153-mutt-send-email-mst@kernel.org>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
 <20260905152059.89560-3-kmehltretter@gmail.com>
 <20260907174559-mutt-send-email-mst@kernel.org>
 <ap82pFlX8enNG0gZ@gmail.com>
MIME-Version: 1.0
In-Reply-To: <ap82pFlX8enNG0gZ@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Xc_7L_Iv2MbOpmRZcR4MffbjUimbgY4zlmo94OD9EMU_1788819735
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260907_152219_653864_12706AE0 
X-CRM114-Status: GOOD (  12.36  )
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

On Tue, Sep 08, 2026 at 12:15:14AM +0200, Karl Mehltretter wrote:
> On Mon, Sep 07, 2026 at 05:46:07PM +0100, Michael S. Tsirkin wrote:
> > > Assisted-by: LLM
> > 
> > which llm and which agent?
> > 
> 
> Claude Code and OpenAI Codex, each with their current models.
> 
> I switch between them and let one do review, the other
> helps with implementation.
> 
> "Assisted-by: LLM" is the form Documentation/process/coding-assistants.rst
> gives now.
> 
> Thanks,
> Karl

really? not what i see. in which version?


