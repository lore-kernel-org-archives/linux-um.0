Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EoiPM-0003mu-8X for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Dec 2005 06:24:04 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EoiPI-0001P4-HF
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Dec 2005 06:24:04 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: pcap cross-linking [PATCH]
References: <1134932624.10491.76.camel@localhost.localdomain>
	<200512192027.06840.blaisorblade@yahoo.it>
	<1135028820.4622.7.camel@localhost.localdomain>
In-Reply-To: <1135028820.4622.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512201523.32040.blaisorblade@yahoo.it>
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
Date: Tue, 20 Dec 2005 15:23:31 +0100
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Monday 19 December 2005 22:47, Antoine Martin wrote:
> > > So I added this statement to the Makefile (patch attached) and now all
> > > is well:
> > > +ifeq ($(SUBARCH),i386)
> > > +LDFLAGS_pcap.o := -r /usr/lib32/libpcap.a
> > > +else
>
> ahh, so this is the right way to find the lib... (cool)

Suggested by Al Viro IIRC...

> > $ gcc -print-file-name=libpcap.a
> > /usr/lib/gcc/x86_64-pc-linux-gnu/3.4.4/../../../../lib64/libpcap.a
> > $ gcc -m32 -print-file-name=libpcap.a
> > /usr/lib/gcc/x86_64-pc-linux-gnu/3.4.4/../../../../lib32/libpcap.a
>
> Works for me (tm) too.

> Can this be merged? (I can't see any reason not to now)

Wait a moment - CFLAGS is supposed to contain -m32:

arch/um/Makefile-i386:

CFLAGS                  += $(call cc-option,-m32)

so there is something strange going on - but have you tested without this 
patch _after_ symlinking libraries into /usr/lib32?
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
