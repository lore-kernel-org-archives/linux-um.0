Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DkNV3-00066w-H4	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Jun 2005 07:43:45 -0700
Received: from externalmx-1.sourceforge.net ([12.152.184.25])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)	id 1DkNV1-0003Vl-5R
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Jun 2005 07:43:45 -0700
Received: from sphinx.mythic-beasts.com ([212.69.37.6])
	by externalmx-1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)	id 1DkNUx-0005XA-Nn
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Jun 2005 07:43:40 -0700
From: Paul Warren <pdw@ex-parrot.com>
Subject: Re: [uml-devel] problem booting uml without xterms
Message-ID: <20050620154329.F19306@sphinx.mythic-beasts.com>
References: <7920a17820a19800a14b80a.20050620073424.pbqrznpuvar@www.dslextreme.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: 
	<7920a17820a19800a14b80a.20050620073424.pbqrznpuvar@www.dslextreme.com>; from
	codemachine@dslextreme.com on Mon, Jun 20, 2005 at 07:34:24AM -0700
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
Date: Mon, 20 Jun 2005 15:43:29 +0100
To: codemachine@dslextreme.com
Cc: user-mode-linux-devel@lists.sourceforge.net

On Mon, Jun 20, 2005 at 07:34:24AM -0700, codemachine@dslextreme.com wrote:
> I'm trying to  boot uml on a server, and I don't want to have to have X
> installed to do it, so I want to boot without the xterm consoles.
> 
> For the life if me I can't figure out the right con=* command line params
> and/or get them to work per:

We use:

con=null con0=fd:0,fd:1

but you'll need to tweak your root image so that:

1. inittab brings up a getty on tty0
2. tty0 is listed in /etc/securetty.

This is probably one for the user list, BTW.

Paul


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
