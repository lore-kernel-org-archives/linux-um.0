Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CFJfA-0002dB-U4 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Oct 2004 14:49:32 -0700
Received: from nudl.linbit.com ([212.69.162.21] helo=mail.linbit.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CFJf7-0002Vl-8k for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Oct 2004 14:49:32 -0700
Received: from minna.local (Ad268.a.pppool.de [213.6.210.104])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 755BE14338
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed,  6 Oct 2004 23:49:26 +0200 (CEST)
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
Subject: Re: [uml-devel] uml "ip header error" for large (fragmented) udp
	packets
Message-ID: <EPVOfiPct8+KnHqiZ4mos5U=lge@web.de>
References: </ydgn6vAKqzNNA6XYwRcEgI=lge@web.de>
	<200410061938.06648.blaisorblade_spam@yahoo.it>
	<vm4cST3zEEx6OdPLK17ocyg=lge@web.de>
	<20041006203539.GC22794@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041006203539.GC22794@wotan.suse.de>
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
Date: Wed, 6 Oct 2004 23:48:20 +0200
To: user-mode-linux-devel@lists.sourceforge.net

/ 2004-10-06 22:35:39 +0200
\ Andi Kleen:
> On Wed, Oct 06, 2004 at 08:48:23PM +0200, Lars Ellenberg wrote:
> > > So this could help you for now, while we try to find a clue about this. Quite 
> > > frankly, I must say that I'm not seeing any network kernel hacker here 
> > > (correct me if I'm wrong), so it will take some time to debug it. Maybe Gerd 
> > > Knorr is an exception, actually.
> > 
> > Well, then I take Andi Kleen and Lars Marowsky-Br?e into CC for now.
> > Lars, because I expect him to be interessted in having UML as full
> > featured cluster simulation tool available, and Andi because I hope he
> > might know the network code much better than me...
> > 
> > FYI, full thread can be found for example at
> > http://thread.gmane.org/gmane.linux.uml.devel/4607
> 
> Paolo's analysis is basically correct. loopback sets this flag
> for better performance.  Actually in 2.6 it probably doesn't help
> very much anymore because TCP can do checksum copy RX now, and that
> would get the checksum basically for free. But it's still there
> and may still make things slightly faster.
> 
> If UML taps the packets from lo it will see incorrect checksums.
> 
> Using a tun or ethertap device would avoid this. In the worst
> case you could also just delete the flag from the loopback
> interface, it's only an optimization.
> 
> -Andi

unfortunately ethertap transport does not work either,
at least if UML is 2.6.6 and host kernel is 2.4.21-suse-whatever...
I did not try other combinations yet, but I doubt that changes a thing.

you suggest that we remove NET_IF_F_NO_CSUM from lo in the host?
ok, I'll try recompile my host then, and followup if that helps.

	lge



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
