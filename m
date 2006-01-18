Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EzBEX-0003jN-Ao for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 03:12:09 -0800
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EzBET-00038e-EH
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 03:12:09 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
References: <20060117235659.14622.18544.stgit@zion.home.lan>
	<20060118001920.14622.79573.stgit@zion.home.lan>
	<20060118025354.GA13825@ccure.user-mode-linux.org>
In-Reply-To: <20060118025354.GA13825@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601181211.50190.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: [PATCH 1/9] uml: avoid sysfs warning on hot-unplug
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
Date: Wed, 18 Jan 2006 12:11:49 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Wednesday 18 January 2006 03:53, Jeff Dike wrote:
> On Wed, Jan 18, 2006 at 01:19:21AM +0100, Paolo 'Blaisorblade' Giarrusso 
wrote:
> > Done by Jeff around January for ubd only, later lost, then restored in
> > his tree - however I'm merging it now since there's no reason to leave
> > this here.
>
> The original was dinged by hch for covering over a problem without really
> fixing it.
>
> We need to think about this one some more.

About this, have you reported upstream the "crash with remove ubd2 and ubd3" 
thing caused by wrong refcounts? Greg and friends tend to fix various drivers 
all around, I guess it's the right policy to ask them to fix this too.

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger with Voice: chiama da PC a telefono a tariffe esclusive 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
