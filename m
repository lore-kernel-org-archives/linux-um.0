Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C5GuJ-0004kD-FY for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Sep 2004 21:51:39 -0700
Received: from mail.stral.net ([61.14.141.91] helo=ns1.stral.net ident=qmailr)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1C5GuB-0000wT-QX
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Sep 2004 21:51:38 -0700
Reply-To: <ralston@stral.net>
From: "Michael Ralston" <ralston@stral.net>
Subject: RE: [uml-devel] Compiling UML 2.6.8.1 with Static Linking results in
	segfault 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <200409090043.i890hpBP016311@ccure.user-mode-linux.org>
Message-ID: <E1C5GuB-0000wT-QX@sc8-sf-mx2.sourceforge.net>
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
Date: Thu, 9 Sep 2004 14:51:12 +1000
To: 'Jeff Dike' <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

(gdb) run
Starting program: /uml/linux-2.4.26-static

Program received signal SIGSEGV, Segmentation fault.
0x0815c520 in __libc_setup_tls ()
(gdb) bt
#0  0x0815c520 in __libc_setup_tls ()
#1  0x0815c82b in __pthread_initialize_minimal ()
#2  0x00000004 in ?? ()
#3  0xbffffd88 in ?? ()
#4  0x0815c2e8 in __libc_start_main ()
Previous frame inner to this frame (corrupt stack?)
(gdb)


I compiled the uml binary with debugging symbols enabled... Let me know if
there is anything else I can do... Would my complete .config be useful?

Michael 

> -----Original Message-----
> From: Jeff Dike [mailto:jdike@addtoit.com] 
> Sent: Thursday, 9 September 2004 10:44 AM
> To: ralston@stral.net
> Cc: user-mode-linux-devel@lists.sourceforge.net
> Subject: Re: [uml-devel] Compiling UML 2.6.8.1 with Static 
> Linking results in segfault 
> 
> ralston@stral.net said:
> > Hey, the core is 20k gzipped :)
> 
> And the core is useless without the binary that produced it.  
> In any case, it's probably a lot easier for you to type 'bt' 
> at gdb and send that rather than compressing a core file and 
> binary and sending them.
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
