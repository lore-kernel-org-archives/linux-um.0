Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ASZ0B-0000hX-Re
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 06 Dec 2003 01:45:27 -0800
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1ASZ0B-0000mR-7b
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 06 Dec 2003 01:45:27 -0800
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] [PATCH] provide asm/ldt.h 
In-Reply-To: <200312060005.hB6050Av008225@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.44.0312061043110.13464-100000@filer.marasystems.com>
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
Date: Sat, 6 Dec 2003 10:45:01 +0100 (CET)
To: Jeff Dike <jdike@addtoit.com>
Cc: Steve Bennett <steveb@snapgear.com>, user-mode-linux-devel@lists.sourceforge.net

On Fri, 5 Dec 2003, Jeff Dike wrote:

> I don't think that's a great idea.  UML pretends to be the same arch as the 
> host to userspace, so you should be compiling against the host's headers.

Which is a bit troublesome on self-hosted UML systems of when building 
kernel configuration dependent programs.

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
