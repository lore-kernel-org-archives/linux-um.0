Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D96Iz-0002qS-UT for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 10:53:13 -0800
Received: from bay24-f35.bay24.hotmail.com ([64.4.18.85] helo=hotmail.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D96Iy-0001xp-85 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 10:53:13 -0800
Message-ID: <BAY24-F357DBC6F37DC0BCFA0926483510@phx.gbl>
In-Reply-To: <200503091134.12352.blaisorblade@yahoo.it>
From: "Steve Schmidtke" <steve_schmidtke@hotmail.com>
Subject: Re: [uml-devel] RE: uml_switch security fixing
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
Date: Wed, 09 Mar 2005 18:53:07 +0000
To: blaisorblade@yahoo.it, user-mode-linux-devel@lists.sourceforge.net
Cc: kraxel@bytesex.org

Blaisorblade wrote:
>But an unpatched UML won't work with a newer uml_net binary (for SLIP usage
>only and only for closing the interface, I mean), right?

Correct.  I think uml_net would need to manage a database of who opened what 
to do what you suggest.

>I also looked at the versioning for uml_net, but what happens is that we 
>can
>only stop unpatched uml_net from working with newer UML for any protocol, 
>not
>anything else. So I won't change that. However, I just saw that we did it
>correctly until Version 3 of the uml_net protocol...
>I wonder what has happened after.

I'd like to know this too.  It is odd that it was only the shutdown of the 
interface that changed, it worked perfectly well before.

> > Agreed, tuntap is a compile time option, slip should be as well.
>Ok... tuntap is compile-time because of a rough check for host support.

Yes, but uml_net is suid.  I may not want my users to be able to set up slip 
devices on their own (why? I don't know, I'm just paranoid that way).

Steve Schmidtke




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
