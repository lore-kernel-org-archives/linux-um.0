Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HyGmq-00022u-4l for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Jun 2007 17:32:36 -0700
Received: from winmain.rutgers.edu ([128.6.230.194] helo=liman.rutgers.edu)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HyGmo-0007yI-F3
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Jun 2007 17:32:36 -0700
From: "George Hadjichristofi" <gh@winlab.rutgers.edu>
References: <010701c7ace0$f98b0d80$d8c8a8c0@angel4>
	<20070612150405.GA7102@c2.user-mode-linux.org>
Date: Tue, 12 Jun 2007 20:32:15 -0400
Message-ID: <036601c7ad52$4b0c76a0$d8c8a8c0@angel4>
MIME-Version: 1.0
In-Reply-To: <20070612150405.GA7102@c2.user-mode-linux.org>
Subject: Re: [uml-devel] UDP vs. TCP performance over UML
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
To: 'Jeff Dike' <jdike@addtoit.com>, 'George Hadjichristofi' <gh@winlab.rutgers.edu>
Cc: 'shruti singhal' <shruti20@gmail.com>, user-mode-linux-devel@lists.sourceforge.net

Hi Jeff,

We took some more measurements. This is what we have:
A to B with UML: 46Mbps with UDP, 147Mbps with TCP
A to B from Host kernel: 285 Mbps for both UDP and TCP

In the case of A to B (with UML on A) there are packets dropped. Based on
Ifconfig on the host kernel the packets seem to drop between tap0 and eth0
on the host kernel. (i.e., the number of packets on tap0 is higher than
eth0).

Hope that was clear enough. 

Thank you,
George



-----Original Message-----
From: user-mode-linux-devel-bounces@lists.sourceforge.net
[mailto:user-mode-linux-devel-bounces@lists.sourceforge.net] On Behalf Of
Jeff Dike
Sent: Tuesday, June 12, 2007 11:04 AM
To: George Hadjichristofi
Cc: 'shruti singhal'; user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] UDP vs. TCP performance over UML

On Tue, Jun 12, 2007 at 07:01:05AM -0400, George Hadjichristofi wrote:
>  When we use TCP the throughput is 100 Mbps from the UML instance of node
A
> to the host kernel of node B and 100 Mbps from the host kernel of node A
to
> the host kernel of node B.  However, when we use UDP the throughput is
only
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


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
