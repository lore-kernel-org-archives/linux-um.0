Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BBEBC54E41
	for <linux-um@archiver.kernel.org>; Tue,  5 Mar 2024 10:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bMWgURJ3jS8l4Cq9Nb814P898s9DhjQB0FUrf8jQrR4=; b=Edoo96hPJcUsLIA9LvtHGxBOCI
	6sEEbOH8echWGQd1C93Dn3SlfuFPRK7cqg+bAiCde8gnyeTJNfYEH1s32dodz5v1zIU0Ox8vETd5m
	YmY82+LYZPc9vR0dw58PzS1oZW2P5rWlEGPSz2fp/ct/AwuImBo2GBid750vOU/4GnRz+wGkBulDt
	/1rVRCF8OdPhBHc+FQaUrrKqLZH7ScX8BDoQ42P09KsFP6oepYzYmfeUFGahs6Eg7cAHztr+TxhI4
	MwMHnKsrKUZdEefsjNBKxAx99qBBQ5nkndhlqRzHtI5mIJfE5WeyIyKmk3rjM6oBL02jfAMNxBgUe
	ybG0JzAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhSSn-0000000DCTV-0NcN;
	Tue, 05 Mar 2024 10:56:01 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhSSj-0000000DCSK-2bhr
	for linux-um@lists.infradead.org;
	Tue, 05 Mar 2024 10:55:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=bMWgURJ3jS8l4Cq9Nb814P898s9DhjQB0FUrf8jQrR4=;
	t=1709636157; x=1710845757; b=bKZkT1vgIbHyWvElohvDskSlFJes17dhK3M2N5jOTiFMJha
	ZAh5LRSSFWAIuXWT2S4NcpiiakeNihjZUpo83uWdZDTHDE2z4UwUfSHZN9cWHc2iADbovSpNrWrKr
	QLiwQqH7ZRwh0mLBxjy7+gyH24PmyURHXa0d3deiyC+Svsd8CrLuWvfkrtLoSrulKnP81fv6k4yCf
	6fasQE5UdXtQkoGtUFvVT8PNVpnZYDu9WN1I38CjiZ4ctDzVZNCAKrXz/KSmryMwHAoL+EfU0mStQ
	nMbXJTjpaEFa6Ew4Q3PvqE6PLSuFd36vw1d8A+fMQmQU6yJ0sIWrB+HZnxb/RsNA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rhSSb-00000002iyF-3Thw;
	Tue, 05 Mar 2024 11:55:50 +0100
Message-ID: <22d9f3dc9fc8a05808f03df33bf2d58924fb61e6.camel@sipsolutions.net>
Subject: Re: [PATCH vhost 2/4] virtio: vring_create_virtqueue: pass struct
 instead of multi parameters
From: Johannes Berg <johannes@sipsolutions.net>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Hans de Goede <hdegoede@redhat.com>,
 Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Vadim
 Pasternak <vadimp@nvidia.com>, Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck
 <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,  Eric Farman
 <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>,  Alexander Gordeev <agordeev@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang
 <jasowang@redhat.com>, linux-um@lists.infradead.org, 
 platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 linux-s390@vger.kernel.org, kvm@vger.kernel.org
Date: Tue, 05 Mar 2024 11:55:48 +0100
In-Reply-To: <20240304114719.3710-3-xuanzhuo@linux.alibaba.com>
References: <20240304114719.3710-1-xuanzhuo@linux.alibaba.com>
	 <20240304114719.3710-3-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_025557_695503_62D17E5F 
X-CRM114-Status: GOOD (  11.34  )
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

On Mon, 2024-03-04 at 19:47 +0800, Xuan Zhuo wrote:
> Now, we pass multi parameters to vring_create_virtqueue. These parameters
> may from transport or from driver.
>=20
> vring_create_virtqueue is called by many places.
> Every time, we try to add a new parameter, that is difficult.
>=20
> If parameters from the driver, that should directly be passed to vring.
> Then the vring can access the config from driver directly.
>=20
> If parameters from the transport, we squish the parameters to a
> structure. That will be helpful to add new parameter.
>=20
> Because the virtio_uml.c changes the name, so change the "names" inside
> the virtio_vq_config from "const char *const *names" to
> "const char **names".
>=20
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  arch/um/drivers/virtio_uml.c       | 14 +++++---

Looks fine here.

Acked-by: Johannes Berg <johannes@sipsolutions.net>

johannes

