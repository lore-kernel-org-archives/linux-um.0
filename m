Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B18C5475B
	for <linux-um@archiver.kernel.org>; Tue, 20 Feb 2024 14:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lwg89Fejrts84YeaKU8repsaV4y5Gi7gxXNcjrj4/H0=; b=SQ9B4aP+hlEI4t/LUOOiqngOXy
	OoaVu4Wp88mKTSOW6LOmdoqL3D1umxTiZdGJwn8qQufK2F2RnWuLDQi5bRekmat2y7i05wYVrB9pP
	hxStpUkoFkXMSzc9tPf2uBubuLzdiNCBvpkt5BqRLYBXebzR30eak6u/ng+RHRintDg2RELLnN53q
	wMUwLF48hbbCbgdEZeswo9yb7apWwkU9rl+sSBRVkLDJvAoqDsvt/uOPUuTA+UomWgiCeymnAjRDd
	TGpNDIeoTb1E71sWZD8hXX4o0t28HLiXzdYSzIA9gfHxraMyTKxKIesqa0OoIso3vhDisFcsYQr3y
	ffAFfmSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcQxR-0000000F4lU-4AzX;
	Tue, 20 Feb 2024 14:18:54 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcQxO-0000000F4kk-3ddg
	for linux-um@lists.infradead.org;
	Tue, 20 Feb 2024 14:18:52 +0000
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41KDV1Hw025709;
	Tue, 20 Feb 2024 14:18:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=lwg89Fejrts84YeaKU8repsaV4y5Gi7gxXNcjrj4/H0=;
 b=fIWmtA/onYq24esqtZ73ktfPBTnYIpYFXlJDPahdh2CVKpi2f3XFRbRdvVoo8/s/Twg4
 Gugfrif7lC51GwCtxaDT6NUorELWUYRjE7k3f01QR8KyA49d9i2RKOk3orwiBV9xTmGe
 n1KjfGR6Vwu/m7F3FIG8MVapwpw3o9F2pqXNyZB6fFK+9Ucl/+slsOSzeK9EHXBxwrrp
 yQzHgzl7VvPWC9Xmjdfao7dHj0DO5L5WBUq6WDygLhepqV9ES4qXld+TKnxrYVcTs736
 HluvRBPiyKhzCPHYdcGLiVOE3cQ+IRmrOk1PP/IpgW6tphlXdeciCY5IEAkFpStTIop4 pA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wcunmkqgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 14:18:28 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41KE6dH7031572;
	Tue, 20 Feb 2024 14:18:26 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wcunmkqfc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 14:18:26 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41KDjTcI013492;
	Tue, 20 Feb 2024 14:18:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb7h08ube-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 14:18:24 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41KEIIx511535068
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 14:18:21 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC54F2006B;
	Tue, 20 Feb 2024 14:18:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 789E22006A;
	Tue, 20 Feb 2024 14:18:18 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.152.224.212])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 Feb 2024 14:18:18 +0000 (GMT)
Date: Tue, 20 Feb 2024 15:18:15 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, virtualization@lists.linux.dev,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov
 <anton.ivanov@cambridgegreys.com>,
        Johannes Berg
 <johannes@sipsolutions.net>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David
 S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Hans de Goede
 <hdegoede@redhat.com>,
        Ilpo =?UTF-8?B?SsOkcnZpbmVu?=
 <ilpo.jarvinen@linux.intel.com>,
        Vadim Pasternak <vadimp@nvidia.com>,
        Bjorn
 Andersson <andersson@kernel.org>,
        Mathieu Poirier
 <mathieu.poirier@linaro.org>,
        Cornelia Huck <cohuck@redhat.com>, Eric
 Farman <farman@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle
 <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
 <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John
 Fastabend <john.fastabend@gmail.com>,
        Benjamin Berg
 <benjamin.berg@intel.com>,
        Yang Li <yang.lee@linux.alibaba.com>, linux-um@lists.infradead.org,
        netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, bpf@vger.kernel.org,
        Halil
 Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH vhost 07/17] virtio: find_vqs: pass struct instead of
 multi parameters
Message-ID: <20240220151815.5c867cce.pasic@linux.ibm.com>
In-Reply-To: <1706756442.5524123-1-xuanzhuo@linux.alibaba.com>
References: <20240130114224.86536-1-xuanzhuo@linux.alibaba.com>
	<20240130114224.86536-8-xuanzhuo@linux.alibaba.com>
	<CACGkMEvb4N8kthr4qWXrLOh9v422OYhrYU6hQejusw-e5EacPw@mail.gmail.com>
	<1706756442.5524123-1-xuanzhuo@linux.alibaba.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eUllX_-qgAsmHKd_JgBJQZtujh7cPJYr
X-Proofpoint-ORIG-GUID: RtiekxNRFN2wBWltsYALkmwUnLKUTe6e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1011
 lowpriorityscore=0 spamscore=0 phishscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 mlxlogscore=809 adultscore=0 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402200103
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240220_061850_930059_4AA728E0 
X-CRM114-Status: GOOD (  17.65  )
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

On Thu, 1 Feb 2024 11:00:42 +0800
Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:

> > > And squish the parameters from transport to a structure.  
> > 
> > The patch did more than what is described here, it also switch to use
> > a structure for vring_create_virtqueue() etc.
> > 
> > Is it better to split?  
> 
> Sure.

I understand there will be a v2. From virtio-ccw perspective I have
no objections.

Regards,
Halil

