Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ABKqO-0000i5-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 19 Oct 2003 14:12:08 -0700
Received: from pop.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1ABKDw-0000xG-Uz
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 19 Oct 2003 13:32:25 -0700
From: Dan Aloni <da-x@gmx.net>
Subject: Re: [uml-devel] Problem with UML cross compilation
Message-ID: <20031019202825.GA10810@callisto.yi.org>
References: <20031018183128.GA22119@callisto.yi.org> <200310191716.h9JHGZdb011736@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310191716.h9JHGZdb011736@ccure.karaya.com>
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
Date: Sun, 19 Oct 2003 22:28:25 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

On Sun, Oct 19, 2003 at 01:16:34PM -0400, Jeff Dike wrote:
> da-x@gmx.net said:
> > My solution is: 
> > 
> >  * Let not build and run those utils on the build host, obviously.
> >  * All the required versions of the generated code for each of the
> >    targets will already reside in the tree, the build process will
> >    automatically pick up the right version and symlink to it.
> >  * Create a completely standalone program that embeds those utils 
> >    and generates the code. People who port UML to other 
> >    architectures will take this program, compile and run it on
> >    the target and put its output(s) in the tree.
> 
> I was thinking something similar, but differing in the details.  I was thinking
> about shipping the generated code in the tree, but non-cross builds would
> ignore it and just regenerate it.  Now, I'm thinking it shouldn't be in the
> tree, and that cross builds should put it there.
>
> 
> The other difference is that you're proposing a small build process to run
> on the target to generate the code.  I'm thinking that they should just copy
> the entire kernel tree over, and 'make arch_headers ARCH=um' or something.
> Then they would copy the directory containing the generated code back to the
> build host.
> 

Okay, so you say that a cross build procedure would need a one-time stage
where the person would generate the arch_headers at the host and then manually
copy the generated outputs back to the build host? Sounds difficult, but
people who are attempting cross builds are probably smart enough to understand
this, so it's good.

What sorts of changes are needed to be made in the build system to make 
it possible? I thought of adding $(CROSS_COMPILE) as a prefix to the filenames
of the generated outputs plus rules to generate symlinks that point from 
the normal filenames, in the case where $(CROSS_COMPILE) is activated.

Then, make arch_headers ARCH=um at the target will skip everything but 
running the helpers, packing their outputs to a .tar.gz, and something
like make install_arch_headers ARCH=um CROSS_COMPILE=[..] at the host 
will install those at the right spots in the tree with the given prefix
in CROSS_COMPILE.

Works for you?

-- 
Dan Aloni
da-x@gmx.net


-------------------------------------------------------
This SF.net email sponsored by: Enterprise Linux Forum Conference & Expo
The Event For Linux Datacenter Solutions & Strategies in The Enterprise 
Linux in the Boardroom; in the Front Office; & in the Server Room 
http://www.enterpriselinuxforum.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
