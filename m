Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ElX6m-0000jX-Q3 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 11 Dec 2005 11:43:44 -0800
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1ElX6j-0000Eo-8m
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 11 Dec 2005 11:43:44 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
References: <1134007824.32598.48.camel@localhost.localdomain>
	<200512111747.30441.blaisorblade@yahoo.it>
	<1134328772.29209.82.camel@localhost.localdomain>
In-Reply-To: <1134328772.29209.82.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512112043.26863.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: 2.4.32-bs2
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
Date: Sun, 11 Dec 2005 20:43:26 +0100
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>

On Sunday 11 December 2005 20:19, Antoine Martin wrote:
> On Sun, 2005-12-11 at 17:47 +0100, Blaisorblade wrote:
> > On Thursday 08 December 2005 03:10, Antoine Martin wrote:
> > > All,
> > >
> > > Talking about tty logging and fake ide reminded of the current state of
> > > UML on 2.4 kernels:
> > > http://uml.nagafix.co.uk/uml-2.4.32-bs2.patch.bz2
> > > Is Blaisorblade's 2.4.28-bs2 patch tweaked to apply cleanly on 2.4.32.
> >
> > There should be (I think) just offsets, not even fuzzes, so there should
> > be no problem.

> > > /usr/lib/libc.a: could not read symbols: Bad value

> > I'd like to see the exact cmd line producing this. Possibly seeing also
> > gcc -v output with that cmd line would help.


> collect2: ld returned 1 exit status

> > (After seeing if there's anything strange with the file itself, but I
> > think you can compile on the same box some

> > > Any idea why that is? It happens when I use:
> > > i686-pc-linux-gnu-3.4.4-vanilla
> > > but not with:
> > > i686-pc-linux-gnu-3.3.6-vanilla

> Trying again today with 3.3.6, I get a new warning (bcmp) and the same
> error.

The warning is about two memcmp() definitions, of which one is from libc and 
one from UML. And memcmp() is called in bcmp(), triggering the error.

> I have no idea what I've done different! 

Ok, now we have that the difference between 3.3 and 3.4 could be in collect2, 
the ld wrapper, which was discarding the useful message. I don't think gcc 
3.4 could do anything differently. (I've not looked at linux-2.4.32 sources, 
though, I'm 

> gcc -Wl,-T,arch/um/link.ld -static -Wl,--wrap,malloc -Wl,--wrap,free
> -Wl,--wrap,calloc \
>         -o linux arch/um/main.o vmlinux.o -L/usr/lib -lutil
> /usr/lib/libc.a(memcmp.o): In function `bcmp':
> ../sysdeps/i386/i686/memcmp.S:(.text+0x0): multiple definition of
> `memcmp'

Notice the line below:

> vmlinux.o:/usr/src/linux-2.4.32-bs2/lib/string.c:452: first defined here

I.e. memcmp is multiply defined.

> /usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.6/../../../../i686-pc-linux-gnu/bin/
>ld: Warning: size of symbol `memcmp' changed from 53 in vmlinux.o to 128 in
> /usr/lib/libc.a(memcmp.o)

This particular warning (size of function changed) may depend on gcc 3.3 
creating 53-bytes of code and gcc used for glibc using 128 ones (doh!). 
However it's a stupid way to say again "duplicate symbol".

Ok, this makes *much* sense to me, and we had that in 2.6. I'm not sure why it 
started appearing here, I think it started existing either for some kernel 
cleanup or for what else... (maybe the kernel cleanup got backported in 
2.4.32).

I think in that case I #ifdefed just the function definition (for memcmp, not 
for bcmp!) in lib/string.c, while keeping the EXPORT_SYMBOL() line (wherever 
it is).

> fix_libtool_files.sh did fix some libs when I upgraded to 3.4 - but did
> not help in this case.

ok, no more worry, the current 3.3 error message *is* informative.


> > Hmm, I never compiled 2.4 kernels on x86_64 machines. Probably I
> > backported just an earlier attempt - in fact I thought I'd done it on
> > 2.6, but until I started testing it, it didn't work.
>
> Not to worry, I just thought it was meant to work.

> How would I go about building a 32-bit pcap enabled kernel in the
> chroot? Do I copy the pcap.a from outside the chroot?

No, pcap.a is a static library so you don't need that. The problem is that you 
need a matching glibc inside the chroot and outside for the libraries which 
are dlopen()ed by glibc, i.e. the whole libnss + helpers called 
by /etc/nsswitch.conf for instance. On my system the linker spits out a 
warning to say that ("You must have the same glibc used for compiling, even 
if you're linking statically").

Hope that glibc people have not been so strict.

> I almost did, but the patch was twice as long... will do next time.

Sometimes this can happen, the problem is that probably a patch (even for this 
file only) is (normally) more readable.

[... I read your answers on the patch ...]

> I'll send a patch when the whole thing works.

The patch is for review, and please don't send any whole patch on the ML - 
limit to the interesting hunks, with reference URLs if needed (let's avoid 
spamming people).
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
