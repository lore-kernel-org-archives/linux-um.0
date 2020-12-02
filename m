Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkSx8-0003cd-LU
 for linux-um@lists.infradead.org; Wed, 02 Dec 2020 14:17:55 +0000
Subject: Re: [PATCH v2 2/7] um: virtio: use dynamic IRQ allocation
References: <20201202115956.42963-1-johannes@sipsolutions.net>
 <20201202125915.d5cbac8ab2de.Id7bf6cf5659579ac53cce88552126e4d98a74e3d@changeid>
 <ecbde0af-49f8-034f-ff74-494dcbea711a@cambridgegreys.com>
 <8a759a5dc560659d7ae00861334e136e015f6b9f.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <7361f4d8-3bc9-2b8f-18b2-4fe6206ea86a@cambridgegreys.com>
Date: Wed, 2 Dec 2020 14:17:51 +0000
MIME-Version: 1.0
In-Reply-To: <8a759a5dc560659d7ae00861334e136e015f6b9f.camel@sipsolutions.net>
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


On 02/12/2020 14:14, Johannes Berg wrote:
> On Wed, 2020-12-02 at 14:13 +0000, Anton Ivanov wrote:
>>> Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>>> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>>>
>> Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> FWIW, I preserved your ACKs where I didn't change the patches :)

Sorry, I did not notice it :)

So I just acked the whole series one more time :)

It looks good this time.

I am going to wait for the performance check to pass on 7 and I will ack it too.

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
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

