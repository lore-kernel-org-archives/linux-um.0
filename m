Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHihi-0085ue-NE
 for linux-um@lists.infradead.org; Thu, 04 Mar 2021 07:47:38 +0000
Message-ID: <3c447c59bc30ba2bae1130ec89beddd699a0d21a.camel@sipsolutions.net>
Subject: Re: linux uml segfault
From: Johannes Berg <johannes@sipsolutions.net>
Date: Thu, 04 Mar 2021 08:47:20 +0100
In-Reply-To: <m21rcv5vi5.wl-thehajime@gmail.com>
 (sfid-20210304_063856_031728_6ABDCCE2)
References: <3448a70e7a39b9c3202aeefa7858ace265b8a978.camel@debian.org>
 <6d37b5aa-36f2-1fce-b70b-8faa0ff882e0@kot-begemot.co.uk>
 <c8bb257c-1542-12f5-89f1-5c1f14b8a70a@collabora.com>
 <db40449e-6916-56bf-377c-01b042b9c890@kot-begemot.co.uk>
 <529cd4e2f39efffb18125dffab3058aeec3351ce.camel@debian.org>
 <573e256a-990b-ddf6-7965-367bb8b21229@kot-begemot.co.uk>
 <1bdedf3c60058e1ae242a2a7f16eee256b0be3e0.camel@debian.org>
 <6370b92a-84fa-aa21-4270-fcaf1bf42407@kot-begemot.co.uk>
 <02e348bbb13f0fac92f2147309fb1c006b4583b2.camel@debian.org>
 <5ee28b97-6111-e12c-d0e9-83a13f2151ce@kot-begemot.co.uk>
 <5e068447e2067fff8b21c0689f14d080b984f6e0.camel@debian.org>
 <01a1b3551284a39a3c06ab2ec0222cbf6099a537.camel@sipsolutions.net>
 <m21rcv5vi5.wl-thehajime@gmail.com> (sfid-20210304_063856_031728_6ABDCCE2)
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
To: Hajime Tazaki <thehajime@gmail.com>
Cc: rrs@debian.org, anton.ivanov@kot-begemot.co.uk, chris.obbard@collabora.com, linux-um@lists.infradead.org, 983379@bugs.debian.org

On Thu, 2021-03-04 at 14:38 +0900, Hajime Tazaki wrote:

> > Now, I don't know how to fix it (short of changing your nsswitch
> > configuration) - maybe we could somehow rename sem_init()? Or maybe we
> > can somehow give the kernel binary a lower symbol resolution than the
> > libc/libpthread.
> 
> objcopy (from binutils) can localize symbols (i.e., objcopy -L
> sem_init $orig_file $new_file).  It also does renaming symbols.  But
> not sure this is the ideal solution.

Yes, we started thinking about it but it was too late at night when I
replied ...

I think there's basically a way to have an external list of symbols to
export, for symbol versioning, that we could/should use to basically not
export any of the kernel symbols out to libs.

> How does UML handle symbol conflicts between userspace code and Linux
> kernel (like this case sem_init) ?  AFAIK, libnl has a same symbol as
> Linux kernel (genlmsg_put) and others can possibly do as well.

I fear it doesn't?

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

