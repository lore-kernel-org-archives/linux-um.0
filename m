Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CpdeD-0006ok-NK for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 14 Jan 2005 18:26:41 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CpdeB-0005tQ-RP for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 14 Jan 2005 18:26:41 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] About "jiffies" patch
References: <200501130612.34417.blaisorblade@yahoo.it>
In-Reply-To: <200501130612.34417.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501150306.08535.blaisorblade@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sat, 15 Jan 2005 03:06:07 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

On Thursday 13 January 2005 06:12, Blaisorblade wrote:
> Well, effectively your reasoning holds, apart for one point: the code
> should not hang because of that large INITIAL_JIFFIES. What we care about
> are only the value of jiffies relative to INITIAL_JIFFIES, indeed.
>
> In fact, that code works on 64-bit arch's. But INITIAL_JIFFIES is not 0 to
> make sure it wraps 5 minutes after the boot, to make sure the wrapping
> mechanism is debugged. And this, currently, does not happen likely.
>
> While on 32-bit  archs that construct is like "(unsigned int) (-300*HZ)",
> on 64-bit archs to get a negative number we'd need something like:
>
> (unsigned long)(long)(-300*HZ)
>
> or
>
> (unsigned long)(-300L*HZ)
>
> so that the number is first sign-extended and then casted to unsigned.
Sorry, I now went patching the code, and discovered I was a total moron:

/*
 * Have the 32 bit jiffies value wrap 5 minutes after boot
 * so jiffies wrap bugs show up earlier.
 */
#define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-300*HZ))

It does not say "jiffies wrap", but the "32 bit values" of jiffies wrap...
So, the x86_64 value must actually be the one you have seen - the problem is 
that this trigger some kind of bug in UML - do we have some extra 32-bit var?

However, I have two suggestion
paolo [~/Admin/kernel/6/linux-2.6.11: 02:47 (2)] $ grep  INITIAL_JIFFIES `find 
arch/um/`
paolo [~/Admin/kernel/6/linux-2.6.11: 02:47 (2)] $ grep  INITIAL_JIFFIES `find 
include/asm-um`
paolo [~/Admin/kernel/6/linux-2.6.11: 02:47 (2)] $ grep  INITIAL_JIFFIES `find 
include/linux`
include/linux/jiffies.h:#define INITIAL_JIFFIES ((unsigned long)(unsigned int) 
(-300*HZ))

For stolen headers:

$ grep  INITIAL_JIFFIES `find include/asm-i386`
$ grep  INITIAL_JIFFIES `find include/asm-generic`

I.e. we don't use INITIAL_JIFFIES, it seems. Please point out the problem in 
my search!

Instead, for i386:

paolo [~/Admin/kernel/6/linux-2.6.11: 02:48 (2)] $ grep INITIAL_JIFFIES 
arch/i386/kernel/*.c
arch/i386/kernel/time.c:u64 jiffies_64 = INITIAL_JIFFIES;
arch/i386/kernel/time.c:        xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * 
(NSEC_PER_SEC / HZ);
arch/i386/kernel/time.c:        xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * 
(NSEC_PER_SEC / HZ);


- I've compared the link scripts, and discovered this code:
from arch/um/kernel/{dyn,uml}.lds.S and arch/i386/kernel/vmlinux.lds.S
jiffies = jiffies_64;

in arch/x86_64/kernel/vmlinux.lds.S:
jiffies_64 = jiffies;

I'm going to check if I see what is the difference. This is just a note, it 
seems that it could be the same thing, after some analisys - in both cases 
the sources define the jiffies_64 var.
However, I didn't want to miss it anyway, just in case.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
