Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ce0gM-0000QN-Qw for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 13 Dec 2004 16:36:50 -0800
Received: from almesberger.net ([63.105.73.238] helo=host.almesberger.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1Ce0gK-0001dm-O1
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 13 Dec 2004 16:36:50 -0800
From: Werner Almesberger <wa@almesberger.net>
Subject: Re: [uml-devel] Re: What to do with uml_switch?
Message-ID: <20041213213601.A28618@almesberger.net>
References: <7044.1102525892@marajade.sandelman.ottawa.on.ca>
	<BAY24-F3095F190F005AC385C24ED83B60@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY24-F3095F190F005AC385C24ED83B60@phx.gbl>;
	from steve_schmidtke@hotmail.com on Wed, Dec 08, 2004 at
	07:49:09PM +0000
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
Date: Mon, 13 Dec 2004 21:36:01 -0300
To: Steve Schmidtke <steve_schmidtke@hotmail.com>
Cc: mcr@sandelman.ottawa.on.ca, blaisorblade_spam@yahoo.it, kraxel@bytesex.org, uml@uxu.ch, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net

Steve Schmidtke wrote:
> It would be useful if daemon_user.c could be run in a synchronous mode such 
> that packets are guaranteed delivered to the switch and guaranteed delivered 
> to a host.  The switch could then mangle packets in a deterministic fashion 
> for testing.

BTW, for testing purposes, one may also want to consider umlsim,
which gives you even more control over what happens to the packets
(including delay, etc.).

Right now, the networking support still isn't great, but it's
getting there ...

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
