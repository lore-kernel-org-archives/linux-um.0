Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIGie-00GI11-Es
 for linux-um@lists.infradead.org; Fri, 05 Mar 2021 20:06:42 +0000
Message-ID: <d657cc169ff8fee29353cf473f5c4093c374ecc8.camel@sipsolutions.net>
Subject: Re: linux uml segfault
From: Johannes Berg <johannes@sipsolutions.net>
Date: Fri, 05 Mar 2021 21:06:35 +0100
In-Reply-To: <02a1bb6c-3727-61d6-d0bb-a2200f1b0d14@kot-begemot.co.uk>
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
 <c016e628-5c28-e732-d99d-7b2f10e3c5a3@kot-begemot.co.uk>
 <BA89CA55-A40B-48E7-BD6A-8F33B9045E09@sipsolutions.net>
 <02a1bb6c-3727-61d6-d0bb-a2200f1b0d14@kot-begemot.co.uk>
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
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, Hajime Tazaki <thehajime@gmail.com>
Cc: rrs@debian.org, chris.obbard@collabora.com, linux-um@lists.infradead.org, 983379@bugs.debian.org

On Fri, 2021-03-05 at 19:03 +0000, Anton Ivanov wrote:
> 
> I thought of that, but surrendered to the "dark side" of the quick and ugly fix.

:)

> We can do that for the ipc/sem.c - it brings in uaccess.h which
> ultimately pulls uaccess from our asm tree. So if we do it there, it
> will end up in sem.c

Well, most easily you could do it in ipc/util.h, where it's declared. Or
any place that is pulled in by it, e.g. even asm/errno.h.

All ugly though.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

