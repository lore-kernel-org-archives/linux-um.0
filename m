Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A2Z4b-0002Nx-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 25 Sep 2003 09:34:33 -0700
Received: from brown.brainfood.com ([146.82.138.61] helo=gradall.private.brainfood.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A2Z4a-00011g-NM
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 25 Sep 2003 09:34:32 -0700
From: Adam Heath <adam@doogie.org>
Subject: Re: [uml-devel] (no subject)
In-Reply-To: <Pine.LNX.4.58.0309251449260.20970@boston.corp.fedex.com>
Message-ID: <Pine.LNX.4.44.0309251132320.26334-100000@gradall.private.brainfood.com>
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
Date: Thu, 25 Sep 2003 11:33:03 -0500 (CDT)
To: Jeff Chua <jeff98@silk.corp.fedex.com>
Cc: UserModeLinux <user-mode-linux-devel@lists.sourceforge.net>

On Thu, 25 Sep 2003, Jeff Chua wrote:

>
> Please apply the patch below to host-skas3.patch so that it does not need
> to be undone when compiling uml.
>
> Currently, I need to apply host-skas3.patch to /usr/src/linux to compile
> the host's vmlinux, and reverse it in order to compile uml linux. With the
> patch below, this will prevent gcc from redefining the struct twice.

A better fix it to modify uml's include, to not redefine the structure.

Maybe a common include, for both files.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
