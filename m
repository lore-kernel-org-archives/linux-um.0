Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3ZwH-0005lG-5l	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 06:51:13 -0700
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1E3ZwB-0005mJ-Ov
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 06:51:13 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] 'soft lockup' issue on shutdown
References: <CBELIFGMBIEPIEOFCJFAGEIPCAAA.brocka@sterlingcgi.com>
	<20050809134702.GA4254@ccure.user-mode-linux.org>
In-Reply-To: <20050809134702.GA4254@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508121528.59723.blaisorblade@yahoo.it>
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
Date: Fri, 12 Aug 2005 15:28:59 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Anthony Brock <brocka@sterlingcgi.com>

On Tuesday 09 August 2005 15:47, Jeff Dike wrote:
> On Sun, Aug 07, 2005 at 03:57:48PM -0700, Anthony Brock wrote:
> > I've been encountering a "freeze" on shutdown with guest kernel
> > 2.6.12-rc5-mm1. Today, I was busy with other things so I left it frozen
> > for a while. When I returned, I saw the following:
> >
> > Turning off swap
> > BUG: soft lockup detected on CPU#0!
>
> How reproducable is this?  I was seeing sleeps sleeping forever, often
> on shutdown, but in a different place than this.
And the soft lockup you got during a kernel compile in Ottawa, in the room? 
Have you diagnosed that?
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
