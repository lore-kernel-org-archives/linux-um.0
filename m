Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AAqLZ-0001VK-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Sat, 18 Oct 2003 05:38:17 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1AAqLO-0004Sb-N5
	for User-mode-linux-devel@lists.sourceforge.net; Sat, 18 Oct 2003 05:38:06 -0700
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] filemap feature 2.4.22-5um
In-Reply-To: <BAY7-F71MKk9LqOVoQc000091eb@hotmail.com>
Message-ID: <Pine.LNX.4.44.0310181435400.30746-100000@filer.marasystems.com>
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
Date: Sat, 18 Oct 2003 14:37:12 +0200 (CEST)
To: Steve Schmidtke <steve_schmidtke@hotmail.com>
Cc: adam@doogie.org, User-mode-linux-devel@lists.sourceforge.net

On Sat, 18 Oct 2003, Steve Schmidtke wrote:

> It would be nice if a chroot wrapper could open the files and pass the 
> "filemap=" config strings to your config parser.  Something like this:

What I do not quite get in this discussion is why one does not want to
have the selected files available in the chroot in the first place?

To chroot you need to be root. As root you are also allowed to map files
around using mount --bind.

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
