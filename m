Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AOohH-0002Pl-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Tue, 25 Nov 2003 17:42:27 -0800
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AOohG-0007Ng-Hq
	for User-mode-linux-devel@lists.sourceforge.net; Tue, 25 Nov 2003 17:42:26 -0800
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] iptables-restore randomly crashes under UML
In-Reply-To: <Pine.LNX.4.44.0311251845550.10550-100000@gradall.private.brainfood.com>
Message-ID: <Pine.LNX.4.44.0311260212420.1800-100000@filer.marasystems.com>
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
Date: Wed, 26 Nov 2003 02:42:19 +0100 (CET)
To: Adam Heath <adam@doogie.org>
Cc: User-mode-linux-devel@lists.sourceforge.net

On Tue, 25 Nov 2003, Adam Heath wrote:

> Er, I don't see newinfo being initialized with anything.  Did you exclude this
> in your email?
> 
> If not, then newinfo->entries will randomly point to some other block of
> memory.

As commented in my message newinfo->entries is not a pointer, it is an 
array within newinfo and this reference is correct even if it looks odd at 
a first sight.

the name of an array evaluates to the address of the array.  Due to this
oddity of the C language newinfo->entries == &newinfo->entries ==
&newinfo->entries[0] and in this case is the address 0x40 bytes into 
newinfo (0xa2819040 if newinfo is 0xa2819000)

> > (gdb) x/1024b newinfo
> > 0xa2819000:     Cannot access memory at address 0xa2819000
> >
> > the same addresses just after copy_from_user() works just fine however..
> 
> This kind of error goes hand-in-hand with my observation above.

I don't see the relation. Please elaborate. Please note that the command 
above is reading the memory area as returned by vmalloc(), not directly 
the newinfo->entries member.

How I read the above is that the UML kernel has not yet set up the VM 
mapping of this newly vmalloc():ed area.

The real problem as I see it is that the content of the memory area
changes suddenly without this kernel touching it, at least not in this
code thread or in any other code thread visible to gdb. The exact place
when this happens seems to be timing related.

What I suspect is that the kernel virtual memory area gets remapped
somehow causing it to suddenly point to another "physical" memory area,
and due to the repetive nature of my tests the contents of this other
memory usually looks similar but not identical to the correct data.

It would be great if someone (Jeff?) could explain how the kernel
virtual->physical memory mappings are managed in TT mode, and if there is
any such operations which is not visible to a GDB session attached via the
ptproxy interface of tt mode UML kernels. This is still mostly magics to
me.. Before looking into this I did not even know the kernel had a virtual
memory and thought it was always using "physical" memory statically mapped
except when referring to user memory..

Regards
Henrik



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
