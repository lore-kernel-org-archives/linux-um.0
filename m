Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iFMnk-0007yl-QG
 for linux-um@lists.infradead.org; Tue, 01 Oct 2019 18:23:10 +0000
Subject: Re: [PATCH v2] um: Loadable BPF "Firmware" for vector drivers
References: <20191001165537.3386-1-anton.ivanov@cambridgegreys.com>
 <0c6503e6b74ed1f25457d9919552fbfe48b68f37.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <1a5ed73e-be91-5f0b-d061-213e90c48316@cambridgegreys.com>
Date: Tue, 1 Oct 2019 19:23:05 +0100
MIME-Version: 1.0
In-Reply-To: <0c6503e6b74ed1f25457d9919552fbfe48b68f37.camel@sipsolutions.net>
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

On 01/10/2019 18:33, Johannes Berg wrote:
> On Tue, 2019-10-01 at 17:55 +0100, Anton Ivanov wrote:
>>
>> +	vp->bpf->filter = kmalloc(fw->size, GFP_KERNEL);
>> +	if (!vp->bpf->filter)
>> +		goto free_buffer;
>> +
>> +	memcpy(vp->bpf->filter, fw->data, fw->size);
> 
> Also, that's really just kmemdup().
> 
>> +	release_firmware(fw);
>> +
>> +	vp->bpf->len = fw->size / sizeof(struct sock_filter);
> 
> and that's a use-after-free, afaict?
> 
> johannes
> 
> 
> 
Ughhh... well spotted. New version later today.

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

