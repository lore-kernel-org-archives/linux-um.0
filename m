Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DJbWi-0006WN-35 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Apr 2005 11:14:48 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DJbWh-00036V-EF for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Apr 2005 11:14:48 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Broken compiling under 2.6.12-rc2 on my machine
References: <cbec11ac050405205173f18157@mail.gmail.com>
	<200504070408.30964.rob@landley.net>
	<87k6neq2gf.fsf@freeze.oslo.dnmi.no>
In-Reply-To: <87k6neq2gf.fsf@freeze.oslo.dnmi.no>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504072020.57121.blaisorblade@yahoo.it>
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
Date: Thu, 7 Apr 2005 20:20:57 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Adrian Phillips <a.phillips@met.no>

On Thursday 07 April 2005 12:57, Adrian Phillips wrote:
> >>>>> "Rob" == Rob Landley <rob@landley.net> writes:
>     >> > > > System is Debian Woody,
>     >> >
>     >> > Can you post your sed version? and Rob, can you then test it
>     >>
>     >> and fix the > code?
>     >>
>     >> GNU sed version 3.02
>
>     Rob> That said, the change I posted earlier would probably make it
>     Rob> work.  The question is, do we care?  Documentation/Changes
>     Rob> doesn't list a required sed version (even though other things
>     Rob> in the kernel build use it), but perhaps it should.
>
> Well, for Woody users there is always a backports sed - anyone using
> 2.6 with woody needs at least module-init-tools from backports so one
> more package won't matter, even though one could be compiling 2.6 on a
> 2.4 system.
This user hasn't root access. And the patch isn't difficult or problematic.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
