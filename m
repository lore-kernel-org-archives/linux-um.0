Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EyrZ3-0000Lp-4J for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jan 2006 06:12:01 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EyrZ0-0001mS-E7
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jan 2006 06:12:01 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] slip_init and slirp_init using 12K of stack
References: <200601170126.12774.blaisorblade@yahoo.it>
	<20060117034116.GF17171@ccure.user-mode-linux.org>
In-Reply-To: <20060117034116.GF17171@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601171511.47160.blaisorblade@yahoo.it>
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
Date: Tue, 17 Jan 2006 15:11:46 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tuesday 17 January 2006 04:41, Jeff Dike wrote:
> On Tue, Jan 17, 2006 at 01:26:12AM +0100, Blaisorblade wrote:
> > I ran by accident scripts/checkstack.pl and found that slip_init and
> > slirp_init are two big offenders.
> >
> > They are since of such lines:
> >
> >         *spri = ((struct slip_data)
> >                 { .name         = { '\0' },
> >                   .addr         = NULL,
> >                   .gate_addr    = init->gate_addr,
> >                   .slave        = -1,
> >                   .slip         = SLIP_PROTO_INIT,
> >                   .dev          = dev });
>
> Yuck, I guess it's time to initialize that field-by-field.
Yep, done... I'll flush my queue when you're done with yours, there are too 
many conflicts right now. What about getting TLS in in this cycle (after 
-rc1, the freeze is less strict for us in practice)? If yes, I'm going to 
take care at it - I'm cleaning it anyway.
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
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
