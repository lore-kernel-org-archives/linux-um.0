Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EoQfH-0002S6-Uv for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Dec 2005 11:27:19 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EoQfH-0000Cq-CJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Dec 2005 11:27:19 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: pcap cross-linking [PATCH]
References: <1134932624.10491.76.camel@localhost.localdomain>
	<200512191716.06370.blaisorblade@yahoo.it>
	<1135017219.15991.131.camel@ant.internal>
In-Reply-To: <1135017219.15991.131.camel@ant.internal>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512192027.06840.blaisorblade@yahoo.it>
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
Date: Mon, 19 Dec 2005 20:27:06 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Antoine Martin <antoine@nagafix.co.uk>

On Monday 19 December 2005 19:33, Antoine Martin wrote:
> > > pcap builds and runs fine on amd64 but there is a problem when building
> > > with SUBARCH=i386: it uses the wrong version of libpcap.a:
> > > ld -r -dp -o arch/um/drivers/pcap.o arch/um/drivers/pcap_kern.o
> > > arch/um/drivers/pcap_user.o  -m elf_i386
> > > -r /usr/lib/gcc/x86_64-pc-linux-gnu/3.4.4/../../../libpcap.a

> > > Whereas the one it needs to link against is here:
> > > /emul/linux/x86/usr/lib/libpcap.a

> > This is IMHO a Gentoo bug -

> I'll ask the gentoo devs, for the time being I can copy this library
> manually to /usr/lib32 (which is the standard location for 32-bit libs
> on amd64)

> But the problem remains, the linker should use:
> -r /usr/lib32/libpcap.a
> and not ../../../libpcap.a which ends up as /usr/lib (which points
> to /usr/lib64 on standard distros)
> But only when building with SUBARCH=i386.

> So I added this statement to the Makefile (patch attached) and now all
> is well:
> +ifeq ($(SUBARCH),i386)
> +LDFLAGS_pcap.o := -r /usr/lib32/libpcap.a
> +else

Yep, seen that - obviously this patch can't be merged as the thing is 
non-standard (not that I know, I just guess this). Just a first guess 
however.

Also, by gross testing on my system (guess Gentoo devs have screwed up 
something else on your system, too). Note the -m32 difference and lib32 vs. 
lib64:

$ gcc -print-file-name=libpcap.a
/usr/lib/gcc/x86_64-pc-linux-gnu/3.4.4/../../../../lib64/libpcap.a
$ gcc -m32 -print-file-name=libpcap.a
/usr/lib/gcc/x86_64-pc-linux-gnu/3.4.4/../../../../lib32/libpcap.a

> chroot without su is pointless (since you can use 'chroot-again' to
> escape)
Indeed.
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
