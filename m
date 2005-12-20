Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eon6g-0005Bb-O8 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Dec 2005 11:25:06 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Eon6d-0004kP-OT
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Dec 2005 11:25:06 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: pcap cross-linking [PATCH]
References: <1134932624.10491.76.camel@localhost.localdomain>
	<200512201523.32040.blaisorblade@yahoo.it>
	<1135095932.4622.24.camel@localhost.localdomain>
In-Reply-To: <1135095932.4622.24.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512202024.33062.blaisorblade@yahoo.it>
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
Date: Tue, 20 Dec 2005 20:24:32 +0100
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tuesday 20 December 2005 17:25, Antoine Martin wrote:
> > > > $ gcc -print-file-name=libpcap.a
> > > > /usr/lib/gcc/x86_64-pc-linux-gnu/3.4.4/../../../../lib64/libpcap.a
> > > > $ gcc -m32 -print-file-name=libpcap.a
> > > > /usr/lib/gcc/x86_64-pc-linux-gnu/3.4.4/../../../../lib32/libpcap.a
> > >
> > > Works for me (tm) too.
> > >
> > > Can this be merged? (I can't see any reason not to now)
> >
> > Wait a moment - CFLAGS is supposed to contain -m32:
> >
> > arch/um/Makefile-i386:
> >
> > CFLAGS                  += $(call cc-option,-m32)
> >
> > so there is something strange going on - but have you tested without this
> > patch _after_ symlinking libraries into /usr/lib32?
>
> Yes, that works and in fact the patch solved nothing: I forgot to remove
> the library from /usr/lib32 and that's what it used - DOH.
> # gcc -m32 -print-file-name=libpcap.a
> /usr/lib/gcc/x86_64-pc-linux-gnu/3.4.4/../../../libpcap.a
> I thought the '-m32' would force it to try to find the 32 bit version?

-m32 means "compile a 32bit program". Gcc is smart enough to correct the 
libraries search path. Gentoo is not smart enough to put emulation libraries 
in /usr/lib32.

Btw, which emul- package did you install to get libpcap? Also there's almost 
no .a file in /emul - they're intended to be used for .so (dynamic) libraries 
only, I guess - you sneaked it there, right?

However, the Gentoo bug is still there, and you followed its example in 
putting your libpcap.a.

I'm discussing the issue at:

http://bugs.gentoo.org/show_bug.cgi?id=100923

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
