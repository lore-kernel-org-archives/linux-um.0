Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AO3nA-0004kV-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Sun, 23 Nov 2003 15:37:24 -0800
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AO3n9-0007BJ-C8
	for User-mode-linux-devel@lists.sourceforge.net; Sun, 23 Nov 2003 15:37:23 -0800
Received: from localhost (henrik@localhost)
	by filer.marasystems.com (8.11.6/8.11.6) with ESMTP id hANNbKY07334
	for <User-mode-linux-devel@lists.sourceforge.net>; Mon, 24 Nov 2003 00:37:20 +0100
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] iptables-restore randomly crashes under UML
In-Reply-To: <Pine.LNX.4.44.0311221347440.20561-100000@filer.marasystems.com>
Message-ID: <Pine.LNX.4.44.0311232251090.6878-100000@filer.marasystems.com>
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
Date: Mon, 24 Nov 2003 00:37:20 +0100 (CET)
To: User-mode-linux-devel@lists.sourceforge.net

On Sat, 22 Nov 2003, Henrik Nordstrom wrote:

> We have found what looks like a UML-specific problem when running the 
> iptables-restore command.

Have been looking closely at this one, and from what I can tell everything
indicates there is something within UML which corrupts the kernel memory
allocated by iptables.

The culpit code from net/ipv4/netfilter/ip_tables.c:do_replace() with 
comments:

        newinfo = vmalloc(sizeof(struct ipt_table_info)
                          + SMP_ALIGN(tmp.size) * smp_num_cpus);
        if (!newinfo)
                return -ENOMEM;

[The allocated size is verified to be correct]

        if (copy_from_user(newinfo->entries, user + sizeof(tmp),
                           tmp.size) != 0) {
                ret = -EFAULT;
                goto free_newinfo;
        }

[So far everything looks fine and what gdb finds in newinfo->entries
matches what looks like was sent from userspace. Sizes of the copied data
has been verified that there is no buffer overflow. newinfo->entries is
correct even if it looks odd at first sight (array, not a pointer)]

        counters = vmalloc(tmp.num_counters * sizeof(struct ipt_counters));
        if (!counters) {
                ret = -ENOMEM;
                goto free_newinfo;
        }

[still everything looks fine, and contents identical to after the 
copy_from_user call above]

        memset(counters, 0, tmp.num_counters * sizeof(struct ipt_counters));

[here randomly (not always) the data copied has been currupted in
semi-random ways.  Sometimes this corruption can be seen before the call
to translate_table(), sometimes early in the start of translate_table()  
before the memory in question is referenced. There seems to be only two or
three different patterns of corruption all spread out little here little
there in the memory aream, but that pattern may also be an artefact of 
the repetive nature of the test used to trigger the error]

        ret = translate_table(tmp.name, tmp.valid_hooks,
                              newinfo, tmp.size, tmp.num_entries,
                              tmp.hook_entry, tmp.underflow);


I have tried using a watch expression on the data which gets currupted but
GDB does not seem to detect any writes to this area. The memory just
"magically" changes content. Using watch expressions on data changes in
the same are done within the relevant code flow works fine however.

This is seen with Linux-2.4.22 + current UML CVS in TT mode, without any
other kernel patches.

The only good thing is that I can very easily reproduce the problem within
a few seconds, and also reliably detect when it happens by using a few
breakpoints spread out along the code path checksumming the relevant
memory area for changes.

Bad thing is that I am really out of options what to look for next. To me 
it looks like my UML is simulating badly broken memory, but I am pretty 
sure there is some other magics messing around somewhere..

The exact same error is seen on multiple different hosts so I am fully
confident it is not a cause of broken host memory.



Hmm.. I just found one odd thing which might hint to where the problem may
be.. if I break just after vmalloc() but before copy_from_user() then GDB
can't read the memory area:

(gdb) x/1024b newinfo
0xa2819000:     Cannot access memory at address 0xa2819000

the same addresses just after copy_from_user() works just fine however..

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
