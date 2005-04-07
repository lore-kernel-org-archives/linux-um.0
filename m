Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DJUi4-0008Sx-AD for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Apr 2005 03:58:04 -0700
Received: from smtp1.oslo.dnmi.no ([128.39.62.241])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:RC4-SHA:128)
	(Exim 4.41) id 1DJUi0-0004gm-Pz
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Apr 2005 03:58:04 -0700
Received: from freeze.oslo.dnmi.no ([157.249.16.34])
	by smtp1.oslo.dnmi.no with esmtp (Exim 4.34) id 1DJUhM-00042G-8V
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Apr 2005 10:57:20 +0000
Received: from tandem by freeze.oslo.dnmi.no with local (Exim 3.35 #1)
	id 1DJUhM-0006DP-00 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Apr 2005 10:57:20 +0000
Subject: Re: [uml-devel] Broken compiling under 2.6.12-rc2 on my machine
From: Adrian Phillips <a.phillips@met.no>
In-Reply-To: <200504070408.30964.rob@landley.net> (Rob Landley's message of
	"Thu, 7 Apr 2005 04:08:30 -0400")
References: <cbec11ac050405205173f18157@mail.gmail.com>
	<200504062136.26895.blaisorblade@yahoo.it>
	<cbec11ac05040616556d6a71d8@mail.gmail.com>
	<200504070408.30964.rob@landley.net>
Message-ID: <87k6neq2gf.fsf@freeze.oslo.dnmi.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Thu, 07 Apr 2005 12:57:20 +0200
To: user-mode-linux-devel@lists.sourceforge.net

>>>>> "Rob" == Rob Landley <rob@landley.net> writes:

    >> > > > System is Debian Woody,
    >> >
    >> > Can you post your sed version? and Rob, can you then test it
    >> and fix the > code?
    >> 
    >> GNU sed version 3.02

    Rob> That said, the change I posted earlier would probably make it
    Rob> work.  The question is, do we care?  Documentation/Changes
    Rob> doesn't list a required sed version (even though other things
    Rob> in the kernel build use it), but perhaps it should.

Well, for Woody users there is always a backports sed - anyone using
2.6 with woody needs at least module-init-tools from backports so one
more package won't matter, even though one could be compiling 2.6 on a
2.4 system.

Sincerely,

Adrian Phillips

-- 
Who really wrote the works of William Shakespeare ?
http://www.pbs.org/wgbh/pages/frontline/shakespeare/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
