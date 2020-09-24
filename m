Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kLMlN-0005ND-CJ
 for linux-um@lists.infradead.org; Thu, 24 Sep 2020 08:38:02 +0000
Subject: Re: [RFC v6 01/21] um: split build in kernel and host parts
References: <cover.1600922528.git.thehajime@gmail.com>
 <034e4235086fceb43659c679770b7088e974f5d7.1600922528.git.thehajime@gmail.com>
 <738c23cc-7c19-90b8-c0d3-1a56ad3fb3e3@cambridgegreys.com>
 <m2h7rn7f8k.wl-thehajime@gmail.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <15b3793a-25c2-27ad-443d-28201790eee6@cambridgegreys.com>
Date: Thu, 24 Sep 2020 09:37:55 +0100
MIME-Version: 1.0
In-Reply-To: <m2h7rn7f8k.wl-thehajime@gmail.com>
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
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-arch@vger.kernel.org, tavi.purdila@gmail.com, richard@nod.at, jdike@addtoit.com, linux-um@lists.infradead.org, retrage01@gmail.com, tavi@cs.pub.ro, linux-kernel-library@freelists.org



On 24/09/2020 09:26, Hajime Tazaki wrote:
> 
> On Thu, 24 Sep 2020 16:33:49 +0900,
> Anton Ivanov wrote:
> 
>>> The host build part has been implemented in tools/um so that we can
>>> reuse the available host build infrastructure.
>>>
>>> The patch also changes the UML build invocation, if before
>>>
>>>    $ make ARCH=um defconfig
>>>    $ make ARCH=um
>>>
>>> was generating the executable now this only generates the relocatable
>>> object.
>>
>> This will break packaging in all distributions. We need to figure out an alternative way which is backward compatible with their builds.
> 
> Hmm, I understand the situation.
> We may have to put additional steps after generating the relocatable
> object in arch/um/Makefile.

Cool.

I will go through the rest of the patches and if I notice something I will comment on specific ones.

Brgds,

> 
> -- Hajime
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

