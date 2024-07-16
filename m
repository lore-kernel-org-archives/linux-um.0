Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A60FC3DA49
	for <linux-um@archiver.kernel.org>; Tue, 16 Jul 2024 10:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5YpLZBFHa4u/yz0h1zDRTMe6ArvUdZ8SFwam82a19uI=; b=qdB5QAkEAAzSZ8NsEVA0asoN/j
	/BfrSb66x3/uBf8jY47gnidvrM1HRKsFY9MNDmCDtVW0YFvJxXgPVVbaGNX12A1fvBgRcLvi4aoO2
	Uf8efDwbPvXQtOZERdWwg2elAvWVwLCtosNV2PvO/YUeO98DdqGVbNJiY15Y0q9VspcKNcTJcyTfh
	v+t29jJ1LoyzlN/DbY6HaoZLxyNqsRuzCRx+vuymki1tJZo/EEzqNSmq8cdgRrSfqvZE4GohdxEQx
	RLfDb+kU4zGPaPrWSLYm5Ft9BWwB2mauMrLj0Ujn6k5gocHmxkEO9VzhVTbQnmTBGQs12oDxGWzTo
	ic6r1dUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTfs0-0000000A7SD-3JCJ;
	Tue, 16 Jul 2024 10:57:20 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTfrx-0000000A7Rc-2nXp
	for linux-um@lists.infradead.org;
	Tue, 16 Jul 2024 10:57:19 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46GAlTkY013924;
	Tue, 16 Jul 2024 10:57:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=pp1; bh=
	5YpLZBFHa4u/yz0h1zDRTMe6ArvUdZ8SFwam82a19uI=; b=g1MqdYC16MSvXnSC
	RNEUUAV6nWW70hptfnT8bMAMjyQxdsV2SFbXGn8CI13yDWySB4Ja2XsLnHD9WD+w
	F4dCLeD19qYDE+Hanm7ADpvxXUtJ+1xh5ydIb236y6HJVCuAM4FiZ0ezaYWbFPWo
	U7LlV9dh+yAjYN6Gb5wAk9KzmylwwBSXGUU8sHtOPAyl6dLSWYDhnfYOoOfLw2LK
	Jjps/xcGLznmIpWBejvZ+cjh5WYclyfHesVhYvVizdkJrLT2GFOHnaw6GCqLTnF0
	zWJAk0TggqHOX5ZKbTf8tqrhLJRIFC2PNVQcUcIwBt/7tpZF7ckkIM9OMD6GC/Vo
	XPo38A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40dq4wr1fr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 10:57:06 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46GAv5nb025254;
	Tue, 16 Jul 2024 10:57:05 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40dq4wr1cv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 10:57:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46G8jlL1030523;
	Tue, 16 Jul 2024 10:52:27 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40c4a0ktt3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 10:52:27 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46GAqMU322872322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jul 2024 10:52:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA57920043;
	Tue, 16 Jul 2024 10:52:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C3D220040;
	Tue, 16 Jul 2024 10:52:21 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.152.224.212])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Jul 2024 10:52:21 +0000 (GMT)
Date: Tue, 16 Jul 2024 12:52:20 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org,
        Alexander Duyck
 <alexander.h.duyck@linux.intel.com>,
        Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg
 <johannes@sipsolutions.net>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Cornelia Huck
 <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
        Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Jason
 Wang <jasowang@redhat.com>,
        Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>,
        linux-um@lists.infradead.org, linux-remoteproc@vger.kernel.org,
        linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
        kvm@vger.kernel.org, Halil Pasic
 <pasic@linux.ibm.com>
Subject: Re: [PATCH v2 2/2] virtio: fix vq # for balloon
Message-ID: <20240716125220.677dccf4.pasic@linux.ibm.com>
In-Reply-To: <3d655be73ce220f176b2c163839d83699f8faf43.1720611677.git.mst@redhat.com>
References: <cover.1720611677.git.mst@redhat.com>
	<3d655be73ce220f176b2c163839d83699f8faf43.1720611677.git.mst@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -ciPuNbu1ulB9x3MDH6mw0VxJdTjfl_5
X-Proofpoint-ORIG-GUID: _zkRs-FyWlqEBV9NEtx1Xwx1HT6kmSDZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_19,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 clxscore=1011 priorityscore=1501 adultscore=0
 impostorscore=0 phishscore=0 mlxlogscore=866 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407160079
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240716_035717_852187_4087EF30 
X-CRM114-Status: GOOD (  13.41  )
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

On Wed, 10 Jul 2024 07:42:46 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -694,7 +694,7 @@ static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>  {
>  	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
>  	dma64_t *indicatorp = NULL;
> -	int ret, i, queue_idx = 0;
> +	int ret, i;
>  	struct ccw1 *ccw;
>  	dma32_t indicatorp_dma = 0;
>  
> @@ -710,7 +710,7 @@ static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>  			continue;
>  		}
>  
> -		vqs[i] = virtio_ccw_setup_vq(vdev, queue_idx++, vqi->callback,
> +		vqs[i] = virtio_ccw_setup_vq(vdev, i, vqi->callback,
>  					     vqi->name, vqi->ctx, ccw);
>  		if (IS_ERR(vqs[i])) {
>  			ret = PTR_ERR(vqs[i]);

Acked-by: Halil Pasic <pasic@linux.ibm.com> #s390

