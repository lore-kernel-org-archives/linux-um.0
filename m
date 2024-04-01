Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A7CCD128A
	for <linux-um@archiver.kernel.org>; Mon,  1 Apr 2024 19:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aZXSfjaMBc291x0r5s10KrZuyuUQ5nACgOTXqz/o1xA=; b=q7C+SXfIbDpjv8nkcSSdyFrpoF
	NAa2fH81PSrj8vmBkCGDIOwVdQD365wAKsvv4SKYf/iY5hS47nbXCUGJFNiY2/hGU+8dsjC19XzJC
	aJuOTrPkhoPSk2bFZQuzq/s47gKsy6ecTOW7GhZCLwiFgKMVvEDqwCc/aEwMgHAVjTVsx4mqghEiZ
	50p1ZbpQ2/aPFKgkpRyP+ipRpGuZQ57L28/ZMNHkoiDWGO20IJm2gC94rbxA1E908taXo9ygl6kJD
	X7CGAEVlpb5r6ShNfVSmAAcpBlhtuAKL4NRyteb06CKwIb7uTyAhkHl9lHhYobG7KvVWviZfUC0fq
	VSV3ovGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrNnI-00000008jdN-1qDS;
	Mon, 01 Apr 2024 19:58:12 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrNnF-00000008jct-0fIJ
	for linux-um@lists.infradead.org;
	Mon, 01 Apr 2024 19:58:10 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 431JvMSh031777;
	Mon, 1 Apr 2024 19:58:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=aZXSfjaMBc291x0r5s10KrZuyuUQ5nACgOTXqz/o1xA=;
 b=MtHMONJuWI4BS/OncPb0G7UrCd5a1+upLwg++2BRNDWxwG8OTvS/RePABsXe2if5KM4C
 dDkuazOhECPw8qR+s4101+Zft/cEIzyqHsY2YIa3hX88Q4l4oF1oTV8QcQXF6cFvOIZj
 zDCxyI5AksU/IVWVVJWYJE3daa6gbNXDjDjlm6ThtFbOc8GsVoB4cM3v040OVga5p6G1
 AuBAWS0Kz/yOzSBGzC10SPzScenKFWuo+7fKvyVdiJLyo/JpI5j+onOnzcxnq+0Z6mfL
 PpUIV1+gheVFXjFIE3250QLz8q6OL2F+0ET4DDid0vH0rgpTPAtaImyepWK6lc0tYfGj Eg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x83hhg036-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 19:58:01 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 431Jw1S8032297;
	Mon, 1 Apr 2024 19:58:01 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x83hhg030-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 19:58:01 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 431Ixw7p002194;
	Mon, 1 Apr 2024 19:57:59 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x6xjma0by-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 19:57:59 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 431Jvu8Q27067096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Apr 2024 19:57:58 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7F5B58054;
	Mon,  1 Apr 2024 19:57:56 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AAFE65805A;
	Mon,  1 Apr 2024 19:57:53 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown [9.61.184.184])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Apr 2024 19:57:53 +0000 (GMT)
Message-ID: <cbdce01bbf2843062f4afd7e5c9af767e69cc70b.camel@linux.ibm.com>
Subject: Re: [PATCH vhost v7 0/6] refactor the params of find_vqs()
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
Date: Mon, 01 Apr 2024 15:57:53 -0400
In-Reply-To: <20240328080348.3620-1-xuanzhuo@linux.alibaba.com>
References: <20240328080348.3620-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CVJdQ_e6TRRp_yDfdRwGfh273GvCB2h1
X-Proofpoint-ORIG-GUID: Ruk7klDLWbFbZ4w-u3ObzCq-1Zf9Ly1V
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_14,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=924
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404010139
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240401_125809_427925_9308F962 
X-CRM114-Status: GOOD (  15.01  )
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
> This pathset is splited from the
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0
> http://lore.kernel.org/all/20240229072044.77388-1-xuanzhuo@linux.alibaba.=
com
>=20
> That may needs some cycles to discuss. But that notifies too many
> people.

This will need to be rebased to 6.9; there were some conflicts when I
tried to apply this locally which I didn't chase down, but it works
fine on 6.8.

Thanks,
Eric

