Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CpVSY-0006xh-N8 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 14 Jan 2005 09:42:06 -0800
Received: from alyz.com ([66.220.1.229])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CpVSX-0007Ay-1Q for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 14 Jan 2005 09:42:06 -0800
From: Allen Chan <alydar@users.sourceforge.net>
Subject: Re: [uml-devel] Anyone running nested UMLs? It seem to work well
	enough...
References: <200501131722.35838.blaisorblade@yahoo.it>
In-Reply-To: <200501131722.35838.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501141242.27898.alydar@users.sourceforge.net>
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
Date: Fri, 14 Jan 2005 12:42:27 -0500
To: user-mode-linux-devel@lists.sourceforge.net

I played with nesting quite a bit when the -bb1 and -bb2 kernels were 
the latest available, trying to set up a network simulation for 
educational/testing purposes.  Although the nested kernels (with 
properly configured CONFIG_NEST_LEVEL) booted properly and appeared 
to work well, it ran into trouble (i.e., seg faults and/or hangs) 
whenever I tried to ssh into one of the nested kernels.

When I find some free time, I'll try it again with the latest UML 
kernels and report any successes or failures.

On Thursday 13 January 2005 11:22 am, Blaisorblade wrote:
> Well, inside my 2.6.9-bs5 session, I compiled a kernel as little
> stress-test, it worked, and just for fun I tried running it (even
> if I didn't tune CONFIG_NEST_LEVEL)... well, to my biggest
> surprise, the nested UML was able to boot and work well enough.
>
> A lot of "segmentation fault" messages appeared, but I expected
> that this feature wouldn't work at all... (and also I didn't tune
> CONFIG_NEST_LEVEL, as I said, and it makes sense that this causes
> the Segfaults). So it's nice to see this working.
>
> However, is anybody using them? For which reasons?
>
> Bye


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
