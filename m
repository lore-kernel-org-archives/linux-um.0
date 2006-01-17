Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EyfjW-0006QS-7d for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Jan 2006 17:34:02 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EyfjT-00048f-Ma
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Jan 2006 17:34:02 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] 2.6.15-rc1 Badness in handle_page_fault
References: <1137444603.8036.2.camel@localhost>
	<20060116235450.GB14064@ccure.user-mode-linux.org>
In-Reply-To: <20060116235450.GB14064@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601170233.59826.blaisorblade@yahoo.it>
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
Date: Tue, 17 Jan 2006 02:33:59 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Antoine Martin <antoine@nagafix.co.uk>

On Tuesday 17 January 2006 00:54, Jeff Dike wrote:
> On Mon, Jan 16, 2006 at 08:50:03PM +0000, Antoine Martin wrote:
> > Found these in a guest running 2.6.15-rc1.
> > Note sure this is relevant anymore, but here it is anyway:
> >
> > [45512066.140000] Badness in handle_page_fault at
> > arch/um/kernel/trap_kern.c:101
> >
> > [45512066.830000] load_TLS(O_FORCE) in fork_handler returned -2
>
> These are fixed.

I remember the badness in handle_page_fault (bogus warning from me), what 
about load_TLS? I only got -22, I fixed it by removing tls-debug (it was a 
kludgy attempt to get things working, and didn't appear correct to me); still 
not completely tested.

See my "TLS patches compilation fixups" for the fixes.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
