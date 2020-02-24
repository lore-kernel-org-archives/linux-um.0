Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j6Jon-000504-78
 for linux-um@lists.infradead.org; Mon, 24 Feb 2020 19:55:06 +0000
Subject: Re: [PATCH v3] virtio: Work around frames incorrectly marked as gso
References: <20200224132550.2083-1-anton.ivanov@cambridgegreys.com>
 <CA+FuTSd8P6uQnwisZEh7+nfowW9qKLBEvA4GPg+xUkjBa-6TDA@mail.gmail.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <4e7757cf-148e-4585-b358-3b38f391275d@cambridgegreys.com>
Date: Mon, 24 Feb 2020 19:54:57 +0000
MIME-Version: 1.0
In-Reply-To: <CA+FuTSd8P6uQnwisZEh7+nfowW9qKLBEvA4GPg+xUkjBa-6TDA@mail.gmail.com>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Eric Dumazet <eric.dumazet@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Network Development <netdev@vger.kernel.org>, Jason Wang <jasowang@redhat.com>, linux-um@lists.infradead.org, virtualization@lists.linux-foundation.org

On 24/02/2020 19:27, Willem de Bruijn wrote:
> On Mon, Feb 24, 2020 at 8:26 AM <anton.ivanov@cambridgegreys.com> wrote:
>>
>> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>>
>> Some of the locally generated frames marked as GSO which
>> arrive at virtio_net_hdr_from_skb() have no GSO_TYPE, no
>> fragments (data_len = 0) and length significantly shorter
>> than the MTU (752 in my experiments).
> 
> Do we understand how these packets are generated? 

No, we have not been able to trace them.

The only thing we know is that this is specific to locally generated 
packets. Something arriving from the network does not show this.

> Else it seems this
> might be papering over a deeper problem.
> 
> The stack should not create GSO packets less than or equal to
> skb_shinfo(skb)->gso_size. See for instance the check in
> tcp_gso_segment after pulling the tcp header:
> 
>          mss = skb_shinfo(skb)->gso_size;
>          if (unlikely(skb->len <= mss))
>                  goto out;
> 
> What is the gso_type, and does it include SKB_GSO_DODGY?
> 


0 - not set.

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

