Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EokJB-0002tV-O6 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Dec 2005 08:25:49 -0800
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EokJA-0008AY-DF
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Dec 2005 08:25:49 -0800
Subject: Re: [uml-devel] Re: pcap cross-linking [PATCH]
From: Antoine Martin <antoine@nagafix.co.uk>
In-Reply-To: <200512201523.32040.blaisorblade@yahoo.it>
References: <1134932624.10491.76.camel@localhost.localdomain>
	<200512192027.06840.blaisorblade@yahoo.it>
	<1135028820.4622.7.camel@localhost.localdomain>
	<200512201523.32040.blaisorblade@yahoo.it>
Content-Type: text/plain
Message-Id: <1135095932.4622.24.camel@localhost.localdomain>
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
Date: Tue, 20 Dec 2005 16:25:31 +0000
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

> > > $ gcc -print-file-name=libpcap.a
> > > /usr/lib/gcc/x86_64-pc-linux-gnu/3.4.4/../../../../lib64/libpcap.a
> > > $ gcc -m32 -print-file-name=libpcap.a
> > > /usr/lib/gcc/x86_64-pc-linux-gnu/3.4.4/../../../../lib32/libpcap.a
> >
> > Works for me (tm) too.
> 
> > Can this be merged? (I can't see any reason not to now)
> 
> Wait a moment - CFLAGS is supposed to contain -m32:
> 
> arch/um/Makefile-i386:
> 
> CFLAGS                  += $(call cc-option,-m32)
> 
> so there is something strange going on - but have you tested without this 
> patch _after_ symlinking libraries into /usr/lib32?
Yes, that works and in fact the patch solved nothing: I forgot to remove
the library from /usr/lib32 and that's what it used - DOH.
# gcc -m32 -print-file-name=libpcap.a
/usr/lib/gcc/x86_64-pc-linux-gnu/3.4.4/../../../libpcap.a
I thought the '-m32' would force it to try to find the 32 bit version?

So in the end the only way to get it to build is to copy the library
to /usr/lib32... no patch needed.

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
