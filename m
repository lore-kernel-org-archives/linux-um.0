Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EoPvN-0007z7-1s for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Dec 2005 10:39:53 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EoPvF-0005MB-6V
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Dec 2005 10:39:53 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: pcap cross-linking
References: <1134932624.10491.76.camel@localhost.localdomain>
	<200512191716.06370.blaisorblade@yahoo.it>
In-Reply-To: <200512191716.06370.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512191939.22249.blaisorblade@yahoo.it>
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
Date: Mon, 19 Dec 2005 19:39:21 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Antoine Martin <antoine@nagafix.co.uk>

On Monday 19 December 2005 17:16, Blaisorblade wrote:
> On Sunday 18 December 2005 20:03, Antoine Martin wrote:
> > Paolo,
> >
> > pcap builds and runs fine on amd64 but there is a problem when building
> > with SUBARCH=i386: it uses the wrong version of libpcap.a:
> > ld -r -dp -o arch/um/drivers/pcap.o arch/um/drivers/pcap_kern.o
> > arch/um/drivers/pcap_user.o  -m elf_i386
> > -r /usr/lib/gcc/x86_64-pc-linux-gnu/3.4.4/../../../libpcap.a
> >
> > Whereas the one it needs to link against is here:
> > /emul/linux/x86/usr/lib/libpcap.a
>
> This is IMHO a Gentoo bug - it is not setup for compilation of 32-bit
> binaries using anything else than glibc. I hit this problem with
> libncurses, when doing make menuconfig ARCH=um (now this was solved as
> helper programs are built as native again).

> However, I built uml with libpcap by default for some time - possibly it
> was before me switching to 64-bit linux.

No, the thing works but only because I indeed symlinked 32-bit libraries 
inside /usr/lib32.
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
