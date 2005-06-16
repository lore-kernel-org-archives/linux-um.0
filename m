Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DizOO-0004ph-QW	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Jun 2005 11:47:08 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DizOO-0001Ra-44	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Jun 2005 11:47:08 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Recent patches of note
References: <20050616160728.GA6040@ccure.user-mode-linux.org>
	<200506162041.27013.blaisorblade@yahoo.it>
	<42B1C787.6010402@fujitsu-siemens.com>
In-Reply-To: <42B1C787.6010402@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506162051.21441.blaisorblade@yahoo.it>
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
Date: Thu, 16 Jun 2005 20:51:20 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, Jeff Dike <jdike@addtoit.com>

On Thursday 16 June 2005 20:40, Bodo Stroesser wrote:
> Blaisorblade wrote:
> > On Thursday 16 June 2005 20:31, Bodo Stroesser wrote:
> >>Blaisorblade wrote:
> >>>arch_switch already exists (wasn't used for SKAS). About improving it
> >>> and making it more "general-purpose" (I've written this for the TLS
> >>> code needs), could you have a look to the attached patches? do_fork-*
> >>> is another thing (a cleanup discussed some time ago with Jeff) but may
> >>> be needed to apply the second.
> >>
> >>Wouldn't it be better to have separate arch_switch_tt and
> >> arch_switch_skas? I think, arch_switch has to do different things for tt
> >> and skas (and maybe even for skas0 and skas3)
> >
> > Let's not go creating too many layers. switch_to_* calls arch_switch,
> > then it can use CHOOSE_MODE if it needs (see the TLS patch I'm working
> > on, it's in the -devel tarball here:
>
> Then swtich_to_tt should call arch_switch_tt and switch_to_skas should call
> arch_switch_skas. This avoids a CHOOSE_MODE and a function call.
Hmm, yes, I thought too but for common code you have anyway a call... but it 
can be inlined, so it may make sense.

> And also it makes tt a bit more removable, if Jeff decides to.
Well, on this point I'd be cautious.

Currently there is no way to even test UML in SMP mode other than using TT 
mode, so at least this must be solved.

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
