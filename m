Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A7ErX-00071b-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 08 Oct 2003 07:00:23 -0700
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=0)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A7ErW-0003dD-Jd
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 08 Oct 2003 07:00:22 -0700
Subject: Re: [uml-devel] skas & /proc/mm in the host kernel, yet /proc/mm
 'not found'
References: <200309182037.h8IKbMEk028815@hongkong.cs.nmsu.edu>
	<20030919095020.294F93BCE4@home.petschge.de>
	<20030920173518.521B03BCE7@home.petschge.de>
	<Pine.LNX.4.58.0309220535000.28187@crystal.nuked.org>
	<200309232016.h8NKGNaK003251@ccure.karaya.com>
	<Pine.LNX.4.58.0309232330340.28187@crystal.nuked.org>
	<200309241619.h8OGJwaK006019@ccure.karaya.com>
	<87fzig533b.fsf@amaterasu.srvr.nix>
	<200310062125.h96LPbGj020880@ccure.karaya.com>
From: Nix <nix@esperi.org.uk>
In-Reply-To: <200310062125.h96LPbGj020880@ccure.karaya.com> (Jeff Dike's
 message of "Mon, 06 Oct 2003 17:25:37 -0400")
Message-ID: <87k77fg789.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Wed, 08 Oct 2003 15:00:06 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Mon, 06 Oct 2003, Jeff Dike moaned:
> nix@esperi.demon.co.uk said:
>> hppfs_open : failed to open a socket in 'proc/uptime/r', err = 1
>> Kernel panic: init_new_context_skas - new_mm failed, errno = -24 
> 
> I don't see how these can be related.  They are totally separate pieces of
> code.

It confused me, too.

Both go away completely if I turn off hppfs. (I've not tried mounting
it somewhere quiet and not using it, but I can't see how that would
be any different from simply not mounting it at all...)

>>  Hm, maybe I'm barking up a gum tree here.  Anyway, I
>> haven't seen the init_new_context_skas error since I stopped using
>> hppfs. It's still built in, just not mounted anymore.)
> 
> Hmmm, maybe there is some relationship, but I have no idea what it would be.

Without hppfs mounted, all works wonderfully. My firewall thanks you,
and it was very much easier to get my iffy ADSL router to cooperate with
the ability to reboot the UML that was talking to it in about six
seconds. (Try *that* with a non-userspace kernel. ;} )

-- 
`If you want a vision of the future, it is a wireless broadband network
 feeding requests for foreign money-laundering assistance into a human
 temporal lobe, forever. With banner ads.' --- John M. Ford


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
