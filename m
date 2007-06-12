Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hy7un-0008SW-94 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Jun 2007 08:04:14 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Hy7ul-0002s9-OC
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Jun 2007 08:04:13 -0700
Date: Tue, 12 Jun 2007 11:04:05 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070612150405.GA7102@c2.user-mode-linux.org>
References: <010701c7ace0$f98b0d80$d8c8a8c0@angel4>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <010701c7ace0$f98b0d80$d8c8a8c0@angel4>
Subject: Re: [uml-devel] UDP vs. TCP performance over UML
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: George Hadjichristofi <gh@winlab.rutgers.edu>
Cc: 'shruti singhal' <shruti20@gmail.com>, user-mode-linux-devel@lists.sourceforge.net

On Tue, Jun 12, 2007 at 07:01:05AM -0400, George Hadjichristofi wrote:
>  When we use TCP the throughput is 100 Mbps from the UML instance of node A
> to the host kernel of node B and 100 Mbps from the host kernel of node A to
> the host kernel of node B.  However, when we use UDP the throughput is only
> 26 Mbps from the UML instance on node A to the host kernel of node B, but
> 100 Mbps from the host kernel of node A to the host kernel of node B.  We
> also notice that a large number of packets were dropped in the case of UDP
> over UML.

At what interface are the packets being dropped?

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
