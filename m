Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AOnqS-0004n9-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Tue, 25 Nov 2003 16:47:52 -0800
Received: from brown.brainfood.com ([146.82.138.61] helo=gradall.private.brainfood.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AOnqS-0001he-41
	for User-mode-linux-devel@lists.sourceforge.net; Tue, 25 Nov 2003 16:47:52 -0800
From: Adam Heath <adam@doogie.org>
Subject: Re: [uml-devel] iptables-restore randomly crashes under UML
In-Reply-To: <Pine.LNX.4.44.0311232251090.6878-100000@filer.marasystems.com>
Message-ID: <Pine.LNX.4.44.0311251845550.10550-100000@gradall.private.brainfood.com>
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
Date: Tue, 25 Nov 2003 18:48:14 -0600 (CST)
To: Henrik Nordstrom <hno@marasystems.com>
Cc: User-mode-linux-devel@lists.sourceforge.net

On Mon, 24 Nov 2003, Henrik Nordstrom wrote:

> The culpit code from net/ipv4/netfilter/ip_tables.c:do_replace() with
> comments:
>
>         newinfo = vmalloc(sizeof(struct ipt_table_info)
>                           + SMP_ALIGN(tmp.size) * smp_num_cpus);
>         if (!newinfo)
>                 return -ENOMEM;
>
> [The allocated size is verified to be correct]
>
>         if (copy_from_user(newinfo->entries, user + sizeof(tmp),
>                            tmp.size) != 0) {
>                 ret = -EFAULT;
>                 goto free_newinfo;
>         }

Er, I don't see newinfo being initialized with anything.  Did you exclude this
in your email?

If not, then newinfo->entries will randomly point to some other block of
memory.

> Hmm.. I just found one odd thing which might hint to where the problem may
> be.. if I break just after vmalloc() but before copy_from_user() then GDB
> can't read the memory area:
>
> (gdb) x/1024b newinfo
> 0xa2819000:     Cannot access memory at address 0xa2819000
>
> the same addresses just after copy_from_user() works just fine however..

This kind of error goes hand-in-hand with my observation above.



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
