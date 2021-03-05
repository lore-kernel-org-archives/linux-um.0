Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lI7NV-00ERxy-Nv
 for linux-um@lists.infradead.org; Fri, 05 Mar 2021 10:08:16 +0000
Message-ID: <8c894bae0401e5cdb6d214a0854fa750e00a0c31.camel@sipsolutions.net>
Subject: Re: linux uml segfault
From: Johannes Berg <johannes@sipsolutions.net>
Date: Fri, 05 Mar 2021 11:07:48 +0100
In-Reply-To: <1543fce7-7bcd-b8c9-ca1c-0970e0a0c590@kot-begemot.co.uk>
 (sfid-20210305_110000_980788_73AE7F28)
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
 <m21rcv5vi5.wl-thehajime@gmail.com>
 <3c447c59bc30ba2bae1130ec89beddd699a0d21a.camel@sipsolutions.net>
 <19322b1442a7fc5938e026cb4eccc113a7c2328b.camel@sipsolutions.net>
 <fdbe84e1-ab45-7eb4-7aa7-5ba9798be633@kot-begemot.co.uk>
 <1543fce7-7bcd-b8c9-ca1c-0970e0a0c590@kot-begemot.co.uk>
 (sfid-20210305_110000_980788_73AE7F28)
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
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, Benjamin Berg <benjamin@sipsolutions.net>, Hajime Tazaki <thehajime@gmail.com>
Cc: rrs@debian.org, chris.obbard@collabora.com, linux-um@lists.infradead.org, 983379@bugs.debian.org

On Fri, 2021-03-05 at 09:59 +0000, Anton Ivanov wrote:
> 
> This is proving very "interesting" to try to chase down, because the
> "picking the wrong library" does not happen every time.
> 
> F.E. yesterday my 5.10 builds were picking glibc memcpy and friends.
> Today with the same config and everything else the same it is picking
> built-ins.

Ouch.

> I need to finds some better way to reproduce this.

Maybe something like the original report? That caused sem_init() to be
called, so we know libc will/may call something there.

You and me probably don't have the nss setup to cause sem_init() to get
called, but maybe simply putting

void init_nss_interface(void)
{
  panic("how did we get here");
}

somewhere in the kernel image might already reproduce it?

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

