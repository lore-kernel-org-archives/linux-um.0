Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0053C54E58
	for <linux-um@archiver.kernel.org>; Mon, 25 Mar 2024 06:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Date:Subject:Message-ID:
	Reply-To:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BJ2ubMtU85p7XN+WIaKbvt0uua6wwUwRoEIA4BLg6No=; b=VoEJpa3sxtwBddZaYf9ucQRePy
	FVZ+hiRqaIzubgL60dgD1omk990ztkmmycTnSX/kw0s4c7smSyC2ui3ObZJrr1Ce53lYJrVkgxThv
	4WJ8IA9fwcb+ZbmRvFE43+sd5roqPYyZAJ2deYVkIVVhnpLvYo8Rq4jTxiDoCednwqnIIgTZJU3HA
	qvcT/JzpyMZkeEUV2yveQWaiVNF5jMYoDouM8rrMwl3IjNwkp/cUP3DoDeLByocXjMDt12639q/cK
	i6wiqWxZbfnDdV1Cc/aft+GwhQg62o/1aDM3cEUIN8IR0JlIGXWZgY1tsB6MSoilSEqCbd1OC7I5f
	5Oh2nEKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rodbY-0000000FalF-0lrF;
	Mon, 25 Mar 2024 06:14:44 +0000
Received: from out30-110.freemail.mail.aliyun.com ([115.124.30.110])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rodbK-0000000Faid-1krc
	for linux-um@lists.infradead.org;
	Mon, 25 Mar 2024 06:14:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711347264; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=BJ2ubMtU85p7XN+WIaKbvt0uua6wwUwRoEIA4BLg6No=;
	b=bk+q3LNmMyqm3hrvoL0V+7pBUN078eUE/DLsY1xY+CQWIFwGlRwD2HVVgk3wJa9qsGKlNaFSVecbK/ZNt5heVIHwl8NqbpUXUhN7bzF9QOEInW+3WrO+FAIuf+5vA0jOV30Nr0hxK/qBO0uTBC9SJNOEyvFuroVvnmaqv2mGh2g=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=26;SR=0;TI=SMTPD_---0W39d8Wn_1711347261;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W39d8Wn_1711347261)
          by smtp.aliyun-inc.com;
          Mon, 25 Mar 2024 14:14:22 +0800
Message-ID: <1711346901.0977402-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v4 1/6] virtio_balloon: remove the dependence where names[] is null
Date: Mon, 25 Mar 2024 14:08:21 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: David Hildenbrand <david@redhat.com>
Cc: virtualization@lists.linux.dev,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 linux-um@lists.infradead.org,
 platform-driver-x86@vger.kernel.org,
 linux-remoteproc@vger.kernel.org,
 linux-s390@vger.kernel.org,
 kvm@vger.kernel.org,
 Daniel Verkamp <dverkamp@chromium.org>
References: <20240321101532.59272-1-xuanzhuo@linux.alibaba.com>
 <20240321101532.59272-2-xuanzhuo@linux.alibaba.com>
 <CABVzXAkwcKMb7pC21aUDLEM=RoyOtGA2Vim+LF0oWQ7mjUx68g@mail.gmail.com>
 <b420a545-0a7a-431c-aa48-c5db3d221420@redhat.com>
In-Reply-To: <b420a545-0a7a-431c-aa48-c5db3d221420@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240324_231431_505759_2A8D4AB4 
X-CRM114-Status: GOOD (  33.45  )
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

On Fri, 22 Mar 2024 22:02:27 +0100, David Hildenbrand <david@redhat.com> wr=
ote:
> On 22.03.24 20:16, Daniel Verkamp wrote:
> > On Thu, Mar 21, 2024 at 3:16=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> >>
> >> Currently, the init_vqs function within the virtio_balloon driver reli=
es
> >> on the condition that certain names array entries are null in order to
> >> skip the initialization of some virtual queues (vqs). This behavior is
> >> unique to this part of the codebase. In an upcoming commit, we plan to
> >> eliminate this dependency by removing the function entirely. Therefore,
> >> with this change, we are ensuring that the virtio_balloon no longer
> >> depends on the aforementioned function.
> >
> > This is a behavior change, and I believe means that the driver no
> > longer follows the spec [1].
> >
> > For example, the spec says that virtqueue 4 is reporting_vq, and
> > reporting_vq only exists if VIRTIO_BALLOON_F_PAGE_REPORTING is set,
> > but there is no mention of its virtqueue number changing if other
> > features are not set. If a device/driver combination negotiates
> > VIRTIO_BALLOON_F_PAGE_REPORTING but not VIRTIO_BALLOON_F_STATS_VQ or
> > VIRTIO_BALLOON_F_FREE_PAGE_HINT, my reading of the specification is
> > that reporting_vq should still be vq number 4, and vq 2 and 3 should
> > be unused. This patch would make the reporting_vq use vq 2 instead in
> > this case.
> >
> > If the new behavior is truly intended, then the spec does not match
> > reality, and it would need to be changed first (IMO); however,
> > changing the spec would mean that any devices implemented correctly
> > per the previous spec would now be wrong, so some kind of mechanism
> > for detecting the new behavior would be warranted, e.g. a new
> > non-device-specific virtio feature flag.
> >
> > I have brought this up previously on the virtio-comment list [2], but
> > it did not receive any satisfying answers at that time.
>
> Rings a bell, but staring at this patch, I thought that there would be
> no behavioral change. Maybe I missed it :/
>
> I stared at virtio_ccw_find_vqs(), and it contains:
>
> 	for (i =3D 0; i < nvqs; ++i) {
> 		if (!names[i]) {
> 			vqs[i] =3D NULL;
> 			continue;
> 		}
>
> 		vqs[i] =3D virtio_ccw_setup_vq(vdev, queue_idx++, callbacks[i],
> 					     names[i], ctx ? ctx[i] : false,
> 					     ccw);
> 		if (IS_ERR(vqs[i])) {
> 			ret =3D PTR_ERR(vqs[i]);
> 			vqs[i] =3D NULL;
> 			goto out;
> 		}
> 	}
>
> We increment queue_idx only if an entry was not NULL. SO I thought no
> behavioral change? (at least on s390x :) )
>
> It's late here in Germany, so maybe I'm missing something.

I think we've encountered a tricky issue. Currently, all transports handle =
queue
id by incrementing them in order, without skipping any queue id. So, I'm qu=
ite
surprised that my changes would affect the spec. The fact that the
'names' value is null is just a small trick in the Linux kernel implementat=
ion
and should not have an impact on the queue id.

I believe that my recent modification will not affect the spec. So, let's
consider the issues with this patch set separately for now. Regarding the M=
emory
Balloon Device, it has been operational for many years, and perhaps we shou=
ld
add to the spec that if a certain vq does not exist, then subsequent vqs wi=
ll
take over its id.

Thanks.



>
> --
> Cheers,
>
> David / dhildenb
>

