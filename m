Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-dm6nam12on2063.outbound.protection.outlook.com
 ([40.107.243.63] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mLiWd-00917R-7W
 for linux-um@lists.infradead.org; Thu, 02 Sep 2021 08:56:51 +0000
Subject: Re: [PATCH] drm/ttm: provide default page protection for UML
References: <20210902020129.25952-1-rdunlap@infradead.org>
 <9faacbc8-3346-8033-5b4d-60543eae959e@cambridgegreys.com>
 <f978cae5-7275-6780-8a17-c6e61247bce7@infradead.org>
 <0887903c-483d-49c7-0d35-f59be2f85bac@cambridgegreys.com>
 <288a2d4dbcb1e6b0fbeff6da86569aa92df09202.camel@sipsolutions.net>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <e4e4a4c2-6729-4964-edc9-8e06733207a9@amd.com>
Date: Thu, 2 Sep 2021 10:56:36 +0200
In-Reply-To: <288a2d4dbcb1e6b0fbeff6da86569aa92df09202.camel@sipsolutions.net>
Content-Language: en-US
MIME-Version: 1.0
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
To: Johannes Berg <johannes@sipsolutions.net>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= <thomas.hellstrom@linux.intel.com>, Huang Rui <ray.huang@amd.com>, dri-devel@lists.freedesktop.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>

Am 02.09.21 um 09:43 schrieb Johannes Berg:
> On Thu, 2021-09-02 at 07:19 +0100, Anton Ivanov wrote:
>>>> I have a question though - why all of DRM is not !UML in config. Not
>>>> like we can use them.
>>> I have no idea about that.
>>> Hopefully one of the (other) UML maintainers can answer you.
>> Touche.
>>
>> We will discuss that and possibly push a patch to !UML that part of the
>> tree. IMHO it is not applicable.
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

Yeah, as TTM maintainer I was about to NAK that approach here.

Basically you are claiming to be X86_64, but then you don't use the 
X86_64 architecture and are surprised that it things break somewhere else.

This is not something you can blame on subsystems or even drivers, but 
rather just a broken architectural design and so needs to be fixed there.

Regards,
Christian.

>
> I think we can just fix that and get rid of this entire class of
> problems? Something like
>
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fp.sipsolutions.net%2Ffbac19d86637e286.txt&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7Cd773b1e8b66643874d1308d96de56a86%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637661654674393046%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=xBT%2Fj%2FbEgltQfvE%2B7%2FGRV7IctGn3sDvy8ycmBvTTSXU%3D&amp;reserved=0
>
> johannes
>
>


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

