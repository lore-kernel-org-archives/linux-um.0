Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D0AC982EA
	for <linux-um@archiver.kernel.org>; Wed, 23 Sep 2026 10:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5qQnouxMXBaz7GRH1wNAX5+8qsLPLIKgVbqXxrNNlSM=; b=izFeR+dbvNELBw2LJV2TF01lMc
	3/7MvQE9qWe3v5V5CCS1yXsJonKm/euh5ZrsJdby8LsqnuJKuKUPvYrFnOu0iiqpZ9Rj6dJr5XJCE
	HKVDdq/dA75MAxqVgvngRSqZv+FsJfiSrzyOBWvO19H9+rz+f4U6rc4l3qPi5KkdlJ1Jy6TdaPzF2
	Vu7p1i9b1WgdmjmGTQu7VZF1CvbF75kokieILlLm7oS8n59LIjBW+7vDn1k4UIIRPzJdbo8axRozn
	nqu5KiWqhRjm223/LNltZ0hnwS/Q2gh5sJEgR8czL552j9Z2TpyJCmhlYLaKVGvJ1hX8AgLe+An1U
	fE4k7ZEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9KVA-00000007wCu-32x7;
	Wed, 23 Sep 2026 10:47:00 +0000
Received: from mail-qk2-x0e.google.com ([2607:f8b0:4864:34::e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9KV7-00000007wC9-3nzE
	for linux-um@lists.infradead.org;
	Wed, 23 Sep 2026 10:46:59 +0000
Received: by mail-qk2-x0e.google.com with SMTP id d75a77b69052e-52fb766bfd8so7677391cf.3
        for <linux-um@lists.infradead.org>; Wed, 23 Sep 2026 03:46:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790160416; cv=none;
        d=google.com; s=arc-20260327;
        b=Y315dGYdUIn9FFzBkYvVn8UkvFn0XMnoPJuJOvJ3iYEjI3G9fLNkCEfpQNGR4caOTd
         SGGMs4Kn+FWzsq5gJPbRIMXuc7OCsPNkHLB0Bxm7nFdFC3KTFeGEx/vx1IdymvwRvTCa
         xzqT8k1TVTHTm9Hf/KBRIocNPOwkvp8yrD6Wy1futp7CMoGCoP9KHIf9MGIYi+lt2axU
         WmTJYoC+gw/OJGGj4NZULCTN0rjO5m/P3QE9Bi8Fog+4gRteCbBYHeC6v9s6YVwdxC5s
         n0TzQ8IyejtfNe1o6kiSP2y2clT5eIktEP7emK1vjmylIO948QBTICzzGu4s4QPloR0H
         A3hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5qQnouxMXBaz7GRH1wNAX5+8qsLPLIKgVbqXxrNNlSM=;
        fh=dNb8elUp8wc8H1tptan8e9C1k135ecWYAWD93/YfdYg=;
        b=rpLNOfQym5wFZcFT2rPWUMMAzKLJY60bsfEH1kjJ6O9WK9jE2AdvVnBN6p5WVV7fGb
         u7QFo6XPrguH8Go1XYq2bogVXhqB3IYFMamxLPXHWEk2gC7ZiqvghimJzYADe+vjwCZa
         AQ4gEZmtETUOrKqTZYTZIN46mXHQf0x+x8hglzOixbIi8szX8c4WEZeoKMn7QBSBinga
         SuSKEOLq+OJnUG9y8DUBwVdUnxHBK6ZOb1tc4Ews+OBbWCaVcFqxEXbITR8WDMfxOzcD
         UltzShAxEdWgHy2cvxpduopH/uPvlNwJh1XNkTjKWcTTbbnimiK/21seZC/kLm5N+n3c
         ZWnQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790160415; x=1790765215; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5qQnouxMXBaz7GRH1wNAX5+8qsLPLIKgVbqXxrNNlSM=;
        b=vKCnmsxGZBo9c59c7UBbiXHzdYbTPX3f4YO5yLLgHzp4mU8VJqckpX12hOlB04t/xa
         9YHSDHTgQqQG+RXJbmf4yNEiM9V0aHkwEB4aHKH/tPylm6nLgR+J/BIuJBEB097W8cQ4
         qQ4G5eNHwuIU7mS7Xy4zg/3tfsZ1iNyAIMkAHKQwXoH0dNoOTNMYrkLPJvE/kDJcS1PD
         5qALKdm3eSCAjKXJ0Dg7XkH3USYZg6uMaAwqSdBMHkv7dgfjU7pxmy6mhNr3PYDLfSz/
         0U8t0SjHYb7DwWzsVBac6rBCDELcTZgg8KyDVO8B7jvZJ69Hf6goZ1rVq8bUJ0nAn3Ba
         9zUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790160416; x=1790765216;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5qQnouxMXBaz7GRH1wNAX5+8qsLPLIKgVbqXxrNNlSM=;
        b=Z3r4fp61uU/t8KZC+/KAoZ841aFvO0AvopDRjnOJpdKylpHpbeHz7Ouykz/BSDQj9E
         EfkBpUU73F0CP4EKsU4/U0VpQOJ5757PhpGvgtvWlxSthgyZIg+lP2FId6hIv6kNSK+v
         wlUwlcAaI3d1dCH/Ao47Q+c6NaRNuSk2Lw8uWIDUVBQvQsEhxVwvY3uPjtoSFYG5MmzA
         rppz1cGjZwLxgs0dzFOWMz6xMe+gQYdfAZVXd87klOfLRTSwDMPzWfoe6DbTNVPOVjIn
         5KBEmvjz//rYxfchjgq08BDhpKe5ysCmY5p0lBoMG9vb069sO7tndl8ZtqHsWmc3MquT
         gL2g==
X-Forwarded-Encrypted: i=1; AKwUvBxAHsLnrfrADAU/sz1Rml0U4tb2p98n02gUDOD3anFcxicMYnaGDQY7sojht6PD3ayVt9VPVGmh1Q==@lists.infradead.org
X-Gm-Message-State: AFuF++lOW69KUDWxHwn7q8djAa/92SIlNd7wy95TvyN52DWuP1chsf2I
	mbqOAPCacXf655G8RHKQtAEk6loTQr581J50PxiMDpHKcNS03Z5vR6SP6jR1gm5jxOZgLlGiDKU
	uWFcucCjpDkHrO4wynhfTAb5vlQb24adRyjjiv0pS
X-Gm-Gg: AYBFou0LIce7Wfipsl+xCR5FXhvW4uPrzTxjW3aYolBmUhpPYYr04STQv19ffAcj/jY
	ClPH2P/NMHEaFpWeh8vrKV+wKp9QSemoFVC6kd37SHwQsJW7hhUiUU4iNea+b1qezXpvmNEPb7h
	apwziMEGCGZ+STbjaisxisyeocoSQbQL7+26L7PgNgDTeS5DajFm/3bmKVIDJXSbV9u12ANo/vk
	rbBLp1YpYO0vUE+ymyVjAhEzluAQP18iYJmyVZJpCGNeZYEk7ni8rzjUm0AuK6WA/jvxeQeXBwb
	xdTWLYmcJLf2+DCrHrnKLTjaNLiyLOTA3+zGkNfy5TWmR85ou1w06lV/y+ztIANZBFyXqr7EV/H
	ZteYfWjEEAxnB0vBJE2AAFW6Sv+YpvhcbornOQ7AL+aC7Bs/ZtVJeA2N+JUyS1nkLiSSjEO1sc2
	7s9Mc=
X-Received: by 2002:a05:622a:2505:b0:530:e4fb:60fc with SMTP id
 d75a77b69052e-532eabdc770mr32673981cf.15.1790160414447; Wed, 23 Sep 2026
 03:46:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260922030310.8684-1-habte.yibelo@gmail.com> <20260922030310.8684-2-habte.yibelo@gmail.com>
 <willemdebruijn.kernel.259bc7096258d@gmail.com> <willemdebruijn.kernel.2cdfef118aa1d@gmail.com>
 <20260923061215-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260923061215-mutt-send-email-mst@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 23 Sep 2026 12:46:42 +0200
X-Gm-Features: AcwNN1U8Ts6TWBa2uXtOoMwvm8fJd83V_C6ZYk_pSBxsCdUgnTa4az_r5gjrcY4
Message-ID: <CANn89iJaE5UarTdg6FMEp=rZ9mG3g=xrVRLyvMS5S02iE8CwGg@mail.gmail.com>
Subject: Re: [PATCH net v6 1/2] net: validate virtio checksum start after
 network header
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Paulos Yibelo <habte.yibelo@gmail.com>, 
	netdev@vger.kernel.org, richard@nod.at, anton.ivanov@cambridgegreys.com, 
	johannes@sipsolutions.net, jasowangio@gmail.com, eperezma@redhat.com, 
	xuanzhuo@linux.alibaba.com, andrew+netdev@lunn.ch, pablo@netfilter.org, 
	fw@strlen.de, phil@nwl.cc, razor@blackwall.org, idosch@nvidia.com, 
	dsahern@kernel.org, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, linux-um@lists.infradead.org, 
	virtualization@lists.linux.dev, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, bridge@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260923_034657_982093_6538E2B9 
X-CRM114-Status: GOOD (  44.64  )
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

On Wed, Sep 23, 2026 at 12:21=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Tue, Sep 22, 2026 at 09:27:26PM -0400, Willem de Bruijn wrote:
> > Willem de Bruijn wrote:
> > > Paulos Yibelo wrote:
> > > > __virtio_net_hdr_to_skb() checks a minimum network-header length fo=
r
> > > > CHECKSUM_PARTIAL packets. Its checksum start is relative to skb->da=
ta,
> > > > but some callers have not established skb->network_header when they
> > > > convert the virtio header.
> > > >
> > > > Pass the data-relative L3 origin explicitly. Ethernet receive paths
> > > > parse the frame and nested VLAN headers without changing skb state.
> > > > AF_PACKET uses the frame's actual L3 origin even when the socket
> > > > protocol is ETH_P_IP and the raw frame carries VLAN tags. Non-Ether=
net
> > > > AF_PACKET devices retain their established skb network offset.
> > > >
> > > > Also pass the actual L3 protocol so IPv6 packets use the 40-byte ba=
se
> > > > header minimum even without TCPv6 GSO. IFF_TUN obtains that protoco=
l
> > > > from the packet before skb->protocol is set. Name the Ethernet pars=
er
> > > > accordingly, use the same origin for tunnel validation, and propaga=
te
> > > > conversion failures in UML.
> > > >
> > > > The bound remains a minimum; fragmentation paths separately validat=
e
> > > > the parsed IPv4 or IPv6 header length before completing a checksum.
> > > >
> > > > Fixes: 49d14b54a527 ("net: test for not too small csum_start in vir=
tio_net_hdr_to_skb()")
> > > > Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP G=
SO tunneling.")
> > > > Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
> > > > Link: https://lore.kernel.org/netdev/20260920004733.6473-2-habte.yi=
belo@gmail.com/
> > > > Cc: stable@vger.kernel.org
> > > > Assisted-by: LLM
> > > > Signed-off-by: Paulos Yibelo <habte.yibelo@gmail.com>
> > > > ---
> > > >  arch/um/drivers/vector_transports.c | 13 ++++-
> > > >  drivers/net/tun_vnet.h              | 52 ++++++++++++++++-
> > > >  drivers/net/virtio_net.c            | 10 +++-
> > > >  include/linux/virtio_net.h          | 87 ++++++++++++++++++++++++-=
----
> > > >  net/packet/af_packet.c              | 24 +++++++-
> > > >  5 files changed, 163 insertions(+), 23 deletions(-)
> > >
> > > The fix may still miss the case IPv4 packets have options.
> > >
> > > This version is a very large patch.
> > >
> > > Untested shorter first suggestion by bot, which looks plausible as a
> > > starting point for discussion.
> >
> > Cleaned up some more:
> >
> >     diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> >     index f4c652b1fa44..c24607af2aad 100644
> >     --- a/drivers/net/tun_vnet.h
> >     +++ b/drivers/net/tun_vnet.h
> >     @@ -180,6 +180,9 @@ static inline int tun_vnet_hdr_put(int sz, stru=
ct iov_iter *iter,
> >      static inline int tun_vnet_hdr_to_skb(unsigned int flags, struct s=
k_buff *skb,
> >                            const struct virtio_net_hdr *hdr)
> >      {
> >     +    if ((flags & TUN_TYPE_MASK) =3D=3D IFF_TUN)
> >     +        skb_reset_network_header(skb);
> >     +
> >          return virtio_net_hdr_to_skb(skb, hdr, tun_vnet_is_little_endi=
an(flags));
> >      }
> >
> >     @@ -199,6 +202,9 @@ tun_vnet_hdr_tnl_to_skb(unsigned int flags, net=
dev_features_t features,
> >                  struct sk_buff *skb,
> >                  const struct virtio_net_hdr_v1_hash_tunnel *hdr)
> >      {
> >     +    if ((flags & TUN_TYPE_MASK) =3D=3D IFF_TUN)
> >     +        skb_reset_network_header(skb);
> >     +
> >
> >     diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.=
h
> >     index c381b916c1b5..02c448de0802 100644
> >     --- a/include/linux/virtio_net.h
> >     +++ b/include/linux/virtio_net.h
> >     @@ -48,6 +48,42 @@ static inline int virtio_net_hdr_set_proto(struc=
t sk_buff *skb,
> >          return 0;
> >      }
> >
> >     +static inline int virtio_net_hdr_nh_min_len(const struct sk_buff *=
skb,
> >     +                        unsigned int nh_min_len)
> >     +{
> >     +    int thoff =3D skb_transport_offset(skb);
> >     +    __be16 proto;
> >     +    int nhoff;
> >     +
> >     +    if (skb_network_header_was_set(skb)) {
> >     +        nhoff =3D skb_network_offset(skb);
> >     +        proto =3D skb->protocol;
> >     +    } else {
> >     +        if (unlikely(thoff < ETH_HLEN))
> >     +            return -EINVAL;
> >     +        nhoff =3D ETH_HLEN;
> >     +        proto =3D eth_hdr(skb)->h_proto;
> >     +    }
> >     +
> >     +    if (eth_type_vlan(proto)) {
> >     +        proto =3D __vlan_get_protocol(skb, proto, &nhoff);
> >     +        if (!proto)
> >     +            return -EINVAL;
> >     +    }
> >     +
> >     +    if (proto =3D=3D htons(ETH_P_IP)) {
> >     +        const struct iphdr *iph =3D (void *)(skb->data + nhoff);
> >     +
> >     +        if (unlikely(thoff < nhoff + sizeof(*iph)))
> >     +            return -EINVAL;
> >     +        nh_min_len =3D max_t(u32, iph->ihl * 4, sizeof(*iph));
> >     +    } else if (proto =3D=3D htons(ETH_P_IPV6)) {
> >     +        nh_min_len =3D sizeof(struct ipv6hdr);
> >     +    }
> >     +
> >     +    return nhoff + nh_min_len;
> >     +}
> >     +
> >      static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
> >                            const struct virtio_net_hdr *hdr,
> >                            bool little_endian, u8 hdr_gso_type)
> >     @@ -98,13 +134,15 @@ static inline int __virtio_net_hdr_to_skb(stru=
ct sk_buff *skb,
> >              u32 start =3D __virtio16_to_cpu(little_endian, hdr->csum_s=
tart);
> >              u32 off =3D __virtio16_to_cpu(little_endian, hdr->csum_off=
set);
> >              u32 needed =3D start + max_t(u32, thlen, off + sizeof(__su=
m16));
> >     +        int min_thoff;
> >
> >              if (!pskb_may_pull(skb, needed))
> >                  return -EINVAL;
> >
> >              if (!skb_partial_csum_set(skb, start, off))
> >                  return -EINVAL;
> >     -        if (skb_transport_offset(skb) < nh_min_len)
> >     +        min_thoff =3D virtio_net_hdr_nh_min_len(skb, nh_min_len);
> >     +        if (min_thoff < 0 || skb_transport_offset(skb) < min_thoff=
)
> >                  return -EINVAL;
>
>
> Certainly looks much better. But I'd like to ask, generally:
> doesn't the net stack need to protect against weird packets?
>

It does, but csum_start/csum_offset are not "weird packet" material,
they are skb metadata, not bytes on the wire.

For essentially every skb in the kernel, this metadata is produced by
the kernel itself,
from headers it has just built or just parsed, and the rest of the
stack (GSO, skb_checksum_help(),
fragmentation, netfilter, and every driver doing TX csum offload)
consumes it as an invariant.

The only producers of attacker/guest controlled CHECKSUM_PARTIAL metadata a=
re
the virtio_net_hdr_to_skb() callers: af_packet, tun/tap, virtio_net,
and the UML vector driver.

So this is not "virtio specific validation", this is input validation
at the one trust boundary
where the invariant can be violated.

> It seems likely that not all drivers validate headers defensively,
> and incoming packets can easily become outgoing ones.

Packets coming from a real NIC are CHECKSUM_UNNECESSARY,
CHECKSUM_COMPLETE or CHECKSUM_NONE.
They do not carry a remote-provided csum_start.
(Remote checksum offload is the rare exception, and there the offsets
are computed by the stack from headers it just parsed.)

Incoming packets becoming outgoing ones is precisely the problem here:
a virtio_net RX skb with VIRTIO_NET_HDR_F_NEEDS_CSUM becomes
an skb that can be bridged/forwarded/fragmented and then handed to a real N=
IC.

> So do we even need virtio specific validation, or is it enough to
> validate everything in the net stack, where we are poking at the
> header anyway?

The core stack cannot afford it.

1) Drivers program skb->csum_start / skb->csum_offset straight into
the TX descriptor, and the NIC will happily write two bytes wherever
it was told, e.g. into the IP header of the frame we put on the wire.
Auditing/adding checks in every driver is not realistic, and drivers
must not pay for it.

2) Catching this in the core would mean re-parsing L2/L3 in
dev_hard_start_xmit()
(or in every place that eventually looks at the transport header) for
the 99.99+%
of packets that were built by the stack and are known to be consistent.
That is far more expensive than one check at injection time.

3) Failing at injection returns -EINVAL to the sendmsg()/writev() caller,
which is the correct and testable behavior. Failing later means dropping
the packet deep in the xmit path, usually with a splat: the commit being fi=
xed
here (49d14b54a527) exists exactly because such a packet reached
skb_checksum_help() from ip_do_fragment() and hit the "offset (-6) >=3D
skb_headlen() (14)" WARN.

>
> Or maybe it's more a defense in depth thing?
>
> My worries:
> - more poking at the header, more cache misses, where we really
>   do not need that

I do not expect anything measurable.

af_packet and tun: we have just copied that header from user space, it is i=
n L1.
virtio_net: we call eth_type_trans() right after, and GRO parses L3/L4
immediately.

The whole block is under the CHECKSUM_PARTIAL condition, where we already
do pskb_may_pull() and skb_partial_csum_set(), i.e. we already touch
this cache line.
Reading iph->ihl from a cache line we are about to read anyway is noise.

> - future protocol extensions that now will require surgery in
>   virtio, instead of just being passed through to the host

Fair, and this is an argument about how the check is written, not
about whether it exists.
The rule should be:

Only tighten the bound for the protocols we already parse (IPv4/IPv6),
and keep the existing generic minimum for anything else.

Then an unknown ethertype simply keeps flowing, no surgery is needed.
Willem's version does that. A new protocol would only be impacted if it wan=
ted
csum_start to point inside what we consider the L3 header, and such a packe=
t
would not survive the rest of the stack anyway.

So: not defense in depth, but validation at the trust boundary, where
it is cheapest
and where we can still report the error to the producer.

>
> What do others think?
>
> --
> MST
>

