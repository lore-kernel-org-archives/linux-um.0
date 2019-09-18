Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iAU3j-000219-3i
 for linux-um@lists.infradead.org; Wed, 18 Sep 2019 07:07:28 +0000
Message-ID: <5dad6c3e76e474b9f43df99ea235eb77389ce63f.camel@sipsolutions.net>
Subject: Re: CONFIG_COMPAT for UM?
From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 18 Sep 2019 09:07:22 +0200
In-Reply-To: <b3507d24-ebd9-8e7f-25a8-61c1891c37d4@kot-begemot.co.uk>
References: <60f73376da11640d5b335512f052a583fd784fd8.camel@sipsolutions.net>
 <76d688c3-3d8b-fb59-3ad4-ef8dd9c023be@kot-begemot.co.uk>
 <b3507d24-ebd9-8e7f-25a8-61c1891c37d4@kot-begemot.co.uk>
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
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, linux-um@lists.infradead.org

On Wed, 2019-09-18 at 07:48 +0100, Anton Ivanov wrote:
> 
> I was thinking about running 32 bit instances on a 64 bit host.

Yeah, I guess I could run as a 32-bit instance, but I'd rather actually
use a 64-bit instance. If I ever manage to get KASAN running (among
other things) this will totally be required :)

> Pure 32 bit userspace on 64 kernel - yeah... why not. Though to be 
> honest, nearly all distributions now have multiarch support so the need 
> for this is nowhere near as pressing as 10+ years ago when the first 
> AMD64 processors came out.

True, it's not really of that much use these days. I guess it could be
helpful to test the compat code (ioctls) itself.

I've mostly worked around my problem by making the test suite bootstrap
64-bit compatible, which was annoying but doable :-)

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

