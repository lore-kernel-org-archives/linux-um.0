Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mLhoR-008vGB-Gw
 for linux-um@lists.infradead.org; Thu, 02 Sep 2021 08:11:11 +0000
Subject: Re: [PATCH] drm/ttm: provide default page protection for UML
References: <20210902020129.25952-1-rdunlap@infradead.org>
 <9faacbc8-3346-8033-5b4d-60543eae959e@cambridgegreys.com>
 <f978cae5-7275-6780-8a17-c6e61247bce7@infradead.org>
 <0887903c-483d-49c7-0d35-f59be2f85bac@cambridgegreys.com>
 <288a2d4dbcb1e6b0fbeff6da86569aa92df09202.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <347e4cb8-a7c5-9e1b-16bc-96805442d35b@cambridgegreys.com>
Date: Thu, 2 Sep 2021 09:10:54 +0100
MIME-Version: 1.0
In-Reply-To: <288a2d4dbcb1e6b0fbeff6da86569aa92df09202.camel@sipsolutions.net>
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
To: Johannes Berg <johannes@sipsolutions.net>, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= <thomas.hellstrom@linux.intel.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>, dri-devel@lists.freedesktop.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>

On 02/09/2021 08:43, Johannes Berg wrote:
> On Thu, 2021-09-02 at 07:19 +0100, Anton Ivanov wrote:
>>>>
>>>> I have a question though - why all of DRM is not !UML in config. Not
>>>> like we can use them.
>>>
>>> I have no idea about that.
>>> Hopefully one of the (other) UML maintainers can answer you.
>>
>> Touche.
>>
>> We will discuss that and possibly push a patch to !UML that part of the
>> tree. IMHO it is not applicable.
> 
> As I just said on the other patch, all of this is fallout from my commit
> 68f5d3f3b654 ("um: add PCI over virtio emulation driver") which is the
> first time that you could have PCI on UML.
> 
> Without having checked, in this particular case it's probably something
> like
> 
> 	depends on PCI && X86_64
> 
> as we've seen in other drivers (idxd, ioat).
> 
> The biggest problem is probably that UML internally uses X86_64
> (arch/x86/um/Kconfig), which is ... unexpected ... since CONFIG_X86_64
> is typically considered the ARCH, and now the ARCH is actually um.
> 
> I think we can just fix that and get rid of this entire class of
> problems? Something like
> 
> https://p.sipsolutions.net/fbac19d86637e286.txt

Good idea. I suspect that DRM will not be the only thing to pop up out 
of this so we might as well fix it "at the top".

A

> 
> johannes
> 
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

