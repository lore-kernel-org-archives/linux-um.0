Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CHBeU-0001OK-1Q for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 18:40:34 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CHBeP-0004Te-Hu for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 18:40:33 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] UML not returning memory
References: <25368.1097543079@marajade.sandelman.ottawa.on.ca>
In-Reply-To: <25368.1097543079@marajade.sandelman.ottawa.on.ca>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410120340.45546.blaisorblade_spam@yahoo.it>
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
Date: Tue, 12 Oct 2004 03:40:45 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Michael Richardson <mcr@sandelman.ottawa.on.ca>

On Tuesday 12 October 2004 03:04, Michael Richardson wrote:
> Host:
>
> gimli-[aggr/testing/pluto/basic-pluto-01] mcr 1097 %uname -a
> Linux gimli 2.4.24 #4 Tue Mar 9 22:18:59 EST 2004 i686 GNU/Linux
> debian-sarge, linus kernel.
> I seem to be running in TT mode, rather than MM.
Ah, ok, you mean SKAS mode, right? However, please make sure that /proc/mm 
does not exist; if it exists you are running in SKAS mode.
> (I guess I forgot to apply skas3 on this host)

> Guest:
>
> east:~# uname -a
> Linux east 2.4.26-3um #1 Fri Oct 8 00:26:17 EDT 2004 i686 unknown
>
> As I run, I gradually run out of memory.
> I start UMLs and stop them, reboot them, lots as I am working.

> The box does nothing else. I killed all random processes that might have
> been using ram, but the memory does not return. We had this problem
> on another box, and never figured it out.
>
> I expect that UML is allocating memory and never returning it.
> But, given lack of /proc/mm, I don't see how it could be doing this kind
> of thing.
>
> Any ideas of where else memory might be disappearing to?
The host kernel allocates his own memory (let's say it has his kmalloc'ed() 
memory) - this is the only possible idea I have.
To check this, please go posting before/after reboot, together with this data 
(please take another shoot of this data), the content of /proc/slabinfo 
and /proc/meminfo. Also, please go in runlevel 1:

telinit 1
before taking the shoot. I'd also like a comparison between the datas before 
and after you have fully started, worked on and stopped one UML instance. And 
use "ps auxw" in both cases.

Finally, please attach everything - I don't care if it is one file or separate 
files, but just that it's not inline in the mail. I prefer to avoid line 
wrapping and such things.

However, are you able to reproduce this on a box without Open/FreeSWAN 
installed (I don't know what you are using here)? If the new data I've 
requested you that the bug is in the host kernel, either it is in the vanilla 
kernel or it is in the Open/FreeSWAN patch, or in whatever other patches you 
have applied.

Having said this, I must note that something similar happened (in some special 
configurations) on host kernels with SKAS patch; but only with the version 
for kernel >= 2.4.25, and with UML in SKAS mode, and with the very first 
patch I posted on my web-site; I fixed this months ago.

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
