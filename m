Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMFOj-0001En-BG for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Mar 2006 18:18:01 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FMFOg-0005wd-9W
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Mar 2006 18:18:01 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200603230317.48384.blaisorblade@yahoo.it>
Subject: [uml-devel] TLS support - status - need for re-testing
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
Date: Thu, 23 Mar 2006 03:17:45 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Antoine Martin <antoine@nagafix.co.uk>

I've integrated "linux-unistd" from Jeff series, while leaving out 
"user-desc" (I've solved the problem another way, which should work on both 
host header set - we give our own definition for userspace files, and use our 
one for kernelspace, but give the resulting type the name of "user_desc_t").
Jeff, I've looked at all other patches _names_ and they're patches which I 
already have, so I shouldn't have lost any other changes.

Plus, I've just done a couple of other cleanups of the TLS code, removing dead 
code which was there for experiments; I've implemented 2.4 host detection (I 
hope I've not forgot to check the host_supports_tls variable anywhere), and 
I'm ripping out global-ldt-sem which I longly hated (and which isn't easy to 
avoid).

I've ripped it out by comparing header dependencies to i386; the result is 
that our additional dependency is from processor.h and ptrace.h on ldt.h, but 
they only depend on the user_desc declaration and not on the uml_ldt_t 
declaration (which is the one using the semaphore).

So I split the user_desc part away in a new header file, and this fixed the 
problem.

However, I tested seriously the new code and it doesn't work with apache2 
mpm-worker nor with simpler tests.... I hadn't run such tests recently, and I 
now see that the code does assumptions which are wrong on x86_64 hosts.

Has anyone got success or failure with TLS code on 32-bit machines on 64-bit 
hosts?

More important: has anyone tested that?
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
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
