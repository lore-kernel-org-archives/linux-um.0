Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EoPpg-0007lz-2D for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Dec 2005 10:34:00 -0800
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EoPpe-0001ci-7r
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Dec 2005 10:34:00 -0800
From: Antoine Martin <antoine@nagafix.co.uk>
In-Reply-To: <200512191716.06370.blaisorblade@yahoo.it>
References: <1134932624.10491.76.camel@localhost.localdomain>
	<200512191716.06370.blaisorblade@yahoo.it>
Content-Type: multipart/mixed; boundary="=-v3m94K6uG6yyBMsX2F9A"
Message-Id: <1135017219.15991.131.camel@ant.internal>
Mime-Version: 1.0
Subject: [uml-devel] Re: pcap cross-linking [PATCH]
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
Date: Mon, 19 Dec 2005 18:33:39 +0000
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>


--=-v3m94K6uG6yyBMsX2F9A
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> > pcap builds and runs fine on amd64 but there is a problem when building
> > with SUBARCH=i386: it uses the wrong version of libpcap.a:
> > ld -r -dp -o arch/um/drivers/pcap.o arch/um/drivers/pcap_kern.o
> > arch/um/drivers/pcap_user.o  -m elf_i386
> > -r /usr/lib/gcc/x86_64-pc-linux-gnu/3.4.4/../../../libpcap.a
> 
> > Whereas the one it needs to link against is here:
> > /emul/linux/x86/usr/lib/libpcap.a
> 
> This is IMHO a Gentoo bug -
I'll ask the gentoo devs, for the time being I can copy this library
manually to /usr/lib32 (which is the standard location for 32-bit libs
on amd64)

But the problem remains, the linker should use:
-r /usr/lib32/libpcap.a
and not ../../../libpcap.a which ends up as /usr/lib (which points
to /usr/lib64 on standard distros)
But only when building with SUBARCH=i386. 

So I added this statement to the Makefile (patch attached) and now all
is well:
+ifeq ($(SUBARCH),i386)
+LDFLAGS_pcap.o := -r /usr/lib32/libpcap.a
+else

> Good thing, libnss_* is probably good - but don't forget /etc/nsswitch.conf 
> and /etc/pam.d/* - /etc/pam.conf
Yep, they're all there... see:
http://uml.nagafix.co.uk/SELinux/chroot/
This chroot example is here for SELinux but it applies just as well to
others.

I think I'll rebuild it with compartment and build su without pam to
trim it down even more.
> > (also lib/security so I can get into the chroot)
> That's for su, right? There are some tools (including "compartment") to 
> combine chroot + su together.
Yep, it's a shame compartment does not ship with all distros.
chroot without su is pointless (since you can use 'chroot-again' to
escape) changing uid/guid should really be included in chroot.

> Also, I see you're using SeLinux. I don't know anything about its library 
> handling, and possibly it's going to make the story more difficult.
It can do that... but the good thing is that it can be disabled.
>  However, 
> strace/ltrace as suggested above should diagnose any problem.
Cool - I'll try that and report back.

Many thanks
Antoine

--=-v3m94K6uG6yyBMsX2F9A
Content-Disposition: inline; filename=uml-pcap-subarchi386-linkerfix.patch
Content-Type: text/x-patch; name=uml-pcap-subarchi386-linkerfix.patch;
	charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- linux-2.6.15-rc6-x86-broken/arch/um/drivers/Makefile   2005-12-19 18:07:17.000000000 +0000
+++ linux-2.6.15-rc6-x86/arch/um/drivers/Makefile          2005-12-19 18:11:11.000000000 +0000
@@ -17,7 +17,11 @@
 port-objs := port_kern.o port_user.o
 harddog-objs := harddog_kern.o harddog_user.o

+ifeq ($(SUBARCH),i386)
+LDFLAGS_pcap.o := -r /usr/lib32/libpcap.a
+else
 LDFLAGS_pcap.o := -r $(shell $(CC) $(CFLAGS) -print-file-name=libpcap.a)
+endif

 targets := pcap_kern.o pcap_user.o


--=-v3m94K6uG6yyBMsX2F9A--



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
