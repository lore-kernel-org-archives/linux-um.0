Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPCdK-0006dA-1Z for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 15 May 2004 20:48:14 -0700
Received: from mail5.speakeasy.net ([216.254.0.205])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1BPCdJ-0003Gq-PK
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 15 May 2004 20:48:13 -0700
Received: from dsl081-102-219.den1.dsl.speakeasy.net (HELO speakeasy.net)
	(dminer@[64.81.102.219]) (envelope-sender <dminer@speakeasy.net>)
	by mail5.speakeasy.net (qmail-ldap-1.03) with SMTP
	for <user-mode-linux-devel@lists.sourceforge.net>;
	16 May 2004 03:48:13 -0000
Message-ID: <40A6E47C.40404@speakeasy.net>
From: Dan Miner <dminer@speakeasy.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] uml 2.4.26 controlling tty problem
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
Date: Sat, 15 May 2004 21:48:12 -0600
To: user-mode-linux-devel@lists.sourceforge.net

I'm attempting to build and run UML.  I've been relatively successful at 
getting UML and utilities to build with 2.4.26 (stock Linus kernel + uml 
patch).

However, none of the 'login' type programs work due to stranges errors.

minigetty reports: no controllying tty: Operation not permiited
telnetd reports: telnetd: Unable to set controlling terminal: No such 
device or address

and ssh just dropped the connection :)

I'm running mdk 10.0 official with their 2.6.3 kernel but I'm building a 
mdk 10.0 UML image with 2.4.26 UML kernel.  I've also try this same UML 
kernel on a mdk 9.0 system with the same results.

I've checked that devfsd is running (it is) and all the dev entrys looks 
like the ones on my host computer -- so, I'm really confused by this one.

I configured UML with make xconfig ARCH=um, changed scsi_debug to no and 
saved.  All default values.

Any clues?

    Regards,
       Dan


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
