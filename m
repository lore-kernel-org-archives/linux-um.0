Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CX5EC-0007Ek-0f for User-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Nov 2004 14:03:08 -0800
Received: from bay24-f37.bay24.hotmail.com ([64.4.18.87] helo=hotmail.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CX5EB-0008Gs-Bi for User-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Nov 2004 14:03:07 -0800
Message-ID: <BAY24-F37F3586AE72E2E119F0A4483B80@phx.gbl>
In-Reply-To: <41A4EE93.9090800@uxu.ch>
From: "Steve Schmidtke" <steve_schmidtke@hotmail.com>
Subject: Re: [uml-devel] [PATCH] uml_router: cleanup
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
Date: Wed, 24 Nov 2004 22:02:31 +0000
Content-Transfer-Encoding: 8bit
To: uml@uxu.ch
Cc: kraxel@bytesex.org, User-mode-linux-devel@lists.sourceforge.net

Felix M�ri <uml@uxu.ch> wrote:
>long ago I found similar issues with the uml_switch codebase. My problem 
>was not
>the mac handling, but an missing feature to connect two switches together 
>via an
>udp-tunnel.

Interesting.  Is there a way to signal the program that a remote switch is 
not responding?

>(I want an uml-switch, which can start and stop uml-guests and be 
>controlled via a
>control socket)

Hmmm, is that the right spot for control?  I'd be concerned that a unsecured 
UDP port would allow someone to inject arbitrary control packets between the 
switches.  A seperate daemon that spoke mconsole securely and could talk to 
uml_switch would probably make more sense and be safer.

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
