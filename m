Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DJG7T-0000qe-FO for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Apr 2005 12:23:19 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DJG7O-0005iT-J4 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Apr 2005 12:23:19 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: UML-patches to prepare UML/s390
References: <4253E3D6.2000809@fujitsu-siemens.com>
	<20050406203558.GA3307@ccure.user-mode-linux.org>
	<20050406191623.GA10085@wavehammer.waldi.eu.org>
In-Reply-To: <20050406191623.GA10085@wavehammer.waldi.eu.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504062128.27283.blaisorblade@yahoo.it>
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
Date: Wed, 6 Apr 2005 21:28:27 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Bastian Blank <bastian@waldi.eu.org>

On Wednesday 06 April 2005 21:16, Bastian Blank wrote:
> On Wed, Apr 06, 2005 at 04:35:58PM -0400, Jeff Dike wrote:
> > I merged these, except for the restartnointr one because I don't have
> > ERESTARTNOINTR in my
Please note:
> > /usr/include

> > , inside a #ifdef KERNEL or not.  

>
> 2.6.11 shows:
> | $ grep ERESTARTNOINTR -r .
> | ./linux/errno.h:#define ERESTARTNOINTR  513
>
> And it is there since 2.5.
Yes, what you say is true, but non significant. He's speaking about the host 
include (and there are good reasons to do so) and we cannot rely on 2.6 host 
kernel headers.

Bye
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
