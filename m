Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j6KER-0007e3-6V
 for linux-um@lists.infradead.org; Mon, 24 Feb 2020 20:21:36 +0000
Received: by mail-yb1-xb41.google.com with SMTP id i16so3167294ybp.6
 for <linux-um@lists.infradead.org>; Mon, 24 Feb 2020 12:21:33 -0800 (PST)
Received: from mail-yw1-f53.google.com (mail-yw1-f53.google.com.
 [209.85.161.53])
 by smtp.gmail.com with ESMTPSA id m15sm5606501ywh.78.2020.02.24.12.21.30
 for <linux-um@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2020 12:21:31 -0800 (PST)
Received: by mail-yw1-f53.google.com with SMTP id t141so5815028ywc.11
 for <linux-um@lists.infradead.org>; Mon, 24 Feb 2020 12:21:30 -0800 (PST)
MIME-Version: 1.0
References: <20200224132550.2083-1-anton.ivanov@cambridgegreys.com>
 <CA+FuTSd8P6uQnwisZEh7+nfowW9qKLBEvA4GPg+xUkjBa-6TDA@mail.gmail.com>
 <4e7757cf-148e-4585-b358-3b38f391275d@cambridgegreys.com>
In-Reply-To: <4e7757cf-148e-4585-b358-3b38f391275d@cambridgegreys.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 24 Feb 2020 15:20:53 -0500
Message-ID: <CA+FuTSdOCJZCVS4xohx+BQmkmq8JALnK=gGc0=qy1TbjY707ag@mail.gmail.com>
Subject: Re: [PATCH v3] virtio: Work around frames incorrectly marked as gso
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Eric Dumazet <eric.dumazet@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Network Development <netdev@vger.kernel.org>, Jason Wang <jasowang@redhat.com>, linux-um@lists.infradead.org, virtualization@lists.linux-foundation.org

On Mon, Feb 24, 2020 at 2:55 PM Anton Ivanov
<anton.ivanov@cambridgegreys.com> wrote:
>
> On 24/02/2020 19:27, Willem de Bruijn wrote:
> > On Mon, Feb 24, 2020 at 8:26 AM <anton.ivanov@cambridgegreys.com> wrote:
> >>
> >> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> >>
> >> Some of the locally generated frames marked as GSO which
> >> arrive at virtio_net_hdr_from_skb() have no GSO_TYPE, no
> >> fragments (data_len = 0) and length significantly shorter
> >> than the MTU (752 in my experiments).
> >
> > Do we understand how these packets are generated?
>
> No, we have not been able to trace them.
>
> The only thing we know is that this is specific to locally generated
> packets. Something arriving from the network does not show this.
>
> > Else it seems this
> > might be papering over a deeper problem.
> >
> > The stack should not create GSO packets less than or equal to
> > skb_shinfo(skb)->gso_size. See for instance the check in
> > tcp_gso_segment after pulling the tcp header:
> >
> >          mss = skb_shinfo(skb)->gso_size;
> >          if (unlikely(skb->len <= mss))
> >                  goto out;
> >
> > What is the gso_type, and does it include SKB_GSO_DODGY?
> >
>
>
> 0 - not set.

Thanks for the follow-up details. Is this something that you can trigger easily?

An skb_dump() + dump_stack() when the packet socket gets such a
packet may point us to the root cause and fix that.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

