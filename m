Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DUR8T-000692-1Y	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 07 May 2005 08:22:33 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DUR8N-0004aQ-GQ	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 07 May 2005 08:22:32 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Status of 2.6.[10-11] constant 1 loadavg?
References: <002501c5504a$18852c70$0201a8c0@hawk>
	<001901c551eb$eb6dc050$0201a8c0@hawk>
In-Reply-To: <001901c551eb$eb6dc050$0201a8c0@hawk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505071716.23243.blaisorblade@yahoo.it>
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
Date: Sat, 7 May 2005 17:16:23 +0200
To: "Christopher S. Aker" <caker@theshore.net>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Friday 06 May 2005 05:30, Christopher S. Aker wrote:
> > Has the constant "loadavg of 1" bug been resolved, or has the patch been
> > accepted into 2.6.12?
> >
> > Blaisorblade -- it appears to be back.  My recent tests with 2.6.11
> > vanilla still exhibit this problem.
>
> It appears as though uml-fix-update_process_times-call.patch fixes the
> values in /proc/stat, but the loadavg of 1 problem still exists.
In fact, what I saw with "top" is that the loadavg. is 1, ksoftirqd is always 
running, but the CPU time it gets is always 0.

It's really strange, I'll have to ask on LKML. However, a question: does it 
show up also on 2.6.10 or not?
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
