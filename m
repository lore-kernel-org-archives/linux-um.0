Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ACxG3-00048Q-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 24 Oct 2003 01:25:19 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1ACxDB-0005Wz-NT
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 24 Oct 2003 01:22:21 -0700
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] Re: Valgrind meets UML 
In-Reply-To: <200310240101.h9O11hmN006339@ccure.karaya.com>
Message-ID: <Pine.LNX.4.44.0310241018400.24620-100000@filer.marasystems.com>
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
Date: Fri, 24 Oct 2003 10:22:03 +0200 (CEST)
To: Jeff Dike <jdike@addtoit.com>
Cc: Giovanni Marzot <gmarzot@nortelnetworks.com>, user-mode-linux-devel@lists.sourceforge.net, jeremy@goop.org

On Thu, 23 Oct 2003, Jeff Dike wrote:

> You've found the UML config changes needed for Valgrind.  If Valgrind itself
> has the changes that Jeremy and I made, then you should be all set to at
> least run UML under it.

Which alone should trap some stupid mistakes with uninitialized variables,
even if the memory allocation/deallocation integration is not set yet so 
it it not totally fruitless.

It should also allow for the cachegrind mode, which some people might 
find useful.

Regards
Henrik



-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
