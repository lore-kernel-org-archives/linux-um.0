Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17315CD1284
	for <linux-um@archiver.kernel.org>; Tue,  2 Apr 2024 20:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6EFIqdA8XplVJ0ZlXfVio2BHcRwEuUtC9S9wzigAU+M=; b=pbk+ROneEzzwV7+RsJ2R31vbxt
	mZyziDCUGYakVuxKFa6Ft9gWp8fiUzYMWDYQppQNk8bhw5myVM9fwVrXyQf7hv1n3wwfZTxHLDsp5
	VSXUpMp7eirF8aKK4HjidAfweM3yZze940a8/DeQanol/f+llyMFBoJajPXuYraTXXuzpQs7AmjRj
	/tfDSje47gHXBpehBzoGZ0r5KLGWaOLfQIq5A2HB7CfqEllh1nRe6jvOZJu5HzOE9V1RBTTuIbDwu
	abi9FwoOqhXJlbUQslHhH3m/BCXU1uCJIkRHQcqHqC2nMRXvrUE2YtCG1zGgbu3HK3A/3AUffH9ln
	PwyU9mUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrkr9-0000000CiTn-1oIQ;
	Tue, 02 Apr 2024 20:35:43 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrkr6-0000000CiRV-1fKN
	for linux-um@lists.infradead.org;
	Tue, 02 Apr 2024 20:35:41 +0000
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 432KPY5t000389;
	Tue, 2 Apr 2024 20:35:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=6EFIqdA8XplVJ0ZlXfVio2BHcRwEuUtC9S9wzigAU+M=;
 b=DW2RbcUO3AVtSM2K4B4m8Fk5O7A/sDhJrjK5noD2OpuJhzqpTwUJMstFQknfuSLL6J68
 FX8UjmJ5uXNrup4N2jjlYnNb03fnEFYnhoZtLfWVTUzkpGBZr1uEkkkQJkxY0Uk/5+hI
 PEoczFJ3b2mVMmlKTr+rHQBRzGlSEiUJG1qSuxclS4swMLUSCfdQ8ot1D6NybNAJ8Grl
 vijMU7WSd/WuXdIBIszVJM7axoa6Dt8AJF9/T9Rvgg3xHgK2SmZ9A7zVr36RZ6M7dgfB
 scNBTZtYHptON1oz0lyjHuxYdGFP9/vuEcdl2U61TvqeMcXAwOK6qcFEEVMPOj1smAvO HA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x8ruj81cm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 20:35:29 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 432KZSkJ017805;
	Tue, 2 Apr 2024 20:35:28 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x8ruj81ch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 20:35:28 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 432JnwGb002181;
	Tue, 2 Apr 2024 20:35:27 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x6xjmgvag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 20:35:26 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 432KZLrl31392128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Apr 2024 20:35:23 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A2102004E;
	Tue,  2 Apr 2024 20:35:21 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4B4F20043;
	Tue,  2 Apr 2024 20:35:19 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.171.41.83])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue,  2 Apr 2024 20:35:19 +0000 (GMT)
Date: Tue, 2 Apr 2024 22:35:18 +0200
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
Subject: Re: [PATCH vhost v7 3/6] virtio: find_vqs: pass struct instead of
 multi parameters
Message-ID: <20240402223518.0add6cd3.pasic@linux.ibm.com>
In-Reply-To: <20240328080348.3620-4-xuanzhuo@linux.alibaba.com>
References: <20240328080348.3620-1-xuanzhuo@linux.alibaba.com>
	<20240328080348.3620-4-xuanzhuo@linux.alibaba.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7jDpQ1yMOWcm-IM2KD26JVVAa_AXcVrs
X-Proofpoint-ORIG-GUID: sstjIMr-0FUHN7IGukXRCXEPlGwbSdCP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_13,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404020152
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240402_133540_467572_3CEB24B1 
X-CRM114-Status: GOOD (  19.27  )
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

On Thu, 28 Mar 2024 16:03:45 +0800
Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:

> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -499,9 +499,8 @@ static void virtio_ccw_del_vqs(struct virtio_device *vdev)
>  }
>  
>  static struct virtqueue *virtio_ccw_setup_vq(struct virtio_device *vdev,
> -					     int i, vq_callback_t *callback,
> -					     const char *name, bool ctx,
> -					     struct ccw1 *ccw)
> +					     int i, struct ccw1 *ccw,
> +					     struct virtio_vq_config *cfg)
>  {
>  	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
>  	bool (*notify)(struct virtqueue *vq);
> @@ -538,8 +537,11 @@ static struct virtqueue *virtio_ccw_setup_vq(struct virtio_device *vdev,
>  	}
>  	may_reduce = vcdev->revision > 0;
>  	vq = vring_create_virtqueue(i, info->num, KVM_VIRTIO_CCW_RING_ALIGN,
> -				    vdev, true, may_reduce, ctx,
> -				    notify, callback, name);
> +				    vdev, true, may_reduce,
> +				    cfg->ctx ? cfg->ctx[i] : false,
> +				    notify,
> +				    cfg->callbacks[i],
> +				    cfg->names[i]);
>  
>  	if (!vq) {
>  		/* For now, we fail if we can't get the requested size. */
> @@ -650,15 +652,13 @@ static int virtio_ccw_register_adapter_ind(struct virtio_ccw_device *vcdev,
>  	return ret;
>  }
>  
> -static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
> -			       struct virtqueue *vqs[],
> -			       vq_callback_t *callbacks[],
> -			       const char * const names[],
> -			       const bool *ctx,
> -			       struct irq_affinity *desc)
> +static int virtio_ccw_find_vqs(struct virtio_device *vdev,
> +			       struct virtio_vq_config *cfg)
>  {
>  	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
> +	struct virtqueue **vqs = cfg->vqs;
>  	unsigned long *indicatorp = NULL;
> +	unsigned int nvqs = cfg->nvqs;
>  	int ret, i;
>  	struct ccw1 *ccw;
>  
> @@ -667,14 +667,12 @@ static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>  		return -ENOMEM;
>  
>  	for (i = 0; i < nvqs; ++i) {
> -		if (!names[i]) {
> +		if (!cfg->names[i]) {
>  			ret = -EINVAL;
>  			goto out;
>  		}
>  
> -		vqs[i] = virtio_ccw_setup_vq(vdev, i, callbacks[i],
> -					     names[i], ctx ? ctx[i] : false,
> -					     ccw);
> +		vqs[i] = virtio_ccw_setup_vq(vdev, i, ccw, cfg);
>  		if (IS_ERR(vqs[i])) {
>  			ret = PTR_ERR(vqs[i]);
>  			vqs[i] = NULL;

For the virtio-ccw part:
Acked-by: Halil Pasic <pasic@linux.ibm.com>

