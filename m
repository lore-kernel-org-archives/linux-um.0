Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87120CD1288
	for <linux-um@archiver.kernel.org>; Mon,  1 Apr 2024 19:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/Zzsl+Bkc3z9NpQG00hOGWdteA94EcSnyYVSA5spADQ=; b=rc2w1MO2S0/1YeSXkjlwm+mWzG
	ZqZ+acSskwEMbWwX2amnyvjW4tW6ltl1aXDBOsB0CEEKL5CaKOiy7n9p7btbcLj7zp5FUaXR9Vpe8
	2ThTXrZwGvgHLX4WaILlZ86AlPbdusUmmLE6eBnPHtescyOfNQ5xrdJnFJBUZzQm2DGf00bumVcX7
	zor+MR0gsadWMjRSB2E9/fVdd5g240DMDH+/2AIQNj47TZOMP+YbfHML+oQqDrKUOCrj0JptmyR6n
	o1j4HGciu8vKnYyjO0cIpoe84DB1Z0EXhzz82zHiIxSAAmm/8K+IiSw0LpH2ILL2tZzwiGMjVpRhW
	ScPX6+0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrN0R-00000008djz-3tJ3;
	Mon, 01 Apr 2024 19:07:43 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrN0O-00000008djb-44KM
	for linux-um@lists.infradead.org;
	Mon, 01 Apr 2024 19:07:42 +0000
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 431J3Bsq027876;
	Mon, 1 Apr 2024 19:07:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=/Zzsl+Bkc3z9NpQG00hOGWdteA94EcSnyYVSA5spADQ=;
 b=h8kngFWDGj4HGyH/fr/piW0YeLuVa2s2IAGvNTjGwsDN/g6F4gE4LSqXCXOLLZkT4QV7
 ZMIwG+lr4glBhpvd2zW/LqovGYk0HO6hKj0rVJl6LITxrRlojirADhKhWCUpILYxbD95
 +DYDf2cpMvNdHO+zRHTw7YPz4I/fSctrlgSbwwd9Dx3xmCwo0Lt+9JHN59x8cj4vDA3z
 I6cHYfs1hLABzR54cry5cekh6PC3tBLjxb5i/F4KH9AZ9/rG+QteQh5AAxa6t2Ur83Bb
 k9BFjjPWeGKWIWvtnNL2NBWmCGXS4e1V9D1D38/W4/ehPi2zwzfIRTllUJZfVwlJwa7l VA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x82r2g090-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 19:07:33 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 431J7Xm7000549;
	Mon, 1 Apr 2024 19:07:33 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x82r2g08w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 19:07:33 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 431H2k6B008425;
	Mon, 1 Apr 2024 19:07:32 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x6w2tt8a1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 19:07:32 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 431J7SLR22479482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Apr 2024 19:07:30 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60B555805A;
	Mon,  1 Apr 2024 19:07:28 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC2EA5806E;
	Mon,  1 Apr 2024 19:07:26 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown [9.61.184.184])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Apr 2024 19:07:26 +0000 (GMT)
Message-ID: <64ab5c9cc88caa904e76f650b19849d39be7038b.camel@linux.ibm.com>
Subject: Re: [PATCH vhost v7 4/6] virtio: vring_create_virtqueue: pass
 struct instead of multi parameters
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
Date: Mon, 01 Apr 2024 15:07:26 -0400
In-Reply-To: <20240328080348.3620-5-xuanzhuo@linux.alibaba.com>
References: <20240328080348.3620-1-xuanzhuo@linux.alibaba.com>
	 <20240328080348.3620-5-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1K2BfUVYRRE0SvKwv6mgrRPJ9DAZrLuc
X-Proofpoint-GUID: fFVMYXoCuPhDEznBbvUxsMiJXZL01SvC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_14,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404010134
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240401_120741_218543_C0BBB386 
X-CRM114-Status: GOOD (  19.36  )
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
> Now, we pass multi parameters to vring_create_virtqueue. These
> parameters
> may from transport or from driver.
>=20
> vring_create_virtqueue is called by many places.
> Every time, we try to add a new parameter, that is difficult.
>=20
> If parameters from the driver, that should directly be passed to
> vring.
> Then the vring can access the config from driver directly.
>=20
> If parameters from the transport, we squish the parameters to a
> structure. That will be helpful to add new parameter.
>=20
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Acked-by: Johannes Berg <johannes@sipsolutions.net>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> ---
> =C2=A0arch/um/drivers/virtio_uml.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
14 +++++---
> =C2=A0drivers/s390/virtio/virtio_ccw.c=C2=A0=C2=A0 | 14 ++++----
> =C2=A0drivers/virtio/virtio_mmio.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
14 ++++----
> =C2=A0drivers/virtio/virtio_pci_legacy.c | 15 ++++----
> =C2=A0drivers/virtio/virtio_pci_modern.c | 15 ++++----
> =C2=A0drivers/virtio/virtio_ring.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
57 ++++++++++++----------------
> --
> =C2=A0drivers/virtio/virtio_vdpa.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
21 +++++------
> =C2=A0include/linux/virtio_ring.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 51 +++++++++++++-------------
> =C2=A08 files changed, 101 insertions(+), 100 deletions(-)

Acked-by: Eric Farman <farman@linux.ibm.com> # s390

