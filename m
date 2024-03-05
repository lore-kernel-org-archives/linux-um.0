Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9223EC54E41
	for <linux-um@archiver.kernel.org>; Tue,  5 Mar 2024 11:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:Date:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G8NVZZIbWJqXH8cqExxLkhFJLnOnex04S4r8xZ48ydg=; b=ozvDjYQMQqbC0jTT5m+sEvxjhW
	0MeIQ3DRm1oQG/g2b+DOxf4fOckRHx1gumFcy8oTJ11xVfndhurrtqEZ5DmaA/MLAFB9wQirUZjFi
	FOj/eRAv3219YUhVYzi2T3FLbJWxvOu2aC3Y9xyjP5E5wSoE5PmNE0Mbts4OIqU+8dMvx59A/PacM
	rTR7VYeDJK19hzu+t4ICdK5dIE3Swoqt2+9JBqL9AbBP3nuaNOVoV+RA7WZMgqmZ7JkUcsd5uBiIO
	/urG7Ls2PIl908clRSx45X62T/BnBsmvrlaCFJvoRU9xX9TER+rrwb8DRUD7PokpJCkC8Lc/mUe6g
	ckh0e+kQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhSxR-0000000DLfE-0feg;
	Tue, 05 Mar 2024 11:27:41 +0000
Received: from mgamail.intel.com ([198.175.65.21])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhSxO-0000000DLdx-2dkU
	for linux-um@lists.infradead.org;
	Tue, 05 Mar 2024 11:27:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709638059; x=1741174059;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=71g9qi5Belzj0Qm+IHK6UQxAPbvhY2FQyghQGiogSW8=;
  b=Ts238y5lf6UvXeQZcTkx63cqOf+98gx5nEY6/i7ScjnrAEKh+7pETJzC
   TedZ3uxp+z3Enzmtay/e9HnbfT4t0VVhdJvdA3JsIbfJcJcLYRUb3GRK5
   01gq/x4oxcTbG7UFLHZjHPFYWxLuobhakDCv3O4ugbHaZxjzdQY2JGE1y
   T+DEInlrQ1b7tMdm/jocOt8ff27jtSpB1as2NVFFB0bt9ns/Q5MZpzgSN
   zi39+f3h2N2H1ZttOZUhb0RLLV+fMvymJ/EvCpFtXAu+D4o8/1wnryTuo
   3oHehX4gN4yANge9QjAs39dkjjE3h9q2hCfF+b0nvJGe0AuFZrIMiEfGS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4109499"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4109499"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 03:27:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="14007135"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.51.37])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 03:27:30 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 5 Mar 2024 13:27:25 +0200 (EET)
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>, 
    Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
    Johannes Berg <johannes@sipsolutions.net>, 
    Hans de Goede <hdegoede@redhat.com>, Vadim Pasternak <vadimp@nvidia.com>, 
    Bjorn Andersson <andersson@kernel.org>, 
    Mathieu Poirier <mathieu.poirier@linaro.org>, 
    Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
    Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
    Vasily Gorbik <gor@linux.ibm.com>, 
    Alexander Gordeev <agordeev@linux.ibm.com>, 
    Christian Borntraeger <borntraeger@linux.ibm.com>, 
    Sven Schnelle <svens@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
    Jason Wang <jasowang@redhat.com>, linux-um@lists.infradead.org, 
    platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
    linux-s390@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH vhost 3/4] virtio: vring_new_virtqueue(): pass struct
 instead of multi parameters
In-Reply-To: <20240304114719.3710-4-xuanzhuo@linux.alibaba.com>
Message-ID: <0cbf4910-ec0c-4b06-681e-aafae3720455@linux.intel.com>
References: <20240304114719.3710-1-xuanzhuo@linux.alibaba.com> <20240304114719.3710-4-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_032738_731108_59398197 
X-CRM114-Status: UNSURE (   7.09  )
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

On Mon, 4 Mar 2024, Xuan Zhuo wrote:

> Just like find_vqs(), it is time to refactor the
> vring_new_virtqueue(). We pass the similar struct to
> vring_new_virtqueue.

Please write a proper commit message here and do not just refer to 
some other commit to describe what's going on here.

-- 
 i.


