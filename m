Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ATHlD-0005Lw-2Y
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Dec 2003 01:32:59 -0800
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1ATHlC-0002HZ-Cj
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Dec 2003 01:32:58 -0800
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] SKAS vs ChrootJail
In-Reply-To: <skqnx1nepxadcv5.081220030759@STENNY>
Message-ID: <Pine.LNX.4.44.0312081030460.9997-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 8 Dec 2003 10:32:50 +0100 (CET)
To: Stenny <uml@w4.homeip.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Mon, 8 Dec 2003, Stenny wrote:

> I'm new UML users, I have a question regarding SKAS and chrootjail, what
> is diffirent between them, and if I have SKAS mode enabled, do I still
> need chrootjail for increase of security?

SKAS and chrootjail addresses quite different aspects. SKAS addresses how
UML manages memory, chrootjail tries to protect the host from users
breaking out of UML.

Regards
Henrik



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
