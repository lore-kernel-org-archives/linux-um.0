Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D93fn-0001Xq-6G for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 08:04:35 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1D93fi-0007Gs-Sp for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 08:04:35 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: uml_switch security fixing
References: <200503021553.14862.blaisorblade@yahoo.it>
	<87hdjs6gmn.fsf@aka.i.naked.iki.fi>
In-Reply-To: <87hdjs6gmn.fsf@aka.i.naked.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503091023.50460.blaisorblade@yahoo.it>
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
Date: Wed, 9 Mar 2005 10:23:50 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Nuutti Kotivuori <naked@iki.fi>

On Thursday 03 March 2005 13:47, Nuutti Kotivuori wrote:
> blaisorblade@yahoo.it wrote:
> > Suggestions?
>
> FWIW, we have gone off using switch daemon entirely. We are using
> simply preallocated tap devices, connected to bridges via normal Linux
> bridging controls. Works cleaner and faster, more places to dump the
> traffic from and it allows normal linux traffic queueing and
> firewalling to be used to limit transfers between machines.
>
> All physical networks and virtual network (networks not connected to
> any physical interfaces) are implemented as bridges.
>
> The only problem was the tap device queue hang (SIGIO problem), which
> was resolved with the one queue option (and hopefully fixed in UML or
> mainline kernel later).

I just verified I was inaccurate in the title... the problem which was found 
was about the setuid uml_net, not uml_switch. It amounts to the possibility 
for unprivileged users to do the equivalent of "ifconfig down " for chosen 
interfaces, by simply running uml_net.

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
