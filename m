Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D93fm-0001X5-Cq for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 08:04:34 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1D93fk-0007pZ-Ip for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 08:04:34 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503091134.03322.blaisorblade@yahoo.it>
Subject: [uml-devel] Switching uml_utilities to public CVS and no-maintainer
	model
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
Date: Wed, 9 Mar 2005 11:34:02 +0100
To: Jeff Dike <jdike@addtoit.com>, Steve Schmidtke <steve_schmidtke@hotmail.com>, Gerd Knorr <kraxel@bytesex.org>, Felix =?iso-8859-15?q?M=FCri?= <uml@uxu.ch>, Michael Richardson <mcr@marajade.sandelman.ottawa.on.ca>
Cc: user-mode-linux-devel@lists.sourceforge.net

Now, I'm thinking to move uml_utilities to a CVS repository, either the 
SourceForge one or the UML's own one.

And give to many write-access to it (for public read access we'll see, there 
are security problems with pserver. Having a rsyncable CVS repos like for the 
kernel should be ok - the repos. will be very little anyway).

There are too much little things to fix to have a central maintainer, IMHO. 
And nobody volunteered, sadly, and I can't either.

I'm only 19 years old and little Unix programming experience (yes, I'm the 
same one who works on UML, I've probably a more detailed understanding of the 
kernel than of the Unix userspace), so I have a hard time understanding what 
exactly is going on in uml_switch (a SLIP connection uses a virtual pty? Wow! 
It makes sense since it's called "SLIP", so it must use a tty anyway... still 
I discovered it when reading the uml_net local DoS fix from Steve).

So I can only read the changelogs and the patches and check if they have 
"political" problems (like breaking APIs, being too big and possibly 
destabilizing code). And this when I have time.
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
