Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19wZgz-00055P-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 08 Sep 2003 21:01:25 -0700
Received: from boof.brainfood.com ([146.82.138.61] helo=gradall.private.brainfood.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19wWY6-0005U5-EC
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Sep 2003 17:40:02 -0700
From: Adam Heath <adam@doogie.org>
Subject: Re: [uml-devel] Kernel panic: I/O op mismatch
In-Reply-To: <3F593DFB.7040609@davidcoulson.net>
Message-ID: <Pine.LNX.4.44.0309081936590.26334-100000@gradall.private.brainfood.com>
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
Date: Mon, 8 Sep 2003 19:38:55 -0500 (CDT)
To: David Coulson <david@davidcoulson.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, 5 Sep 2003, David Coulson wrote:

> I'm having a few issues with my current UML kernels -
>
> /dev/ubd/2: recovering journal
> Kernel panic: I/O op mismatch
> In interrupt handler - not syncing

Yes.  Started seeing that today.

Here is what I have tracked down.

Host 2.4.21-1um.  UML 2.4.21-1um.
Host 2.4.22, UML 2.4.22
Host 2.4.22, UML 2.4.21-1um

All these combinations had this problem.  However, Host 2.4.21-1um, UML
2.4.20-6um and host 2.4.22, UML 2.4.20-6um ran fine.

I am not using a COW file.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
