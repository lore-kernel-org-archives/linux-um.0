Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ABIW5-0007Rw-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 19 Oct 2003 11:43:01 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1ABI7F-00031P-LZ
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 19 Oct 2003 11:17:22 -0700
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id h9JH0sj27512
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 19 Oct 2003 13:00:54 -0400
Message-Id: <200310191716.h9JHGZdb011736@ccure.karaya.com>
Subject: Re: [uml-devel] Problem with UML cross compilation 
In-Reply-To: Your message of "Sat, 18 Oct 2003 20:31:28 +0200."
             <20031018183128.GA22119@callisto.yi.org> 
References: <20031018183128.GA22119@callisto.yi.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Sun, 19 Oct 2003 13:16:34 -0400
To: Dan Aloni <da-x@gmx.net>
Cc: User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

da-x@gmx.net said:
> My solution is: 
> 
>  * Let not build and run those utils on the build host, obviously.
>  * All the required versions of the generated code for each of the
>    targets will already reside in the tree, the build process will
>    automatically pick up the right version and symlink to it.
>  * Create a completely standalone program that embeds those utils 
>    and generates the code. People who port UML to other 
>    architectures will take this program, compile and run it on
>    the target and put its output(s) in the tree.

I was thinking something similar, but differing in the details.  I was thinking
about shipping the generated code in the tree, but non-cross builds would
ignore it and just regenerate it.  Now, I'm thinking it shouldn't be in the
tree, and that cross builds should put it there.

The other difference is that you're proposing a small build process to run
on the target to generate the code.  I'm thinking that they should just copy
the entire kernel tree over, and 'make arch_headers ARCH=um' or something.
Then they would copy the directory containing the generated code back to the
build host.

				Jeff



-------------------------------------------------------
This SF.net email sponsored by: Enterprise Linux Forum Conference & Expo
The Event For Linux Datacenter Solutions & Strategies in The Enterprise 
Linux in the Boardroom; in the Front Office; & in the Server Room 
http://www.enterpriselinuxforum.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
