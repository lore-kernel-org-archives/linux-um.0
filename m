Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CFdCZ-0005LW-LK for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Oct 2004 11:41:19 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CFdCX-00029v-Pu for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Oct 2004 11:41:19 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] uml "ip header error" for large (fragmented) udp
	packets
References: </ydgn6vAKqzNNA6XYwRcEgI=lge@web.de>
	<20041006203539.GC22794@wotan.suse.de>
	<EPVOfiPct8+KnHqiZ4mos5U=lge@web.de>
In-Reply-To: <EPVOfiPct8+KnHqiZ4mos5U=lge@web.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410072041.16933.blaisorblade_spam@yahoo.it>
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
Date: Thu, 7 Oct 2004 20:41:16 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Lars Ellenberg <Lars.Ellenberg@linbit.com>

On Wednesday 06 October 2004 23:48, Lars Ellenberg wrote:
> / 2004-10-06 22:35:39 +0200
>
> \ Andi Kleen:
> > On Wed, Oct 06, 2004 at 08:48:23PM +0200, Lars Ellenberg wrote:
> > > > So this could help you for now, while we try to find a clue about
> > > > this. Quite frankly, I must say that I'm not seeing any network
> > > > kernel hacker here (correct me if I'm wrong), so it will take some
> > > > time to debug it. Maybe Gerd Knorr is an exception, actually.
> > >
> > > Well, then I take Andi Kleen and Lars Marowsky-Br?e into CC for now.
> > > Lars, because I expect him to be interessted in having UML as full
> > > featured cluster simulation tool available, and Andi because I hope he
> > > might know the network code much better than me...
> > >
> > > FYI, full thread can be found for example at
> > > http://thread.gmane.org/gmane.linux.uml.devel/4607
> >
> > Paolo's analysis is basically correct. loopback sets this flag
> > for better performance.  Actually in 2.6 it probably doesn't help
> > very much anymore because TCP can do checksum copy RX now, and that
> > would get the checksum basically for free. But it's still there
> > and may still make things slightly faster.
> >
> > If UML taps the packets from lo it will see incorrect checksums.
It does not, so the solution is not the right one.
> > Using a tun or ethertap device would avoid this. In the worst
> > case you could also just delete the flag from the loopback
> > interface, it's only an optimization.
> >
> > -Andi
>
> unfortunately ethertap transport does not work either,
> at least if UML is 2.6.6 and host kernel is 2.4.21-suse-whatever...
> I did not try other combinations yet, but I doubt that changes a thing.
>
> you suggest that we remove NET_IF_F_NO_CSUM from lo in the host?
> ok, I'll try recompile my host then, and followup if that helps.

No, I think he spoke about the guest; also he misunderstood a bit the problem, 
since the packets do not go through the "lo" interface inside UML.

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
