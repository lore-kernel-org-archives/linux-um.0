Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2772CC5475B
	for <linux-um@archiver.kernel.org>; Mon, 11 Mar 2024 12:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-ID:Content-Type:
	MIME-Version:References:Message-ID:In-Reply-To:Subject:cc:To:Date:From:
	Reply-To:Content-Transfer-Encoding:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BF0iv9HGoEWlT/2eHkMATRMWUfurYWFgkDd7XV/QqP8=; b=41bxaX6JSlZONgFvkyKQdcedZP
	OP/XT3DMweB9gyYCf8g9N9eSm6ZMXKip4qzoPzsWa2PAd3f/AobiDTH63YB+qdsP+CZvnZ9lQIoMD
	dpRqsR8Rea6RZiREtFY4zpEcAfw3BooVzA3p5226X0oIlpBvM0B73FFf6n9eiRyU2TelaEMtywj4Q
	zSu15TQQHmz0wxCEvjgiGO6vlB5Hnv1UGIHRAva3TfYFHSHGcc6PeK34J4zueLc/uVRARpZvZt+Fi
	3nyQy/tOexym1F1mue1SNFQaWJwogQ6MVr3O/XtQAorDalG11yUduIRrnEIOG7vO/dJXrHjPNL2pD
	q89Xu7NA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjehh-00000001SDx-0L7w;
	Mon, 11 Mar 2024 12:24:29 +0000
Received: from mgamail.intel.com ([198.175.65.13])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjehd-00000001SCu-2hOl
	for linux-um@lists.infradead.org;
	Mon, 11 Mar 2024 12:24:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710159866; x=1741695866;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=uvc2srdklbEZWRyAUkveO2lIu9fiESGPXlIMmlZAhO4=;
  b=PdwbUZF0PeJRQ0jGSJrP9BymHKRlzCj6LdoMhxBmNsics1sfaeHX9HWk
   TIG7jQHWFZBPHHBXlnaNpbf3aQG1Lw/9AlyNtO9ANup7U5DnSvdcxqQcG
   /u7wnG2CW5fZB0EY6kCoWzywCV9YdBc9aHLXa9iC+rMFYlKqjak13Obi5
   R2HdZQgxX6X9RtEXjTe0KnIzikKi9w2oVJEjWooM9gY7oCgy8YMqaBQ2a
   GRSRleyoueLnq185KTNXjngsbyIli8b55EwUk8tCltlWsgiHihpA9xJ8r
   WD3u733Ye1rwkJmnRyZRDICNO6HaWvxu/FczVC59aKmRerQU8SawvGTRT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="15956663"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="15956663"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 05:24:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="11240984"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.201])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 05:24:16 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 11 Mar 2024 14:24:11 +0200 (EET)
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>, 
    Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
    Johannes Berg <johannes@sipsolutions.net>, 
    Hans de Goede <hdegoede@redhat.com>, Vadim Pasternak <vadimp@nvidia.com>, 
    Bjorn Andersson <andersson@kernel.org>, 
    Mathieu Poirier <mathieu.poirier@linaro.org>, 
    Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
    Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
    Vasily Gorbik <gor@linux.ibm.com>, 
    Alexander Gordeev <agordeev@linux.ibm.com>, 
    Christian Borntraeger <borntraeger@linux.ibm.com>, 
    Sven Schnelle <svens@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
    Jason Wang <jasowang@redhat.com>, linux-um@lists.infradead.org, 
    platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
    linux-s390@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH vhost v2 0/4] refactor the params of find_vqs()
In-Reply-To: <20240311072113.67673-1-xuanzhuo@linux.alibaba.com>
Message-ID: <576263bc-5e86-5288-7fc5-de214dc622dd@linux.intel.com>
References: <20240311072113.67673-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-925155278-1710159757=:1071"
Content-ID: <c2f52b25-b189-ac04-112b-c9f04d16b66f@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240311_052425_841559_62D46722 
X-CRM114-Status: GOOD (  12.67  )
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-925155278-1710159757=:1071
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <f3d0e1c1-ebcb-baa0-324b-5ca93ffa7301@linux.intel.com>

On Mon, 11 Mar 2024, Xuan Zhuo wrote:

> This pathset is splited from the
>=20
>      http://lore.kernel.org/all/20240229072044.77388-1-xuanzhuo@linux.ali=
baba.com
>=20
> That may needs some cycles to discuss. But that notifies too many people.
>=20
> But just the four commits need to notify so many people.
> And four commits are independent. So I split that patch set,
> let us review these first.
>=20
> The patch set try to  refactor the params of find_vqs().
> Then we can just change the structure, when introducing new
> features.
>=20
> Thanks.
>=20
> v2:
>   1. add kerneldoc for "struct vq_transport_config" @ilpo.jarvinen
>=20
> v1:
>   1. fix some comments from ilpo.jarvinen@linux.intel.com
>=20
>=20
> Xuan Zhuo (4):
>   virtio: find_vqs: pass struct instead of multi parameters
>   virtio: vring_create_virtqueue: pass struct instead of multi
>     parameters
>   virtio: vring_new_virtqueue(): pass struct instead of multi parameters
>   virtio_ring: simplify the parameters of the funcs related to
>     vring_create/new_virtqueue()

FWIW,

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.
--8323328-925155278-1710159757=:1071--

