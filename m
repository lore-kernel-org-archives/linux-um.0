Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMkil-0001QI-Gy for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 03:44:47 -0800
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FMkil-00065T-4n
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 03:44:47 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: TLS support - status - need for re-testing
References: <200603230317.48384.blaisorblade@yahoo.it>
	<20060324015120.GA8104@ccure.user-mode-linux.org>
	<1143196799.2868.1.camel@localhost>
In-Reply-To: <1143196799.2868.1.camel@localhost>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ou9IEs3daZ654tV"
Message-Id: <200603241244.40735.blaisorblade@yahoo.it>
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
Date: Fri, 24 Mar 2006 12:44:40 +0100
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

--Boundary-00=_ou9IEs3daZ654tV
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 24 March 2006 11:39, Antoine Martin wrote:
> On Thu, 2006-03-23 at 20:51 -0500, Jeff Dike wrote:
> > On Fri, Mar 24, 2006 at 12:44:05AM +0100, Blaisorblade wrote:
> > > Yes, that is true, but meanwhile give a testing to them, especially
> > > regressio test the new patches. I can't merge new patches in until I'm
> > > sure they don't cause regressions.
> >
> > OK, I give it a thumbs-up on a first boot - it's running my FC5
> > filesystem without any trouble.  I'll keep playing with it and let you
> > know of any trouble.
>
> I haven't been able to run FC4/FC5 x86 filesystems with any of the
> patches floating around. (on amd64 host)

I can inform you it's not FC4/FC5 but it's the amd64 host.

I missed this because I hadn't time for proper tests before, however:

add on top of 2.6.15-bb6 the attached patch. (It should more or less work 
against any other tls patchset, but I tested it like this).

Don't compile the resulting kernel for x86, and don't run the UML you get on 
x86 host!

As you can see (it touches include/asm-i386 only), this patch is an quick hack 
made for testing, but I know how to fix it, and I'm going to code it.

> > Attached is a tarball of the patches merged after the patches I have
> > planned for 2.6.17.  Nothing major, just some fuzz, some Makefile
> > rejections, and rejections from some whitespace cleanup in
> > kernel/skas/process_kern.c.

> I couldn't figure out in which order I need to apply these (no series
> file) and I've ran out of time.
Guess it's -bb6 series file (or I won't be able to apply them).
> Antoine

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_ou9IEs3daZ654tV
Content-Type: text/x-diff; charset="iso-8859-1";
	name="workaround-x86_64-host-problem"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="workaround-x86_64-host-problem"

Only for testing on x86_64 hosts.

Index: linux-2.6.15/include/asm-i386/segment.h
===================================================================
--- linux-2.6.15.orig/include/asm-i386/segment.h
+++ linux-2.6.15/include/asm-i386/segment.h
@@ -46,7 +46,7 @@
  *  31 - TSS for double fault handler
  */
 #define GDT_ENTRY_TLS_ENTRIES	3
-#define GDT_ENTRY_TLS_MIN	6
+#define GDT_ENTRY_TLS_MIN	12
 #define GDT_ENTRY_TLS_MAX 	(GDT_ENTRY_TLS_MIN + GDT_ENTRY_TLS_ENTRIES - 1)
 
 #define TLS_SIZE (GDT_ENTRY_TLS_ENTRIES * 8)

--Boundary-00=_ou9IEs3daZ654tV--

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
