Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6BF7C79F99
	for <linux-um@archiver.kernel.org>; Mon,  7 Sep 2026 22:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mnujOlryOcOB2B/LvIPxTaLmbwXh/kZV9FXNR3oxSFM=; b=iHCU4jAcSKC54LFxwd9fHbTeUd
	NbAsJAYPdVDU0nTwlNiwqmzGcLB5T1eSfsJPiq+D7GPawrSd8voUBOo3FGNzWOWebDaarYaiWsBcG
	Xryk9DYqCCzSF4+syye+6EOIpk5/VR0aZxlvBrDmFIIUFHhKj1TTwOCv39vuRTKW8E9ahUz4PgyUN
	shobD3Qxr/qCo2PeMmXmy9tAfEe5QMRl/uvHrUyVDlmReCJvXY0rAZ65yNCFqNcXw+dE4fpetIl3y
	Me7hjpZXrsAZOwE9QcK97Y6+WN2DYwp8wMU28k2H+iCEZi7AVGLLZJuyP9jYvwHnVpdIyEGaD+PQ7
	WgQ8jbCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3htc-00000007ojV-1STg;
	Mon, 07 Sep 2026 22:33:00 +0000
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3htY-00000007ojB-2ddw
	for linux-um@lists.infradead.org;
	Mon, 07 Sep 2026 22:32:58 +0000
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-499ae1c6471so38885255e9.3
        for <linux-um@lists.infradead.org>; Mon, 07 Sep 2026 15:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788820374; x=1789425174; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mnujOlryOcOB2B/LvIPxTaLmbwXh/kZV9FXNR3oxSFM=;
        b=FOnq5BcNbzqRZ6GKB8GSzWIl6OdkVnQhk0aohF+NgvBHaYRnLJT9VPoLQdg5r4gHaE
         LS1/QD9gO/2t5ghcbHh8zbyumwDRlM+V8ys2y6bWoWDND8Qnz8mME51+lFtYf2/Euf46
         NaE68LQECl7ReNtNtfefBe/iDXQix0IxddxtzakdeDjSPDyZwrlQ3anXJBx9wwAKbXhq
         Dwz3UThW6ivGiR/BYhD9ToyTyTlAR3TKFlxHYRd1eDA5A6cEIfc924aF/NLpboqXEHiD
         bzexT4/B80qJnDbs6or9u3jEGgzfcdM0Djqp9lyvff6SLd5gy0O6qKhrHRKN4hR8xm6k
         c3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788820374; x=1789425174;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mnujOlryOcOB2B/LvIPxTaLmbwXh/kZV9FXNR3oxSFM=;
        b=KriJwYHqFwFUCmn57oqaWIq059uekOTle17ggkdl6CYniFEADjJKD3x2iWysyjaOOY
         v+OXZSwqOVe1Ue9CgSYsnOupnLDY8ioncc02hpDrO1ETW160KRUjeNl2V6l86iOhBJDE
         iM2lJXaLMQGrmoxwa1Q+KuVjG+mAoExjYiY9pyWSY8252shVtGtSp2RHhjHVQsl3GvOQ
         WD2a6c6Aeeadg3eGO+ofA5JIyIVtIC+TG7Jzwx2kITJXGiWzTxvX77UqMMr+kv/4//F4
         4wECykrtVeeHhQkTV9pvbF9ZG94O3fafZzbK8iTWLxHHZmm2DUtGuq9SNO6pBuzj7ofD
         fM/w==
X-Forwarded-Encrypted: i=1; AKwUvBzoz4WHw64QPTC9vuz3ZaiqiFn5YPMAt5t2tLCbuAJd++rkuJnBpNPpkFea3pqZV3tvj4TNlot4fw==@lists.infradead.org
X-Gm-Message-State: AFuF++k0imSUd+nb4I7FWZOPdiM3inFZfXiqI4TzJzQgAds2SXlaEMD/
	wp/WUumOTb3ArpwWHLEc6k/Im1IvkX8dsgkf0Ib74oeMtSaNeXl7RVfl
X-Gm-Gg: AYBFou1ixEcu4R2Tx9ufXLqL1igaKx6dacwOm5brq0wDaVrVSRdFxCA/QAVs4smcM51
	sGDg7X6CnUUsslpLdQxqcRB6C1uF/wbUkhrpY1VHH8eUzhBjP9lZpnMaOZJ33cbalz8pej/EX03
	8uJPxvaH2VB4ZZKXCgB9XB9y6IfmzBtceuv4a3JA0H7TGzUZTLa16N9q5JzKMJl5u5457ZhwxBv
	shBkmMf8TeQhLnGB1Yjhd17gnHKdH2SmR5MwvFIe+Gi7cPteTRn/FTP8ykR09lWAgiMQh+yk4ix
	4akxST9c29n6jnbkHCZzYM7x6UaeIyN2Z33NIyP+0CPHQ/9RfzasVSZHAX9CM8DVLA6n7YJ1tAK
	kHZ3wRF5Zkw8G5to1qTYX9njCIMEXBaHxyKNcATr//Hsy2SqiJwSVBZVO2iIkT8Y0rFWZJICz/V
	0Ufu9JuXInijAWJq3FXpZhsdk1lafPmqkH3IiHF3QIVJAffkCm3ChaJKe1GTAFnvUoUGfXQl1iU
	t2LTNW2s7Uyk7goiG9rQOHG3Vd4g59Xi2mgMVmROXQOioXft4sw5CLW4dK4LT3FOnjuxtucUkUu
	WlMEqHfQA6g7803VfLVMJd7BmrxPR0JhLE3AE1Rf11FF5tg/TfgTkB50W4s0mBAuVsGki0FI1O9
	/
X-Received: by 2002:a05:600c:a0a:b0:49c:e1f1:3dd5 with SMTP id 5b1f17b1804b1-49cf81e6cebmr448618745e9.4.1788820374459;
        Mon, 07 Sep 2026 15:32:54 -0700 (PDT)
Received: from MacBook-Pro-von-Karl (dynamic-2a02-3100-b0c9-3601-cdce-ba4b-d0e3-dede.310.pool.telefonica.de. [2a02:3100:b0c9:3601:cdce:ba4b:d0e3:dede])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce551bf7asm289518525e9.2.2026.09.07.15.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 15:32:53 -0700 (PDT)
Date: Tue, 8 Sep 2026 00:32:47 +0200
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
Message-ID: <ap87JrBAxjbPe_jX@gmail.com>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
 <20260905152059.89560-3-kmehltretter@gmail.com>
 <20260907174559-mutt-send-email-mst@kernel.org>
 <ap82pFlX8enNG0gZ@gmail.com>
 <20260907182153-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907182153-mutt-send-email-mst@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260907_153256_682313_52EBDF2C 
X-CRM114-Status: UNSURE (   9.34  )
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

On Mon, Sep 07, 2026 at 06:22:09PM +0100, Michael S. Tsirkin wrote:
> > 
> > "Assisted-by: LLM" is the form Documentation/process/coding-assistants.rst
> > gives now.
> > 
> 
> really? not what i see. in which version?

Since v7.3-rc1. Christian Brauner proposed the change here:

https://lore.kernel.org/r/20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org/

which became commit 816d9992d9ed

Thanks,
Karl

