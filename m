Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CeikI-0006rk-Bi for User-mode-linux-devel@lists.sourceforge.net;
	Wed, 15 Dec 2004 15:39:50 -0800
Received: from bay24-f18.bay24.hotmail.com ([64.4.18.68] helo=hotmail.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CeikI-0008Fo-3X for User-mode-linux-devel@lists.sourceforge.net;
	Wed, 15 Dec 2004 15:39:50 -0800
Message-ID: <BAY24-F18CCBB36259F34F2AFB7C683AD0@phx.gbl>
From: "Steve Schmidtke" <steve_schmidtke@hotmail.com>
Subject: Re: [uml-devel] [local] [kill] uml-utilities 20030903 uml_net
	slip_down() fails
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
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
Date: Wed, 15 Dec 2004 23:37:11 +0000
To: djb@cr.yp.to
Cc: User-mode-linux-devel@lists.sourceforge.net

D. J. Bernstein wrote:
>The underlying bug is that, in slip.c, slip_down() has no idea whether
>the user is actually allowed to take down the specified interface.

I'm thinking the proper fix would be to send the open fd to uml_net just 
like when it was upped (if you can open it, you own it).  The line 
discipline on the fd can be checked with ioctl TIOCGETD if it's N_SLIP, but 
I'm not sure the interface name can be recovered from the fd.  The tty ioctl 
TIOCSETD in the kernel looks like it returns two different values: either 
the dev index if the slip line is new (useful), or 0 if it has already been 
set (not useful).

Steve Schmidtke




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
