Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EoNgZ-0000U5-Ih for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Dec 2005 08:16:27 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EoNgT-0008Pg-CS
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Dec 2005 08:16:27 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
References: <1134932624.10491.76.camel@localhost.localdomain>
In-Reply-To: <1134932624.10491.76.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512191716.06370.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: pcap cross-linking
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
Date: Mon, 19 Dec 2005 17:16:05 +0100
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>

On Sunday 18 December 2005 20:03, Antoine Martin wrote:
> Paolo,

> pcap builds and runs fine on amd64 but there is a problem when building
> with SUBARCH=i386: it uses the wrong version of libpcap.a:
> ld -r -dp -o arch/um/drivers/pcap.o arch/um/drivers/pcap_kern.o
> arch/um/drivers/pcap_user.o  -m elf_i386
> -r /usr/lib/gcc/x86_64-pc-linux-gnu/3.4.4/../../../libpcap.a

> Whereas the one it needs to link against is here:
> /emul/linux/x86/usr/lib/libpcap.a

This is IMHO a Gentoo bug - it is not setup for compilation of 32-bit binaries 
using anything else than glibc. I hit this problem with libncurses, when 
doing make menuconfig ARCH=um (now this was solved as helper programs are 
built as native again).

However, I built uml with libpcap by default for some time - possibly it was 
before me switching to 64-bit linux.

> Fixing the Makefile is beyond me (probably not that hard),

it is a bit hard - in this case it probably suffices to add -L searchpath 
(i.e. -L /emul/linux/x86/usr/lib/ ), but it's non-standard (aka only Gentoo 
works this way) - and merging fixes for every possible distro is not a good 
idea.

> sorry - so I 
> link it manually. After that it works perfectly.

> On the subject of pcap transport, I couldn't dig the email where you
> suggested a way of figuring out which libraries should be placed in the
> chroot, I tried to use the same libraries as I used on a 32-bit setup
> but it fails to bring up the interface (when it works outside chroot).

Don't know what I did suggest, but using strace -e open() (or, even better, 
ltrace -e dlopen ) would probably find the point where it's failing and the 
failed cmd line.

> I tried to guess and even added a few more, here is the chroot's /lib (I
> made /lib64 a link to /lib in chroot):
> ld-2.3.5.so           libcrack.so.2.8.0  libm.so.6

> libnss_compat-2.3.5.so  libnss_hesiod-2.3.5.so   libpam.so

Good thing, libnss_* is probably good - but don't forget /etc/nsswitch.conf 
and /etc/pam.d/* - /etc/pam.conf


> (also lib/security so I can get into the chroot)
That's for su, right? There are some tools (including "compartment") to 
combine chroot + su together.

> But that's not enough... and ldd didn't show me anything missing.

Ldd won't help you with dynamically loaded libraries.

Likely, a recursive "strings object|grep lib" will help - recursive means "do 
that also on libraries found this way".

Also, I see you're using SeLinux. I don't know anything about its library 
handling, and possibly it's going to make the story more difficult. However, 
strace/ltrace as suggested above should diagnose any problem.

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
