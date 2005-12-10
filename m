Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1El7d7-0005WG-Pd for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Dec 2005 08:31:25 -0800
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1El7d7-0003O3-7E
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Dec 2005 08:31:25 -0800
Subject: Re: [uml-devel] tls: set_thread_area failed
From: Antoine Martin <antoine@nagafix.co.uk>
In-Reply-To: <200512101526.17891.blaisorblade@yahoo.it>
References: <1134008028.32598.52.camel@localhost.localdomain>
	<200512091852.15906.blaisorblade@yahoo.it>
	<1134153592.29209.2.camel@localhost.localdomain>
	<200512101526.17891.blaisorblade@yahoo.it>
Content-Type: text/plain
Message-Id: <1134232267.29209.21.camel@localhost.localdomain>
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
Date: Sat, 10 Dec 2005 16:31:07 +0000
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

> > > Also, different glibc are more or less happy in using modify_ldt() rather
> > > than set_thread_area() - it seems that latter is better.
> 
> > Ahh, is it planned 
> What?
I was wondering if this was being worked on, (you answered this below)
> > or do I have to make heavily modified distro images? 
> I'm not suggesting that...
Good!

> And, hold on this - Jeff has made a big progress on this, diagnosing what had 
> been happening.
> 
> I'm not sure how well it works, but in the incrementals page there's the new 
> result. Give it a run and tell us the result, if it works it might go in 
> 2.6.15-bs and 2.6.16.
I've tried these patches:
* there was one suspicious offset on:
patching file arch/um/kernel/skas/process_kern.c
Hunk #1 succeeded at 126 (offset 3 lines).

* CC      arch/um/os-Linux/tls.o
arch/um/os-Linux/tls.c: In function `os_set_thread_area':
arch/um/os-Linux/tls.c:22: error: dereferencing pointer to incomplete
type
arch/um/os-Linux/tls.c: In function `os_get_thread_area':
arch/um/os-Linux/tls.c:36: error: dereferencing pointer to incomplete
type
make[1]: *** [arch/um/os-Linux/tls.o] Error 1
make: *** [arch/um/os-Linux] Error 2

with GCC 3.4.4 and GCC 3.3.4

* another /lib vs lib32 vs lib64 issue with pcap when compiling with
SUBARCH=i386 on this Gentoo system I had to add -r /usr/lib32/libpcap.a:
ld -r -dp -o arch/um/drivers/pcap.o arch/um/drivers/pcap_kern.o
arch/um/drivers/pcap_user.o  -m elf_i386
-r /usr/lib32/libpcap.a /usr/lib/gcc-lib/x86_64-pc-linux-gnu/3.3.4/../../../../lib/libpcap.a
Otherwise it moans about linking 64-bit libs with 32-bit... which is
fair enough I guess.

Antoine



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
