Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D96ud-0004ry-7w for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 11:32:07 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1D96ub-00041i-Ia for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 11:32:07 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] RE: uml_switch security fixing
References: <BAY24-F357DBC6F37DC0BCFA0926483510@phx.gbl>
In-Reply-To: <BAY24-F357DBC6F37DC0BCFA0926483510@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503092031.43707.blaisorblade@yahoo.it>
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
Date: Wed, 9 Mar 2005 20:31:43 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Steve Schmidtke <steve_schmidtke@hotmail.com>, kraxel@bytesex.org

On Wednesday 09 March 2005 19:53, Steve Schmidtke wrote:
> Blaisorblade wrote:
> >But an unpatched UML won't work with a newer uml_net binary (for SLIP
> > usage only and only for closing the interface, I mean), right?

> Correct.  I think uml_net would need to manage a database of who opened
> what to do what you suggest.
Not going to implement it because nobody uses SLIP for what we can see.
> >I also looked at the versioning for uml_net, but what happens is that we
> >can
> >only stop unpatched uml_net from working with newer UML for any protocol,
> >not
> >anything else. So I won't change that. However, I just saw that we did it
> >correctly until Version 3 of the uml_net protocol...
> >I wonder what has happened after.

> I'd like to know this too.  It is odd that it was only the shutdown of the
> interface that changed, it worked perfectly well before.

> > > Agreed, tuntap is a compile time option, slip should be as well.
> >
> >Ok... tuntap is compile-time because of a rough check for host support.
>
> Yes, but uml_net is suid.  I may not want my users to be able to set up
> slip devices on their own (why? I don't know, I'm just paranoid that way).
Correct... And this holds especially for TUN/TAP: I think that giving TUN/TAP 
away to everybody makes it possible for unprivileged users to send raw 
packets, which normally is permitted only to root.
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
