Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BxSUU-0001yg-QL for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Aug 2004 08:36:42 -0700
Received: from brown.brainfood.com ([146.82.138.61]
	helo=gradall.private.brainfood.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BxSUR-0004Hu-90 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Aug 2004 08:36:41 -0700
From: Adam Heath <adam@doogie.org>
Subject: Re: [uml-devel] debug 2.6.7
In-Reply-To: <41234F99.6020208@exse.net>
Message-ID: <Pine.LNX.4.58.0408181036130.14238@gradall.private.brainfood.com>
References: <41234F99.6020208@exse.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Wed, 18 Aug 2004 10:36:30 -0500 (CDT)
To: seb <seb@exse.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, 18 Aug 2004, seb wrote:

> Hi,
>
> ---------------------------
> Starting MTA: exim4.
> Starting PostgreSQL database server: postmaster.
> Starting OpenBSD Secure Shell server: sshd.
> Starting deferred execution scheduler: atd.
> Starting periodic command scheduler: cron.
>
> Debian GNU/Linux 3.1 vhost tty0
>
> vhost login: Out of Memory: Killed process 3773 (xmlhandler.fcpl).

Increase the memory for the uml, using 'mem=xxx' on the cmdline.  The default
is 32m.


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
