Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF9AC54E67
	for <linux-um@archiver.kernel.org>; Wed, 27 Mar 2024 12:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:In-Reply-To:Date:References:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n+h8EHTjfSBQfkfKiBHGrcQqpshC2gsV3USjcyLuFe4=; b=0AqmwCuCn1SJ8EsCvq1mRWJoIL
	ss8Yae+E2Z661i8L+TpizI+/hmULQXtNBlOCfvZBpiWQmgrmxuveN4X52+ir1IxuvwgzIZG/uGxWw
	Z/naGBOlaM9EQyFAdx5R/akvBs1Fv/4gtd43jNUsCvjFq63V8wqB8gGCuKXn0js5ifcB1uv+brHXx
	zbNRXpAvvX18EZMYw1rCcF8o305Me5pNw8jHdonTj+3ITH9Lx2PG8mZ10VsUM1SCOqFRajoshptW4
	xsW6HapVvXv+HUhl7Hzt0RmV5Y8RX2gfjQ8MD1MnD7W5hWHa+9xcaiTRCOphpepaNQE3kbNCJydHo
	0lIi3Bjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpSpR-000000092JY-1ryN;
	Wed, 27 Mar 2024 12:56:29 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpSpF-000000092DQ-1LEN;
	Wed, 27 Mar 2024 12:56:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 2187BCE2616;
	Wed, 27 Mar 2024 12:56:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C93C43390;
	Wed, 27 Mar 2024 12:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711544174;
	bh=t5Dr+QPEU1FaZbxI2VzHHPUV33oVM25Zuyjp8wRwBxQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=PeI1DRl97jSBL5h+TjLof7OmsdrUn8XoRsGQVaXc1QrS2MsqMVnRRdmF+M5dmweaA
	 Cf4i01dUWOny6pJ6QuLijRvpE44xS0PcZc1e9PeN+WBhzhBO4xJy/Ts3k409QwdVEV
	 p+A11VpmypxO3Ps9Q8jXDfwY+GDNk4U7h2495MzupWAahXb3s6nMhf4xTbKbYBv9sH
	 Qg2EVim4HGea+Pk1qx3RaNxw1jAVCalYFQ1zjH9SvFpUEhLNt2Q6UwcJWGcqLuJGpO
	 jNEGpE3iLazGfTCtetqVqdY3FWUY6/vKk+gRsmlO3tArdLh8t7rKXHMt3Lo2FnfSbu
	 armFDkXpy3JVQ==
From: Kalle Valo <kvalo@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,  Jason Wang
 <jasowang@redhat.com>,  Xuan Zhuo <xuanzhuo@linux.alibaba.com>,  Richard
 Weinberger <richard@nod.at>,  Anton Ivanov
 <anton.ivanov@cambridgegreys.com>,  Johannes Berg
 <johannes@sipsolutions.net>,  Paolo Bonzini <pbonzini@redhat.com>,  Stefan
 Hajnoczi <stefanha@redhat.com>,  Jens Axboe <axboe@kernel.dk>,  Marcel
 Holtmann <marcel@holtmann.org>,  Luiz Augusto von Dentz
 <luiz.dentz@gmail.com>,  Olivia Mackall <olivia@selenic.com>,  Herbert Xu
 <herbert@gondor.apana.org.au>,  Amit Shah <amit@kernel.org>,  Arnd
 Bergmann <arnd@arndb.de>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  Gonglei <arei.gonglei@huawei.com>,  "David
 S. Miller" <davem@davemloft.net>,  Viresh Kumar <vireshk@kernel.org>,
  Linus Walleij <linus.walleij@linaro.org>,  Bartosz Golaszewski
 <brgl@bgdev.pl>,  David Airlie <airlied@redhat.com>,  Gerd Hoffmann
 <kraxel@redhat.com>,  Gurchetan Singh <gurchetansingh@chromium.org>,
  Chia-I Wu <olvaffe@gmail.com>,  Jean-Philippe Brucker
 <jean-philippe@linaro.org>,  Joerg Roedel <joro@8bytes.org>,  Alexander
 Graf <graf@amazon.com>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Eric Van
 Hensbergen <ericvh@kernel.org>,  Latchesar Ionkov <lucho@ionkov.net>,
  Dominique Martinet <asmadeus@codewreck.org>,  Christian Schoenebeck
 <linux_oss@crudebyte.com>,  Stefano Garzarella <sgarzare@redhat.com>,  Dan
 Williams <dan.j.williams@intel.com>,  Vishal Verma
 <vishal.l.verma@intel.com>,  Dave Jiang <dave.jiang@intel.com>,  Ira Weiny
 <ira.weiny@intel.com>,  Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
  Bjorn Andersson <andersson@kernel.org>,  Mathieu Poirier
 <mathieu.poirier@linaro.org>,  "Martin K. Petersen"
 <martin.petersen@oracle.com>,  Vivek Goyal <vgoyal@redhat.com>,  Miklos
 Szeredi <miklos@szeredi.hu>,  Anton Yakovlev
 <anton.yakovlev@opensynergy.com>,  Jaroslav Kysela <perex@perex.cz>,
  Takashi Iwai <tiwai@suse.com>,  virtualization@lists.linux.dev,
  linux-doc@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-um@lists.infradead.org,  linux-block@vger.kernel.org,
  linux-bluetooth@vger.kernel.org,  linux-crypto@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-gpio@vger.kernel.org,
  dri-devel@lists.freedesktop.org,  iommu@lists.linux.dev,
  netdev@vger.kernel.org,  v9fs@lists.linux.dev,  kvm@vger.kernel.org,
  linux-wireless@vger.kernel.org,  nvdimm@lists.linux.dev,
  linux-remoteproc@vger.kernel.org,  linux-scsi@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  alsa-devel@alsa-project.org,
  linux-sound@vger.kernel.org
Subject: Re: [PATCH 17/22] wireless: mac80211_hwsim: drop owner assignment
References: <20240327-module-owner-virtio-v1-0-0feffab77d99@linaro.org>
	<20240327-module-owner-virtio-v1-17-0feffab77d99@linaro.org>
Date: Wed, 27 Mar 2024 14:55:58 +0200
In-Reply-To: <20240327-module-owner-virtio-v1-17-0feffab77d99@linaro.org>
	(Krzysztof Kozlowski's message of "Wed, 27 Mar 2024 13:41:10 +0100")
Message-ID: <87plvf7s0x.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_055617_779692_E9B1E4EF 
X-CRM114-Status: UNSURE (   9.63  )
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

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> virtio core already sets the .owner, so driver does not need to.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

We use "wifi:" in the title, not "wireless:". It would be nice if you
can fix this during commit.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

