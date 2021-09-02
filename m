Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mLhOC-008rIt-GX
 for linux-um@lists.infradead.org; Thu, 02 Sep 2021 07:44:04 +0000
Message-ID: <288a2d4dbcb1e6b0fbeff6da86569aa92df09202.camel@sipsolutions.net>
Subject: Re: [PATCH] drm/ttm: provide default page protection for UML
From: Johannes Berg <johannes@sipsolutions.net>
Date: Thu, 02 Sep 2021 09:43:33 +0200
In-Reply-To: <0887903c-483d-49c7-0d35-f59be2f85bac@cambridgegreys.com>
References: <20210902020129.25952-1-rdunlap@infradead.org>
 <9faacbc8-3346-8033-5b4d-60543eae959e@cambridgegreys.com>
 <f978cae5-7275-6780-8a17-c6e61247bce7@infradead.org>
 <0887903c-483d-49c7-0d35-f59be2f85bac@cambridgegreys.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>, dri-devel@lists.freedesktop.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>

On Thu, 2021-09-02 at 07:19 +0100, Anton Ivanov wrote:
> > > 
> > > I have a question though - why all of DRM is not !UML in config. Not 
> > > like we can use them.
> > 
> > I have no idea about that.
> > Hopefully one of the (other) UML maintainers can answer you.
> 
> Touche.
> 
> We will discuss that and possibly push a patch to !UML that part of the 
> tree. IMHO it is not applicable.

As I just said on the other patch, all of this is fallout from my commit
68f5d3f3b654 ("um: add PCI over virtio emulation driver") which is the
first time that you could have PCI on UML.

Without having checked, in this particular case it's probably something
like

	depends on PCI && X86_64

as we've seen in other drivers (idxd, ioat).

The biggest problem is probably that UML internally uses X86_64
(arch/x86/um/Kconfig), which is ... unexpected ... since CONFIG_X86_64
is typically considered the ARCH, and now the ARCH is actually um.

I think we can just fix that and get rid of this entire class of
problems? Something like

https://p.sipsolutions.net/fbac19d86637e286.txt

johannes



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

