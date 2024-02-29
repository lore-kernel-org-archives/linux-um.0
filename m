Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6DBEC54798
	for <linux-um@archiver.kernel.org>; Thu, 29 Feb 2024 09:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OO8aoyT7wIiEkulpJ6X9uJBZ8SvU8RhO2TJweGqWu6c=; b=qODU/cJhgj8nUIVhYLW+CdDdSU
	HIog03MuaLOYRwurWqJv2GhUxN/WruAhtQtjc3sjfLDxCf1bPcP7MUqx6QC1wmUeto7s3PDyZa1cg
	euStX77Pi+slvR4WMUwCbY8pzyn89yFq/eV8KYH47SeE8lFB2EGBU5sICw4hP1XtiuNPSwzINZW8T
	o/fINcCKqa1b4ajSXmByut8OMSpMI/22tTa6tRkGTwCepn6a2+mzR2tqY9NgL6UfVTqXgmr9OyDbC
	J865N8NN6AGVQK4/XomQWfHW0trfvhpjz7fsvB4cSvWe7PIu/aOqJEh4T+V6H9hwCNJ6kZlduplsL
	ctY3riRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfcv4-0000000CyDC-37eH;
	Thu, 29 Feb 2024 09:41:38 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfcv1-0000000Cy9l-3ut6
	for linux-um@lists.infradead.org;
	Thu, 29 Feb 2024 09:41:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=OO8aoyT7wIiEkulpJ6X9uJBZ8SvU8RhO2TJweGqWu6c=;
	t=1709199692; x=1710409292; b=EDbzzm2RmcqnJd6Et+CEEH1af2PIcHVwe4V/CvYrh5Nw5S4
	rFb4nzjfEHWlff3LoFTDkOI+TSmoiLPuMzN5DroO1f/8OnxNdKPvcbl8fL7MgmqNxIsdgQAwb4eI3
	UYxrNSHYHPP9mvEEzPWTC6EOkwbyZcqK73BaJDK9qxQ4UTPYc4wx/UpvbK23ARL1RO13BXzPrXwze
	CxVTogcp1x0480NmJjCrl8s6qXkn5WSOR/97TEdA1zEjk4kVwm4dmlmuwzUUzAjWCMIu3ztxzAVIf
	XVVwahH7ykr/MR632nKW0MkRSRZ1Dh1Eq0Bqn+hvr9Q+auOxsT7MkDDLg94WuIcw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rfcuf-0000000DTl5-2P62;
	Thu, 29 Feb 2024 10:41:13 +0100
Message-ID: <4825d7812ac06be3322ca4ae74e3650b2b0cd8de.camel@sipsolutions.net>
Subject: Re: [PATCH vhost v3 00/19] virtio: drivers maintain dma info for
 premapped vq
From: Johannes Berg <johannes@sipsolutions.net>
To: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
	 <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, Jason Wang
 <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Vadim
 Pasternak <vadimp@nvidia.com>, Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck
 <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Eric Farman
 <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>,  linux-um@lists.infradead.org,
 netdev@vger.kernel.org,  platform-driver-x86@vger.kernel.org,
 linux-remoteproc@vger.kernel.org,  linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, bpf@vger.kernel.org
Date: Thu, 29 Feb 2024 10:41:11 +0100
In-Reply-To: <20240229043238-mutt-send-email-mst@kernel.org>
References: <20240229072044.77388-1-xuanzhuo@linux.alibaba.com>
	 <20240229031755-mutt-send-email-mst@kernel.org>
	 <1709197357.626784-1-xuanzhuo@linux.alibaba.com>
	 <20240229043238-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240229_014136_006391_B5F953EA 
X-CRM114-Status: UNSURE (   6.25  )
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

On Thu, 2024-02-29 at 04:34 -0500, Michael S. Tsirkin wrote:
>=20
> So the patchset is big, I guess it will take a couple of cycles to
> merge gradually.

Could also do patches 7, 8, and maybe 9 separately first (which seem
reasonable even on their own) and get rid of CC'ing so many people and
lists for future iterations of the rest of the patchset :-)

johannes

