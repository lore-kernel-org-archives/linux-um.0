Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nArp8-00Ek7J-B4
 for linux-um@lists.infradead.org; Fri, 21 Jan 2022 11:11:20 +0000
Subject: Re: [PATCH] um: Migrate vector drivers to NAPI
References: <20220121085557.1250299-1-anton.ivanov@cambridgegreys.com>
 <1d4806fe15c70bdfa5fa5d50d63ef1208f6e40a8.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <f1eaf186-ce50-172c-d2c8-1f69701c2f40@cambridgegreys.com>
Date: Fri, 21 Jan 2022 11:11:05 +0000
MIME-Version: 1.0
In-Reply-To: <1d4806fe15c70bdfa5fa5d50d63ef1208f6e40a8.camel@sipsolutions.net>
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
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: richard@nod.at



On 21/01/2022 09:29, Johannes Berg wrote:
> On Fri, 2022-01-21 at 08:55 +0000, anton.ivanov@cambridgegreys.com
> wrote:
>> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>>
>> Migrate UML vector drivers from a bespoke scheduling mechanism
>> to NAPI.
> 
> Nice :)
> 
>> -static void vector_rx(struct vector_private *vp)
>> -{
>> -	int err;
>> -	int iter = 0;
>> -
>> -	if ((vp->options & VECTOR_RX) > 0)
>> -		while (((err = vector_mmsg_rx(vp)) > 0) && (iter < MAX_ITERATIONS))
> 
> You can remove the MAX_ITERATIONS define now.
> 
> 
>> +static int vector_poll(struct napi_struct *napi, int budget)
>>   {
>> -	struct vector_private *vp = from_tasklet(vp, t, tx_poll);
>> +	struct vector_private *vp = container_of(napi, struct vector_private, napi);
>> +	int work_done = 0;
>> +	int err;
>> +	bool tx_enqueued = false;
>>   
>> -	vp->estats.tx_kicks++;
>> -	vector_send(vp->tx_queue);
>> +	if ((vp->options & VECTOR_TX) != 0)
>> +		tx_enqueued = (vector_send(vp->tx_queue) > 0);
>> +	if ((vp->options & VECTOR_RX) > 0)
>> +		err = vector_mmsg_rx(vp);
>> +	else {
>> +		err = vector_legacy_rx(vp);
> 
> It feels like you should honour the NAPI and pass the budget down, using
> it to limit the number of packets processed for TX/RX, something like
> 
> tx_enqueued = vector_send(..., budget);
> budget -= tx_enqueued;

Looking through the source of other drivers - they do not account tx in budget.

It tried to add it as an experiment - this incurs quite a performance penalty.

> 
> if (budget > 0)
> 	err = vector_mmsg_rx(vp, budget);

This one works as advertised it will be in v2 which will hit the mailing list shortly.


> 
> etc.
> 
>> @@ -1264,6 +1251,10 @@ static int vector_net_open(struct net_device *dev)
>>   		if (vp->header_txbuffer == NULL)
>>   			goto out_close;
>>   	}
>> +	/* NAPI */
>> +
> 
> That comment feels a bit pointless, but whatever :)
> 
>> +	netif_napi_add(vp->dev, &vp->napi, vector_poll, 64);
>> +	napi_enable(&vp->napi);
> 
> I think this should only be done once when you create the netdev?
> 
> 
>> @@ -1312,9 +1303,11 @@ static int vector_net_open(struct net_device *dev)
>>   	 * SIGIOs never arrive, and the net never works.
>>   	 */
>>   
>> -	vector_rx(vp);
>>   
>>   	vector_reset_stats(vp);
>> +
>> +	napi_schedule(&vp->napi);
>>
> 
> The comment should probably move with this?
> 
> johannes
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

