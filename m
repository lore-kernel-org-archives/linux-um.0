Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ieFCC-0000Ci-6c
 for linux-um@lists.infradead.org; Mon, 09 Dec 2019 09:19:14 +0000
Subject: Invalid GSO - from 4.x (TBA) to 5.5-rc1. Was: Re: 64 bit time
 regression in recvmmsg()
References: <3820d68b-1d97-8f41-d55d-237d1695458c@cambridgegreys.com>
 <CAMuHMdWuiGC4ay=f6M2H=-PLiffavnFSu8CPXE26euAi6aoY0w@mail.gmail.com>
 <CAK8P3a1mrFgRyh5Fgv-d8Szd2pq0T6Ac7wL3ogeYcf-Uyrg4ZQ@mail.gmail.com>
 <a5b9709d-b93b-46e1-ab18-a94ab921ccf7@cambridgegreys.com>
 <9dc1be66-5c55-8b3d-875b-4e1206914e78@cambridgegreys.com>
 <CAK8P3a1KcRcpUB2PdA17tnHN_dDs2Y02zPtkgM22Z-JdugAkfQ@mail.gmail.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <e96aebcc-907a-d86f-ea8f-f5b10f74f39b@cambridgegreys.com>
Date: Mon, 9 Dec 2019 09:19:04 +0000
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1KcRcpUB2PdA17tnHN_dDs2Y02zPtkgM22Z-JdugAkfQ@mail.gmail.com>
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
To: Arnd Bergmann <arnd@arndb.de>
Cc: netdev <netdev@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>



On 06/12/2019 20:06, Arnd Bergmann wrote:
> On Fri, Dec 6, 2019 at 6:50 PM Anton Ivanov
> <anton.ivanov@cambridgegreys.com> wrote:
>> On 29/11/2019 16:34, Anton Ivanov wrote:
>>
>> I apologize, problem elsewhere. I have narrowed it down, it is a host
>> regression at the end, not a recvmmsg/time one.
>>
>> The EINVAL is occasionally returned from the guts of packet_rcv_vnet
>>
>> https://elixir.bootlin.com/linux/latest/ident/packet_rcv_vnet
>>
>> in af_packet. I am going to try to figure out exactly when it happens
>> and why.
>>
>> My sincere apologies,
> 
> No, worries, I'm glad it wasn't me this time ;-)

At some point in late 4.x (I am going to try narrowing down the 
version), gso code introduced a condition which should not occur:

We have

sinfo(skb)->gso_type = 0

while

sinfo(skb)->gso_size = 752.
skb->len = 818
skb->data_len = 0

As a result we get a skb which is GSO, but it has a no GSO type.

This shows up in virtio_net_hdr_from_skb() which detects the condition 
as invalid and returns an -EINVAL

A few interesting things.

1. Size is always 752.

2. I have found it while tracing an -EINVAL when using recvmmsg() on raw 
sockets. No idea if it shows up elsewhere.

3. The environment under test is reading/writing to a raw socket opened 
on a vEth pair configured as follows:


ip link add l-veth0 type veth peer name p-veth0 && ifconfig p-veth0 up
ifconfig l-veth0 192.168.97.1 netmask 255.255.255.252

the UML linux instance used as a reader/writer relies on 
recvmmsg/sendmmesg raw socket with vnet headers enabled.

virtio_net_hdr_from_skb() is called from the af_packet packet_recv_vnet 
function.

This condition simply should not occur. A skb with no data in the frags, 
gso on, gso size less than MTU and no type looks bogus.


> 
>       Arnd
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

