Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D93fn-0001Y0-CM for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 08:04:35 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1D93fk-0007pb-OW for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 08:04:35 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] RE: uml_switch security fixing
References: <BAY24-F21573D60D3DDE776FDC27C835F0@phx.gbl>
In-Reply-To: <BAY24-F21573D60D3DDE776FDC27C835F0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503091134.12352.blaisorblade@yahoo.it>
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
Date: Wed, 9 Mar 2005 11:34:12 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Steve Schmidtke <steve_schmidtke@hotmail.com>, kraxel@bytesex.org

On Monday 07 March 2005 05:42, Steve Schmidtke wrote:
> Blaisorblade wrote:
> >Hey, has anyone found the time to put together any patch to workaround the
> >security bug in uml_net?

> Attached are two patches.  The first one, uml_net-slip.diff, is the minimal
> patch to apply to uml_net.  The second one, uml_net-uml.diff, applies to
> 2.4.27-1um
Thanks for your time and work!
> (note the half-hearted attempt to plug a FD leak in there as 
> well).
Verified, both seem correct (the closed fd's are local var, so there is no 
possibility they were closed elsewhere).

half-hearted... ok, found in my dictionary!!! Wow!
> As a nice bonus, a UML with this patch still works with an 
> unpatched uml_net binary.
Hmm, this means many users could avoid upgrading... Well, it's their box 
anyway.

But an unpatched UML won't work with a newer uml_net binary (for SLIP usage 
only and only for closing the interface, I mean), right?

I see that this way it's not possible to avoid this (and frankly, I was ready 
to discard SLIP support until the fix was ready, so it is ok). Also the patch 
is very little (and applies unchanged to 2.6.11, so I guess there will be 0 
backporting problems).

I'm applying this nevertheless in my tools (I think I'll forward all this to 
Jeff, or maybe I'll send him a released tarball + the splitout changes), and 
I'm also going to publish as much information as I can (which means 
pre-adding an entry to the Wiki).

I also looked at the versioning for uml_net, but what happens is that we can 
only stop unpatched uml_net from working with newer UML for any protocol, not 
anything else. So I won't change that. However, I just saw that we did it 
correctly until Version 3 of the uml_net protocol...
I wonder what has happened after.

> >I think it would be ok also to simply comment out the offending code (even
> >providing some kind of -D configuration option for who really needs SLIP
> >support, and they are few)!
> >
> >Suggestions?
>
> Agreed, tuntap is a compile time option, slip should be as well.
Ok... tuntap is compile-time because of a rough check for host support.
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
