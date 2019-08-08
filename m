Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hvdHT-0004if-HE
 for linux-um@lists.infradead.org; Thu, 08 Aug 2019 07:56:17 +0000
Subject: Re: [RFC] um: virtio: Workaround for using virtio_net with snabb
References: <20190731203030.29821-1-johannes@sipsolutions.net>
 <394f11ad-88e3-1d1f-8b8e-51fdc14aea8d@cambridgegreys.com>
 <1e988e1583b94761ba876827af24eede0c46ccf4.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <36928187-8013-9e25-3ff8-a7a0962c8274@cambridgegreys.com>
Date: Thu, 8 Aug 2019 08:56:05 +0100
MIME-Version: 1.0
In-Reply-To: <1e988e1583b94761ba876827af24eede0c46ccf4.camel@sipsolutions.net>
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
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Erel Geron <erelx.geron@intel.com>



On 08/08/2019 08:26, Johannes Berg wrote:
> On Wed, 2019-08-07 at 17:14 +0100, Anton Ivanov wrote:
>    
>>> +	/* TODO workaround for some implementations */
>>> +	if (vu_dev->vdev.id.device == VIRTIO_ID_NET)
>>> +		vu_dev->features &= ~BIT_ULL(VIRTIO_NET_F_CTRL_VQ) &
>>> +				~BIT_ULL(VIRTIO_NET_F_MQ);
>>
>> If it is needed only for some implementations, then it should be an option.
> 
> Yeah, I guess it should be. Then again, will anyone really even want to
> use snabb? I don't know, perhaps, but perhaps it should just be fixed on
> the snabb side? It stands to reason that regardless of what we do here,
> it shouldn't just crash.

True.

However, a cursory search shows these being turned off in a few other 
cases as well including vs some DPDK based software.

So snabb is not alone having issues with MQ and VQ flags.

> 
>> Have you tried it vs let's say dpdk (IIRC it supports vhost_user as an
>> interface).
> 
> No, and we probably won't, we're not really particularly interested in
> the network aspect of it. Trying it out here with existing device
> implementations was really just for development, ultimately our plan is
> to have our own device implementation(s) and driver(s). 

Understood, however for it to be upstreamed it should work with 
something else which is publicly available. That is why I am going to 
try it vs Bess/DPDK (it is also lowest effort for me as I already have 
that set-up).

> I'm hoping to
> publish and upstream something that will let you run multiple UML
> machines in "synchronized time travel" mode over vhost-user though.

vhost-user clock? Interesting idea.

> 
> johannes
> 
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 

-- 
Anton R. Ivanov

Cambridge Greys Limited, England and Wales company No 10273661
http://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

