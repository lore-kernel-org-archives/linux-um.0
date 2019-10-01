Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iFMmM-0007uT-Dy
 for linux-um@lists.infradead.org; Tue, 01 Oct 2019 18:21:44 +0000
Subject: Re: [PATCH v2] um: Loadable BPF "Firmware" for vector drivers
References: <20191001165537.3386-1-anton.ivanov@cambridgegreys.com>
 <6e5e87abcf0fa6453239678524be6049598dc080.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <539c878c-043b-defb-3545-39e233a5f007@cambridgegreys.com>
Date: Tue, 1 Oct 2019 19:21:36 +0100
MIME-Version: 1.0
In-Reply-To: <6e5e87abcf0fa6453239678524be6049598dc080.camel@sipsolutions.net>
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

On 01/10/2019 18:32, Johannes Berg wrote:
> 
>> +/*
>> + * We cannot use the firmware.c loader API here because this is not a module
>> + *  and we do not have a proper device structure to pass to it as required
>> + *  by the firmware API
>> + */
> 
> I think you should delete the comment now :)

Mea culpa.

Will do that shortly.

I started following your suggestion about platform device and realized 
that we actually already have one :)

> 
> [...]
> 
>> +	if (request_firmware(&fw, efl->data, &vdevice->pdev.dev))
>> +		goto flash_fail;
> 
> That is the standard firmware loader now after all.
> 
> johannes
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

