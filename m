Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HjbR8-0000aY-Sc for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 May 2007 06:33:34 -0700
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HjbR3-0005Um-Md
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 May 2007 06:33:34 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Thu, 3 May 2007 15:32:43 +0200
References: <20070501182159.GA8363@c2.user-mode-linux.org>
In-Reply-To: <20070501182159.GA8363@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200705031532.44157.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 5/6] UML - Network and pcap cleanup
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Content-Transfer-Encoding: quoted-printable
To: Jeff Dike <jdike@addtoit.com>
Cc: akpm@osdl.org, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On marted=EC 1 maggio 2007, Jeff Dike wrote:
> [ Paolo - could you eyeball the globally valid MAC piece of this and
> see if you think it's OK? ]

Done, the patch can be accepted (I've not looked at the PCAP part). I've a =

note on the other fix there (the additional return).

> Some network device cleanup.
>
> When setup_etheraddr found a globally valid MAC being assigned to an
> interface, it went ahead and used it rather than assigning a random
> MAC like the other cases do.  This isn't really an error like the
> others, but it seems consistent to make it behave the same.
Fine, agreed. For this, you can add my Acked-by. Probably at that time MAC =

randomization wasn't implemented.

> We were getting some duplicate kfree() in the error case in
> eth_configure because platform_device_unregister frees buffers that
> the error cases following tried to free again.

This is due to patch:
"uml: drivers get release methods"
this could be useful to check whether other such changes are needed, by=20
grepping for platform_device_unregister in exit paths, also for ubd driver.

That patch only fixed net_remove() and ubd_remove().
--=20
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

