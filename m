Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1eOKVq-0003aQ-86
 for user-mode-linux-devel@lists.sourceforge.net;
 Mon, 11 Dec 2017 09:36:38 +0000
Received: from ivanoab5.miniserver.com ([78.31.111.25]
 helo=www.kot-begemot.co.uk)
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.89)
 id 1eOKVo-0006YY-HW for user-mode-linux-devel@lists.sourceforge.net;
 Mon, 11 Dec 2017 09:36:38 +0000
References: <20171209114940.fsi7jbxd7zbhhu74@mwanda>
 <54b3ee94-6afd-7907-3764-e2413f231209@cambridgegreys.com>
 <3254171.LO6pLlHuPk@blindfold>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <c70fd135-f105-5c39-d2ef-da249578120b@kot-begemot.co.uk>
Date: Mon, 11 Dec 2017 09:36:29 +0000
MIME-Version: 1.0
In-Reply-To: <3254171.LO6pLlHuPk@blindfold>
Content-Language: en-US
Subject: Re: [uml-devel] [PATCH 1/2] um: vector_kern: Unlock on error in
 vector_net_open()
List-Id: The user-mode Linux development list
 <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: dan.carpenter@oracle.com

Both are correct - omissions on my side

Please apply.

A.


On 12/11/17 09:33, Richard Weinberger wrote:
> Anton,
>
> Am Samstag, 9. Dezember 2017, 18:09:17 CET schrieb Anton Ivanov:
>> Thanks,
>>
>> I guess I missed that one.
>>
>> A.
>>
>> On 09/12/17 11:49, Dan Carpenter wrote:
>>> We need to unlock and restore IRQs on this error path.
>>>
>>> Fixes: ad1f62ab2bd4 ("High Performance UML Vector Network Driver")
>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>>
>>> diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
>>> index d1d53015d572..bb83a2d22ac2 100644
>>> --- a/arch/um/drivers/vector_kern.c
>>> +++ b/arch/um/drivers/vector_kern.c
>>> @@ -1156,8 +1156,10 @@ static int vector_net_open(struct net_device *dev)
>>>
>>>   	struct vector_device *vdevice;
>>>   	
>>>   	spin_lock_irqsave(&vp->lock, flags);
>>>
>>> -	if (vp->opened)
>>> +	if (vp->opened) {
>>> +		spin_unlock_irqrestore(&vp->lock, flags);
>>>
>>>   		return -ENXIO;
>>>
>>> +	}
>>>
>>>   	vp->opened = true;
>>>   	spin_unlock_irqrestore(&vp->lock, flags);
> Please review/ack these patches.
>
> Thanks,
> //richard
>
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

