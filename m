Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EoSqf-0001MU-WD for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Dec 2005 13:47:14 -0800
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EoSqe-0001nW-Nf
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Dec 2005 13:47:14 -0800
Subject: Re: [uml-devel] Re: pcap cross-linking [PATCH]
From: Antoine Martin <antoine@nagafix.co.uk>
In-Reply-To: <200512192027.06840.blaisorblade@yahoo.it>
References: <1134932624.10491.76.camel@localhost.localdomain>
	<200512191716.06370.blaisorblade@yahoo.it>
	<1135017219.15991.131.camel@ant.internal>
	<200512192027.06840.blaisorblade@yahoo.it>
Content-Type: text/plain
Message-Id: <1135028820.4622.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Date: Mon, 19 Dec 2005 21:47:00 +0000
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

> > So I added this statement to the Makefile (patch attached) and now all
> > is well:
> > +ifeq ($(SUBARCH),i386)
> > +LDFLAGS_pcap.o := -r /usr/lib32/libpcap.a
> > +else
ahh, so this is the right way to find the lib... (cool)

> $ gcc -print-file-name=libpcap.a
> /usr/lib/gcc/x86_64-pc-linux-gnu/3.4.4/../../../../lib64/libpcap.a
> $ gcc -m32 -print-file-name=libpcap.a
> /usr/lib/gcc/x86_64-pc-linux-gnu/3.4.4/../../../../lib32/libpcap.a
Works for me (tm) too.
Can this be merged? (I can't see any reason not to now)

--- linux-2.6.15-rc6-x86-broken/arch/um/drivers/Makefile   2005-12-19
18:07:17.000000000 +0000
+++ linux-2.6.15-rc6-x86/arch/um/drivers/Makefile          2005-12-19 21:45:17.000000000 +0000
@@ -17,7 +17,11 @@
 port-objs := port_kern.o port_user.o
 harddog-objs := harddog_kern.o harddog_user.o

+ifeq ($(SUBARCH),i386)
+LDFLAGS_pcap.o := -r $(shell $(CC) $(CFLAGS) -m32 -print-file-name=libpcap.a)
+else
 LDFLAGS_pcap.o := -r $(shell $(CC) $(CFLAGS) -print-file-name=libpcap.a)
+endif

 targets := pcap_kern.o pcap_user.o



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
