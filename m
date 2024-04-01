Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C7DCD128A
	for <linux-um@archiver.kernel.org>; Mon,  1 Apr 2024 19:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JbQ/vyagne1B2SNAZ1pSK9x8j0xrTBqxnXBPQrwReEA=; b=IGY/0xbz+RJW/O6nuL6wndy/+Q
	74d/qTbVNfUjRWPcrZeEgkmqACIX96hAOTCEh+SJRmvFgBHxwNMd50ffpUH0oWsAInmu2WJlg+Odl
	kRTMmG/ga9DoXoYfk3dWfLlUa018iwM1ypkHVkJzVMf7ftqAZNH5G7GeTU3Jj1JDGTDVgsNam1w6U
	OH58G2W/cyuJNsnKYLkeCsSxkscuwpASkBA//JUKFeXfRqeC8rdz9Z0EC7JFMNczAqk0Wc/tW9KO5
	FO+andzbn/XAyKvWsrug/qhWTKK52bGuAmPmutsepiMf8PpDr/xFIrfYgWnlKov2LXuCI2K8C8wBM
	cny/AwdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrMvg-00000008cp0-37nI;
	Mon, 01 Apr 2024 19:02:48 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrMvc-00000008cm3-3Q3C
	for linux-um@lists.infradead.org;
	Mon, 01 Apr 2024 19:02:46 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 431IvYNB011088;
	Mon, 1 Apr 2024 19:02:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=JbQ/vyagne1B2SNAZ1pSK9x8j0xrTBqxnXBPQrwReEA=;
 b=bAc4K7FDIfOzcAy62OkeeAUsX6ql6uHvU/ukjq5DsKj7m96BB1g3nuoRzKfPz/IUm1xt
 0fy2cUAG1IgJqQH24E3k0a3ZPX3Z/7hozrvV/+m5MjL4+LdTcbBoT9ZF7AmMq58FUOyD
 0ztKcecNXpz9I5+juG+tT9Of/8Bpd6hrSvYBKYCznnVYqCVWK8PnQuoI9gEG5xt3Rc6+
 L12jo4rcmbD+5bevoeW6ZwlgCvmnMzvTi0SnUHxeamPh0vqoqgZXDEmqxkt4Ig3Zkq4W
 sdoPpLXleVhq4Kl7GHQYBmIM10vOyMubCxbpyWbqbiKxNCDfRJDOugnp/33z8skRRDmV Kg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x82nf00gs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 19:02:23 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 431J2MA1020505;
	Mon, 1 Apr 2024 19:02:22 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x82nf00gn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 19:02:22 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 431J2Ds3015234;
	Mon, 1 Apr 2024 19:02:21 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x6y9ksk1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 19:02:21 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 431J2Iru23134946
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Apr 2024 19:02:20 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 536B058058;
	Mon,  1 Apr 2024 19:02:18 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A75E25805C;
	Mon,  1 Apr 2024 19:02:15 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown [9.61.184.184])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Apr 2024 19:02:15 +0000 (GMT)
Message-ID: <00311e8bb63ba873da9906d87e49499f40df5134.camel@linux.ibm.com>
Subject: Re: [PATCH vhost v7 2/6] virtio: remove support for names array
 entries being null.
From: Eric Farman <farman@linux.ibm.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev
Cc: Richard Weinberger <richard@nod.at>,
        Anton Ivanov
 <anton.ivanov@cambridgegreys.com>,
        Johannes Berg
 <johannes@sipsolutions.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Vadim
 Pasternak <vadimp@nvidia.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Cornelia Huck
 <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
        Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "Michael
 S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason
 Wang <jasowang@redhat.com>, linux-um@lists.infradead.org,
        platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org
Date: Mon, 01 Apr 2024 15:02:15 -0400
In-Reply-To: <20240328080348.3620-3-xuanzhuo@linux.alibaba.com>
References: <20240328080348.3620-1-xuanzhuo@linux.alibaba.com>
	 <20240328080348.3620-3-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: P1ukwj2SO_fm-loIj3BYJeRlaiRy_jcA
X-Proofpoint-GUID: coub_UfOYCf5qBMsA2tFbBkXJ8453ebI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_14,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999
 bulkscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404010134
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240401_120245_099935_AC1E6668 
X-CRM114-Status: GOOD (  16.22  )
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

On Thu, 2024-03-28 at 16:03 +0800, Xuan Zhuo wrote:
> commit 6457f126c888 ("virtio: support reserved vqs") introduced this
> support. Multiqueue virtio-net use 2N as ctrl vq finally, so the
> logic
> doesn't apply. And not one uses this.
>=20
> On the other side, that makes some trouble for us to refactor the
> find_vqs() params.
>=20
> So I remove this support.
>=20
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> ---
> =C2=A0arch/um/drivers/virtio_uml.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 ++++----
> =C2=A0drivers/remoteproc/remoteproc_virtio.c | 11 ++++-------
> =C2=A0drivers/s390/virtio/virtio_ccw.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 8 ++++----
> =C2=A0drivers/virtio/virtio_mmio.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 11 ++++-------
> =C2=A0drivers/virtio/virtio_pci_common.c=C2=A0=C2=A0=C2=A0=C2=A0 | 18 +++=
++++++---------
> =C2=A0drivers/virtio/virtio_vdpa.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 11 ++++-------
> =C2=A0include/linux/virtio_config.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A07 files changed, 30 insertions(+), 39 deletions(-)

Acked-by: Eric Farman <farman@linux.ibm.com> # s390

