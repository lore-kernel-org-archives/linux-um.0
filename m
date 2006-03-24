Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMnWj-0004ND-9i for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 06:44:33 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FMnWh-00022k-T4
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 06:44:33 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Resend: how to debug module on UML kernel 2.6.15.6 +
	SKAS mode?
References: <442366BA.3080902@gmail.com>
In-Reply-To: <442366BA.3080902@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603241544.23878.blaisorblade@yahoo.it>
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
Date: Fri, 24 Mar 2006 15:44:23 +0100
To: user-mode-linux-devel@lists.sourceforge.net, mikado4vn@gmail.com
Cc: user-mode-linux-user@lists.sourceforge.net

On Friday 24 March 2006 04:25, Mikado wrote:
> - How can I debug loadable modules at run time?
>
> Here is my way:
>
>   ( /tmp/mymodule.ko exists on both [Host] and [UML] )
>   + [Host] # gdb linux
>   + [Host] (gdb) ...
>   + [Host] (gdb) r <params>
>   + [UML] # insmod /tmp/mymodule.ko
>   + [UML] # cat /sys/module/mymodule/sections/{.text,.bss,.data}
>   + [Host] (gdb) add-symbol-file /tmp/mymodule.ko <.text_addr> -s .bss
> <.bss_addr> -s .data <.data_addr>
>   + ...
>
> Tell me if I was wrong, thanks!
>
> - How can I set breakpoint at module's init function?
>
> After add module's symbol, I set breakpoint at init function then
> 'rmmod' then re-'insmod' but gdb didn't break at init function. What was
> wrong?

gdb modifies the program code to set breakpoints, but the code is reloaded on 
module reload.

So, break on the caller of the module init function, and step from there. 
Maybe Bahi's mail refers to 2.4, I'm not sure, but the concepts are the same.

Most module-related code is in kernel/module.c, as for instance
static LIST_HEAD(modules);

which is the new name for module_list.

> - Sometimes gdb can't follow source codes in '.h' header files. Did I
> miss something?

What happens? Maybe gdb is stepping there but the calls are inlined and it's 
not apparent that it's looking at source code. However I've not clear what 
you describe, anyway.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	
	
		
___________________________________ 
Yahoo! Messenger with Voice: chiama da PC a telefono a tariffe esclusive 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
