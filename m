Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I7Cy5-00075N-BU for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 07 Jul 2007 09:17:09 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1I7Cy3-0007Pa-NY
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 07 Jul 2007 09:17:09 -0700
Date: Sat, 7 Jul 2007 12:16:45 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070707161645.GA7352@c2.user-mode-linux.org>
References: <3d0408630707070401i336cc879k8055d5858c97054a@mail.gmail.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3d0408630707070401i336cc879k8055d5858c97054a@mail.gmail.com>
Subject: Re: [uml-devel] UML Build error when hostFS support is included.
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
To: Yan Zheng <yanzheng@21cn.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sat, Jul 07, 2007 at 07:01:36PM +0800, Yan Zheng wrote:
> ERROR: "ftruncate64" [fs/hostfs/hostfs.ko] undefined!
> ERROR: "__fxstat64" [fs/hostfs/hostfs.ko] undefined!
> ERROR: "futimes" [fs/hostfs/hostfs.ko] undefined!
> ERROR: "fchown" [fs/hostfs/hostfs.ko] undefined!
> ERROR: "fchmod" [fs/hostfs/hostfs.ko] undefined!
> ERROR: "utimes" [fs/hostfs/hostfs.ko] undefined!

Looks like it needs a bunch of EXPORT_SYMBOLs - easily fixed.

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
