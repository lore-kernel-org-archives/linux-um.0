Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DNybP-0003Hu-L5 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 Apr 2005 12:41:43 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DNybK-00018a-KC for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 Apr 2005 12:41:43 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] MacOS X port?
References: <20050418113114.GA7159@muffin>
	<20050418140559.GA4219@ccure.user-mode-linux.org>
In-Reply-To: <20050418140559.GA4219@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200504191758.32356.blaisorblade@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 19 Apr 2005 17:58:31 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, "Wesley W. Terpstra" <wesley@terpstra.ca>

On Monday 18 April 2005 16:05, Jeff Dike wrote:
> On Mon, Apr 18, 2005 at 01:31:14PM +0200, Wesley W. Terpstra wrote:
> > Hi, I know that user-mode-linux has been ported to linux/ppc already.
> > What I was wondering is if there was work underway to port it to MacOS X?
> > That is to say, running a linux kernel from the BSD-ish MacOS X userland.
> >
> > This would be really cool; it would mean MacOS X users could run linux
> > applications 'natively' under UML with X forwarding to MacOS X's X
> > server. I couldn't imagine a more ideal configuration. :-)
> >
> > How hard would such an undertaking be?
>
> That's an OS port, which is very different from an arch port.  There is
> work underway (see the os abstraction patches at
> http://user-mode-linux.sf.net/patches.html) to make UML OS-portable.
>
> arch/um/include/os.h will show you what you currently have to implement for
> a new OS.  This is subject to change since we have only moved the existing
> OS-specific stuff and not tried to rationalize it yet.
>
> 				Jeff
Currently (i.e. in committed code, not counting the changes mentioned above), 
os.h abstracts away mostly some file access and process handling functions.

That said, to do such a port there is the need for a Mac OS X developer... 
since Mac OS X is still Unix that should not be too hard, but I don't know.

For instance, does ptrace() exists (check via "man ptrace")? I think that 
incapsulating this call is not a work in progress, and it won't be until we 
don't have at least another API to port UML to.

Also, I heard rumors of a FreeBSD port (although I don't remember if it was 
just a request); since the FreeBSD roots of MacOSX, a lot of code could 
probably be shared by those ports.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade





-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
