Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iBMj6-0005jL-Uf
 for linux-um@lists.infradead.org; Fri, 20 Sep 2019 17:29:50 +0000
Message-ID: <dad1a2ea4bc0272bf45ba83bec71e0f735409e30.camel@sipsolutions.net>
Subject: Re: linux-image-5.2.0-2-amd64: breaks UML all versions, both debian
 stock and compiled from source.
From: Johannes Berg <johannes@sipsolutions.net>
Date: Fri, 20 Sep 2019 19:29:38 +0200
In-Reply-To: <4eb157d9-421e-092d-c2e9-96a2205e8ba4@kot-begemot.co.uk>
References: <156897436056.2001.10040310871991691509.reportbug@sleer.kot.begemot.co.uk>
 <ded0fc52-3631-375f-e4b5-c18e93777c4f@kot-begemot.co.uk>
 <4eb157d9-421e-092d-c2e9-96a2205e8ba4@kot-begemot.co.uk>
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
Cc: 940820@bugs.debian.org

On Fri, 2019-09-20 at 16:57 +0100, Anton Ivanov wrote:
> Looks like the culprit is a different default elf start address on 5.x
> 
> What changes is not the sbrk(0) or _end - these are pretty much 
> identical as in 4.x. It is the START which after some "fixups" in 
> arch/um/kernel/uml.lds.S becomes __binary_start

Doesn't this just use sbrk(0) to basically detect the end of the
"regular" part of the binary that's mapped by the loader, i.e. basically
"uml_reserved"? At least that's what I thought when I looked.

And if so, perhaps we could detect all this differently? Or even place
the (mmap'ed) physical memory somewhere else? I'd think nothing really
should care if it's contiguous or not?

If we did that we wouldn't have the whole thing contiguous in memory,
but do we really need to? Hmm. Maybe we do, so we don't have huge page
tables or something?

But then again, isn't the difference basically where the binary is
mapped, maybe we could mark it as non-relocatable?

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

