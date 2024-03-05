Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B8B2C54E41
	for <linux-um@archiver.kernel.org>; Tue,  5 Mar 2024 10:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EKvznC5nXjPBL3KoybiT7SDRunCs0+c0gV3HBnK/T7A=; b=muHN+hgwDgmDLLLbUXDI/EUc0h
	LQLulvajm/S6iYChWKxhRP9npld2NbJ6kQwCtzlhoqRfR1BrRNBq14RO1lGG8ntUiltX0+weulvcN
	ZwIAqt+tGyQPMNbVFtwVWlSSueBlsQ5kgathE03JBZpDKEDbwahuS1L7wb+RaWhz2IZwJEdf9KwBi
	JMNMiDM1IgItGOB0rG7KiZcIrY+91qVX+iZVD89P2nHQrJNLdiP1kfxGTmtKToqK4zq7uBdoakmuf
	sqHBFiFd2ioCH01dAIAsK5hkACq+r/CAxUU2kTWZyYHY0+KK06SZ0iNNBBkgenAorG4MvZJZ4jAcb
	ct8lpuJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhSS3-0000000DCH3-185D;
	Tue, 05 Mar 2024 10:55:15 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhSS0-0000000DCFs-0NFW
	for linux-um@lists.infradead.org;
	Tue, 05 Mar 2024 10:55:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=EKvznC5nXjPBL3KoybiT7SDRunCs0+c0gV3HBnK/T7A=;
	t=1709636111; x=1710845711; b=pqE3NodBjnk/vwzj9RCxXTQDqcGr7T2L5MjzO87Syrg2AMi
	Vijl3rYsVuMYCRQCG2odnR9QgmqJ+tHy5fR7Ce8fHzV+vg4fhjGEiqWvHyg6Ok+ZKV11gmM60tIrQ
	rvc2ntDzylH1R6wy+Pee1OOwkag3HAjqB9/Xa/2Ty+C5XkKxJ3psYmKjiOgoTA0aA+50r9udqeltu
	Y/DvkcSVO7NmhdcmSKh7wiRBDcI30B98Qbkb/FrChjFPmdDU5uUA6QlxMse2IsACEet7FsEyrx4iv
	WSpCS5hRX9I7u9ziaCotF0qfFWIPjmANFxfZChMCKreZrqluSzGlkoHR2I6ST/YA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rhSRq-00000002iv2-0O5o;
	Tue, 05 Mar 2024 11:55:02 +0100
Message-ID: <d4572433e5294c04ec2cab99cefca10f997f8507.camel@sipsolutions.net>
Subject: Re: [PATCH vhost 1/4] virtio: find_vqs: pass struct instead of
 multi parameters
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
Date: Tue, 05 Mar 2024 11:55:00 +0100
In-Reply-To: <20240304114719.3710-2-xuanzhuo@linux.alibaba.com>
References: <20240304114719.3710-1-xuanzhuo@linux.alibaba.com>
	 <20240304114719.3710-2-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_025512_239687_89060EF6 
X-CRM114-Status: UNSURE (   5.16  )
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

On Mon, 2024-03-04 at 19:47 +0800, Xuan Zhuo wrote:
> Now, we pass multi parameters to find_vqs. These parameters
> may work for transport or work for vring.
>=20
> And find_vqs has multi implements in many places:
>=20
>  arch/um/drivers/virtio_uml.c

That part looks fine to me.

Acked-by: Johannes Berg <johannes@sipsolutions.net>

johannes

