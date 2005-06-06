Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DfQWB-0007tq-RA	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Jun 2005 15:56:27 -0700
Received: from slartibartfast.pa.net ([66.59.111.182])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DfQWA-0003DD-Au	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Jun 2005 15:56:27 -0700
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
In-Reply-To: <1118098104.10147.38.camel@localhost>
Message-ID: <Pine.LNX.4.62.0506061854010.5707@sparrow>
References: <20050606224201.1557CFD31@sc8-sf-spam2.sourceforge.net>
 <1118098104.10147.38.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [uml-devel] Re: 2.6.12-rc5-mm2-patches20050605 build issues, run
	issues, backtrace
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
Date: Mon, 6 Jun 2005 18:55:51 -0400 (EDT)
To: antoine <antoine@nagafix.co.uk>
Cc: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>, William Stearns <wstearns@pobox.com>

Good evening, Antoine,

On Mon, 6 Jun 2005, antoine wrote:

>> [uml-devel] 2.6.12-rc5-mm2-patches20050605 build issues, run issues, backtrace
>>
>>  	Trying to build 2.6.5-rc5-mm2 on x86_64.  This is with all the
>> patches in Jeff's quilt tarball from 20050605:
>>
>> fs/externfs/externfs.c:20:23: 2_5compat.h: No such file or directory
>> make[2]: *** [fs/externfs/externfs.o] Error 1
>> make[1]: *** [fs/externfs] Error 2
>> make: *** [fs] Error 2
>
> You are missing at least one patch, apply all of them except the testing
> one (which does not apply cleanly anyway)

 	That's possible.
 	I don't seem to see any references to 2.5_compat in any of the 
patches I have from yesterday's tarball, but I could believe that there's 
an indirect reference somewhere.
 	Thanks for the help!
 	Cheers,
 	- Bill

---------------------------------------------------------------------------
 	"It is difficult to produce a television documentary that is both
incisive and probing when every twelve minutes one is interrupted by
twelve dancing rabbits singing about toilet paper."
 	-- Rod Serling
(Courtesy of Dr. G.W. Wettstein <greg@wind.enjellic.com>)
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
--------------------------------------------------------------------------


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
