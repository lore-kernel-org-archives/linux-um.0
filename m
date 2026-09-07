Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB68AC79F99
	for <linux-um@archiver.kernel.org>; Mon,  7 Sep 2026 21:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zj4alWZ0+Z5ViHZ+ZCYKHStoDMFk30/0JNVi4/sJSpo=; b=JgFxt54mOPUXnQcynJeab/LC2U
	M8CGAGa8VIZxxyfWftmLouFz3TqlJCMBVdjMgDtWU4baJDBaSqEaCzVMILO8/klDX7BwnaBaIQRVs
	9muX/xBVAE4UcvJO1Mo2i2nLMqUMvqTEZ8Bjg7OFXIJI6XlpWs/0BrREi9RBWgNmVDG7pQzG8HWu/
	lk4ejrRF8znoOloSVJWQbmrNQvTg8v2CoMNzbK0N7iQI4aW+flt3GZalwA9XS9wdVa1LQG8BbRun0
	O8hTVFTbmGP2mnwSuMTF5nmM3B6c5bg19cHuodFqVkUOfzTfe3XeWv6LNwwGe4NKHbNw22cJLMg9q
	4kasLdLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3goH-00000007kok-397U;
	Mon, 07 Sep 2026 21:23:25 +0000
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3goF-00000007ko7-1IuQ
	for linux-um@lists.infradead.org;
	Mon, 07 Sep 2026 21:23:24 +0000
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-4859245e493so1849995f8f.1
        for <linux-um@lists.infradead.org>; Mon, 07 Sep 2026 14:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788816201; x=1789421001; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zj4alWZ0+Z5ViHZ+ZCYKHStoDMFk30/0JNVi4/sJSpo=;
        b=XmXmZTNnmR0kypAxkfhDkfZMoRYtP5umwBnlPInQGy7OLALnkTWkJhad9RcRSQcNUX
         HExqsqgWva9nTjNFzgwyN/swokd4CIVN0Lf82H18NV8AeuklGPdJt6ImBEYsS0WeKz/b
         FdGhcHvjXhzrpcid14PB6S9HH5WrsalXA/V+Ku9n6zWXd5vL5NNiANVcQg00l1uHHrOB
         xnUJCU7ljD7HNL9/592uUphGFGW18N1Emj8PQF8ihUAbJLrUwddYiJWjx/hlBIqmNbqW
         YT68UhiCcxnjlOcyQlXXcXz4uJbuViYEXK+ushlRUht+WLVUkNiUG3l/Vcu7+izy9JCP
         6f4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788816201; x=1789421001;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zj4alWZ0+Z5ViHZ+ZCYKHStoDMFk30/0JNVi4/sJSpo=;
        b=b4pm+ELRhUHHUHSAy2VL6sWK2wlo9IGoWi2DCEdhmYFmJUg+IQBYly18/YAkpFvuCD
         ICDxlxO8E3m3JoBo4FJh82RTBzzDwTflR8yv9bESvlqes392MwBvvixVhD/F4LDQt6Rh
         8srAS6gSnv7e0sGDNF184FE5s0bMiCfSPwPWnu/dsloEiOayQSuOFUWr5MiN5RggFuLn
         ns/0h5yXxM5X0PKYGagng9s+q16XfAd7QF+pAu3eR6l/R5a6mrCtEtGzid7g1gDZNpeF
         nizDsyHbPPAf4aEa2UWfa04jD2QIU4RaGINexXW/omSXAPiaa/P1faBvkJdGyt4LMsbD
         OBeg==
X-Forwarded-Encrypted: i=1; AKwUvBwte0zsc/4tTVmt5uMIcXwt10dge6NmtcsINhQCuRNMQCFvnB2GDnVt5eft7wQT6X7BJx44LbgxTg==@lists.infradead.org
X-Gm-Message-State: AFuF++ns0LbwS8B1j2yCNKEqpE2J5eIXiNuAH5LCLJUlex2F0in/sloU
	IW89n3lo11Rs/nxD16ux1FispHHbWIS+rkzPBCxKwBQyPZ5zC/lwN6/y
X-Gm-Gg: AYBFou3ESEK9jXLOEhpxZetH35nuUOJMm9o0iYATZz8h7tjpcaKTSt+gcjpdBWa3GDE
	KxWOCxm8bZilrJzbFxBVT4oisUydQHhB5n1hv7zS7Tc2Gs2s5ROW+sdqw52BdLSOcC3mkvAow04
	mEExZGFKRq/rCa5b+4pfg6n1tGZHZhSNn2xrSbK1j/a2fmN/35iz+NsPfvc1j1PiHUvoYaXPwTs
	lXzA7sWzF52vFPeEJ435L3rbD5FVmFWpkPhgfNrBmshlMCVsBslMuEa14td/q7kz22vfF5C/mVN
	+ytbQKXpVbt5WAw1kq1FT4auKZc5bJyPG7gtzf6fepPjgD8P1vscmPasPags3zeOwJ3rpmluT8p
	YYlMOBUEpHx5SkrqkJC15V02mzC6l6LsKq0wdK5c+6/UO1d3Ta+YhW3UUv7E4sJoptFqo+3Lf0m
	mZqusCwWMJuvnJgAPivyP9e+OwF8P9f9y7K7+jUFjDKrvXsKz0RNn2VdKHaf7IYlagmo6IXo8fn
	ot0+jCB5CIQ6CH2P5Javx7hOsja5OJI37NXC+IsYbspTRGSOdNo0UwnKMKS3xp6ZaqIHznwoagf
	wB2Tn/t4agvmL3r2RTDESEGnR5dw1wLG4/ptj53ES6dERSxgkvoeFdrcf3fn0+xuyOv6HiuO78z
	m+xSvARJVDNk=
X-Received: by 2002:a05:6000:4a0a:b0:484:3310:f39b with SMTP id ffacd0b85a97d-485872e05f9mr26354952f8f.28.1788816201067;
        Mon, 07 Sep 2026 14:23:21 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-b0c9-3601-cdce-ba4b-d0e3-dede.310.pool.telefonica.de. [2a02:3100:b0c9:3601:cdce:ba4b:d0e3:dede])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858ac2b4cdsm29964718f8f.16.2026.09.07.14.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 14:23:20 -0700 (PDT)
Date: Mon, 7 Sep 2026 23:23:19 +0200
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
Message-ID: <ap8rCQII9fASEosZ@gmail.com>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
 <20260907091033-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907091033-mutt-send-email-mst@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260907_142323_388930_7EC404AC 
X-CRM114-Status: GOOD (  12.02  )
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

On Mon, Sep 07, 2026 at 09:13:28AM +0100, Michael S. Tsirkin wrote:
> got all 3 patches now. it's a good start, thanks, but they need
> a bit more work, in particular addressing sashiko comments.
> I'd also prefer patch 1 to be split: moving code from pci to core
> is separate from ccw fixes.
> 
> Pls write or at least edit commit log messages yourself,
> after reviewing Documentation/process/coding-assistants.rst
> 

Thank you for the review and feedback. I'll work on a v2 now.

Karl

