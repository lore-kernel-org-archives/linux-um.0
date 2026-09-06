Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B71C79F9E
	for <linux-um@archiver.kernel.org>; Sun,  6 Sep 2026 18:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UoPs+GJMD19+2K8VaVNyBFab1idZZJbQk2Q9rWXgiCY=; b=rKDhPb3T3HGV7NFaBK+j5CLl6h
	mqK9pTAlAo75LDynnFIzO0bOtgrD768JORraZ7l37CjajM+i6WOPGKndT91rqPKff1qqVFK6orgPz
	VUBJAAYZGyTpA/OOfQ7/QvIvMuRq5E07tekaSASA17nuMfOlhTiHTCkZCVM5XO4i6V/f5+UC5qOl5
	8kD5h/VHKKRH+U+a5gpV1HgerHQS10ci7A1UjhwTUXeBP9HcekCh8CS3/nTHX4HGOk8FDu6w9WgMW
	TYh3dnnwLVcE+z0o78qDuL2BKm5lGK5xZSmZxOzFyeTXzlO+ypcyyz8mfcQfKyoXLDiKjaD+uDAID
	9msb5bWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3I2e-00000005Uar-3tan;
	Sun, 06 Sep 2026 18:56:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3I2Y-00000005UaY-2Bga
	for linux-um@lists.infradead.org;
	Sun, 06 Sep 2026 18:56:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788720988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UoPs+GJMD19+2K8VaVNyBFab1idZZJbQk2Q9rWXgiCY=;
	b=NTs0Dq6ID7Utpl8vuq/dAPjs+dNnBvQiCCVqu4/+kh6I37jUoOBjwPz+gARVGZT7DEbGMY
	SeNCqj1pqObM7Q1xUl1k9ljmeR2btIP7aYpQL8y6KywPZyAPTubAiu68zYQ1JztrFXM6IV
	QJm4fZkYeTTB0rh3JWFtUOt617gmMBY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-NX7HjdSkMx6XwuTiiEkoPg-1; Sun, 06 Sep 2026 14:56:26 -0400
X-MC-Unique: NX7HjdSkMx6XwuTiiEkoPg-1
X-Mimecast-MFC-AGG-ID: NX7HjdSkMx6XwuTiiEkoPg_1788720986
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48436db95e1so1854393f8f.0
        for <linux-um@lists.infradead.org>; Sun, 06 Sep 2026 11:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788720986; x=1789325786;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UoPs+GJMD19+2K8VaVNyBFab1idZZJbQk2Q9rWXgiCY=;
        b=qRWvQ4lVJc8L/lZVlRADnGtOK1ro11Ozd+dtLH7B8qaThDmYde3met0NOkOPW73ZDt
         eqEwg1vEAQ26SFv0IsibP90xH8sgIN/8efV/HDmLYZVsAy894BUVjyH9hqF2+c7cquhq
         vwZVT8tEgm/kPX/HaBTWDg3tzWKSzr4c78T1+6fOJovZBdjj2ArHQ18B7MjAkpP65MIH
         XaHlXh+QC0lYma8FQ0Xcma7+N5QCC3473GtuTYKJ04zWRhrVA5p69t1JiNsTLuBJ/Au6
         uqvSjfAD6bwKUEt/J252ygIQAJarx2gIt2pH2S5Le4QrjqxkK2WA9Rr40UpJctOBJrn9
         dkuA==
X-Forwarded-Encrypted: i=1; AKwUvBztmxkM2y+a/h3B5CDS07WPM9zhz1zjtyiWFjRntvqCaksUjx09oc1lzcaWdLguCgAJr1fK0hTknw==@lists.infradead.org
X-Gm-Message-State: AFuF++lsxWSyDawitLn1Y6bc3q/eLEXovQBSxQEIMsOPXVqyr6ECvQUn
	Qe96rrXSMzZokC2Pz2WBE+jjBa/qetH/5IbMtD4st2Stgvgm/qM9wDum37PCdw5ATdhhpSgCcUc
	QmTcGJAzYRqXUrrI/pZiaXAFXQmKUPCDMu14xJe+ARPfuoQxUCgCdBpsfKBImDfwMYg==
X-Gm-Gg: AYBFou1xdoNsgvABuZEOqnwJlqAiHSfBQBEhqP852I4lc6YyZVz1X8aHTMB2/K1qM74
	JXh1HyAUFg28At9+z8x/zALLb3koBxjJzXBIVA43Tp5Z+dGRe2O65x1vpNsmS3HwBakrfAQceIf
	NggDJyNNDHXsl9vcV78UCy7P/xTuh0/2dEQjW+3PrWWkuGdeQ1nvzvabBEs/yhv1opIZhUXgb9c
	7B6HT0bJ6Kks83DyV80GNRxwqAG2xEiYt4eltWaIl5XMr3xyBoalTIlh3LaDAJF1chaIIT4hkjx
	zGgcG4AdKqrEse2JRaBM39yp4kdXA+7r/UWZ2bSqH4ERqT58a50QHDwc++GoVpyfvpqysObH2sy
	lmkUJToc6ItRYC+Z/uemCuGA=
X-Received: by 2002:a05:600c:8b29:b0:49c:ee22:364c with SMTP id 5b1f17b1804b1-49cf824743cmr196985035e9.9.1788720985676;
        Sun, 06 Sep 2026 11:56:25 -0700 (PDT)
X-Received: by 2002:a05:600c:8b29:b0:49c:ee22:364c with SMTP id 5b1f17b1804b1-49cf824743cmr196984675e9.9.1788720985146;
        Sun, 06 Sep 2026 11:56:25 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d084d62b0sm80311485e9.2.2026.09.06.11.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 11:56:24 -0700 (PDT)
Date: Sun, 6 Sep 2026 14:56:20 -0400
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
Subject: Re: [PATCH v2 0/3] virtio: synchronize callbacks during device reset
Message-ID: <20260906145605-mutt-send-email-mst@kernel.org>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
 <20260906025249-mutt-send-email-mst@kernel.org>
 <ap2VJkoIsBbsqcNm@gmail.com>
MIME-Version: 1.0
In-Reply-To: <ap2VJkoIsBbsqcNm@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: G_d5EJVSffr8EFm6wBqn3tmcuFlYJZKyHRZEzZK1C-0_1788720986
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260906_115630_662780_637BE9D9 
X-CRM114-Status: UNSURE (   9.86  )
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

On Sun, Sep 06, 2026 at 06:32:40PM +0200, Karl Mehltretter wrote:
> On Sun, Sep 06, 2026 at 02:53:05AM +0100, Michael S. Tsirkin wrote:
> > You didn't send patch 3.
> > 
> 
> I resent it to just you now. Mail must have gotton lost somewhere.

got it now, thanks!

> If all else fails, it's on lore:
> https://lore.kernel.org/r/20260905152059.89560-4-kmehltretter@gmail.com/
> 
> Thanks,
> Karl


