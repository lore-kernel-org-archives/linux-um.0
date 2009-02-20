Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Message-ID: <499E8AFD.2060905@ecp.fr>
Date: Fri, 20 Feb 2009 11:50:37 +0100
From: Nicolas Boullis <nicolas.boullis@ecp.fr>
MIME-Version: 1.0
Subject: [uml-devel] What's the status of UBD with AIO?
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

Hello,

I've been using UML for production servers for years, but I'm now
experiencing some performance problems with UBD (I've always used it
with CONFIG_BLK_DEV_UBD_SYNC).

I tried to patch UBD to run several I/O threads that perform the
requests in parallel. It improved performances significantly, but not
enough for me.

Using UML without CONFIG_BLK_DEV_UBD_SYNC improves performance a lot,
but the the guest has no way to ensure that it's data is actually
written on the disc. I certainly don't wan this for, e.g., a mail
server, or my users will kill me.

I read that there used to be some work done about using AIO for UBD,
with the device file opened with O_DIRECT. As far as I can see, it lokks
exactly like what I need. I read that Jeff reverted the change just
before 2.6.14, but he was then saying that he would re-add it soon...

What's the status of UBD with AIO nowadays? Does anyone use it? Where
can I find a patch that implements this?


Regards,

Nicolas

------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

