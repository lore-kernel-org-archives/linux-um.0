Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j6JOx-0007rG-Ff
 for linux-um@lists.infradead.org; Mon, 24 Feb 2020 19:28:24 +0000
Received: by mail-yb1-xb43.google.com with SMTP id x9so3082640ybl.5
 for <linux-um@lists.infradead.org>; Mon, 24 Feb 2020 11:28:22 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com.
 [209.85.219.173])
 by smtp.gmail.com with ESMTPSA id l191sm31634ywb.12.2020.02.24.11.28.20
 for <linux-um@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2020 11:28:20 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id f130so5169431ybc.7
 for <linux-um@lists.infradead.org>; Mon, 24 Feb 2020 11:28:20 -0800 (PST)
MIME-Version: 1.0
References: <20200224132550.2083-1-anton.ivanov@cambridgegreys.com>
In-Reply-To: <20200224132550.2083-1-anton.ivanov@cambridgegreys.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 24 Feb 2020 14:27:42 -0500
Message-ID: <CA+FuTSd8P6uQnwisZEh7+nfowW9qKLBEvA4GPg+xUkjBa-6TDA@mail.gmail.com>
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
To: anton.ivanov@cambridgegreys.com
Cc: Eric Dumazet <eric.dumazet@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Network Development <netdev@vger.kernel.org>, Jason Wang <jasowang@redhat.com>, linux-um@lists.infradead.org, virtualization@lists.linux-foundation.org

On Mon, Feb 24, 2020 at 8:26 AM <anton.ivanov@cambridgegreys.com> wrote:
>
> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>
> Some of the locally generated frames marked as GSO which
> arrive at virtio_net_hdr_from_skb() have no GSO_TYPE, no
> fragments (data_len = 0) and length significantly shorter
> than the MTU (752 in my experiments).

Do we understand how these packets are generated? Else it seems this
might be papering over a deeper problem.

The stack should not create GSO packets less than or equal to
skb_shinfo(skb)->gso_size. See for instance the check in
tcp_gso_segment after pulling the tcp header:

        mss = skb_shinfo(skb)->gso_size;
        if (unlikely(skb->len <= mss))
                goto out;

What is the gso_type, and does it include SKB_GSO_DODGY?

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

