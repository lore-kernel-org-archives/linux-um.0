Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FGOd2-000080-Ng for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Mar 2006 14:56:36 -0800
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FGOd1-0006XP-7F
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Mar 2006 14:56:36 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: [uml-user] Crash and stability problems with
	2.6.15.3-bs2
References: <LEEIJGBJEEABAGOFFGAHEEKCDEAA.brocka@sterlingcgi.com>
	<200603061810.44997.blaisorblade@yahoo.it>
	<20060306113353.m61i8wp6i08g8ssc@www.scgiservices.com>
In-Reply-To: <20060306113353.m61i8wp6i08g8ssc@www.scgiservices.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603062309.30606.blaisorblade@yahoo.it>
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
Date: Mon, 6 Mar 2006 23:09:30 +0100
To: Anthony Brock <brocka@sterlingcgi.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

On Monday 06 March 2006 20:33, Anthony Brock wrote:
> > On Monday 06 March 2006 9:11, Blaisorblade wrote:
> >
> > On Monday 27 February 2006 17:27, Anthony Brock wrote:
> > > In the mean time, we've experienced a second crash with the
> > > 2.6.15.1-bs1 kernel. It looks to be very similar to the previous crash.
> > > Only, in this case, I issued the command "uml_mconsole www-prod-1 sysrq
> > > s" in preparation for a backup (after issuing a "uml_mconsole $1 stop"
> > > command).
> >
> > It's a particular scenario, and I've been doubtly about it, but
> > indeed it seems that it's safe (at least by design).
>
> I apologize. However, I'm having difficulty understanding your meaning
> here.

I.e. I had doubt about "stop + sysrq s" being safe; today when I looked at the 
code and at what I remembered of my doubt, I concluded I was wrong.

> > > Mem-info:
> > > DMA per-cpu:
> > > cpu 0 hot: low 0, high 18, batch 3 used:2
> > > cpu 0 cold: low 0, high 6, batch 1 used:5
> > > DMA32 per-cpu: empty
> > > Normal per-cpu: empty
> > > HighMem per-cpu: empty
> > > Free pages:         376kB (0kB HighMem)
> > > Active:2985 inactive:8684 dirty:4 writeback:0 unstable:0 free:94
> > > slab:3428 mapped:933 pagetables:48
> > > DMA free:376kB min:1024kB low:1280kB high:1536kB active:11940kB
> > > inactive:34736kB present:65536kB pages_scanned:0 all_unreclaimable?
> > > no
> > > lowmem_reserve[]: 0 0 0 0
> >
> > There are 376kB of free pages, so it's strange that it can't satisfy
> > this request.
>
> I agree. However, this is the only instance where we've been able to
> reproduce a crash with a non-bs2 patched kernel. Other than this, the
> bs1 patches have been very stable.
>
> What can we do to further diagnose this? Alternatively, should we try a
> different guest kernel version or set of patches?
>
> Tony

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
