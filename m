Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EyguC-0002nF-9k for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Jan 2006 18:49:08 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EyguB-0005sR-0J
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Jan 2006 18:49:08 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] slip_init and slirp_init using 12K of stack
Message-ID: <20060117034116.GF17171@ccure.user-mode-linux.org>
References: <200601170126.12774.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601170126.12774.blaisorblade@yahoo.it>
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
Date: Mon, 16 Jan 2006 22:41:16 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, Jan 17, 2006 at 01:26:12AM +0100, Blaisorblade wrote:
> I ran by accident scripts/checkstack.pl and found that slip_init and 
> slirp_init are two big offenders.
> 
> They are since of such lines:
> 
>         *spri = ((struct slip_data)
>                 { .name         = { '\0' },
>                   .addr         = NULL,
>                   .gate_addr    = init->gate_addr,
>                   .slave        = -1,
>                   .slip         = SLIP_PROTO_INIT,
>                   .dev          = dev });

Yuck, I guess it's time to initialize that field-by-field.

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
