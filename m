Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DKHtG-0004Kn-Pm for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 09 Apr 2005 08:28:54 -0700
Received: from pike.sandelman.ca ([205.150.200.164])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1DKHtE-0003zw-9X
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 09 Apr 2005 08:28:54 -0700
Received: from sandelman.ottawa.on.ca (wlan232.sandelman.ca [205.150.200.232])
	by pike.sandelman.ca (Postfix) with ESMTP id B154560AE9
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat,  9 Apr 2005 11:28:43 -0400 (EDT)
Received: from marajade.sandelman.ottawa.on.ca (marajade [127.0.0.1])
	by sandelman.ottawa.on.ca (Postfix) with ESMTP id 0C70CBD7C
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat,  9 Apr 2005 11:28:43 -0400 (EDT)
From: "Michael Richardson" <mcr@sandelman.ottawa.on.ca>
Message-ID: <5595.1113060523@marajade.sandelman.ottawa.on.ca>
Subject: [uml-devel] debugging skas kernels
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
Date: Sat, 09 Apr 2005 11:28:43 -0400
To: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----


I know that I can invoke skas kernels like any other process.
However, I find this a bit of a pain. I like to debug under Xemacs, and
I don't want the terminal directed to my emacs buffer, and the command
line arguments are kind of complex.

Is there a reason I can't just "attach" the process? 
Could we make "debug" or "gdb" command line cause a pause() in the code,
near startup?

I'll do that and submit a patch if there isn't something I'm missing.

- -- 
] Michael Richardson          Xelerance Corporation, Ottawa, ON |  firewalls  [
] mcr @ xelerance.com           Now doing IPsec training, see   |net architect[
] http://www.sandelman.ca/mcr/    www.xelerance.com/training/   |device driver[
] panic("Just another Debian GNU/Linux using, kernel hacking, security guy"); [


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Finger me for keys

iQCVAwUBQlf0qYqHRg3pndX9AQF8lQQA5o1EB2Kt7veqCpSjCNZf8ztdohSwMNA6
wD2K9H5MRZ8cgy1bIBCopOb5Is2Xogk7t2FnMwojecQLZX6HfBBTkBcsTDA73uPt
VghywKS4ClNhBYBTiub1oCnGtsR/OOS++kIvsEoyRTJP8fwTQ6Q/hQYYQ7txP4KU
z/9cmvp7t68=
=uRWI
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
