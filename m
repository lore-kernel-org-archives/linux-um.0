Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D7bmD-0000It-36 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 05 Mar 2005 08:05:13 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1D7bmB-0004PO-6J for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 05 Mar 2005 08:05:12 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] SKAS3 v8 for x86_64
References: <OJEEKGNKKDLJIEPBEJMIAEIOCAAA.brocka@sterlingcgi.com>
In-Reply-To: <OJEEKGNKKDLJIEPBEJMIAEIOCAAA.brocka@sterlingcgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503051638.49653.blaisorblade@yahoo.it>
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
Date: Sat, 5 Mar 2005 16:38:49 +0100
To: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, "Christopher S. Aker" <caker@theshore.net>
Cc: Anthony Brock <brocka@sterlingcgi.com>

On Friday 04 March 2005 01:24, Anthony Brock wrote:
> Recently some individuals posted a "port" of the SKAS 3 patch to x86_64.
> However, this port was for the 2.4 kernel.
And I know it didn't work... sadly.
> Has anyone worked on porting 
> SKAS 3 (especially v7 or v8) to the x86_64 architecture on 2.6 kernel? Is
> this even on the radar for the current developers?
Yesterday I was working on it. I've put the code together, as I did last time, 
now it's only time to debug it. However the two problems are:

1) I don't use a 64-bit arch normally (I have a ugly Fedora AMD64 installed).
2) when I did it last time, UML didn't boot and nothing in the patch made me 
understood what was wrong.

I hope next week I can publish my version, even if I don't solve the problem, 
so that eventually somebody will be able to fix it.

However, notice that what we can currently give is a port to run 32-bit UMLs. 
Which is very nice, but not everything. On the host side, the 64-bit version 
is probably ready and easier to debug than the 32-bit emulation.

The problem for 64-bit UMLs is that, to my knowledge, they must still get 
support for 64-bit SKAS. It shouldn't be hard, I hope.
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
