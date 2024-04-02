Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89ED5C6FD1F
	for <linux-um@archiver.kernel.org>; Tue,  2 Apr 2024 18:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ge+PCdmfdapG3nCKI7WpuuoKJVjlsUHNMa5EZQPh+Qk=; b=hKxbt8ibKxFRKUdBTQO8xqpxPQ
	QZgSPwsYhSa3JFX1M853PSz/1P2RKzpTqNjwmhkgUT5cLY+V9zX1HU+Nw/KXk9jj61clTWN/te8A4
	fYChEGrmyz3IqMxJ46h4Fi1jlpiwymM1d5c9IhyZUkwquO6Qz2PMcMJHlzJqKEHgXOea6UGxoRCP5
	we5IHkuAnRC6wtCNhtCfjqUk5J4lg8tNJgD/TGw2LGysxLSty7h48B5K5s9M/mwGmEGE6LwTXEwxK
	k+Ol3JG3wxPOhTsXQbWvJbCC+62rXDRF2YDx7toIiJRrflkE5jsxEFD3Q5U9TmHN4yRbGHYjALDYP
	uL2NUjdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rriRt-0000000CHxL-2xNL;
	Tue, 02 Apr 2024 18:01:29 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rriRq-0000000CHwe-2OEE
	for linux-um@lists.infradead.org;
	Tue, 02 Apr 2024 18:01:28 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 432HqscV029201;
	Tue, 2 Apr 2024 18:01:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=Ge+PCdmfdapG3nCKI7WpuuoKJVjlsUHNMa5EZQPh+Qk=;
 b=aRpk6iA+UUeeVLtiuFhtNmSaMQsQ7/8MXvzEu8Mz9fU+69iduRNpXZr4ilYShTeGvl7j
 izRH42UiYy1PGawVts2wptHJH9nKHPEVcb9LeC9zAChnX8rdlYfUdPqXyejA8yLVyAVn
 bxYtOAW+XsUXB9qZHA8XprmlMQF3LrMq9kFoE6/2LIbrud66CVO1vAVsYomrl6m0O/nC
 MZu3H4GhAdO0FgpD2zJ+yEFYnXlgSPrjIuQOZ1Tc4Sa9vK0QZ040Glv38O99yavZ9mP0
 BNS823odZ/QAGUbl7LUJSOPsZi+h31FyUGa/ykcnCSSXz75mj31jzypSvf1L76ucvfrX WA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x8pt70121-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 18:01:14 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 432I1Dtf009350;
	Tue, 2 Apr 2024 18:01:13 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x8pt7011r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 18:01:13 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 432I0tfR029616;
	Tue, 2 Apr 2024 18:01:12 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x6ys2ypvh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 18:01:12 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 432I16XT33620508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Apr 2024 18:01:08 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A898A2004F;
	Tue,  2 Apr 2024 18:01:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 305C120043;
	Tue,  2 Apr 2024 18:01:05 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.171.41.83])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue,  2 Apr 2024 18:01:05 +0000 (GMT)
Date: Tue, 2 Apr 2024 20:01:03 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg
 <johannes@sipsolutions.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Ilpo
 =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Vadim Pasternak
 <vadimp@nvidia.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu
 Poirier <mathieu.poirier@linaro.org>,
        Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
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
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        Halil Pasic
 <pasic@linux.ibm.com>
Subject: Re: [PATCH vhost v7 2/6] virtio: remove support for names array
 entries being null.
Message-ID: <20240402200103.19618d0c.pasic@linux.ibm.com>
In-Reply-To: <20240328080348.3620-3-xuanzhuo@linux.alibaba.com>
References: <20240328080348.3620-1-xuanzhuo@linux.alibaba.com>
	<20240328080348.3620-3-xuanzhuo@linux.alibaba.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6KSAETINDiOyU9QFEllktnLI-PyY1diP
X-Proofpoint-GUID: xwEdoevRFYCwufoSFRJa0qEo9oBQY5g_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_10,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 clxscore=1011 mlxscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2403210000 definitions=main-2404020133
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240402_110127_070961_127535DB 
X-CRM114-Status: GOOD (  16.80  )
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

On Thu, 28 Mar 2024 16:03:44 +0800
Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:

> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -659,7 +659,7 @@ static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>  {
>  	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
>  	unsigned long *indicatorp = NULL;
> -	int ret, i, queue_idx = 0;
> +	int ret, i;
>  	struct ccw1 *ccw;
>  
>  	ccw = ccw_device_dma_zalloc(vcdev->cdev, sizeof(*ccw));
> @@ -668,11 +668,11 @@ static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>  
>  	for (i = 0; i < nvqs; ++i) {
>  		if (!names[i]) {
> -			vqs[i] = NULL;
> -			continue;
> +			ret = -EINVAL;
> +			goto out;
>  		}
>  
> -		vqs[i] = virtio_ccw_setup_vq(vdev, queue_idx++, callbacks[i],
> +		vqs[i] = virtio_ccw_setup_vq(vdev, i, callbacks[i],
>  					     names[i], ctx ? ctx[i] : false,
>  					     ccw);
>  		if (IS_ERR(vqs[i])) {

For the virtio-ccw part:
Acked-by: Halil Pasic <pasic@linux.ibm.com>

