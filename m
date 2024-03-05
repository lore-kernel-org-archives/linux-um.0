Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 953FAC54798
	for <linux-um@archiver.kernel.org>; Tue,  5 Mar 2024 11:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To
	:From:Date:Subject:Message-ID:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JO+6AB9KzJnq15c7g9gV2LhFHu7FmUfPL9YGcXxQKUI=; b=nXgv8JNou2zpvpUSJtQvvgtwhb
	j0Moi5WQS96PPYshRLWlaVyyrLpab/BkGmQF8vRfhYVzfaZsmU1mI4QGNVkSf/OiAvJhO3EbWZBQ7
	W7iME0+7Bv5FsTCkX7aSxSnX0TayKMTnkR0NCiJus5Z17KG0/avskDlg68XWO/bEtqq+UikSDPW7w
	kODlWdFBbS4Wcxh4eMHNwclDFoPrjCxfO5f2IlcOinH/U2xabdO5D0CX5I9Vim7Sx+bK0syD0xGht
	Z/AEY5I9Q6c/q+LwbbADCCFdtzgEeR/zJQNWs5YljkYEhwNgRWutjvcxSMZ6xEc7OzgRy5lAHHP+u
	1YSOfOkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhT6L-0000000DObK-10nu;
	Tue, 05 Mar 2024 11:36:53 +0000
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhT6I-0000000DOaL-3OxC
	for linux-um@lists.infradead.org;
	Tue, 05 Mar 2024 11:36:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709638609; h=Message-ID:Subject:Date:From:To;
	bh=JO+6AB9KzJnq15c7g9gV2LhFHu7FmUfPL9YGcXxQKUI=;
	b=wr4Xlb381T/rtgFhBsqCUkscRn+yOIMMUtsoUz1dUnX27jv9hsfPP+jME37K0KlNdgFokwPiLnYddpnvXUcIOtERcN253hLje+1l9d4a0eBZZBNgIOvR7ATBOIZ292+MKh974HZwZKbIvYD2RhXnP8anq/Vy+v6AFU9D/wc0Toc=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0W1uAS0I_1709638606;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W1uAS0I_1709638606)
          by smtp.aliyun-inc.com;
          Tue, 05 Mar 2024 19:36:47 +0800
Message-ID: <1709638595.0478082-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 3/4] virtio: vring_new_virtqueue(): pass struct instead of multi parameters
Date: Tue, 5 Mar 2024 19:36:35 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: virtualization@lists.linux.dev,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Hans de Goede <hdegoede@redhat.com>,
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
 kvm@vger.kernel.org
References: <20240304114719.3710-1-xuanzhuo@linux.alibaba.com>
 <20240304114719.3710-4-xuanzhuo@linux.alibaba.com>
 <0cbf4910-ec0c-4b06-681e-aafae3720455@linux.intel.com>
In-Reply-To: <0cbf4910-ec0c-4b06-681e-aafae3720455@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_033651_027851_F1BBB9FF 
X-CRM114-Status: UNSURE (   8.05  )
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

On Tue, 5 Mar 2024 13:27:25 +0200 (EET), =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com> wrote:
> On Mon, 4 Mar 2024, Xuan Zhuo wrote:
>
> > Just like find_vqs(), it is time to refactor the
> > vring_new_virtqueue(). We pass the similar struct to
> > vring_new_virtqueue.
>
> Please write a proper commit message here and do not just refer to
> some other commit to describe what's going on here.


YES.

Thanks.


>
> --
>  i.
>

