Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j6DCZ-0006ZD-P1
 for linux-um@lists.infradead.org; Mon, 24 Feb 2020 12:51:13 +0000
Subject: Re: [PATCH v2] virtio: Work around frames incorrectly marked as gso
References: <20200224101912.14074-1-anton.ivanov@cambridgegreys.com>
 <20200224074516-mutt-send-email-mst@kernel.org>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <ca0ca1b6-b453-cba0-adb0-42a9517743e9@cambridgegreys.com>
Date: Mon, 24 Feb 2020 12:51:05 +0000
MIME-Version: 1.0
In-Reply-To: <20200224074516-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, linux-um@lists.infradead.org, eric.dumazet@gmail.com, virtualization@lists.linux-foundation.org



On 24/02/2020 12:46, Michael S. Tsirkin wrote:
> On Mon, Feb 24, 2020 at 10:19:12AM +0000, anton.ivanov@cambridgegreys.com wrote:
>> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>>
>> Some of the locally generated frames marked as GSO which
>> arrive at virtio_net_hdr_from_skb() have no GSO_TYPE, no
>> fragments (data_len = 0) and length significantly shorter
>> than the MTU (752 in my experiments).
>>
>> This is observed on raw sockets reading off vEth interfaces
>> in all 4.x and 5.x kernels I tested.
> 
> A bit more info on how to reproduce couldn't hurt here.

Will do, a v3 will follow shortly.

> 
>>
>> These frames are reported as invalid while they are in fact
>> gso-less frames.
>>
>> This patch marks the vnet header as no-GSO for them instead
>> of reporting it as invalid.
>>
>> Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Eric - as you looked at this in the past, would you mind acking please?
> 
>> ---
>>   include/linux/virtio_net.h | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
>> index 0d1fe9297ac6..94fb78c3a2ab 100644
>> --- a/include/linux/virtio_net.h
>> +++ b/include/linux/virtio_net.h
>> @@ -100,8 +100,8 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
>>   {
>>   	memset(hdr, 0, sizeof(*hdr));   /* no info leak */
>>   
>> -	if (skb_is_gso(skb)) {
>> -		struct skb_shared_info *sinfo = skb_shinfo(skb);
>> +	struct skb_shared_info *sinfo = skb_shinfo(skb);

I need to move this a few lines up - the kernel build robot is quite rightfully complaining.

>> +	if (skb_is_gso(skb) && sinfo->gso_type) {
>>   
>>   		/* This is a hint as to how much should be linear. */
>>   		hdr->hdr_len = __cpu_to_virtio16(little_endian,
>> -- 
>> 2.20.1
> 
> 

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

