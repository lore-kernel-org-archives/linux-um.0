Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cf0ea-0005id-K5 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Dec 2004 10:47:08 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1Cf0eZ-0000we-MA for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Dec 2004 10:47:08 -0800
From: Paolo Giarrusso <blaisorblade_personal@yahoo.it>
Subject: Re: [uml-devel] Stranded processes on halt with 2.6.9 host (2.4.26
	client)
References: <41BCD1C8.8060701@easyco.com>
In-Reply-To: <41BCD1C8.8060701@easyco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412161927.12219.blaisorblade_personal@yahoo.it>
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
Date: Thu, 16 Dec 2004 19:27:12 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Doug Dumitru <doug@easyco.com>

On Monday 13 December 2004 00:18, Doug Dumitru wrote:
> I have been running 2.6.7 on the host for some time in SKAs mode.  When
> trying to upgrade to 2.6.9, 2.4.26 clients do run correctly, but upon
> shutdown they leave two processes stranded that cannot be killed (even
> with kill -9).  Both processes show [halt] so this must be very near the
> end of UML shutdown.  Any ideas.  I hunted the message list, but did not
> see anything obvious.
It's on *any* 2.6.9 host (search "zombie" on the list and you'll find many 
info). Some UML kernels have been partially patched for that... but some 
problems are only due to the host kernel and not workaroundable.
> Server is a Dual P-III running fresh Fedora Core 3.  Kernel.org 2.6.9
> kernel has been tried with:

>      15957 host-skas3-2.6.7-v1.patch
This particular one would crash IIRC (even Oops the kernel).... at least on 
2.6.9 prereleases.
>      23838 host-skas3-2.6.9-rc4-v6.patch
>      25510 host-skas3-2.6.9-v7.patch

> but they all behave the same way.

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
