Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FACDO-0002Xn-FG for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Feb 2006 12:28:30 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FACDM-0000oo-OY
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Feb 2006 12:28:30 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Error messages booting 2.6.16-pre3
Message-ID: <20060217202943.GA2889@ccure.user-mode-linux.org>
References: <200602151116.37212.rob.landley@timesys.com>
	<200602151713.52833.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602151713.52833.rob@landley.net>
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
Date: Fri, 17 Feb 2006 15:29:43 -0500
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, Feb 15, 2006 at 05:13:52PM -0500, Rob Landley wrote:
> > parse_chan_pair failed for device 1
> > parse_chan_pair failed for device 2
> > parse_chan_pair failed for device 3
> > parse_chan_pair failed for device 4
> > parse_chan_pair failed for device 5
> > parse_chan_pair failed for device 6
> > parse_chan_pair failed for device 7
> > parse_chan_pair failed for device 8
> > parse_chan_pair failed for device 9
> > parse_chan_pair failed for device 10
> > parse_chan_pair failed for device 11
> > parse_chan_pair failed for device 12
> > parse_chan_pair failed for device 13
> > parse_chan_pair failed for device 14
> > parse_chan_pair failed for device 15

I don't know about the rest of this, but something like this just
happened to me.  It was attaching the consoles to a host portal which
another UML was already using.  I got semi-reasonable "that portal is
already in use" errors in between the parse_chan_pair things.

So, were you trying to reuse some host devices, and which ones?  An
improvement in the errors might be in order here.

				Jeff


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
