Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4pqp-00078j-Mf for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Sep 2004 16:58:15 -0700
Received: from mail.stral.net ([61.14.141.91] helo=ns1.stral.net ident=qmailr)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1C4pqh-0007cr-BD
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Sep 2004 16:58:11 -0700
Reply-To: <ralston@stral.net>
From: "Michael Ralston" <ralston@stral.net>
Subject: RE: [uml-devel] Compiling UML 2.6.8.1 with Static Linking results in
	segfault 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
In-reply-to: <200409080018.i880ISBP011602@ccure.user-mode-linux.org>
Message-ID: <E1C4pqh-0007cr-BD@sc8-sf-mx2.sourceforge.net>
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
Date: Wed, 8 Sep 2004 09:57:52 +1000
To: user-mode-linux-devel@lists.sourceforge.net
Cc: 'Jeff Dike' <jdike@addtoit.com>

The core is 483k, want me to email that just to you (not the list), or is
the gdb output below pretty conclusive?

I'm running this on a 2.6.8.1 host with SKAS3-2.6.7-v1 patch, and as I said
libc6-2.3.2, so it's prolly another one of those lovely NPTL/TLS issues.

The Config options which are set:
# CONFIG_MODE_TT is not set
CONFIG_STATIC_LINK=y
CONFIG_MODE_SKAS=y 

If I disable STATIC_LINK then it runs fine...


(gdb) run
Starting program: /uml/linux

Program received signal SIGSEGV, Segmentation fault.
0x08191800 in __libc_setup_tls () at swab.h:134
134     swab.h: No such file or directory.
        in swab.h



> -----Original Message-----
> From: Jeff Dike [mailto:jdike@addtoit.com] 
> Sent: Wednesday, 8 September 2004 10:18 AM
> To: ralston@stral.net
> Cc: user-mode-linux-devel@lists.sourceforge.net
> Subject: Re: [uml-devel] Compiling UML 2.6.8.1 with Static 
> Linking results in segfault 
> 
> ralston@stral.net said:
> > Can I provide any further info or is this a known problem? 
> 
> Get a core, and get a stack trace from it?
> 
> 				Jeff
> 
> 



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
