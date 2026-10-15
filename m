Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E0ECCC6B33
	for <linux-um@archiver.kernel.org>; Thu, 15 Oct 2026 12:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5t7ujz0LRKmYSDnSpxRV4FUu+VgcIx5vzGaUrJmUsOs=; b=asgETjehlCJBUPUZRuqczamfAf
	UOWWUgQPzVep0iuQ6KV3gH/Om2QOaL8juJV8yBfZTY5/fMeqZeLBKRJJvHPZgMMp6OIHryI81mM06
	cdQKs8xIYQFji5IxABIpr1FpPGbWJ+MWaAdP8Vz/9s/+TirEPKWRtcbrvsezCj3LyU/JqqUpqN/uK
	LPVipvk8xxmFZh2xpjoV+WvrgOhstplclmlU4653WYbXAzekGr7wCuUJkcXCpvVQd/ZJ3H9SgyJia
	7uMp13ID8GuLEolVB0LDegUdXT2JSls0je1vFvHn+/JIxqFlqni8Kx143vn4yDLsxv1aiukSF07/R
	1EXSYt5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHKrf-000000009Z7-3wDu;
	Thu, 15 Oct 2026 12:47:19 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHKrd-000000009Xy-45bQ
	for linux-um@lists.infradead.org;
	Thu, 15 Oct 2026 12:47:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=5t7ujz0LRKmYSDnSpxRV4FUu+VgcIx5vzGaUrJmUsOs=;
	t=1792068437; x=1793278037; b=o1YB1tFJtNjN1v6J++UJvcpxiJFIlK5nnMdGaYmxDK8Yhaz
	mK5gYqYbRF+HoXax3QagkPBw8tvilIJujeF7OXBug+VYuseoFT77rgkeKuOOC9gWCQ8o7umo4oJyQ
	WAvVLgawxMvZrLB8ycTlYcSUT+7Y0QP3LT7CTWjKBmzsnVg8QPXwk9xERQaXI3y276ikTd9HuGQIv
	M+4+NTI3Tk7rcu26k9tDaJxEUzsHj6Xrjw9pGo7nwYUtHx4UCW9GwubnfBlHmaD6c3YaLX1V8v2Bh
	3bEmnQHM4xWicCc3ElErR4seXlZrcxbV5BtGNtlQMfS2m5VUlw5dgJCgST4GtSOQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xHKrO-00000003auM-2yCv;
	Thu, 15 Oct 2026 14:47:03 +0200
Message-ID: <8420ba1fe84fc7d105825026802d4ad10d44af71.camel@sipsolutions.net>
Subject: Re: [PATCH net-next v2 2/7] um: vector: honor virtio net hdr
 conversion failures
From: Johannes Berg <johannes@sipsolutions.net>
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jason Wang	
 <jasowangio@gmail.com>, Eugenio =?ISO-8859-1?Q?P=E9rez?=
 <eperezma@redhat.com>,  Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller"	 <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski	 <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, Rusty Russell <rusty@rustcorp.com.au>, Max
 Krasnyansky <maxk@qualcomm.com>, Richard Weinberger <richard@nod.at>, Anton
 Ivanov	 <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
Date: Thu, 15 Oct 2026 14:47:01 +0200
In-Reply-To: <6716834884238de0ab1ab313004044122aa2adbf.1792067836.git.mst@redhat.com>
References: <cover.1792067836.git.mst@redhat.com>
	 <6716834884238de0ab1ab313004044122aa2adbf.1792067836.git.mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261015_054718_094756_6F6BC826 
X-CRM114-Status: GOOD (  14.47  )
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

On Thu, 2026-10-15 at 08:41 -0400, Michael S. Tsirkin wrote:
> virtio_net_hdr_to_skb() refuses packets whose checksum metadata
> it cannot make sense of, but the vector raw transport ignored
> its return value: rejected packets went on into the stack with
> their metadata unvalidated.
>=20
> Propagate the failure.
>=20
> Assisted-by: LLM
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  arch/um/drivers/vector_transports.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/um/drivers/vector_transports.c b/arch/um/drivers/vector=
_transports.c
> index e1fb2a76fdff..8b7548458663 100644
> --- a/arch/um/drivers/vector_transports.c
> +++ b/arch/um/drivers/vector_transports.c
> @@ -210,7 +210,9 @@ static int raw_verify_header(
>  		return 1;
> =20
>  	skb_set_network_header(skb, ETH_HLEN);
> -	virtio_net_hdr_to_skb(skb, vheader, virtio_legacy_is_little_endian());
> +	if (virtio_net_hdr_to_skb(skb, vheader,
> +			virtio_legacy_is_little_endian()) < 0)
> +		return -1;
>  	return 0;
>=20

Seems it'd be simpler to just

	return virtio_net_hdr_to_skb(...);

As far as I can tell, the function only returns -EINVAL or 0 (never a
positive value), and the caller only cares about negative (error) or
positive (no checksum needed), so that'd be equivalent?

johannes

