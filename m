Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1581C79F99
	for <linux-um@archiver.kernel.org>; Mon,  7 Sep 2026 22:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oxCw6MZUrUMQF3PxuLGYM79WzM4GNi956bvyl3WEJ2c=; b=nfdHMRI4Z2XQBMjwy3v9mfpUQ3
	rAJpo7OFqsfjo1Ysy5EF5CfT6GCshInDdCzMqYU5M3vztme9vmD+3bYjFRxRmic0t6u5buveW3fT0
	Xf1qlBeMj0Yt89jAH/qj22iWO+9DVSm/uwJ6If+BHlMATsd5XZPulbzPw2939a4wDa8bJR8X5lcjN
	7kZXDtZygLRdWf4Pi9TTOAuLVRm1ayMHRuFF10OYIgC1bfbLMGaGwH8qDHE24/SFXM/tokH8rtcoA
	yT+GupP2DNmhxA7IYbkDIqUnVNMs6xmv/b4xerkFu7YMd+UR1w9kTu/9bhjA19TAubnX+X79QmZRH
	1WMgBQ2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3hcZ-00000007o2p-1vXh;
	Mon, 07 Sep 2026 22:15:23 +0000
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3hcW-00000007o2S-1Dfv
	for linux-um@lists.infradead.org;
	Mon, 07 Sep 2026 22:15:22 +0000
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-498028b3d5eso37722805e9.1
        for <linux-um@lists.infradead.org>; Mon, 07 Sep 2026 15:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788819318; x=1789424118; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oxCw6MZUrUMQF3PxuLGYM79WzM4GNi956bvyl3WEJ2c=;
        b=EiFV2DpexINhFjCLPRU61ZXN662tZm8utMe6sDcFeZQ3kAXW/41V94O5vqDwJRExbH
         cRjd630IXZIun4JXDMOXZF4qo91u56sJkMzrhNvk4bVChMeCoyzQHkSBiOfVb+sn+ec5
         mPuffkPaSo0Lka/RKPEWt0qmkP9QKOPFv99mQhwNqpkt+/EkkR34H3gxnfJ1XxmqhqV2
         gb+1hccTp5z9CaMJiXciD5d2t5gff8xCZ2RdQlLOinDagdy0a0GWJhQvUhzi2vd1bBFg
         7Ezb3itOzxipvUACkg2x5SHxDHiLfpNu9LTLnIyvQVpY+avBZzca6yRGM48ZWuAL/ef3
         rysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788819318; x=1789424118;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oxCw6MZUrUMQF3PxuLGYM79WzM4GNi956bvyl3WEJ2c=;
        b=NbqXO0MOqhI8olmrNYTf7LQoPnZ69JV0wBatHTPQg5FAOw/SLlnjJWkNDC8rM6x9eN
         /5oIkSPnDs03ro0dZKocXJjddzIJjJZR0kbDsWGEtVXurs8Wn2Z/K1RdS4iWlCGruxXp
         22tGcD93V7GtsoayeMFOy40L6Fbnpy5VLi7mCS5caHWMO0bjFkjSbF+4UtFvra84szSl
         DMXebNRx2/hJwVJ7UoX3enN5sLQjlVmB85ZNXNZ3p3txzVnvsbwydyTm59gcoJ1UEmze
         mKXTRiFdlyY7b5Q9XcKeGiRbAmoIjuVdgTGNZylQB3ofAZOLwcIRbyuacReghT83ALRf
         87Bw==
X-Forwarded-Encrypted: i=1; AKwUvBwhLoQLSATKADD/FRntVVIifC28IHr8pKzFXvWTWh/I5mB65mlk/HYAnSv7dmz2JBL0i/sceGY47Q==@lists.infradead.org
X-Gm-Message-State: AFuF++mg494Kpg0RoW2SbHWvBK2H6ZcUskBaUqn3Smvi9K7rz1WaRN54
	ha1k875hpYUJLnZ+JQoxTwdI4JTttxXdNW6i1Pto7NWdvxTj6jgbgU2K
X-Gm-Gg: AYBFou2vyyzepOegIIP1Uowffb9Hv3Xvr2hEVflYCiKkBb1nlgLX9V1BGUqzdlpHij3
	7XyX2WBrlwE07CW80MpfyqW0rwq1d9ESCdSVkKkUzu9AdvQ4L/JUCt6DQjUPquLQhk1WhHqjawq
	PcUwW1HztMDdH592T/8erwNO/igvjlCgF6xo3UZ9r3RqDJ6TVaInkoWxMR82MHCL8Y/BdFBl9Z3
	Yu4FplvywJkWBUF7g0wAZkKK/CxWqHlsPYfw5dYDUXHL1meexIBLEO2CVRTcvIHkFwd5QTrXwqU
	BOpJ953X36K0tGECqlLkqOO4Qbpizh3ErLrK23e1xKWCvT5d+x93zZTyN0tJ/zB8xllX397Ioxn
	+Z2ly1GsqrHMYXxLMB1dcYTBhSPXtjRGOCpHYoBFsjta1y6ACZ2VQP+MUj6WxKsaBk9JeO0vz1H
	aqwb3EIkARTGng1GL9BnXBfu9a1KOmTsF0zer2z1MHqv0UY3NFGS6W7aS83EXdmMG36X+Ju7IV1
	bysk3fzXuuZuJYUCPoUys+8v9LXum9IopwBay15U/++nEJUdneQD+hf7Y9GeFO1lpiSVcBW59HC
	tzkJQ1Pb1e1SFKu9oN0E4PSdRQlQf2M8PA9zTEmUEb0q9H+ArpV10WuRCRXu1yXfansa5Cg/o4T
	C
X-Received: by 2002:a05:600c:8012:b0:49c:d818:8764 with SMTP id 5b1f17b1804b1-49cf826818dmr259779075e9.11.1788819318162;
        Mon, 07 Sep 2026 15:15:18 -0700 (PDT)
Received: from MacBook-Pro-von-Karl (dynamic-2a02-3100-b0c9-3601-cdce-ba4b-d0e3-dede.310.pool.telefonica.de. [2a02:3100:b0c9:3601:cdce:ba4b:d0e3:dede])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48588394fa1sm29993570f8f.8.2026.09.07.15.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 15:15:17 -0700 (PDT)
Date: Tue, 8 Sep 2026 00:15:14 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowangio@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rusty Russell <rusty@rustcorp.com.au>, 
	Pawel Moll <pawel.moll@arm.com>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Hans de Goede <hansg@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Vadim Pasternak <vadimp@nvidia.com>, 
	Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	virtualization@lists.linux.dev, linux-input@vger.kernel.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, linux-um@lists.infradead.org, 
	platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] virtio_input: stop callbacks before unregistering
 input device
Message-ID: <ap82pFlX8enNG0gZ@gmail.com>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
 <20260905152059.89560-3-kmehltretter@gmail.com>
 <20260907174559-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907174559-mutt-send-email-mst@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260907_151521_239470_CE23213B 
X-CRM114-Status: UNSURE (   8.80  )
X-CRM114-Notice: Please train this message.
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

On Mon, Sep 07, 2026 at 05:46:07PM +0100, Michael S. Tsirkin wrote:
> > Assisted-by: LLM
> 
> which llm and which agent?
> 

Claude Code and OpenAI Codex, each with their current models.

I switch between them and let one do review, the other
helps with implementation.

"Assisted-by: LLM" is the form Documentation/process/coding-assistants.rst
gives now.

Thanks,
Karl

