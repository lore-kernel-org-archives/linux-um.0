Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ABA5m-0007zD-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Sun, 19 Oct 2003 02:43:18 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1AB51s-0002U2-Ju
	for User-mode-linux-devel@lists.sourceforge.net; Sat, 18 Oct 2003 21:18:56 -0700
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] filemap feature 2.4.22-5um
In-Reply-To: <20031018215745.GK441@shell.blacknet.de>
Message-ID: <Pine.LNX.4.44.0310190028200.963-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 19 Oct 2003 00:29:56 +0200 (CEST)
To: Goetz Bock <bock@blacknet.de>
Cc: User-mode-linux-devel@lists.sourceforge.net

On Sat, 18 Oct 2003, Goetz Bock wrote:

> No, there is no need to be root inside a chrooted environment, or better
> yet you should not be.

The application running inside the chroot obviously should not be root, 
but the one who chroots it must be..

Toe point being that with mount --bind you can set up the chroot directory 
to give access to only the exact files needed before the application is 
started, even if these files normaly lives in a completely different 
location (i.e. /proc/mm and other special files)

Regards
Henrik



-------------------------------------------------------
This SF.net email sponsored by: Enterprise Linux Forum Conference & Expo
The Event For Linux Datacenter Solutions & Strategies in The Enterprise 
Linux in the Boardroom; in the Front Office; & in the Server Room 
http://www.enterpriselinuxforum.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
