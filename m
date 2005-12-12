Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EldMy-0003Q6-0I for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 11 Dec 2005 18:24:52 -0800
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EldMw-0005Ob-ET
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 11 Dec 2005 18:24:52 -0800
From: Antoine Martin <antoine@nagafix.co.uk>
In-Reply-To: <200512112043.26863.blaisorblade@yahoo.it>
References: <1134007824.32598.48.camel@localhost.localdomain>
	<200512111747.30441.blaisorblade@yahoo.it>
	<1134328772.29209.82.camel@localhost.localdomain>
	<200512112043.26863.blaisorblade@yahoo.it>
Content-Type: multipart/mixed; boundary="=-bRSUo94153aFov2+Nzoj"
Message-Id: <1134354266.29209.116.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [uml-devel] [PATCH] Re: 2.4.32-bs2
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
Date: Mon, 12 Dec 2005 02:24:26 +0000
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: uml@nagafix.co.uk, UML devel <user-mode-linux-devel@lists.sourceforge.net>


--=-bRSUo94153aFov2+Nzoj
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> > I have no idea what I've done different! 
I was using mrproper, but I've scripted the whole thing to test all the
combinations from scratch again (with a brand new tree each time - not
just mrproper) and the error only occurs when using the hardened gcc,
and I'm not too bothered about that (it's easy enough to switch, except
in SELinux enforcing mode - but that's another matter...)

So I guess that the patch is good enough as it is.
It is available here:
http://uml.nagafix.co.uk/uml-2.4.32-bs2.patch.bz2
it cumulates:
* 2.4.28-bs2
* offsets for 2.4.32 and removed the whitespace no-change in
drivers/char/tty_io.c.rej
* tiny patch (attached) for tt/Makefile to cope with duplicate symbols
in newer glibc
(done properly this time)
* mconsole-exec patch backported to 2.4:
http://uml.nagafix.co.uk/mconsole-exec.patch-2.4.bz2
(unlike in 2.6 there is no config option for it)

> > How would I go about building a 32-bit pcap enabled kernel in the
> > chroot? Do I copy the pcap.a from outside the chroot?
> 
> No, pcap.a is a static library so you don't need that. The problem is that you 
> need a matching glibc inside the chroot and outside for the libraries which 
> are dlopen()ed by glibc, i.e. the whole libnss + helpers called 
> by /etc/nsswitch.conf for instance. On my system the linker spits out a 
> warning to say that ("You must have the same glibc used for compiling, even 
> if you're linking statically").
Same here. I wish it could tell me which ones so I could place them in
the chroot without guessing or tracing it (we have discussed this a
while back)

So in this case, on a multilib amd64 system, I should be able to build a
chroot using a bind mount to preserve /lib32 and /usr/lib32 to guarantee
that the libs are exactly the same? (and add a 32bit bash, gcc, make...)

> > I'll send a patch when the whole thing works.
> 
> The patch is for review, and please don't send any whole patch on the ML - 
Sure, I meant just the diffs with 2.4.28-bs2!

Antoine

--=-bRSUo94153aFov2+Nzoj
Content-Disposition: inline; filename=2.4.32-bs2-tt-makefile.patch
Content-Type: text/x-patch; name=2.4.32-bs2-tt-makefile.patch;
	charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- linux-2.4.32/arch/um/kernel/tt/Makefile     2005-12-13 03:29:03.000000000 +0000
+++ linux-2.4.32-bs2/arch/um/kernel/tt/Makefile 2005-12-13 03:27:52.000000000 +0000
@@ -26,7 +26,7 @@
 include $(TOPDIR)/Rules.make

 $(USER_OBJS) : %.o: %.c
-       $(CC) $(CFLAGS_$@) $(USER_CFLAGS) -c -o $@ $<
+       $(CC) $(USER_CFLAGS) $(CFLAGS_$@) -c -o $@ $<

 $(O_TARGET) : unmap_fin.o

@@ -34,6 +34,7 @@
        $(CC) $(UNMAP_CFLAGS) -c -o $@ $<

 unmap_fin.o : unmap.o
-       ld -r -o $@ $< -lc -L/usr/lib
+       ld -r -o unmap_tmp.o unmap.o -lc -L/usr/lib
+       objcopy unmap_tmp.o unmap_fin.o -G switcheroo

 clean :

--=-bRSUo94153aFov2+Nzoj--



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
