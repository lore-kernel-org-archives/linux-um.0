Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BTjb7-0003O0-P1 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 May 2004 08:48:41 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1BTjb7-0000T5-CL
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 May 2004 08:48:41 -0700
Message-Id: <200405281636.i4SGaHB5001932@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Fri, 28 May 2004 15:58:16 +0200."
	<20040528135816.GA27837@bytesex.org> 
References: <20040528135816.GA27837@bytesex.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: [2.6 patch] terminal/console cleanups
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
Date: Fri, 28 May 2004 12:36:17 -0400
To: Gerd Knorr <kraxel@bytesex.org>
Cc: uml devel <user-mode-linux-devel@lists.sourceforge.net>

kraxel@bytesex.org said:
> The changes in detail:

Excellent!  I've been wanting to do this for a long time, but haven't had the
spare time.

> The changes in detail:

I haven't looked at the actual changes, but this all sounds right.

> Note that with this patch applied it is strongly recommended to
> specify the device you want to use as console on the kernel command
> line.

Except for this.  I don't want to break everyone's scripts.  I think maybe
some logic similar to the root= might be in order, where it checks to see
if a console was specified, and if not, adds one to the command line.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
