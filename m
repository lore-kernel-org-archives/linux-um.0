Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HyxKq-0001NU-Dz for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Jun 2007 14:58:32 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HyxKp-0005jm-0H
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Jun 2007 14:58:32 -0700
Date: Thu, 14 Jun 2007 17:58:22 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070614215822.GA12047@c2.user-mode-linux.org>
References: <20070614110816.5e579766944bbcab97407204a2c9ea3e.78a7ca2535.wbe@email.secureserver.net>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070614110816.5e579766944bbcab97407204a2c9ea3e.78a7ca2535.wbe@email.secureserver.net>
Subject: Re: [uml-devel] [uml-user] ppp and UML -possible? why or why not?
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Mark <mark@baretoes.net>
Cc: UML-user <user-mode-linux-devel@lists.sourceforge.net>

On Thu, Jun 14, 2007 at 11:08:16AM -0700, Mark wrote:
> My question is I've looked around, but don't understand why (page
> 54) says that UML doesn't support PPP. Is pppd the problem and can I
> just use something like slirp?   (I did find a debian package with UML
> and slirp).

You're looking for a mechanism to exchange packets with the host, not
asking about ppp support within UML?

ppp isn't supported because no one ever wrote it.  Slirp is basically
the last choice for when nothing else will work, and ppp might be
right down there with it.  TUN/TAP is the mechanism of choice.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
