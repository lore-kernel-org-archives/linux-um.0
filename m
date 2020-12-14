Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1koju4-0000s5-I9
 for linux-um@lists.infradead.org; Mon, 14 Dec 2020 09:12:25 +0000
Message-ID: <8f03cd131738415af58ea2840ec18758bc9452d7.camel@sipsolutions.net>
Subject: Re: [PATCH v4 2/7] um: enable the use of optimized xor routines in UML
From: Johannes Berg <johannes@sipsolutions.net>
Date: Mon, 14 Dec 2020 10:12:20 +0100
In-Reply-To: <9dd00b95-ec4a-ac5d-fffa-a5c3fdabcfbb@cambridgegreys.com>
References: <20201211174559.26010-1-anton.ivanov@cambridgegreys.com>
 <20201211174559.26010-3-anton.ivanov@cambridgegreys.com>
 <eaba0159c3925f367e42fd17dcf85b829a703666.camel@sipsolutions.net>
 <d8eb09bd-a8ff-72f1-7ea9-54342935bd60@cambridgegreys.com>
 <419748449d7e47922fb59335e1b2a44789080066.camel@sipsolutions.net>
 <9dd00b95-ec4a-ac5d-fffa-a5c3fdabcfbb@cambridgegreys.com>
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
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
Cc: richard@nod.at

On Mon, 2020-12-14 at 09:07 +0000, Anton Ivanov wrote:
> 
> I had a look at the alternatives processing in x86 once again. The
> exact definition of what we get to use is: "ancient, buggy CPUs in SMP
> mode".

fun.

> So in addition to using one of the worst case scenario
> implementations, we also do not do patching of SMP verbiage to UP
> where appropriate which is done on x86.

right.

> I just had a go at trying to reuse the aforementioned alternatives
> processing "as is" from the x86 tree.
> 
> This is pretty much a no-go from the start. We can't use it. It relies
> on "owning" int handlers and generating int instructions in places. If
> I understand it correctly, it will interfere with gdb by doing its own
> INT 3 work. Key parts of it are also "if-defed away" from us at
> present.
> 
> IMHO - it will have to be rewritten mostly from scratch for UML.
> 
> I will have a look if we can reuse the cpu feature and bug definitions
> instead of using our own. This will allow us to reuse the bits which
> relate to crypto - xor, etc as those are cases/ifdefs instead of
> alternatives.

I agree.

But I feel like something I said sent you on this path, and that never
was my intent. I don't mind using the x86 header files in a fashion
similar to what you did, I just didn't like the symlinks because it
seems those would be awkward if somebody ever wants to port UML to some
other architecture ...

Maybe just put there header files with

#include "../../x86/include/asm/xor.h"

or something like that just to avoid the symlinks?

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

