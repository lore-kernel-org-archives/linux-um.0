Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62657C47DB3
	for <linux-um@archiver.kernel.org>; Thu,  1 Feb 2024 02:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To
	:From:Date:Subject:Message-ID:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lp6gnz0UerLEf+61GoJAoC7KepGxnJDRWTzE7Fmg8w8=; b=iTWx0EbTi+ajOkfUJ/Cnt3YTqq
	OKyigqYZMoIgz8v5aGvq6QQMurJnwYF5XJ7XZOz+Ekl4fNlEaNbUZ+Bd5iazUme299+ct/GOpqDnC
	kz74wSo5zdS4XDafQy1zMPChxb9+qIxicnSVcXbxqaQV1JoaTKH31DpEsuAPrAZuJNZ9d+nyE4hUO
	MIEbQiOjbmQSiOqUg//QeonQSRTgOrZHupe0Jn0vyyjTS7Zs5QGewZA6iy/l8PyIoHwvATOBAAmTk
	Egmni+RVyJ8Vz+tWFdg4JuRixYtsXAwPEYELtAv37uYjfreQC+tPXx3FTdzn/RTq8gew009kkkHBJ
	jXXVXUow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVMkz-00000006I9A-0Pt1;
	Thu, 01 Feb 2024 02:24:49 +0000
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVMkw-00000006I8U-3IBz
	for linux-um@lists.infradead.org;
	Thu, 01 Feb 2024 02:24:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706754283; h=Message-ID:Subject:Date:From:To;
	bh=lp6gnz0UerLEf+61GoJAoC7KepGxnJDRWTzE7Fmg8w8=;
	b=e2r49orRzyzYUW2VkdSlTf5qU9CgM9qC0M8N5WJ4UrNQcgi9DQiIW9oo4kjV3q1WPduRkK9f5OIuwjRe36cx4Kc+1aUdjusj2I8T7oN9H8CrZWVMF5jjq8LqyMoln6GHk5YRCSy7gs2E1O/8yufSlHTKsIvFm/PYFFKlgFVC0mU=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=36;SR=0;TI=SMTPD_---0W.lS.oy_1706754279;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.lS.oy_1706754279)
          by smtp.aliyun-inc.com;
          Thu, 01 Feb 2024 10:24:40 +0800
Message-ID: <1706754257.289654-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 08/17] virtio: vring_new_virtqueue(): pass struct instead of multi parameters
Date: Thu, 1 Feb 2024 10:24:17 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: virtualization@lists.linux.dev,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Vadim Pasternak <vadimp@nvidia.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Benjamin Berg <benjamin.berg@intel.com>,
 Yang Li <yang.lee@linux.alibaba.com>,
 linux-um@lists.infradead.org,
 Netdev <netdev@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org,
 linux-remoteproc@vger.kernel.org,
 linux-s390@vger.kernel.org,
 kvm@vger.kernel.org,
 bpf@vger.kernel.org
References: <20240130114224.86536-1-xuanzhuo@linux.alibaba.com>
 <20240130114224.86536-9-xuanzhuo@linux.alibaba.com>
 <bcd0e35e-e9a3-48b5-fc0a-117ba997439a@linux.intel.com>
In-Reply-To: <bcd0e35e-e9a3-48b5-fc0a-117ba997439a@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_182446_991124_131F5E0F 
X-CRM114-Status: GOOD (  11.07  )
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

On Wed, 31 Jan 2024 13:03:04 +0200 (EET), =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com> wrote:
> On Tue, 30 Jan 2024, Xuan Zhuo wrote:
>
> > Just like find_vqs(), it is time to refactor the
> > vring_new_virtqueue(). We pass the similar struct to
> > vring_new_virtqueue.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
>
> > diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
> > index 98ff808d6f0c..37f8c5d34285 100644
> > --- a/tools/virtio/vringh_test.c
> > +++ b/tools/virtio/vringh_test.c
>
> > @@ -391,7 +391,7 @@ static int parallel_test(u64 features,
> >  				/* Swallow all notifies at once. */
> >  				if (read(to_guest[0], buf, sizeof(buf)) < 1)
> >  					break;
> > -
> > +
> >  				receives++;
> >  				virtqueue_disable_cb(vq);
> >  				continue;
> > @@ -424,7 +424,7 @@ static int parallel_test(u64 features,
> >  				continue;
> >  			if (read(to_guest[0], buf, sizeof(buf)) < 1)
> >  				break;
> > -
> > +
>
> Two unrelated space changes. Please remove them from this patch.


Will fix in next version.

Thanks.


>
>
> --
>  i.
>

