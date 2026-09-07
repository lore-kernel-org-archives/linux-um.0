Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0320C79F9E
	for <linux-um@archiver.kernel.org>; Mon,  7 Sep 2026 21:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JaECoODu5PWLeAxmwxwy2TeJHbPjZIpe/fjVw/Ok5Aw=; b=ZBZw3VruArK0FH33sZGxeAJ13e
	ckvbHXe/N1emcPm94DuYk47sxX8Chq9TiwsFxprFToGbJBDKPGBltPwz6pMwF7CtBbkgdI+fHbzJ9
	7U4PiykKj2c8p4CvOhYGfNtmO/DC6MrSOT3CCOKUgqQMro5V/pR9zPd4ioPawLGPqriyjAVc5PUlC
	QQG0hesY2MznJvpQI8qCg5p1W2femwrYwxpfRoHC4B1emNfuSagVt2NyleSj9YRTwMxFtscidgNbT
	uIYYUf828QhpvQBbO/gQRUOggj2vW+qIOYb5bAMujqCtvvRdAdC0UReXlurCFdchdQVZVT/AcwYIK
	/V92VYcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3h5k-00000007mOM-3JLK;
	Mon, 07 Sep 2026 21:41:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3h5h-00000007mNr-2LEf
	for linux-um@lists.infradead.org;
	Mon, 07 Sep 2026 21:41:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788817284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JaECoODu5PWLeAxmwxwy2TeJHbPjZIpe/fjVw/Ok5Aw=;
	b=aUSZ+ucLLUxHSR2YAyhs1vP4+f1b3R50S869sjI/1pCdeEkqqO2dL8Rki0M7IhWSeqMh2n
	Lmhwxzmd6Upxwg/yAlBA6di584XP6ZiX5mgZNcnNgVj2KtSzFi61zLc26Zy2mku2c8A1nl
	gTp6BvBAFU1nV2YqDe1VKJRrlGNnynU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-_8Zd4IFwN4WkPysJItUVpw-1; Mon, 07 Sep 2026 17:41:22 -0400
X-MC-Unique: _8Zd4IFwN4WkPysJItUVpw-1
X-Mimecast-MFC-AGG-ID: _8Zd4IFwN4WkPysJItUVpw_1788817281
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-495569acf8dso24620905e9.1
        for <linux-um@lists.infradead.org>; Mon, 07 Sep 2026 14:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788817281; x=1789422081;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JaECoODu5PWLeAxmwxwy2TeJHbPjZIpe/fjVw/Ok5Aw=;
        b=XjIzm3MliSZaFvfKcPIFal2nDOWrn9liVYrCPsDOl6+fdWHYZK0sW5TVYE+KT/3dan
         9ffdeR1BYfeM9g487yJyMu4pUo7V/Rr7Wc+BBa7tBNvLX2d6C64SEY4A8G+Wq38/IIs4
         VqSF2SSGznfPVby3Gt+bzoMJiHk6/ep3HE7jgFU/6U4yTVulkRM+EpXzdKZRWEQP9msg
         nD6JsiyAEdxLrVm5sWoJacuv0Xzc/Lg+ajWBU6woqr5dDvxSQuSqySDNLNnWNZA1cPDG
         /pnEsBri1IBm/H+udszNk0yfpsrdGQTXqbffDdyrgJTBsyG+pTkPpkuAt12UqaoC3VHG
         Dyvw==
X-Forwarded-Encrypted: i=1; AKwUvByRBenlevT6DXyau44Tf7sJq+x1sJhilnKylYFa5D4IjBf8Q5wYLoachC9PEikCshSrlZMLIJa2nA==@lists.infradead.org
X-Gm-Message-State: AFuF++kefxYUD6aX0viOvhRPQQxx7prukkAUwK5KODrcr2yTHdWWeyzu
	FOSNLzCOFJ5BAT70x7Ex4q4ZyResaFkaFNN6sfhNTYeBE2XRjLP6hHX0hqvlo6CdCOo974Cv0vI
	/J/WbAKjrdA02i5cS9PD3Kt7PBowyLtWXUXsdoB/rkS2CwLzPu8PQDsa5YDKlglXQwg==
X-Gm-Gg: AYBFou0xVbYkglbs89H+9VNdBweJ6ZbbJnT3/26O/ETiRTFefVyOziQQCHncVix/D+4
	s7NnUUs0gSHmPaMh2rebHiNTRV1DLRyBhJgWVMJ/4+YNGdAqRuNWlPN/YU6/q0UIfa0IQcwTxnH
	75tH6Z5ROAn/dtGBHv2Mg9yYbcuNCOluhhF86AHSDDiOqU0YDCXEO+SzXrMd3Y2vXqBfITKp8y0
	GAMCO8WGLQNLastfr6haVa91olZ+qgLC7GDzt9DgrKvh9I5KZHYQ30yKwqqDORWG1q66hJslnVF
	D13KSCcNO1LiWntGU1QiQfzRFQ3IYPJBqs7HF0G1RybUAbWFNtTECqxamj+upWqm8stOBE8cBi8
	GdQNZbDZiFpVBi8spny89920=
X-Received: by 2002:a05:600c:3d92:b0:49d:726:cc9f with SMTP id 5b1f17b1804b1-49d0726cd2emr320765815e9.5.1788817280976;
        Mon, 07 Sep 2026 14:41:20 -0700 (PDT)
X-Received: by 2002:a05:600c:3d92:b0:49d:726:cc9f with SMTP id 5b1f17b1804b1-49d0726cd2emr320765175e9.5.1788817280462;
        Mon, 07 Sep 2026 14:41:20 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce58da3acsm892607965e9.0.2026.09.07.14.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 14:41:19 -0700 (PDT)
Date: Mon, 7 Sep 2026 17:41:15 -0400
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
Message-ID: <20260907174032-mutt-send-email-mst@kernel.org>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
 <20260907091033-mutt-send-email-mst@kernel.org>
 <ap8rCQII9fASEosZ@gmail.com>
MIME-Version: 1.0
In-Reply-To: <ap8rCQII9fASEosZ@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DzcslNhJakVwb01dU8Bj2ggzYSxRYgyISNv3mVMl6Ag_1788817281
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260907_144125_666865_D7DC6472 
X-CRM114-Status: GOOD (  16.61  )
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

On Mon, Sep 07, 2026 at 11:23:19PM +0200, Karl Mehltretter wrote:
> On Mon, Sep 07, 2026 at 09:13:28AM +0100, Michael S. Tsirkin wrote:
> > got all 3 patches now. it's a good start, thanks, but they need
> > a bit more work, in particular addressing sashiko comments.
> > I'd also prefer patch 1 to be split: moving code from pci to core
> > is separate from ccw fixes.
> > 
> > Pls write or at least edit commit log messages yourself,
> > after reviewing Documentation/process/coding-assistants.rst
> > 
> 
> Thank you for the review and feedback. I'll work on a v2 now.
> 
> Karl

FYI I picked the virtio input patch, no need to repost that.
If you want to fix the evt leak, it can be a separate patch.

-- 
MST


