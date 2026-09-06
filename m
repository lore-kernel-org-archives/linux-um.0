Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B3EC79F8C
	for <linux-um@archiver.kernel.org>; Sun,  6 Sep 2026 16:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oSMRVQ2ffl+GqdtcpJsergu6EJ70aiuLEE/q2zryERM=; b=z8rVmg2G1Mr49fxfYTA/BiNdW7
	nd/SxTeUg6gCpYqmCa3mG226+ONmOvN9D7isaB59oRXdiyko0B6Yx3j31+m+jnUKrbcYDXQLv2p+j
	rRZoXA7O8eMIQKeuvzgWFECfsf4NCf3UeH7aA9afnA2DOYEcnLWtQsvEZIr8je6TeJcXTd3i9nSk6
	uWCOj4jAPnwGwDMFlV5b8GyGiaLG83paUes/vweY4c/XLX6ds8nSWi1Ew05anablTi9cdhFg+/QBa
	jGs9doBK0sxF74n5ha2lRdNV+2ck6lcwpFB2Jp033iGncwtU+2zg0a6AJPW0UIx4qv15iFnMvibdf
	j0HxLUhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3FnV-00000005BGy-3e1z;
	Sun, 06 Sep 2026 16:32:49 +0000
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3FnS-00000005BGP-2Mrl
	for linux-um@lists.infradead.org;
	Sun, 06 Sep 2026 16:32:47 +0000
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-49cf4f81d86so20557005e9.2
        for <linux-um@lists.infradead.org>; Sun, 06 Sep 2026 09:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788712364; x=1789317164; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oSMRVQ2ffl+GqdtcpJsergu6EJ70aiuLEE/q2zryERM=;
        b=VrYU1e0aInt4XqUB47Y3TsS+ajhzg0KvhmrgrIlnCOjrlvwuCVFq856b4yGmv2tydo
         JG2IvhOaX2Tn7mDpQfWxLjm6WYl2sbhtfKvrZM0o6v166jLCnXpJkOqfawo8fjag3IJ2
         OD6Ddy7h8NDjFFFn1+QD4qZZ4zBkZnFXK9NBJq7A63v5zCyQREdzJzbfzr/vtQeeCwl/
         XehEQRLZya/i3hSu/ONd4upED2hteJjWhAxPYagnrMGL1FtAcwp7dYooQYaH55ltGlnQ
         BWcinP4KE4BWAnTORws7emqVNtSBeYxnncvUM3wELzsiyDFt383VzRU8F6Xh8TxbjcLt
         EZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788712364; x=1789317164;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oSMRVQ2ffl+GqdtcpJsergu6EJ70aiuLEE/q2zryERM=;
        b=LKCeCVocEE9Mp+dQ/6DB37H8QJwFgCeTfehLjfl+dRIcQuPhFdgkmYGCq3lHkwH7Q7
         g9KhDcfsAFqFpKNWfi/Bn75iSE+furXoL7SESg1jYN9Zn//Mcq97xeLltMsKEHM7Ohm1
         rT2wtBrIKwQo05xsvFTNPKc5hhpd/Fir2dTbcpTAd3x5gpGpm/CtdqLeqpUD8e97Mjus
         UeIdKDfny4afUKqMMZgqXBwOtkDvitr6Yw1UoXNNT1Zv0TrG/npejc9KRZsOhknkSaQ0
         zpJUnjO5mK1k9GetfezFBIOppEWL+rtjQCUnwxAD5Vf6UragADlO7oxdWhkrjdhUd2sD
         Veqw==
X-Forwarded-Encrypted: i=1; AKwUvBzdybNih25Np3zxROss1hz9/1kPWgMk/6YZNaUj2/GmPUNStNtK72FGZCGHSHWIsFdGRRvAp5htjg==@lists.infradead.org
X-Gm-Message-State: AFuF++lsRk2AITMqk1Uk+X9DJw5lqFV55DALBBDcOzIkP5hIPCNyXA+X
	QoR15dUFa2teFphsXLLcDe2EhhEA3DJifXkO7EEY3ZMGxPd1Oxc7rxpU
X-Gm-Gg: AYBFou3j7BuSCAxhl/Hu4xSgsb3SkE26My/1IxS0LMZaHJ9RydD3CnNhH5Uj91PLC3z
	8MVoknifPHzSWAr7lE1v3Civ8JplNatxvHKnLcq5g+XzSFlkmDiRPidAmK/dowx4/cViNk8Rj+u
	mLvswJr8Edl7Wc5rePlk724DkziJon4WYQr9MnaHiYhDbfAfOrspFwzaCd9Wf2+o/fu5PF7g/rt
	3VZrJKsgsjh8hNad5iYwnSTZluLzDW0P0WkQwVGqs/kpmYAzNANL5m6dXspLRx0aFyGGHn71mhK
	Ah5S4xcDYiyjjLaWijhihOglmVR7urgTlT1CM5k+ivxZDWOEDkN0awu7hJMWLytneuKYfrf8GnU
	nVgSivIJhMDOv1RWvLCJWWTjtOo4HBU1FjwSsw/fa+FOx1Fya0KOgipMm62HSsGwoTHCchjLzZm
	qKdNGLfZcUU8BQ1QZblp0g9i6J0CW82ZVIoF/G1Ksb3Iqfhr3qBHsqe17bh2sfk0bFio6JRCXs6
	OHZIDRcd4ZcjlVeHSYAKpbxGfkhZKeI02R+NmTsrj7YCKTe//FTKTHqDExROpO+AmOAfzT1pt1Z
	mw8gh0AbVaDOOB0E/hhuajbRmM9rWFcfTTh/yofUusAIEHbUvYO1AJNQ4jUIu38Y92zAmHKt9wq
	k3MNP
X-Received: by 2002:a05:600c:8b04:b0:49c:fc6c:be11 with SMTP id 5b1f17b1804b1-49cfc6cc0c3mr138648845e9.23.1788712363826;
        Sun, 06 Sep 2026 09:32:43 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-9d84-5101-9c80-d25b-14b6-410c.310.pool.telefonica.de. [2a02:3100:9d84:5101:9c80:d25b:14b6:410c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48588394fa1sm21761428f8f.8.2026.09.06.09.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 09:32:43 -0700 (PDT)
Date: Sun, 6 Sep 2026 18:32:40 +0200
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
Subject: Re: [PATCH v2 0/3] virtio: synchronize callbacks during device reset
Message-ID: <ap2VJkoIsBbsqcNm@gmail.com>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
 <20260906025249-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260906025249-mutt-send-email-mst@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260906_093246_617453_74D9F3DA 
X-CRM114-Status: UNSURE (   7.39  )
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

On Sun, Sep 06, 2026 at 02:53:05AM +0100, Michael S. Tsirkin wrote:
> You didn't send patch 3.
> 

I resent it to just you now. Mail must have gotton lost somewhere.

If all else fails, it's on lore:
https://lore.kernel.org/r/20260905152059.89560-4-kmehltretter@gmail.com/

Thanks,
Karl

