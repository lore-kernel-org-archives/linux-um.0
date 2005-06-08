Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dg1ty-0004OV-6a	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Jun 2005 07:51:30 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1Dg1tw-0006tG-Eg	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Jun 2005 07:51:30 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] compile error on 2.6.11.8-bs6 guest
References: <000501c56c37$c5abf830$0201a8c0@lualele>
In-Reply-To: <000501c56c37$c5abf830$0201a8c0@lualele>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506081654.54332.blaisorblade@yahoo.it>
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
Date: Wed, 8 Jun 2005 16:54:53 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: itamar <itamar@ispbrasil.com.br>, uml-user <user-mode-linux-user@lists.sourceforge.net>

On Wednesday 08 June 2005 16:38, itamar wrote:
> [root@router linux-2.6.11.8]# nice -n -20 make linux ARCH=um
>   CHK     include/linux/version.h
> make[1]: `arch/um/sys-i386/util/mk_sc' is up to date.
>   CHK     arch/um/include/skas_ptregs.h
>   CHK     arch/um/include/sysdep-i386/sc.h
>   CHK     arch/um/include/task.h
>   CHK     arch/um/include/kern_constants.h
> make[1]: `arch/um/sys-i386/util/mk_thread' is up to date.
>   CHK     arch/um/include/sysdep-i386/thread.h
>   CHK     include/linux/compile.h
>   CHK     usr/initramfs_list
> arch/um/kernel/Makefile:34: arch/um/scripts/Makefile.rules: No such file or
> directory
> make[1]: *** No rule to make target `arch/um/scripts/Makefile.rules'. 
> Stop. make: *** [arch/um/kernel] Error 2
> [root@router linux-2.6.11.8]#
Yes, patch generation was "a bit" problematic, I met a nice bug in combinediff 
from patchutils... anyhow I'll release (cleanly) -bs7 when I get more time. I 
also updated the news page to track this. Getting any of the problems fixed 
in -bs6? In that case I can point you to the needed splitout patches.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.beta.messenger.yahoo.com



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
