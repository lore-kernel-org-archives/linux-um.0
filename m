Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BoyYE-0003Qt-Ox for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 25 Jul 2004 23:01:30 -0700
Received: from dsl027-162-124.atl1.dsl.speakeasy.net ([216.27.162.124]
	helo=kevlar.burdell.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1BoyYD-0001xt-HP
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 25 Jul 2004 23:01:30 -0700
From: Sonny Rao <sonny@burdell.org>
Subject: Re: [uml-devel] Kallsyms on UML
Message-ID: <20040726060108.GA17971@kevlar.burdell.org>
References: <20040726002724.GA11374@kevlar.burdell.org>
	<web-1072592@b1.c.plasa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <web-1072592@b1.c.plasa.com>
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
Date: Mon, 26 Jul 2004 02:01:08 -0400
To: Mulyadi-Santosa <a_mulyadi@telkom.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Mon, Jul 26, 2004 at 10:57:05AM +0700, Mulyadi-Santosa wrote:
> Hello Sonny
> 
> >I had one question, I noticed that on stack traces I'm 
> >not getting
> >symbols even though I had CONFIG_KALLSYMS enabled.  I 
> >looked into it a
> >bit more and it appears that the kernel build system is 
> 
> Ehm, have you done EXPORT_SYMBOL(your_proc) or 
> EXPORT_SYMBOL(your_variable). I am not sure is this what 
> you want, but I do this on my trial kernel module (well, I 
> am still kernel newbie after all :-)) )

I was referring to the stack traces which appear after an Oops or
panic, or if you is simply call dump_stack() somewhere.  Normally, if
CONFIG_KALLSYMS isn't defined in the kernel's .config file, then those
stack traces don't show function names, just the address of the
function, which is somewhat annoying to decode :)  

Fortunately, an in-kernel symbol table has been added in 2.6 which
does the work for you.  It doesn't seem to work out of the box on UML
on 2.6, and I was just wondering if it would be trivial to add that
support to UML.  It seems that way to me, and its a rather useful
feature for people using UML as a kernel development tool.

Sonny


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
