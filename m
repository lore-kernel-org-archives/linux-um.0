Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D9paR-00082W-9C for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Mar 2005 11:14:15 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1D9paO-0004gp-9n for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Mar 2005 11:14:15 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200503112013.20206.blaisorblade@yahoo.it>
Subject: [uml-devel] SKAS-v8: RC5 released against 2.6.7 - 2.6.11 kernels
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
Date: Fri, 11 Mar 2005 20:13:19 +0100
To: user-mode-linux-devel@lists.sourceforge.net, Bodo Stroesser <bstroesser@fujitsu-siemens.com>, user-mode-linux-user@lists.sourceforge.net
Cc: Gerd Knorr <kraxel@bytesex.org>, Michael Richardson <mcr@sandelman.ottawa.on.ca>, Henrik Nordstrom <hno@marasystems.com>, "Christopher S. Aker" <caker@theshore.net>

This time, I've announced this on my homepage, since I'd like to get a lot 
more testing and to release this patch unchanged as -V8 final version.

Things I've forgot:
* make it apply easily on Fedora kernels.

This should simply mean moving the TIF_SYSCALL_EMU to place no.8, to leave a 
slot free for _DB7, needed for 4g4g or something like that and using testw 
instead of testb for testing against it. This will be done in -V9.

The summary of changes against -RC2 is short... I dropped 
fix-dumpable-handling because I don't feel it secure yet, so everybody using 
-RC2 should upgrade.

The problem is that the correct locking is difficult and even mainline kernel 
code has a lot of confusion about it, and I want to sort this out first, to 
avoid problems with the patch.

Sorry Michael, but this is lower priority than stability and security. It will 
be for next patch.

Description of this patch.
* fix-dumpable-handling.patch: this implemented a feature / bug fix requested 
by Michael Richardson <mcr@sandelman.ottawa.on.ca>. I.e., with this, in 
normal cases, UML *is* allowed to dump core and be seen inside /proc - (until 
now it was treated as if it was a setuid process or one which changed UID / 
GID). If I did any error, however, it could allow privilege escalation.

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
