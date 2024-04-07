Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBBCCD11C2
	for <linux-um@archiver.kernel.org>; Sun,  7 Apr 2024 06:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Date:Subject:Message-ID:
	Reply-To:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nv5U4hxWPS4bKJYdRAmApCzcDyYdxKTgR8eKush4hJU=; b=DqX5UoVxEHKNsTAO2gKEngwOac
	i7FV64Htb68tIBIFaVZrkWOo+wQOCg10F1M5OpsvpFUiwfLQ4jbNM/wf3eY0A7GBvGpwZg0ovzlLd
	vriHHDoSA8tceoMA16jMbnIgLWcrgSuMjk8m900dciceG33jdTCWT5CeNHFwyjM4vN/KeNHdFXWSO
	vxJ4OkT1YWFhFgp86Fvir8l3x55UR3StoHuHM7+bepkuaBdLkHyPjxyCMfq6jlrBu8zCvww1ZX+tP
	MOnRSL1/XzAViQjwbkVfKZh82YgDJFEs27QU9oaX8ceal6W9QkTiLodYV5AmDY34E1FSySxwHR77c
	9ZwCA5Nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtLik-0000000Bs3Q-25b0;
	Sun, 07 Apr 2024 06:09:38 +0000
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtLig-0000000Bs27-3klL
	for linux-um@lists.infradead.org;
	Sun, 07 Apr 2024 06:09:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712470170; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=nv5U4hxWPS4bKJYdRAmApCzcDyYdxKTgR8eKush4hJU=;
	b=u83ZXHgoUCPBRvV27j5Z9AGqCPMmOPgBC57FMHbfW8cT0NcQd4Z24pM6DK4ziKP1xcrKTVNgwNdB3WSGxu9Nw/yULmZBTeOpRRgehiekGC6c9wFaj+xxV5BF2YcmRAuf/3I8r12ClsF4HX+Wrf6A3wMfgEAIdsAUUWd1rtEfrPY=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=25;SR=0;TI=SMTPD_---0W4.JPHS_1712470168;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W4.JPHS_1712470168)
          by smtp.aliyun-inc.com;
          Sun, 07 Apr 2024 14:09:28 +0800
Message-ID: <1712470058.1558342-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v7 0/6] refactor the params of find_vqs()
Date: Sun, 7 Apr 2024 14:07:38 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Eric Farman <farman@linux.ibm.com>
Cc: Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Hans de Goede <hdegoede@redhat.com>,
 =?utf-8?q?IlpoJ=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Vadim Pasternak <vadimp@nvidia.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 linux-um@lists.infradead.org,
 platform-driver-x86@vger.kernel.org,
 linux-remoteproc@vger.kernel.org,
 linux-s390@vger.kernel.org,
 kvm@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20240328080348.3620-1-xuanzhuo@linux.alibaba.com>
 <cbdce01bbf2843062f4afd7e5c9af767e69cc70b.camel@linux.ibm.com>
In-Reply-To: <cbdce01bbf2843062f4afd7e5c9af767e69cc70b.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240406_230935_633631_8BDA0DAD 
X-CRM114-Status: UNSURE (   9.30  )
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

On Mon, 01 Apr 2024 15:57:53 -0400, Eric Farman <farman@linux.ibm.com> wrot=
e:
> On Thu, 2024-03-28 at 16:03 +0800, Xuan Zhuo wrote:
> > This pathset is splited from the
> >
> > =C2=A0=C2=A0=C2=A0=C2=A0
> > http://lore.kernel.org/all/20240229072044.77388-1-xuanzhuo@linux.alibab=
a.com
> >
> > That may needs some cycles to discuss. But that notifies too many
> > people.
>
> This will need to be rebased to 6.9; there were some conflicts when I
> tried to apply this locally which I didn't chase down, but it works
> fine on 6.8.

The target branch is Michael's vhost branch.

	https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/log/?h=3Dlin=
ux-next

I will rebase that after Michael updates the branch.

Thanks.


>
> Thanks,
> Eric

