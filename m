Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DizEs-0004FI-QM	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Jun 2005 11:37:18 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DizEn-0002uL-WA	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Jun 2005 11:37:18 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Recent patches of note
References: <20050616160728.GA6040@ccure.user-mode-linux.org>
	<200506162009.35357.blaisorblade@yahoo.it>
	<42B1C572.5070705@fujitsu-siemens.com>
In-Reply-To: <42B1C572.5070705@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506162041.27013.blaisorblade@yahoo.it>
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
Date: Thu, 16 Jun 2005 20:41:26 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, Jeff Dike <jdike@addtoit.com>

On Thursday 16 June 2005 20:31, Bodo Stroesser wrote:
> Blaisorblade wrote:
> > arch_switch already exists (wasn't used for SKAS). About improving it and
> > making it more "general-purpose" (I've written this for the TLS code
> > needs), could you have a look to the attached patches? do_fork-* is
> > another thing (a cleanup discussed some time ago with Jeff) but may be
> > needed to apply the second.
>
> Wouldn't it be better to have separate arch_switch_tt and arch_switch_skas?
> I think, arch_switch has to do different things for tt and skas (and maybe
> even for skas0 and skas3)
Let's not go creating too many layers. switch_to_* calls arch_switch, then it 
can use CHOOSE_MODE if it needs (see the TLS patch I'm working on, it's in 
the -devel tarball here:

http://www.user-mode-linux.org/~blaisorblade/patches/devel-guest/

(pick the latest)
).
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
