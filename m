Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FEZoz-0000Zi-UQ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 01 Mar 2006 14:29:25 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FEZow-0002V6-70
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 01 Mar 2006 14:29:26 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Unknown symbol vsyscall_end when loading external
	module
References: <6FC4416DDE56C44DA0AEE67BC7CA43710D313E2A@zrc2hxm2.corp.nortel.com>
In-Reply-To: <6FC4416DDE56C44DA0AEE67BC7CA43710D313E2A@zrc2hxm2.corp.nortel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603012329.17111.blaisorblade@yahoo.it>
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
Date: Wed, 1 Mar 2006 23:29:16 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: John Dykstra <jdykstra@nortel.com>

On Wednesday 01 March 2006 21:04, John Dykstra wrote:
> I'm getting this when loading an externally built module:
>
> infinity: Unknown symbol vsyscall_end
> infinity: Unknown symbol vsyscall_ehdr
>
> The module uses copy_from_user().  When ARCH=um, copy_from_user() is
> defined as inline, and uses FIXADDR_USER_END.  That macro is defined as
> VSYSCALL_END, which in turn is defined as vsyscall_end.  However,
> there's no EXPORT_SYMBOL(vsyscall_end).

Ok, EXPORT_SYMBOL for both ones should be added, to any suitable file 
(arch/um/kernel/ksyms.c, for instance), and it'll work.

We'll add the patch ASAP, but please remind us.

> This is in linux-2.6.16-rc4, with Jeff's patch set from last week.

> TIA.

>   --  John

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
